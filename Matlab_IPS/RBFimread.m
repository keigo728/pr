%
% wasabiのrbfフォーマットデータを１０２４×１０２４画素の配列として読み込みます
%
function im = RBFimread(filename)

% filename(end-3:end)

if strcmp(filename(end-3:end),'.rbf')
	
	N=1024;
	fid = fopen(filename, 'r');
	fim = fread(fid, 2049*1000, 'ushort');
	%%% ヘッダ
	% head = fim(1:8*4);
	%%% 12bitデータ
	% data = fim(8*4+1:8*4+5)';
	fclose(fid);

	% 12bitデータを取り出して１０２４×１０２４画像に直す
	tim = fim(8*4+1:8*4+N*N);
	im = reshape(tim,N,N)';

else
	im = imread(filename);

	[x,y,z] = size(im);
	if z==3
		im = double( rgb2gray(im) );
	else
		im = double( im );
	end
end

	%figure;imshow(im,[]);colorbar;axis on;

