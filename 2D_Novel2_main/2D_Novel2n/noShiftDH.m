function holo = noShiftDH( initSet )
global SVFOLDER
global SVF

N = initSet.CCDX;
M = initSet.INPUT_IM_SIZE;


%  ��x�摜�f�[�^�Ƃ��ăZ�[�u�����z���O�����i���K���f�[�^�j���g��
% 8bit�摜�Ȃ̂Ő��\�͈����Ȃ�C12bit�摜�ŃZ�[�u�����ق����ǂ�
filename = sprintf('%sholo1.tif', SVFOLDER)
fringe = imread(filename);	% �z���O�����f�[�^���ēǂݍ���
																	% fringe = imnoise( fringe, 'gaussian', 0, 0.00001);	% �m�C�Y�t��
% �����ɂ���
holo = double( fringe )/255;									% holo = double( holo )/4095;



%============================================================================================
% ������ ����͂X�U�~�X�U��f�Ȃ̂Ŏ��͂ɂO�𖄂߂�y���̕������R�����g�A�E�g����΂P�Q�W�~�P�Q�W�z
%============================================================================================
%tholo = zeros(N,N);
%tholo(N/2-M/2+1:N/2+M/2,N/2-M/2+1:N/2+M/2) = holo(:,:);
%holo = tholo;

	%showWaveAmpPhsRecoAmpPhs(holo, 0);	% �m�F
	figure;	imshow(real(holo),[],'InitialMagnification','fit');	title('CGH'); colorbar; axis on; drawnow;
			