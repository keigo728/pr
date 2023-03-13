function [bayer,RR,GG,BB] = loadRAW_OLYMPAS(filename)

Level = 2^12;		% 12 [bit]

%------------------------------------------------------
fid = fopen(filename,'r','b');
[A,count] = fread(fid,19,'ubit8');
count

		% disp('【確認】ヘッダ行だけ表示する');
		% A;
		% dec2hex(A);

%------------------------------------------------------
disp('【確認】文字列に変換する');

cA=char(A)'			%B=dec2hex(A8(1:20,1))
cA(1:2)
w=str2double(cA(4:7));
h=str2double(cA(9:12));
L=str2double(cA(14:18));

	disp(['     w=' num2str(w) ',  h=' num2str(h) ',  L=' num2str(L)]);disp(' ');

%------------------------------------------------------
disp('【メイン】データのみを取り出す');

% ヘッダ部分を除いて別の配列に代入する	% この数字11は，count-2576*1926=10より，11番目からデータになっていることから得られた，のかな？
[bayer,count] = fread(fid,'ubit16');
disp(['読み込みデータ数＝' num2str(count)]);
d=count-w*h;
if d==0
	disp(['データ数は ' num2str(w) ' x ' num2str(h) ' = ' num2str(w*h)]);
else
	disp(['間違ってます，データ数は ' num2str(w) ' x ' num2str(h) ' = ' num2str(w*h)]);
end
fclose(fid)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pgmファイルのヘッダより，（V,H)=(2576,1926)		%（V,H)=(2088,1550)
bayer = reshape(bayer,w,h);

[ma,p,q]=max2d(bayer)
mi=min(bayer(:))

		% figure(10);hist(bayer);
	
		%%% disp('【確認】20行だけ表示する');
		% bayer(1:20,1);
		% dec2hex(bayer(1:20,1));


% 縦横の方向をあわせる
bayer = rot90(bayer',2);

	figure(70);	imshow( (bayer),[0,Level],'notruesize');colorbar;
				title(['これがベイヤー配列だと思う  Max=' num2str(ma) ' Min=' num2str(mi)]);drawnow;

% 	imwrite(uint8(rot90(bayer)*255/2^12),[filename(1:end-4) 'T.bmp'],'bmp' );
	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	ベイヤー配列のままのRGBデータ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 【緑】ベイヤー配列のカラーごとの位置を表す配列
col=uint8([	0 1;	...
			1 0		]);
col=repmat(col,h/2,w/2);

GG = bayer.*double(col);

%%% 【赤】ベイヤー配列のカラーごとの位置を表す配列
col=uint8([	1 0;	...
			0 0		]);
col=repmat(col,h/2,w/2);

RR = bayer.*double(col);

%%% 【青】ベイヤー配列のカラーごとの位置を表す配列
col=uint8([	0 0;	...
			0 1		]);
col=repmat(col,h/2,w/2);

BB = bayer.*double(col);


% 	figure(71),imshow(RR,[0,Level],'notruesize');axis on;colorbar;
% 				title(['ベイヤー配列のまま　Red  max=' num2str(maR)]);drawnow;
% 	figure(72),imshow(GG,[0,Level],'notruesize');axis on;colorbar;
% 				title(['ベイヤー配列のまま　Green  max=' num2str(maG)]);drawnow;
% 	figure(73),imshow(BB,[0,Level],'notruesize');axis on;colorbar;
% 				title(['ベイヤー配列のまま　Blue  max=' num2str(maB)]);drawnow;

