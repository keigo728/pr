function x = index_phase(phs,colormode)

% INDEX_PHASE(PHS) returns index colored phase data.
% Colormap is hsv(255) or jet(255).
%   -pi < PHS < pi
%

switch colormode
	case 'jet'
    	x=ind2rgb(uint8(128*phs/pi + 128),jet(255));
		
	case 'hsv'
	    x=ind2rgb(uint8(128*phs/pi + 128),hsv(255));
		
	case 'hsv22'			% ���ӁA���̃J���[�}�b�v�́[�Q�΁�PHS���Q�΂̏ꍇ�Ɏg����
		hsv22=[hsv(127);hsv(127)];
		hsv22=circshift(hsv22,[64,0]);
		x=ind2rgb(uint8(128*phs/(2*pi) + 128),hsv22);

	otherwise
		x=ind2rgb(uint8(128*phs/pi + 128),jet(255));
end
