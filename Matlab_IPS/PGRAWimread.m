% raw16でセーブしてください
% ポイントグレイ社のRAWフォーマットデータを読み込みます
% 1928×1448画素の配列として
% 1024×1024画素の配列として
% 2048×2048画素の配列として
% 1280×1024画素の配列として

function im = PGRAWimread(filename)

%filename(end-3:end)

if strcmp(filename(end-3:end),'.raw')

	% RAWファイルをオープン
	fid = fopen(filename, 'r');
	
	% ２バイト(ushort)でファイルの最後まで読みだす
	[data, count] = fread(fid, inf, 'ushort');
	
	fclose(fid);
	
	%読み出し数より画像サイズを推定する
	switch count
	case (1928 * 1448)
		NX = 1928;
		NY = 1448;
		disp('一次元配列を1928×1448画像に直す');
		
	case (1024 * 1024)
		NX = 1024;
		NY = 1024;
		disp('一次元配列を1024×1024画像に直す');
		
    case (2048 * 2048)
		NX = 2048;
		NY = 2048;
		disp('一次元配列を2048×2048画像に直す');
		
	case (1920 * 1024)			%	NX = 1920;	NY = 1024;	data = double( reshape(data,NX,NY) );
		NX = 1280;
		NY = 1024;
		data = reshape(data,[3,655360])';		%1024*1920/3=655360
		data(:,3) = [];
		data = data';
		disp('一次元配列を1280×1024画像に直す');
		
	end

	% 一次元配列をNX×NY画像に直す
	im = double( reshape(data,NX,NY)' );
	
else
	
	im = double( imread(filename) );
	
end

		 
% figure;imshow(im,[],'notruesize');colorbar;axis on;
	