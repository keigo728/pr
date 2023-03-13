function wavefront = FRT_singleFFT(im,lambda,z,dx,dy,method,count,sss)

[WX,WY] = size(im);
[X,Y] = meshgrid(-WX/2:WX/2-1,-WY/2:WY/2-1);

% ˆÊ‘Š€
phs = (pi/lambda/z).*( (X*dx).^2 + (Y*dy).^2 );
phs = exp(i*phs);
	
% ˆÊ‘Š€‚ğ‚©‚¯‚é
im_phase = im.*phs;

% FFT
ft_im_phase = fftshift(ifft2(fftshift(im_phase)))/WX/WY;

% ŒW”‚Ìİ’è
keisu = pi*lambda*z.*( (X/(WX*dx)).^2 + (Y/(WY*dy)).^2 );
    

% y‹Œƒo[ƒWƒ‡ƒ“zÀÛã‚Í‚±‚ê‚Å–â‘è‚È‚¢
% wavefront = exp(i*keisu).*ft_im_phase;
	
% yV‚½‚É’Ç‰Áz³Šm‚É‚Í‹——£‚š‚ÉŠÖ‚·‚éˆÊ‘Š€‚ªŠ|‚¯Z‚³‚ê‚é
%               ‚±‚ê‚ğ‚Â‚¯‚é‚ÆˆÊ‘Š€‚ª‡Ÿ•Ï‚í‚é‚Ì‚Å“`”À‚µ‚Ä‚¢‚é‚æ‚¤‚ÉŒ©‚¦‚é
%              i‹t‚ÉˆÊ‘Š‚Ì•Ï‰»‚ªŒ©“ï‚­‚È‚éj
uo = z/lambda - fix(z/lambda);
wavefront = (-i/lambda/z)*exp(i*2*pi*uo).*exp(i*keisu).*ft_im_phase;		

