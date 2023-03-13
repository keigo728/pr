function wavefront = FResT_IterativeDoubleCONV( im, lamda, z, dx, dy, method, sss )

[N,M] = size(im);
[X,Y] = meshgrid(-N/2:N/2-1,-M/2:M/2-1);
CONV_FT_factor = 1;		% この係数はフレネル近似法とコンボリューション法の強度を一致させるために使う
						%     CONV_FT_factor = N /lamda /z *2 *pi;
 						% のとき一致するが、あまり意味ない

% deltaZ刻みで計算します
dz = z/10;

%%% エイリアスを避けるためにゼロパッドして２倍にする
Nd2=N/2;
Md2=M/2;
im = padarray(im,[Nd2,Md2]);

% 周波数軸の刻み幅
de=1/(2*N*dx);			% 2倍領域にするのでデータ数を2倍にした、これでいいかな
dn=1/(2*M*dy);

% 位相項
% 根号の中の値
theta = 1/lamda.^2 - (X.*de).^2 - (Y.*dn).^2;
% 根号内が正になるかチェック、根号が負ならばAA=0で強制的にゼロにする
AA = ones(size(theta));
AA(theta<0)=0;
theta(AA==0)=0;
% これは２ｎπ成分を計算しないようにするため
theta = (dz) .* sqrt( theta );
theta = theta - fix(theta);
% 根号内が負になるときはゼロにする
gphs = AA .* exp( i * 2 * pi * theta );											clear X Y theta

	if min(AA(:))==0
		figure;	imshow(AA,[],'notruesize');colorbar;drawnow;
	end
	
%%% エイリアスを避けるためにゼロパッドして２倍にする
gphs = padarray(gphs,[Nd2,Md2]);


%%% 反復フレネル変換
for c = dz : dz : z

	% ホログラムを逆フーリエ変換する
	ftim = fftshift( fft2( fftshift(im) ) );

	% 位相項と掛ける
	ftim = gphs .* ftim;

	% 各項の逆フーリエ変換同士をかけてフーリエ変換
	% 【新たに追加】正確には距離ｚに関する位相項が掛け算される
	%               これをつけると位相項が順次変わるので伝搬しているように見える（逆に位相の変化が見難くなる）
	im = ifftshift( ifft2( ifftshift( ftim ) ) );

	disp(['【4】 z=',num2str(c)]);
	%disp(['             2*pi*uo=',num2str(2*pi*uo),'  exp(-i*2*pi*uo)=',num2str(angle(exp(-i*2*pi*uo))),'  uo=',num2str(uo)]);
	%disp(['      fix(count/lamda)=', num2str( fix(count/lamda) ),'  count/lamda=',num2str(count/lamda) ]);

		% show_results(im,gphs,ftim,wavefront);	% 【確認】
end

%===========================================================================
%%% 中心部のみを返す、これを使うとデータ数が同じになる
if strcmp(sss,'same')
	wavefront = im( Nd2+1:N+Nd2, Md2+1:M+Md2 ) * CONV_FT_factor;
else
	wavefront = im * CONV_FT_factor;
end



	% 【旧バージョン】実際上はこれで問題ない
	% 	wavefront = fftshift(ifft2(fftshift( gphs.*ftim )));
