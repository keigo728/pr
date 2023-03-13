function x = mk_intensity(f)
%MK_INTENSITY	make intensity from complex number.
%	MK_INTENSITY(F) returns the intensity from complex number.
%	If F is a vector, the result will have the same orientation.
%

% Make intensity.

x = real(f).^2 + imag(f).^2;
