function wavefront = FResT( im, z, initSet, method, sss )
%FResT	Fresnel transform of Two-dimensional data
%	FResT(im,lamda,z,dx,dy,method,count,sss) returns 
%	the two-dimensional Fresnel transform of matrix im (2D image).
%	If im is a vector, the result will have the same orientation.
%	lamda : wavelength of laser
%	z : length between hologram and CCD camera
%	dx,dy : pixel size of CCD camera
%	method : 'FT', 'SINGLE_CONV', 'DOUBLE_CONV', 'ITERATIVE_DOUBLE_CONV'
%	sss : file name for data save
%

lamda = initSet.lamda;
dx = initSet.CCDdx;
dy = initSet.CCDdy;

if nargin < 7
	sss = 'same';
end

switch method

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   ����Ȃ�t�[���G�ϊ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'FFT'
	
	[WX,WY] = size(im);
	wavefront = fftshift( ifft2( fftshift(im) ) ) * WX * WY;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   �ʑ������|����t���l���ϊ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'FT'

	if abs(z)~=Inf
		wavefront = FResT_singleFFT(im,lamda,z,dx,dy,method);
    else
        disp('z = Inf');
		[WX,WY] = size(im);
		wavefront = fftshift( ifft2( fftshift(im) ) ) * WX * WY;
	end
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  �R���{�����[�V�����ɂ��t���l���ϊ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'SINGLE_CONV'
	
	if abs(z)~=Inf
		wavefront = FResT_singleCONV(im,lamda,z,dx,dy,method);
	else
        disp('z = Inf');
		[WX,WY] = size(im);
		wavefront = fftshift( ifft2( fftshift(im) ) ) * WX * WY;
    end
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  2�{�̈�[���p�b�h�E�R���{�����[�V�����ɂ��t���l���ϊ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'DOUBLE_CONV'

	if abs(z)~=Inf
		wavefront = FResT_doubleCONV(im,lamda,z,dx,dy,method,sss);
    else
        disp('z = Inf');
		[WX,WY] = size(im);
		wavefront = fftshift( ifft2( fftshift(im) ) ) * WX * WY;
	end
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2�{�̈�[���p�b�h�E�R���{�����[�V�����ɂ��t���l���ϊ�
%%%       �����t���l���ϊ��̂��߂̂���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'ITERATIVE_DOUBLE_CONV'

	if abs(z)~=Inf
		wavefront = FResT_IterativeDoubleCONV(im,lamda,z,dx,dy,method,sss);
    else
        disp('z = Inf');
		[WX,WY] = size(im);
		wavefront = fftshift( ifft2( fftshift(im) ) ) * WX * WY;
	end
	
end
