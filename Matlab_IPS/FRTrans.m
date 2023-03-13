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
%%%   �ʑ������|����t���l���ϊ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(method,'FT')

	wavefront = FRT_singleFFT(im,lambda,z,dx,dy,method,count,sss);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  �R���{�����[�V�����ɂ��t���l���ϊ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif strcmp(method,'SINGLE_CONV')

	wavefront = FRT_singleCONV(im,lambda,z,dx,dy,method,count,sss);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  2�{�̈�[���p�b�h�E�R���{�����[�V�����ɂ��t���l���ϊ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif strcmp(method,'DOUBLE_CONV')
	
	wavefront = FRT_doubleCONV(im,lambda,z,dx,dy,method,count,sss);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2�{�̈�[���p�b�h�E�R���{�����[�V�����ɂ��t���l���ϊ�
%%%       �����t���l���ϊ��̂��߂̂���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif strcmp(method,'ITERATIVE_DOUBLE_CONV')
	
	wavefront = FRT_IterativeDoubleCONV(im,lambda,z,dx,dy,method,count,sss);

end
