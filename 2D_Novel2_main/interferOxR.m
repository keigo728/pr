function [holo, z, Imax] = interferOxR( Opwave, Rwave, initSet, Imax, count)
global SVFOLDER
global SVF

%N = initSet.CCDX;
%M = initSet.INPUT_IM_SIZE;

%======================================
%  �y���̔g�z�Ɓy�Q�Ɣg�z�Ƃ̊���
%======================================
holo = abs( Opwave.WAVE + Rwave.WAVE ).^2;

%==================================================================
% ������ 96x96�ɒ����y���̕������R�����g�A�E�g����΂P�Q�W�~�P�Q�W�z
%==================================================================
%holo = holo(N/2-M/2+1:N/2+M/2,N/2-M/2+1:N/2+M/2);

if Imax<0
	Imax = 1.5 * max(holo(:));
end

%----------------------------------------------------------------------
% 8bit�摜�ŃZ�[�u����Ɛ��\�͈����Ȃ�C12bit�摜�ŃZ�[�u�����ق����ǂ�
%----------------------------------------------------------------------
filename = sprintf('%sholo1.tif', SVFOLDER);
imwrite( uint8(255*holo/Imax), filename, 'tif');		% ��P�t���[���̍ő�lImax�Ő��K������8bit�f�[�^�ɕϊ����Ă���
% imwrite( uint16(4095*holo/Imax), filename, 'tif');	% ��P�t���[���̍ő�lImax�Ő��K������12bit�f�[�^�ɕϊ����Ă���
%----------------------
%%% �Đ������̐ݒ�
%----------------------
% ���ʔg�̂Ƃ��A�_�����̈ʒu��
%   1. ���̈ʒu�Ɠ����Ƃ��́A�����Y���X�t�[���G�ϊ��^�@�ˁ@FFT�ōĐ��\
%   2. ���̈ʒu�ƈقȂ�Ƃ��́A���ʂ̃t���l���^�@�ˁ@�œ_�����𒲐�����΁AFT�܂���CONV�ōĐ��\                      
if strcmp(Rwave.type,'sphere') && (-Rwave.Z) ~= Opwave.Z
	
	z = Opwave.Z * (-Rwave.Z)/((-Rwave.Z) - Opwave.Z);
	disp(['���Đ������ύX@OxR = ' num2str(z)])
	
else
	
	z = Opwave.Z;
	
end

