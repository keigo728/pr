
%%% �ݒ�
initSet.lamda = 633e-9;		% [m]	HeNe laser

%%% CCD�̐ݒ�
initSet.INPUT_IM_SIZE = 1024; %�摜�T�C�Y

X = 1920;			% �f�[�^��
Y = 1080;
%X = 512;
%Y = 512;
initSet.CCDX  = X;
initSet.CCDY  = Y;
initSet.CCDdx = 5.4e-6;
initSet.CCDdy = 5.4e-6;
%initSet.CCDdx = 6.45e-6;		% CCD�P��f�̑傫��[m]
%initSet.CCDdy = 6.45e-6;
%initSet.CCDdx = 1.00e-5;		% CCD�P��f�̑傫��[m]
%initSet.CCDdy = 1.00e-5;

%initSet.CCDdx = 1.5e-4;		% CCD�P��f�̑傫��[m]
%initSet.CCDdy = 1.5e-4;

HX = 1920;
HY = 1080;
%HX = 512;
%HY = 1024;

initSet.HMax = 2048;
initSet.HCCDX = HX;
initSet.HCCDY = HY;
%initSet.HCCDdx = 6.45e-6;		% CCD�P��f�̑傫��[m]
%initSet.HCCDdy = 6.45e-6;
%initSet.HCCDdx = 1.00e-5;		% CCD�P��f�̑傫��[m]
%initSet.HCCDdy = 1.00e-5;

initSet.HCCDdx = 5.4e-6;
initSet.HCCDdy = 5.4e-6;

%initSet.HCCDdx = 2.7e-6;
%initSet.HCCDdy = 2.7e-6;

[initSet.SX,initSet.SY]	= meshgrid( -HX/2 : HX/2-1,	-HY/2 : HY/2-1 );

%--------------------------------------------------------------------------
%  ��x�摜�f�[�^�Ƃ��ăZ�[�u�����z���O�������g���A�f�t�H���gON
%--------------------------------------------------------------------------
initSet.USE_DH = 'ON';		%	'off'	%

%--------------------------------------------------------------------------
%  �Ō�̃t���l���ʑ�
%--------------------------------------------------------------------------
initSet.FRESNELPHASE = 'ON';

%--------------------------------------------------------------------------
%  �t���l���ʑ��̕��@
%--------------------------------------------------------------------------
initSet.FRT_METHOD =	'DOUBLE_ANGULAR';	%		'ITERATIVE_DOUBLE_ANGULAR'
