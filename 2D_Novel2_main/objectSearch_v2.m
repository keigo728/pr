%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%物体に点光源があるか検索
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [obj,i] = objectSearch_v2( datafile, initSet)

% データサイズは２のべき乗にする
X = initSet.CCDX; 
Y = initSet.CCDY;
i = 0;

im = double(imread([datafile.FOLDER datafile.name1]))/255;
M = length(im);	% 画像サイズ

% ◆◆◆ 今回は９６×９６画素なので周囲に０を埋める
%img=zeros(N,N);
%img(N/2-M/2+1:N/2+M/2,N/2-M/2+1:N/2+M/2) = im;

for dx = 1:X
    for dy = 1:Y
        if im(dy, dx) ~= 0
            i = i + 1;
            obj(i,1:2) = [dx,dy];
        end
    end
end
