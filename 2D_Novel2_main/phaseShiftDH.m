function holo = phaseShiftingDH( initSet )
global SVFOLDER
global SVF

N = initSet.CCDX;
M = initSet.INPUT_IM_SIZE;

for i = 1:4

	%  ��x�摜�f�[�^�Ƃ��ăZ�[�u�����z���O�����i���K���f�[�^�j���g��
	% 8bit�摜�Ȃ̂Ő��\�͈����Ȃ�C12bit�摜�ŃZ�[�u�����ق����ǂ�
	filename = sprintf('%s%sOR%02d.tif', SVFOLDER, SVF, i-1);
	fringe = imread( filename );	% �z���O�����f�[�^���ēǂݍ���
																	% fringe = imnoise( fringe, 'gaussian', 0, 0.00001);	% �m�C�Y�t��
	% �����ɂ���
	dh{i} = double( fringe )/255;									% holo = double( holo )/4095;
	
	%figure; imshow(dh{i},[0,1]); title( sprintf('OR%02d.tif', i-1) ); colorbar;
	
end

%---------------------------------------
% 4step�ʑ��V�t�g�@ I=a+bcos(Q+$)
%---------------------------------------
holo = (dh{4} - dh{2}) + 1i * (dh{1} - dh{3});


%============================================================================================
% ������ ����͂X�U�~�X�U��f�Ȃ̂Ŏ��͂ɂO�𖄂߂�y���̕������R�����g�A�E�g����΂P�Q�W�~�P�Q�W�z
%============================================================================================
%tholo = zeros(N,N);
%tholo(N/2-M/2+1:N/2+M/2,N/2-M/2+1:N/2+M/2) = holo(:,:);
%holo = tholo;

%	showWaveAmpPhsRecoAmpPhs(holo, 0);	% �m�F
%	figure;	imshow(real(holo),[],'InitialMagnification','fit');	title('4step�ʑ��V�t�g�@'); colorbar; axis on; drawnow;
			