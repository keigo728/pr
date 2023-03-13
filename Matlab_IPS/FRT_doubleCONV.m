function wavefront = FRT_doubleCONV(im,lambda,z,dx,dy,method,count,sss)

[WX,WY] = size(im);
[X,Y] = meshgrid(-WX/2:WX/2-1,-WY/2:WY/2-1);
						
de=1/(2*WX*dx);
dn=1/(2*WY*dy);	
	
% �ʑ���
gphs = exp(-i*pi*lambda*z.*( (X.*de).^2 + (Y.*dn).^2 ));	

%===========================================================================
%%% �G�C���A�X������邽�߂Ƀ[���p�b�h���ĂQ�{�ɂ���
gphs = padarray(gphs,[WX/2,WY/2],'both');
  im = padarray(im,  [WX/2,WY/2],'both');
%===========================================================================
	
% �z���O�������t�t�[���G�ϊ�����
ftim = fftshift(ifft2(fftshift(im)));
	
% �e���̋t�t�[���G�ϊ����m�������ăt�[���G�ϊ�
% �y���o�[�W�����z���ۏ�͂���Ŗ��Ȃ�
% 	wavefront = fftshift(ifft2(fftshift( gphs.*ftim )));

% �y�V���ɒǉ��z���m�ɂ͋������Ɋւ���ʑ������|���Z�����
%               ���������ƈʑ����������ς��̂œ`�����Ă���悤�Ɍ����邪�A�t�Ɉʑ��̕ω�������Ȃ�
uo = z/lambda - fix(z/lambda);
wavefront = exp(i*2*pi*uo).*fftshift(fft2(fftshift( gphs.*ftim )));


disp(['�y3�z  z=',num2str(z),'  count=',num2str(count),'  uo=',num2str(uo)]);
% disp(['      fix(z/lambda)=', num2str( fix(z/lambda) ),'  z/lambda=',num2str(z/lambda) ]);

	
%===========================================================================
%%% ���S���݂̂�Ԃ��A������g���ƃf�[�^���������ɂȂ�
if strcmp(sss,'same')
	wavefront = wavefront( WX/2+1:WX+WX/2, WY/2+1:WY+WY/2 );
end
%===========================================================================

