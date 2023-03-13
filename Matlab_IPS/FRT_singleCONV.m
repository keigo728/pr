function wavefront = FRT_singleCONV(im,lambda,z,dx,dy,method,count,sss)

[WX,WY] = size(im);
[X,Y] = meshgrid(-WX/2:WX/2-1,-WY/2:WY/2-1);

de=1/(WX*dx);
dn=1/(WY*dy);
	
% �ʑ���
gphs = exp(-i*pi*lambda*z.*( (X.*de).^2 + (Y.*dn).^2 ));

% �z���O�������t�t�[���G�ϊ�����
ftim = fftshift(ifft2(fftshift(im)));

% �e���̋t�t�[���G�ϊ����m�������ăt�[���G�ϊ�
% �y���o�[�W�����z���ۏ�͂���Ŗ��Ȃ�
% 	wavefront = fftshift(fft2(fftshift( gphs.*ftim )));

% �y�V���ɒǉ��z���m�ɂ͋������Ɋւ���ʑ������|���Z�����
%               ���������ƈʑ����������ς��̂œ`�����Ă���悤�Ɍ�����
%               �i�t�Ɉʑ��̕ω�������Ȃ�j
uo = z/lambda - fix(z/lambda);
wavefront = exp(i*2*pi*uo).*fftshift(fft2(fftshift( gphs.*ftim )));

