function wavefront = moveWave2_v2(Nwave, initSet, fname, obj, i)
global SVFOLDER
global SVF

cx = initSet.HCCDY;
cy = initSet.HCCDX;

%x = obj(1,2);
%y = obj(1,1);
wavefront = zeros(cx,cy);
N = gpuArray(Nwave.WAVE);
%for n = 1:i
%    x = obj(n,2);
%    y = obj(n,1);
%    wavefront = wavefront + Nwave.WAVE(x : x + cx - 1 , y : y + cy - 1);
%end

%n = 1:i;
x = obj(:,2); y = obj(:,1);
for n = 1:i
 wavefront = wavefront + N(x(n) : x(n) + cx - 1 , y(n) : y(n) + cy - 1);
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