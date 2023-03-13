function wavefront = FRT_singleFFT(im,lambda,z,dx,dy,method,count,sss)

[WX,WY] = size(im);
[X,Y] = meshgrid(-WX/2:WX/2-1,-WY/2:WY/2-1);

% 位相項
phs = (pi/lambda/z).*( (X*dx).^2 + (Y*dy).^2 );
phs = exp(i*phs);
	
% 位相項をかける
im_phase = im.*phs;

% FFT
ft_im_phase = fftshift(ifft2(fftshift(im_phase)))/WX/WY;

% 係数の設定
keisu = pi*lambda*z.*( (X/(WX*dx)).^2 + (Y/(WY*dy)).^2 );
    

% 【旧バージョン】実際上はこれで問題ない
% wavefront = exp(i*keisu).*ft_im_phase;
	
% 【新たに追加】正確には距離ｚに関する位相項が掛け算される
%               これをつけると位相項が順次変わるので伝搬しているように見える
%              （逆に位相の変化が見難くなる）
uo = z/lambda - fix(z/lambda);
wavefront = (-i/lambda/z)*exp(i*2*pi*uo).*exp(i*keisu).*ft_im_phase;		

