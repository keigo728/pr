
function [im, apoMask] = execApotization(im, width)

% 画像サイズ
[r c] = size(im);

% エプロン幅（徐々に暗くする幅）
wleft  = cos(linspace(-pi/2,0,width));
wright = cos(linspace(0,pi/2,width));

wrow = ones(1,r-width*2);
wcol = ones(1,c-width*2);

% アポタイゼーションマスク
apoMask =  horzcat(wleft,wrow,wright)' * horzcat(wleft,wcol,wright);

im = im .* apoMask;

		%figure; imshow(im,[]); colorbar;
		%figure; imshow(apoMask,[]); colorbar;
