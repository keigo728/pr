function x = norm_by_phase( f )
%NORM_BY_PHASE(F)	make normalize intensity from simple data.
%	NORM_BY_PHASE(F) returns the normalized intensity from simple data.
%	If F is a vector, the result will have the same orientation.
%

% Make Normalized intensity.

x = ( f + pi ) / ( 2 * pi );

