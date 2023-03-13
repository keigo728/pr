function wavefront = FResT_singleFFT( im, lamda, z, dx, dy, method )

LENGTHORDER = 1e6;	% 最後で値が大きくなるのを防ぐためμｍオーダーを変える
					% 最後の係数の部分以外は無次元数になるので影響ない

[N,M] = size(im);
[X,Y] = meshgrid(-N/2:N/2-1,-M/2:M/2-1);

% 係数位相の設定
de = 1/(N*dx);
dn = 1/(M*dy);
coeff = ( lamda * z /2) .* ( (X*de).^2 + (Y*dn).^2 );
coeff = coeff - fix(coeff);

% 位相項をかける
phs = ( 1/2 /lamda /z) .* ( (X*dx).^2 + (Y*dy).^2 );
phs = phs - fix(phs);
im = im .* exp(i*2*pi*phs);													clear X Y phs

% FFT
ftim = fftshift( fft2( fftshift(im) ) );


% 【新たに追加】正確には距離ｚに関する位相項が掛け算される
%               これをつけると位相項が順次変わるので伝搬しているように見える
%              （逆に位相の変化が見難くなる）
uo = z/lamda - fix(z/lamda);
Ad = exp(i*2*pi*uo);
lamda = lamda * LENGTHORDER;
z = z * LENGTHORDER;
wavefront = (-i/lamda/z) * Ad .* exp(i*2*pi*coeff) .* ftim;		


%------------------------------------------------------------------------

% 【旧バージョン】実際上はこれで問題ない
% wavefront = exp(i*coeff).*ft_cim;