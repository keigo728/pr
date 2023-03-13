function x = shiftfft2eq(f)
%SHIFTFFT2	Two-dimensional inverse discrete Fourier transform.
%	SHIFTFFT2(F) returns the two-dimensional inverse Fourier transform
%	of matrix F.  If F is a vector, the result will have the same
%	orientation.
%
%	See also FFT2, FFTSHIFT.

% Transform.

[m,n] = size(f);

% �e�e�s�̂Ƃ��͋K�i���萔�Ŋ���
% �K�i���萔 fftnormfactor = sqrt(m)*sqrt(n)

x = ifftshift( fft2( fftshift(f) ) ) / ( sqrt(m * n) );


