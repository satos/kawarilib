#!/usr/bin/ruby
#----------------------------------------------------------------------------
#
# ��AIMS
# AIMS-1/2/3��Ruby�ɂ��Ď���
#
#      Programed by NAKAUE.T (Meister)
#
#  2003.05.18  Version 0.1.0  AIMS-2����
#  2003.05.20  Version 0.2.0  deducer����
#  2003.06.22  Version 0.3.0  ���\�b�h����
#  2003.06.22  Version 0.4.0  �P�ꎫ���ǉ�
#
# ���̃\�t�g�E�F�A��Public Domain Software�ł��B
# ���R�ɗ��p�E���ς��č\���܂���B
# ���ς̗L���ɂ�����炸�A���R�ɍĔz�z���邱�Ƃ��o���܂��B
# ��҂͂��̃\�t�g�E�F�A�Ɋւ��āA�S�Ă̌����ƑS�Ă̋`����������܂��B
#
#----------------------------------------------------------------------------
# AIMS-1/2/3/4�����O���f�[�^�x�[�X
class MicroAIMSdb

  def database;	@database;	end
  def worddict;	@worddict;	end


  def initialize
    @database={}
    @revdatabase={}		# �t����
    @worddict={}		# �P�ꎫ��
  end


  # �f�[�^�x�[�X�ւ̒ǉ�
  def adddb(s,r,d)
    @database[s]={} if !@database[s]
    @database[s][r]={} if !@database[s][r]
    @revdatabase[d]={} if !@revdatabase[d]
    @revdatabase[d][r]={} if !@revdatabase[d][r]

    @database[s][r][d]=true
    @revdatabase[d][r][s]=true

    worddict[s]=true if !worddict.key?(s)
    worddict[r]=true if !worddict.key?(r)
    worddict[d]=true if !worddict.key?(d)

    adddb(d,'���',s) if (r=='���')&&(!query_srd(d,'���',s))
    adddb(d,'���',s) if (r=='���')&&(!query_srd(d,'���',s))
  end


  # �f�[�^�x�[�X�̍폜
  def deldb(s,r,d=nil)
    if d
      @database[s][r].delete(d)
      @revdatabase[d][r].delete(s)

      @database[s].delete(r) if !@database[s][r].size==0
      @database.delete(s) if !@database[s].size==0
      @revdatabase[d].delete(r) if !@revdatabase[d][r].size==0
      @revdatabase.delete(d) if !@revdatabase[d].size==0

      deldb(d,'���',s) if (r=='���')&&(query_srd(d,'���',s))
      deldb(d,'���',s) if (r=='���')&&(query_srd(d,'���',s))
    else
      query_sr(s,r).each{|d| deldb(s,r,d)}
    end
  end


  # �f�[�^�x�[�X��ǂݍ���
  def loaddb(file)
    open(file) {|f|
      while l=f.gets
        l.chomp!
        if l=~/^([^,]+),([^,]+),([^,]+)$/
          adddb($1,$2,$3)
        end
      end
    }
  end


  # �f�[�^�x�[�X��ۑ�
  def savedb(file)
    open(file,"w") {|f|
      eachdb{|s,r,d| f.puts s+','+r+','+d}
    }
  end


  # �f�[�^�x�[�X�̑S�f�[�^���
  def eachdb
    @database.keys.each{|s|
      query_property(s).each {|r|
        query_sr(s,r).each{|d| yield(s,r,d)}
      }
    }
  end


  # S�ɂ��Ă̒m�����
  def query_s(s)
    ans=[]
    query_property(s).each {|r|
      query_sr(s,r).each{|d| ans<<[s,r,d]}
    }
    return ans
  end


  # R�ɂ��Ă̒m�����
  def query_r(r)
    ans=[]
    @database.keys.each{|s|
      query_sr(s,r).each{|d| ans<<[s,r,d]}
    }
    return ans
  end


  # D�ɂ��Ă̒m�����
  def query_d(d)
    return [] if !@revdatabase[d]
    ans=[]
    @revdatabase[d].keys.each{|r|
      @revdatabase[d][r].keys.each{|d| ans<<[s,r,d]}
    }
    return ans
  end


  # S��R�͉��H
  def query_sr(s,r)
    return [] if !@database[s]||!@database[s][r]
    return @database[s][r].keys
  end


  # S�̉���D�H
  def query_sd(s,d)
    return [] if !@database[s]
    return query_property(s).reject {|r| !query_srd(s,r,d)}
  end


  # ����R��D�H
  def query_rd(r,d)
    return [] if !@revdatabase[d]||!@revdatabase[d][r]
    return @revdatabase[d][r].keys
  end


  # S��R��D�H(Quol�����z����true/nil�ŕԓ�)
  def query_srd(s,r,d)
    return nil if !@database[s]||!@database[s][r]
    return @database[s][r].key?(d)
  end


  # S�̎����Ă���R���
  def query_property(s)
    return nil if !@database[s]
    return @database[s].keys
  end


  # S�̎��(���)�͉��H
  def query_class(s,r='���')
    ans=query_class_sub(s,r)
    ans.delete(s)
    return ans.keys
  end


  # S�̎��(���)�͉��H(�������𓚂ɂ�*�K��*�uS�̎�ނ�S�v���܂܂��)
  def query_class_sub(s,r,ans={})
    ans[s]=true
    query_sr(s,r).each{|c|
      ans=query_class_sub(c,r,ans) if !ans.key?(c)
    }
    return ans
  end


end
#----------------------------------------------------------------------------
# ���_�G���W��(AIMS-2����)�t���f�[�^�x�[�X
class MicroAIMSdeducer < MicroAIMSdb

  def initialize
    super
  end


  # S��R�͉��H(���_�t��)
  def deduce_sr(s,r)
    return query_class(s,r) if (r=='���')||(r=='���')

    ans={}
    ([s]+query_class(s)).each{|s2|
      query_sr(s2,r).each{|d| ans[d]=true}
    }
    return ans.keys
  end


end
#----------------------------------------------------------------------------
