#!/usr/bin/ruby
#----------------------------------------------------------------------------
#
# μAIMS
# AIMS-1/2/3のRubyによる再実装
#
#      Programed by NAKAUE.T (Meister)
#
#  2003.05.18  Version 0.1.0  AIMS-2相当
#  2003.05.20  Version 0.2.0  deducer分離
#  2003.06.22  Version 0.3.0  メソッド整備
#  2003.06.22  Version 0.4.0  単語辞書追加
#
# このソフトウェアはPublic Domain Softwareです。
# 自由に利用・改変して構いません。
# 改変の有無にかかわらず、自由に再配布することが出来ます。
# 作者はこのソフトウェアに関して、全ての権利と全ての義務を放棄します。
#
#----------------------------------------------------------------------------
# AIMS-1/2/3/4向け三項データベース
class MicroAIMSdb

  def database;	@database;	end
  def worddict;	@worddict;	end


  def initialize
    @database={}
    @revdatabase={}		# 逆引き
    @worddict={}		# 単語辞書
  end


  # データベースへの追加
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

    adddb(d,'一種',s) if (r=='種類')&&(!query_srd(d,'一種',s))
    adddb(d,'種類',s) if (r=='一種')&&(!query_srd(d,'種類',s))
  end


  # データベースの削除
  def deldb(s,r,d=nil)
    if d
      @database[s][r].delete(d)
      @revdatabase[d][r].delete(s)

      @database[s].delete(r) if !@database[s][r].size==0
      @database.delete(s) if !@database[s].size==0
      @revdatabase[d].delete(r) if !@revdatabase[d][r].size==0
      @revdatabase.delete(d) if !@revdatabase[d].size==0

      deldb(d,'一種',s) if (r=='種類')&&(query_srd(d,'一種',s))
      deldb(d,'種類',s) if (r=='一種')&&(query_srd(d,'種類',s))
    else
      query_sr(s,r).each{|d| deldb(s,r,d)}
    end
  end


  # データベースを読み込み
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


  # データベースを保存
  def savedb(file)
    open(file,"w") {|f|
      eachdb{|s,r,d| f.puts s+','+r+','+d}
    }
  end


  # データベースの全データを列挙
  def eachdb
    @database.keys.each{|s|
      query_property(s).each {|r|
        query_sr(s,r).each{|d| yield(s,r,d)}
      }
    }
  end


  # Sについての知識を列挙
  def query_s(s)
    ans=[]
    query_property(s).each {|r|
      query_sr(s,r).each{|d| ans<<[s,r,d]}
    }
    return ans
  end


  # Rについての知識を列挙
  def query_r(r)
    ans=[]
    @database.keys.each{|s|
      query_sr(s,r).each{|d| ans<<[s,r,d]}
    }
    return ans
  end


  # Dについての知識を列挙
  def query_d(d)
    return [] if !@revdatabase[d]
    ans=[]
    @revdatabase[d].keys.each{|r|
      @revdatabase[d][r].keys.each{|d| ans<<[s,r,d]}
    }
    return ans
  end


  # SのRは何？
  def query_sr(s,r)
    return [] if !@database[s]||!@database[s][r]
    return @database[s][r].keys
  end


  # Sの何はD？
  def query_sd(s,d)
    return [] if !@database[s]
    return query_property(s).reject {|r| !query_srd(s,r,d)}
  end


  # 何のRはD？
  def query_rd(r,d)
    return [] if !@revdatabase[d]||!@revdatabase[d][r]
    return @revdatabase[d][r].keys
  end


  # SのRはD？(Quolを見越してtrue/nilで返答)
  def query_srd(s,r,d)
    return nil if !@database[s]||!@database[s][r]
    return @database[s][r].key?(d)
  end


  # Sの持っているRを列挙
  def query_property(s)
    return nil if !@database[s]
    return @database[s].keys
  end


  # Sの種類(一種)は何？
  def query_class(s,r='種類')
    ans=query_class_sub(s,r)
    ans.delete(s)
    return ans.keys
  end


  # Sの種類(一種)は何？(ただし解答には*必ず*「Sの種類はS」が含まれる)
  def query_class_sub(s,r,ans={})
    ans[s]=true
    query_sr(s,r).each{|c|
      ans=query_class_sub(c,r,ans) if !ans.key?(c)
    }
    return ans
  end


end
#----------------------------------------------------------------------------
# 推論エンジン(AIMS-2相当)付きデータベース
class MicroAIMSdeducer < MicroAIMSdb

  def initialize
    super
  end


  # SのRは何？(推論付き)
  def deduce_sr(s,r)
    return query_class(s,r) if (r=='種類')||(r=='一種')

    ans={}
    ([s]+query_class(s)).each{|s2|
      query_sr(s2,r).each{|d| ans[d]=true}
    }
    return ans.keys
  end


end
#----------------------------------------------------------------------------
