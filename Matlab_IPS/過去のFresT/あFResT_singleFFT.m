function wavefront = FResT_singleFFT( im, lamda, z, dx, dy, method )

[WX,WY] = size(im);
[X,Y] = meshgrid(-WX/2:WX/2-1,-WY/2:WY/2-1);


% �W���̐ݒ�
de = 1/(WX*dx);
dn = 1/(WY*dy);
coeff = pi * lamda * z .* ( (X*de).^2 + (Y*dn).^2 );


% �ʑ�����������
phs = (pi/lamda/z).*( (X*dx).^2 + (Y*dy).^2 );
cim = im .* exp(i*phs);

clear X Y phs


% FFT
ft_cim = fftshift( ifft2( fftshift(cim) ) )/WX/WY;

clear cim


% �y�V���ɒǉ��z���m�ɂ͋������Ɋւ���ʑ������|���Z�����
%               ���������ƈʑ����������ς��̂œ`�����Ă���悤�Ɍ�����
%              �i�t�Ɉʑ��̕ω�������Ȃ�j
uo = z/lamda - fix(z/lamda);
wavefront = (-i/lamda/z) * exp(i*2*pi*uo) .* exp(i*coeff) .* ft_cim;		



%------------------------------------------------------------------------

% �y���o�[�W�����z���ۏ�͂���Ŗ��Ȃ�
% wavefront = exp(i*coeff).*ft_cim;