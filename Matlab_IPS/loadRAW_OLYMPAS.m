function [bayer,RR,GG,BB] = loadRAW_OLYMPAS(filename)

Level = 2^12;		% 12 [bit]

%------------------------------------------------------
% pgm -> bayer
%------------------------------------------------------
bayer = imreadPGM16(filename,'ON');
[w,h]=size(bayer);

[ma,p,q]=max2d(bayer)
mi=min(bayer(:))

% 		figure(70);
% 		imshow( bayer,[0,Level],'notruesize');colorbar;axis on;
% 		title(['���ꂪ�x�C���[�z�񂾂Ǝv��  Max=' num2str(ma) ' Min=' num2str(mi)]);
% 		drawnow;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	�x�C���[�z��̂܂܂�RGB�f�[�^
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% �y�΁z�x�C���[�z��̃J���[���Ƃ̈ʒu��\���z��
col=uint8([	0 1;	...
			1 0		]);
col=repmat(col,w/2,h/2);

GG = bayer.*double(col);

%%% �y�ԁz�x�C���[�z��̃J���[���Ƃ̈ʒu��\���z��
col=uint8([	1 0;	...
			0 0		]);
col=repmat(col,w/2,h/2);

RR = bayer.*double(col);

%%% �y�z�x�C���[�z��̃J���[���Ƃ̈ʒu��\���z��
col=uint8([	0 0;	...
			0 1		]);
col=repmat(col,w/2,h/2);

BB = bayer.*double(col);


% 	figure(71),imshow(RR,[0,Level],'notruesize');axis on;colorbar;
% 				title(['�x�C���[�z��̂܂܁@Red  max=' num2str(maR)]);drawnow;
% 	figure(72),imshow(GG,[0,Level],'notruesize');axis on;colorbar;
% 				title(['�x�C���[�z��̂܂܁@Green  max=' num2str(maG)]);drawnow;
% 	figure(73),imshow(BB,[0,Level],'notruesize');axis on;colorbar;
% 				title(['�x�C���[�z��̂܂܁@Blue  max=' num2str(maB)]);drawnow;

