% �y�\�j�[�T�O�O�T�b�q��p�z�x�C���[�z�񂩂�q�f�a�ւ̕ϊ�
% data : Bayer image data
% type : 'FIT' makes one pixel mergin at upper, bottm, right and left side. (default)
% method : Bayer matrix design 'RGGB'
%			  RG
%			  GB

function [R,G,B] = bayer2interpRGB5005CR(data)

[px,py]=size(data);
%		figure;imshow(data,[],'notruesize');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% �x�C���[�z��̃J���[���Ƃ̈ʒu��\���z��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
IOOO=[1 0;0 0];
IOOO=repmat(IOOO,px/2,py/2);			% 	figure;imshow(b,[],'notruesize');title('Blue');
OIOO=[0 1;0 0];
OIOO=repmat(OIOO,px/2,py/2);			% 	figure;imshow(g,[],'notruesize');title('Green');
OOIO=[0 0;1 0];
OOIO=repmat(OOIO,px/2,py/2);			% 	figure;imshow(g,[],'notruesize');title('Green');
OOOI=[0 0;0 1];
OOOI=repmat(OOOI,px/2,py/2);			% 	figure;imshow(r,[],'notruesize');title('Red');

%-------------------------------------------------
% [0 0]
% [0 B]
%-------------------------------------------------
imA = ( circshift(data,[1,1]) + circshift(data,[-1,1]) + circshift(data,[1,-1]) + circshift(data,[-1,-1]) )/4;
imB = ( circshift(data,[1,0]) + circshift(data,[-1,0]) )/2;
imC = ( circshift(data,[0,1]) + circshift(data,[0,-1]) )/2;

B = (IOOO .* imA) + (OIOO .* imB) + (OOIO .* imC) + (OOOI .* data);
	
% �]���ȕ�������������
B(1,:)=0;	B(:,1)=0;	B(end,:)=0;	B(:,end)=0;

% 		figure;imshow(B,[],'notruesize');colorbar;title('B')

%-------------------------------------------------
% [R 0]
% [0 0]
%-------------------------------------------------
R = (IOOO .* data) + (OIOO .* imC) + (OOIO .* imB) + (OOOI .* imA);
	
% �]���ȕ�������������
R(1,:)=0;	R(:,1)=0;	R(end,:)=0;	R(:,end)=0;

% 		figure;imshow(R,[],'notruesize');colorbar;title('R')
	
%-------------------------------------------------
% [0 G]
% [G 0]
%-------------------------------------------------
imA = (circshift(data,[0,1]) + circshift(data,[0,-1]) + circshift(data,[1,0]) + circshift(data,[-1,0]))/4;
	
G = (IOOO + OOOI) .* imA + (OIOO + OOIO) .* data;
	
% �]���ȕ�������������
G(1,:)=0;	G(:,1)=0;	G(end,:)=0;	G(:,end)=0;

% 			figure;imshow(G,[],'notruesize');

