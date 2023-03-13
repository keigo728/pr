function x = shiftifft2eq(f)
%SHIFTIFFT2	Two-dimensional inverse discrete Fourier transform.
%	SHIFTIFFT2(F) returns the two-dimensional inverse Fourier transform
%	of matrix F.  If F is a vector, the result will have the same
%	orientation.
%
%	See also IFFT2, FFTSHIFT.

% Transform.

[m,n] = size(f);

% �h�e�e�s�̂Ƃ��͋K�i���萔���|����
% �K�i���萔 fftnormfactor = sqrt(m)*sqrt(n)

x = fftshift( ifft2( ifftshift( f ) ) ) * ( sqrt(m * n) );
