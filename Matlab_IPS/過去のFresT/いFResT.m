function wavefront = FResT( im, z, initSet, method, dataSize )
%FResT	Fresnel transform of Two-dimensional data
%	FResT(im,lamda,z,dx,dy,method,count,dataSize) returns 
%	the two-dimensional Fresnel transform of matrix im (2D image).
%	If im is a vector, the result will have the same orientation.
%	lamda : wavelength of laser
%	z : length between hologram and CCD camera
%	dx,dy : pixel size of CCD camera
%	method : 'FT', 'SINGLE_CONV', 'DOUBLE_CONV', 'ITERATIVE_DOUBLE_CONV'
%	dataSize : file name for data save
%

lamda = initSet.lamda;
dx = initSet.CCDdx;
dy = initSet.CCDdy;

if nargin < 5
	dataSize = 'same';
end

switch method

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   たんなるフーリエ変換
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'FFT'
	
	wavefront = simpleFFT(im);
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   位相項を掛けるフレネル変換
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case {'FR', 'FRT', 'FT'}

	if abs(z)~=Inf
		wavefront = FResT_singleFFT(im,lamda,z,dx,dy,method);
    else
        disp('z = Inf');	wavefront = simpleFFT(im);
	end
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  コンボリューションによるフレネル変換
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'SINGLE_CONV'
	
	if abs(z)~=Inf
		wavefront = FResT_singleCONV(im,lamda,z,dx,dy,method);
	else
        disp('z = Inf');	wavefront = simpleFFT(im);
    end
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  2倍領域ゼロパッド・コンボリューションによるフレネル変換
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'DOUBLE_CONV'

	if abs(z)~=Inf
		wavefront = FResT_doubleCONV(im,lamda,z,dx,dy,method, dataSize);
    else
        disp('z = Inf');	wavefront = simpleFFT(im);
	end
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2倍領域ゼロパッド・コンボリューションによるフレネル変換
%%%       反復フレネル変換のためのもの
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'ITERATIVE_DOUBLE_CONV'

	if abs(z)~=Inf
		wavefront = FResT_IterativeDoubleCONV(im,lamda,z,dx,dy,method, dataSize);
    else
        disp('z = Inf');	wavefront = simpleFFT(im);
	end
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  角スペクトル展開によるフレネル変換
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'SINGLE_ANGULAR'
	
	if abs(z)~=Inf
		wavefront = FResT_singleANGULAR(im,lamda,z,dx,dy,method);
	else
        disp('z = Inf');	wavefront = simpleFFT(im);
    end
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  2倍領域ゼロパッド・角スペクトル展開によるフレネル変換
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'DOUBLE_ANGULAR'

	if abs(z)~=Inf
		wavefront = FResT_doubleANGULAR(im,lamda,z,dx,dy,method, dataSize);
    else
        disp('z = Inf');	wavefront = simpleFFT(im);
	end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2倍領域ゼロパッド・角スペクトル展開によるフレネル変換
%%%       反復フレネル変換のためのもの
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'ITERATIVE_DOUBLE_ANGULAR'

	if abs(z)~=Inf
		wavefront = FResT_IterativeDoubleANGULAR(im,lamda,z,dx,dy,method, dataSize);
    else
        disp('z = Inf');	wavefront = simpleFFT(im);
	end
	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  シフテッドフレネル変換によるフレネル変換
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'SHIFTED_FRESNEL'
	
	if abs(z)~=Inf
		wavefront = FResT_shiftedFresnel( im, lamda, z, dx, dy, method, dv, du );
	else
        disp('z = Inf');	wavefront = simpleFFT(im);
	end
	
end

%#############################################################################


function w = simpleFFT(im)

[WX,WY] = size(im);
w = fftshift( ifft2( fftshift(im) ) ) * WX * WY;

