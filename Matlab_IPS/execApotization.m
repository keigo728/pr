
function [im, apoMask] = execApotization(im, width)

% �摜�T�C�Y
[r c] = size(im);

% �G�v�������i���X�ɈÂ����镝�j
wleft  = cos(linspace(-pi/2,0,width));
wright = cos(linspace(0,pi/2,width));

wrow = ones(1,r-width*2);
wcol = ones(1,c-width*2);

% �A�|�^�C�[�[�V�����}�X�N
apoMask =  horzcat(wleft,wrow,wright)' * horzcat(wleft,wcol,wright);

im = im .* apoMask;

		%figure; imshow(im,[]); colorbar;
		%figure; imshow(apoMask,[]); colorbar;
