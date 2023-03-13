function [bayer,RR,GG,BB] = loadRAW_OLYMPAS(filename)

Level = 2^12;		% 12 [bit]

%------------------------------------------------------
fid = fopen(filename,'r','b');
[A,count] = fread(fid,19,'ubit8');
count

		% disp('�y�m�F�z�w�b�_�s�����\������');
		% A;
		% dec2hex(A);

%------------------------------------------------------
disp('�y�m�F�z������ɕϊ�����');

cA=char(A)'			%B=dec2hex(A8(1:20,1))
cA(1:2)
w=str2double(cA(4:7));
h=str2double(cA(9:12));
L=str2double(cA(14:18));

	disp(['     w=' num2str(w) ',  h=' num2str(h) ',  L=' num2str(L)]);disp(' ');

%------------------------------------------------------
disp('�y���C���z�f�[�^�݂̂����o��');

% �w�b�_�����������ĕʂ̔z��ɑ������	% ���̐���11�́Ccount-2576*1926=10���C11�Ԗڂ���f�[�^�ɂȂ��Ă��邱�Ƃ��瓾��ꂽ�C�̂��ȁH
[bayer,count] = fread(fid,'ubit16');
disp(['�ǂݍ��݃f�[�^����' num2str(count)]);
d=count-w*h;
if d==0
	disp(['�f�[�^���� ' num2str(w) ' x ' num2str(h) ' = ' num2str(w*h)]);
else
	disp(['�Ԉ���Ă܂��C�f�[�^���� ' num2str(w) ' x ' num2str(h) ' = ' num2str(w*h)]);
end
fclose(fid)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pgm�t�@�C���̃w�b�_���C�iV,H)=(2576,1926)		%�iV,H)=(2088,1550)
bayer = reshape(bayer,w,h);

[ma,p,q]=max2d(bayer)
mi=min(bayer(:))

		% figure(10);hist(bayer);
	
		%%% disp('�y�m�F�z20�s�����\������');
		% bayer(1:20,1);
		% dec2hex(bayer(1:20,1));


% �c���̕��������킹��
bayer = rot90(bayer',2);

	figure(70);	imshow( (bayer),[0,Level],'notruesize');colorbar;
				title(['���ꂪ�x�C���[�z�񂾂Ǝv��  Max=' num2str(ma) ' Min=' num2str(mi)]);drawnow;

% 	imwrite(uint8(rot90(bayer)*255/2^12),[filename(1:end-4) 'T.bmp'],'bmp' );
	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	�x�C���[�z��̂܂܂�RGB�f�[�^
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% �y�΁z�x�C���[�z��̃J���[���Ƃ̈ʒu��\���z��
col=uint8([	0 1;	...
			1 0		]);
col=repmat(col,h/2,w/2);

GG = bayer.*double(col);

%%% �y�ԁz�x�C���[�z��̃J���[���Ƃ̈ʒu��\���z��
col=uint8([	1 0;	...
			0 0		]);
col=repmat(col,h/2,w/2);

RR = bayer.*double(col);

%%% �y�z�x�C���[�z��̃J���[���Ƃ̈ʒu��\���z��
col=uint8([	0 0;	...
			0 1		]);
col=repmat(col,h/2,w/2);

BB = bayer.*double(col);


% 	figure(71),imshow(RR,[0,Level],'notruesize');axis on;colorbar;
% 				title(['�x�C���[�z��̂܂܁@Red  max=' num2str(maR)]);drawnow;
% 	figure(72),imshow(GG,[0,Level],'notruesize');axis on;colorbar;
% 				title(['�x�C���[�z��̂܂܁@Green  max=' num2str(maG)]);drawnow;
% 	figure(73),imshow(BB,[0,Level],'notruesize');axis on;colorbar;
% 				title(['�x�C���[�z��̂܂܁@Blue  max=' num2str(maB)]);drawnow;

