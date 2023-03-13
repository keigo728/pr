%
% wasabi��rbf�t�H�[�}�b�g�f�[�^���P�O�Q�S�~�P�O�Q�S��f�̔z��Ƃ��ēǂݍ��݂܂�
%
function im = RBFimread(filename)

% filename(end-3:end)

if strcmp(filename(end-3:end),'.rbf')
	
	N=1024;
	fid = fopen(filename, 'r');
	fim = fread(fid, 2049*1000, 'ushort');
	%%% �w�b�_
	% head = fim(1:8*4);
	%%% 12bit�f�[�^
	% data = fim(8*4+1:8*4+5)';
	fclose(fid);

	% 12bit�f�[�^�����o���ĂP�O�Q�S�~�P�O�Q�S�摜�ɒ���
	tim = fim(8*4+1:8*4+N*N);
	im = reshape(tim,N,N)';

	% 	figure;imshow(tim,[0,4095]);colorbar;axis on;
	
else
	im = imread(filename);

	[x,y,z] = size(im);
	if z==3
		im = double( rgb2gray(im(1:1024,1:1024,:)) );
	else
		im = double( im(1:1024,1:1024,:) );
	end
end
