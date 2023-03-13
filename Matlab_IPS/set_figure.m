function set_figure(number,xpos,ypos,w,h)

if (nargin==5)
	
	figure(number)
	set(gcf,'Position',[xpos,ypos,w,h])
	clf
	axis equal
	
else
	
	figure;
	set(gcf,'Position',[number,xpos,ypos,w])
	clf
	axis equal
	
end

