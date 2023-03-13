function wavefront = FRTrans(im,lambda,z,dx,dy,method,count,sss)
%FRTrans	Fresnel transform of Two-dimensional data
%	FRTrans(im,lambda,z,dx,dy,method,count,sss) returns 
%	the two-dimensional Fresnel transform of matrix im (2D image).
%	If im is a vector, the result will have the same orientation.
%	lambda : wavelength of laser
%	z : length between hologram and CCD camera
%	dx,dy : pixel size of CCD camera
%	method : 'FT', 'SINGLE_CONV', 'DOUBLE_CONV', 'ITERATIVE_DOUBLE_CONV'
%	count : Not use
%	sss : file name for data save
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   位相項を掛けるフレネル変換
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(method,'FT')

	wavefront = FRT_singleFFT(im,lambda,z,dx,dy,method,count,sss);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  コンボリューションによるフレネル変換
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif strcmp(method,'SINGLE_CONV')

	wavefront = FRT_singleCONV(im,lambda,z,dx,dy,method,count,sss);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  2倍領域ゼロパッド・コンボリューションによるフレネル変換
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif strcmp(method,'DOUBLE_CONV')
	
	wavefront = FRT_doubleCONV(im,lambda,z,dx,dy,method,count,sss);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2倍領域ゼロパッド・コンボリューションによるフレネル変換
%%%       反復フレネル変換のためのもの
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif strcmp(method,'ITERATIVE_DOUBLE_CONV')
	
	wavefront = FRT_IterativeDoubleCONV(im,lambda,z,dx,dy,method,count,sss);

end
