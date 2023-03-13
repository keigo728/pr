function wavefront = moveWave2_3(Nwave_t, Nwave_y, initSet, fname, obj, i)
global SVFOLDER
global SVF

cx = initSet.HCCDY;
cy = initSet.HCCDX;

%x = obj(1,2);
%y = obj(1,1);
wavefront = zeros(cx,cy);
N = gpuArray(Nwave_y.WAVE);
N2 = fliplr(N);
N3 = gpuArray(Nwave_t.WAVE);
N4 = fliplr(N3);
%for n = 1:i
%    x = obj(n,2);
%    y = obj(n,1);
%    wavefront = wavefront + Nwave.WAVE(x : x + cx - 1 , y : y + cy - 1);
%end

%n = 1:i;
x = obj(:,2); y = obj(:,1); s = obj(:,3);
for n = 1:i
    if s(n) == 4        
        wavefront = wavefront + N(x(n) : x(n) + cx - 1 , y(n) : y(n) + cy - 1);
    elseif s(n) == 3
        wavefront = wavefront + N2(x(n) : x(n) + cx - 1 , y(n) : y(n) + cy - 1);
    elseif s(n) == 2
        wavefront = wavefront + N3(x(n) : x(n) + cx - 1 , y(n) : y(n) + cy - 1);
    elseif s(n) == 1
        wavefront = wavefront + N4(x(n) : x(n) + cx - 1 , y(n) : y(n) + cy - 1);
    end
end
 %wavefront = sum(cgh, 3);


%for k = 1 : cx
%    for l = 1 : cy
%        wavefront(k, l) = Nwave.WAVE(x + cx - k, y + cy - l);
%    end
%end




%if nargin > 3		
%    save([SVFOLDER SVF fname '.mat'],'wave');
%end