function z = spatialShift_PhaseFactor(px,py,N,X,Y)
% ピークの位置(px,py)から、そのピーク位置方向に平行移動する作用をもつ
% 線形位相を持つ複素振幅をつくる
%
global DEBUG

if nargin==3
	[X,Y]=meshgrid(-N/2:N/2-1,-N/2:N/2-1);
end


Tx=N/(N/2-px+1);
Ty=N/(N/2-py+1);

z = exp(i*2*pi*(X/Tx+Y/Ty));




if DEBUG
	
		figure;imshow(real(z),[]);
	
	ftz = fftshift(fft2(fftshift(z)));

		figure;imshow(abs(ftz).^2);title([num2str(Tx) ' = ' num2str(Ty)]);

end