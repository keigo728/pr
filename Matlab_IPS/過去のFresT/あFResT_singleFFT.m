function wavefront = FResT_singleFFT( im, lamda, z, dx, dy, method )

[WX,WY] = size(im);
[X,Y] = meshgrid(-WX/2:WX/2-1,-WY/2:WY/2-1);


% 係数の設定
de = 1/(WX*dx);
dn = 1/(WY*dy);
coeff = pi * lamda * z .* ( (X*de).^2 + (Y*dn).^2 );


% 位相項をかける
phs = (pi/lamda/z).*( (X*dx).^2 + (Y*dy).^2 );
cim = im .* exp(i*phs);

clear X Y phs


% FFT
ft_cim = fftshift( ifft2( fftshift(cim) ) )/WX/WY;

clear cim


% 【新たに追加】正確には距離ｚに関する位相項が掛け算される
%               これをつけると位相項が順次変わるので伝搬しているように見える
%              （逆に位相の変化が見難くなる）
uo = z/lamda - fix(z/lamda);
wavefront = (-i/lamda/z) * exp(i*2*pi*uo) .* exp(i*coeff) .* ft_cim;		



%------------------------------------------------------------------------

% 【旧バージョン】実際上はこれで問題ない
% wavefront = exp(i*coeff).*ft_cim;