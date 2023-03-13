function b = doBinary( Iobj, threshold)

mask = Iobj;
ma = max(mask(:));

if nargin <2
	mask(mask <  ma*0.01) = 0;
	mask(mask >= ma*0.01) = 1;
else
	mask(mask <  ma*threshold) = 0;
	mask(mask >= ma*threshold) = 1;
end

b = mask;

