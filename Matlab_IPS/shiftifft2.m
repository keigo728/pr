function x = shiftifft2(f)
%SHIFTIFFT2	Two-dimensional inverse discrete Fourier transform.
%	SHIFTIFFT2(F) returns the two-dimensional inverse Fourier transform
%	of matrix F.  If F is a vector, the result will have the same
%	orientation.
%
%	See also IFFT2, FFTSHIFT.

% Transform.

%[m,n] = size(f);

x = fftshift( ifft2( fftshift( f ) ) );
