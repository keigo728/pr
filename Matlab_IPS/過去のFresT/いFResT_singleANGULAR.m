function wavefront = FResT_singleANGULAR( im, lamda, z, dx, dy, method )

[N,M] = size(im);
[X,Y] = meshgrid(-N/2:N/2-1,-M/2:M/2-1);
CONV_FT_factor = 1;		% この係数はフレネル近似法とコンボリューション法の強度を一致させるために使う
						%     CONV_FT_factor = N /lamda /z *2 *pi;
 						% のとき一致するが、あまり意味ない

% 周波数軸の刻み幅
de=1/(N*dx);
dn=1/(M*dy);

% 位相項
theta = (z) .* sqrt( 1/lamda.^2 - (X.*de).^2 - (Y.*dn).^2 );
theta = theta - fix(theta);								% これは２ｎπ成分を計算しないようにするため
gphs = exp( i * 2 * pi * theta ) * CONV_FT_factor;								clear theta
																				clear X Y
																				
% ホログラムを逆フーリエ変換する
ftim = fftshift( fft2( fftshift(im) ) );


% 位相項と掛ける
ftim = gphs .* ftim;															clear gphs


% 逆フーリエ変換
wavefront = ifftshift( ifft2( ifftshift( ftim ) ) );
