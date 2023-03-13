function wavefront = moveWave2_2x(Nwave_t, Nwave_y, initSet, fname, obj, i)
global SVFOLDER
global SVF

cx = initSet.HCCDY;
cy = initSet.HCCDX;

%x = obj(1,2);
%y = obj(1,1);
wavefront = zeros(cx,cy);
N = gpuArray(Nwave_t.WAVE);
N2 = gpuArray(Nwave_y.WAVE);
%for n = 1:i
%    x = obj(n,2);
%    y = obj(n,1);
%    wavefront = wavefront + Nwave.WAVE(x : x + cx - 1 , y : y + cy - 1);
%end

%n = 1:i;
x = obj(:,2); y = obj(:,1); s = obj(:,3);
for n = 1:i
    if s(n) == 3         
        wavefront = wavefront + N2(x(n) : x(n) + cx - 1 , y(n) : y(n) + cy - 1);
    elseif s(n) == 4
        wavefront = wavefront + N(x(n) : x(n) + cx - 1 , y(n) : y(n) + cy - 1);
    elseif s(n) == 6
        wavefront = wavefront + N(x(n) : x(n) + cx - 1 , y(n) + 1 : y(n) + cy);
    elseif s(n) == 7
        wavefront = wavefront + N2(x(n) + 1 : x(n) + cx , y(n) : y(n) + cy - 1);
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