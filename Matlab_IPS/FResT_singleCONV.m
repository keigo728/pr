function wavefront = FResT_singleCONV( im, lamda, z, dx, dy, method )

[N,M] = size(im);
[X,Y] = meshgrid(-N/2:N/2-1,-M/2:M/2-1);
CONV_FT_factor = 1;		% この係数はフレネル近似法とコンボリューション法の強度を一致させるために使う
						%     CONV_FT_factor = N /lamda /z *2 *pi;
 						% のとき一致するが、あまり意味ない
						
% 周波数軸の刻み幅
de=1/(N*dx);
dn=1/(M*dy);

% 位相項
theta = (lamda*z/2) .* ( (X.*de).^2 + (Y.*dn).^2 );
theta = theta - fix(theta);								% これは２ｎπ成分を計算しないようにするため
gphs = exp( -i * 2 * pi * theta ) * CONV_FT_factor;								clear theta


% 【テスト】位相項を直接FFTで求めるとき
%           これを使うとフレネル近似法と同じ強度で再生される
%           しかし、再生法が異なるので大きな意味があるわけでない
% gphs = fftshift( fft2( fftshift(   (-i/lamda/z) * exp( i*(pi/lamda/z) * ((X.*dx).^2+(Y.*dy).^2) )   )));

																				clear X Y
% ホログラムを逆フーリエ変換する
ftim = fftshift( fft2( fftshift(im) ) );


% 位相項と掛ける
ftim = gphs .* ftim;															clear gphs

% 距離ｚに関する位相項
uo = z/lamda - fix(z/lamda);
Ad = exp(i*2*pi*uo);

% 距離ｚに関する位相項が掛け算される
% 強度で考えるときはなくてもよい
% これをつけると位相項が順次変わるので伝搬しているように見える（逆に位相の変化が見難くなる）
wavefront = Ad .* ifftshift( ifft2( ifftshift( ftim ) ) );



%--------------------------------------------------------------------------

% 各項の逆フーリエ変換同士をかけてフーリエ変換
% 【旧バージョン】実際上はこれで問題ない
% 	wavefront = fftshift(fft2(fftshift( gphs.*ftim )));