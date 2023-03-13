function [mi,px,py] = min2d(data)

[ma,px,py] = max2d(data);
[tmp,px,py] = max2d(ma-data);

mi = -tmp + ma;