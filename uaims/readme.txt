------------------------------------------------------------------------------

  ��AIMS(KIS)
  AIMS-1/2/3��KIS�ɂ��Ď���

      Ruby�� Programed by NAKAUE.T (Meister)
      KIS��  Programed by Sato.S (���Ɓ[)

   2003.06.09  Version 0.1.0  ��AIMS(Ruby) Ver. 0.1.0����ڐA
   2003.08.08                 �f�[�^�\�����������Adeldb���\�b�h�ǉ�
   2003.08.13                 query_property���\�b�h�Aquery_sd���\�b�h�ǉ�
   2003.08.15  Version 0.2.0  �t���������ǉ��Aquery_rd���\�b�h�ǉ�
                              query_r���\�b�h�ǉ��Aquery_d���\�b�h�ǉ�

  ���̃\�t�g�E�F�A��Public Domain Software�ł��B
  ���R�ɗ��p�E���ς��č\���܂���B
  ���ς̗L���ɂ�����炸�A���R�ɍĔz�z���邱�Ƃ��o���܂��B
  ��҂͂��̃\�t�g�E�F�A�Ɋւ��āA�S�Ă̌����ƑS�Ă̋`����������܂��B

  ���̃��C�u�����Ŏg�p���Ă���O���f�[�^�x�[�X�̏ڍׂ́A�ȉ����Q�Ɖ������B
  http://www.rogiken.org/aims/pdf/AIMS-1-3.pdf

------------------------------------------------------------------------------
  �f�[�^�\��

  MicroAIMS.db.(DB)                      : "MicroAIMS"
  MicroAIMS.db.(DB).Value                : �S�Ă�s�̏W��
  MicroAIMS.db.(DB).Tree.(s_ID)          : s_ID�ɑΉ�����s�̓��e
  MicroAIMS.db.(DB).Value.(s_ID)         : s_ID��s�����S�Ă�r�̏W��
  MicroAIMS.db.(DB).Tree.(s_ID).(r_ID)   : r_ID�ɑΉ�����r�̓��e
  MicroAIMS.db.(DB).Value.(s_ID).(r_ID)  : �us��r��d�v�ɊY������d�̏W��
  MicroAIMS.db.(DB).RValue               : �S�Ă�d�̏W��
  MicroAIMS.db.(DB).RTree.(d_ID)         : d_ID�ɑΉ�����d�̓��e
  MicroAIMS.db.(DB).RValue.(d_ID)        : d_ID��d�����S�Ă�r�̏W��
  MicroAIMS.db.(DB).RTree.(d_ID).(r_ID)  : r_ID�ɑΉ�����r�̓��e
  MicroAIMS.db.(DB).RValue.(d_ID).(r_ID) : �us��r��s�v�ɊY������s�̏W��

    *1 (DB)�̓f�[�^�x�[�X�̖��O
    *2 (s_ID)�A(r_ID)�A(d_ID)�͔񕉐���

------------------------------------------------------------------------------

�֐�     : MicroAIMS
�@�\     : DB�̐錾
��1����  : DB��
��2����  : �R�s�[��DB��(�ȗ��\)
�߂�l   : ����


���\�b�h : save
�@�\     : DB�̕ۑ�
��1����  : DB��ۑ�����t�@�C����
�߂�l   : ����


���\�b�h : adddb
�@�\     : �f�[�^�x�[�X�ւ̒ǉ�
��1����  : S
��2����  : R
��3����  : D
�߂�l   : ����


���\�b�h : deldb
�@�\     : �f�[�^�x�[�X����폜
��1����  : S
��2����  : R
��3����  : D(�ȗ��\�A�ȗ������ꍇ��S�AR�ɊY������S�Ă�D���폜)
�߂�l   : ����


���\�b�h : query_srd
�@�\     : S��R��D���H
��1����  : S
��2����  : R
��3����  : D
�߂�l   : �Y������̏ꍇtrue�A�����̏ꍇfalse


���\�b�h : query_s
�@�\     : S�ɂ��Ă̒m�����
��1����  : �o�͐�G���g���̃��[�g��
��2����  : S
�߂�l   : �Y������̏ꍇ�A�c���[�̑傫��


���\�b�h : query_r
�@�\     : R�ɂ��Ă̒m�����
��1����  : �o�͐�G���g���̃��[�g��
��2����  : R
�߂�l   : �Y������̏ꍇ�A�c���[�̑傫��


���\�b�h : query_d
�@�\     : D�ɂ��Ă̒m�����
��1����  : �o�͐�G���g���̃��[�g��
��2����  : D
�߂�l   : �Y������̏ꍇ�A�c���[�̑傫��


���\�b�h : query_sr
�@�\     : S��R�͉��H
��1����  : �o�͐�G���g����
��2����  : S
��3����  : R
�߂�l   : �Y������̏ꍇ�A�l�̌�


���\�b�h : query_sd
�@�\     : S�̉���D�H
��1����  : �o�͐�G���g����
��2����  : S
��3����  : D
�߂�l   : �Y������̏ꍇ�A�l�̌�


���\�b�h : query_rd
�@�\     : ����R��D�H
��1����  : �o�͐�G���g����
��2����  : R
��3����  : D
�߂�l   : �Y������̏ꍇ�A�l�̌�


���\�b�h : query_property
�@�\     : S�̎����Ă���R���
��1����  : �o�͐�G���g����
��2����  : S
�߂�l   : �Y������̏ꍇ�A�l�̌�


���\�b�h : query_class
�@�\     : S�̎��(���)�͉��H
��1����  : �o�͐�G���g����
��2����  : S
��3����  : R(�ȗ��\�A�ȗ������ꍇ��R=�u��ށv�Ɖ��肷��)
�߂�l   : �Y������̏ꍇ�A����̌�


���\�b�h : deduce_sr
�@�\     : S��R�͉��H(���_�t��)
��1����  : �o�͐�G���g����
��2����  : S
��3����  : R
�߂�l   : �Y������̏ꍇ�A�l�̌�
