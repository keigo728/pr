function wavefront = FResT_singleCONV( im, lamda, z, dx, dy, method )

[WX,WY] = size(im);
[X,Y] = meshgrid(-WX/2:WX/2-1,-WY/2:WY/2-1);
	
% �ʑ���
de=1/(WX*dx);
dn=1/(WY*dy);
gphs = exp(-i*pi*lamda*z.*( (X.*de).^2 + (Y.*dn).^2 ));

clear X Y


% �z���O�������t�t�[���G�ϊ�����
ftim = fftshift( ifft2( fftshift(im) ) );


% �y�V���ɒǉ��z���m�ɂ͋������Ɋւ���ʑ������|���Z�����
%               ���������ƈʑ����������ς��̂œ`�����Ă���悤�Ɍ�����
%               �i�t�Ɉʑ��̕ω�������Ȃ�j
uo = z/lamda - fix(z/lamda);
wavefront = exp(i*2*pi*uo) .* fftshift( fft2( fftshift( gphs.*ftim ) ) );



%--------------------------------------------------------------------------

% �e���̋t�t�[���G�ϊ����m�������ăt�[���G�ϊ�
% �y���o�[�W�����z���ۏ�͂���Ŗ��Ȃ�
% 	wavefront = fftshift(fft2(fftshift( gphs.*ftim )));