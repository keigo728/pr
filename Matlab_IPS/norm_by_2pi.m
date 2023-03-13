function x = norm_by_2pi( f )
%NORM_BY_2PI(F)	make normalize intensity from simple data.
%	NORM_BY_2PI(F) returns the normalized intensity from simple data.
%	If F is a vector, the result will have the same orientation.
%
%       -pi < f < pi


% Make Normalized intensity.
g = zeros(size(f));

g(f<0) = 2*pi;

x = (f + g) / ( 2 * pi );

