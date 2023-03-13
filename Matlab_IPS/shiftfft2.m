function x = shiftfft2(f)
%SHIFTFFT2	Two-dimensional inverse discrete Fourier transform.
%	SHIFTFFT2(F) returns the two-dimensional inverse Fourier transform
%	of matrix F.  If F is a vector, the result will have the same
%	orientation.
%
%	See also FFT2, FFTSHIFT.

% Transform.

[m,n] = size(f);

x = fftshift( fft2( fftshift(f) ) ) / ( m * n );

%x = fftshift( fft2( fftshift(f) ) );
