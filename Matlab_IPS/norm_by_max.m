function x = norm_by_max( f )
%NORM_BY_MAX(F)	make normalize intensity from simple data.
%	NORM_BY_MAX(F) returns the normalized intensity from simple data.
%	If F is a vector, the result will have the same orientation.
%

% Make Normalized intensity.

maxf = max( f(:) );		%maxf = max( max(f) );
minf = min( f(:) );		%minf = min( min(f) );

tmpf = maxf - minf;

if( tmpf > 1e-31 )
	x = ( f - minf ) / ( maxf - minf );
else
	x = f;
end