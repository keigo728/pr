function wavefront = FResT_singleFFT( im, lamda, z, dx, dy, method )

[WX,WY] = size(im);
[X,Y] = meshgrid(-WX/2:WX/2-1,-WY/2:WY/2-1);


% ŒW”‚Ìİ’è
de = 1/(WX*dx);
dn = 1/(WY*dy);
coeff = pi * lamda * z .* ( (X*de).^2 + (Y*dn).^2 );


% ˆÊ‘Š€‚ğ‚©‚¯‚é
phs = (pi/lamda/z).*( (X*dx).^2 + (Y*dy).^2 );
cim = im .* exp(i*phs);

clear X Y phs


% FFT
ft_cim = fftshift( ifft2( fftshift(cim) ) )/WX/WY;

clear cim


% yV‚½‚É’Ç‰Áz³Šm‚É‚Í‹——£‚š‚ÉŠÖ‚·‚éˆÊ‘Š€‚ªŠ|‚¯Z‚³‚ê‚é
%               ‚±‚ê‚ğ‚Â‚¯‚é‚ÆˆÊ‘Š€‚ª‡Ÿ•Ï‚í‚é‚Ì‚Å“`”À‚µ‚Ä‚¢‚é‚æ‚¤‚ÉŒ©‚¦‚é
%              i‹t‚ÉˆÊ‘Š‚Ì•Ï‰»‚ªŒ©“ï‚­‚È‚éj
uo = z/lamda - fix(z/lamda);
wavefront = (-i/lamda/z) * exp(i*2*pi*uo) .* exp(i*coeff) .* ft_cim;		



%------------------------------------------------------------------------

% y‹Œƒo[ƒWƒ‡ƒ“zÀÛã‚Í‚±‚ê‚Å–â‘è‚È‚¢
% wavefront = exp(i*coeff).*ft_cim;