function ma = max_control(data)

so = sort(data(:));				
% so(end-10)/so(end)

if so(end-10)/so(end) > 0.8

	disp('MAXMAXMAX')
	ma = max(data(:));
	
else
	
	disp('--------------------')

	[hi,N] = hist(data(:),256);		%figure; hist(data(:),256);
	hi(1:10)=0;						%figure; bar(hi);
	[ma, p] = max(hi);

	if p==256
	
		[ma,p] = max(data(:));
		data(p)=0;
		[hi,N] = hist(data(:),256);		%figure; hist(data(:),256);
		hi(1:10)=0;						%figure; bar(hi);
		[ma, p] = max(hi);
		if p<128
			ma = N( round(1.5*p) );
		else
			ma = N( round((256-p)/2)+p );		
		end

	else
	
		tmp = hi;
		tmp(hi > ma/12)=0;			%figure;plot(tmp);
		[ma, p] = max(tmp);
		ma = N( p );
	
	end

end








% L = length(data);
% M = L/256;
% N = L/256;
% for q=1:N
% 	for p=1:M
% 		tmax( p+(q-1)*N ) = myMax2d( data( (p-1)*L/M+1:p*L/M, (q-1)*L/N+1:q*L/N) );
% 	end
% end