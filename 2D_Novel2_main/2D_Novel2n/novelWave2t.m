function wave = novelWave2t(Zobj, Nwave, initSet, fname)
global SVFOLDER
global SVF

cx = initSet.HCCDY; %1080
cy = initSet.HCCDX; %1920
Xmax = cx .* 2;
Ymax = cy .* 2;

%x = obj(1,2);
%y = obj(1,1);
wavefront = zeros(cx,cy);
wavefront2 = zeros(Xmax,Ymax);
N = gpuArray(Nwave.WAVE);
%for n = 1:i
%    x = obj(n,2);
%    y = obj(n,1);
%    wavefront = wavefront + Nwave.WAVE(x : x + cx - 1 , y : y + cy - 1);
%end


 wavefront = wavefront + N(cx/2 + 1 : cx/2 + cx, cy/2 + 1 : cy/2 + cy) + N(cx/2 + 1 : cx/2 + cx, cy/2 + 2 : cy/2 + cy + 1);
wavefront2(Xmax/2 - cx/2 + 1 : Xmax/2 + cx/2, Ymax/2 - cy/2 + 1 : Ymax/2 + cy/2 ) = wavefront;

wave.WAVE = wavefront2;
wave.Z = Zobj;
 %wavefront = sum(cgh, 3);


%for k = 1 : cx
%    for l = 1 : cy
%        wavefront(k, l) = Nwave.WAVE(x + cx - k, y + cy - l);
%    end
%end




%if nargin > 3		
%    save([SVFOLDER SVF fname '.mat'],'wave');
%end