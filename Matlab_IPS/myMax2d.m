function [ma,px,py] = myMax2d(data)

[mm,x]=max(data);

[mx,y]=max(mm);

ma=mx;
px=x(y);
py=y;

