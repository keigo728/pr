%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  デジタルホログラフィ：記録と再生のシミュレーション
%%%  記録：画像を読み込んで、距離ｚだけフレネル変化し、平面波と干渉させて干渉縞を求める
%%%  再生：位相項を掛けるフレネル変換により再生する
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;	close all;	disp('  =====  START  =====');
global SVFOLDER
global SVF

%%% 設定
DHinit;

%  【物体波】
DHinit_input;	% 入力画像

N = initSet.CCDX; % N*Nの画像

%[obj,i] = objectSearch_v2(datafile, initSet);
im = double(imread([datafile.FOLDER datafile.name1]))/255;

tic
oct = 0; twxct = 0; twct = 0; thct = 0; fct = 0;
%oct~fct -> 1~4個を持つ2×2のグループ数
%one~fourの作成
for ox = 1:2:1080
    for oy = 1:2:1920
        objct = 0; %　->　2×2内にある物体点の数 
        noobjct = 0;%　->　2×2内にない物体点の数 
        count = 1;%添え字
        on(4) = 0;
        off(4) = 0;
        for cy = oy:oy+1
            for cx = ox:ox+1
                if im(cx, cy) ~= 0
                    objct = objct + 1;
                    on(objct) = count;
                else
                   noobjct = noobjct + 1;
                    off(noobjct) = count;
                end
                count = count + 1;
            end
        end
        
        if objct == 1
            oct = oct + 1;
            one(oct,:) = [oy,ox,on(1)];%一つの場合は一つの点の座標保存
        end
        if objct == 2%2つの場合は二つの点の座標保存
            if on(1) + on(2) == 5
                twxct = twxct + 1;
                twox(twxct,:) = [oy,ox,on(1)];%twoxは斜めに点がある場合
            else
                twct = twct + 1;
                two(twct,:) = [oy,ox,on(1)+on(2)];
            end
        end        
        if objct == 3
            thct = thct + 1;
            three(thct,:) = [oy,ox,off(1)];%三つの場合はない点の座標保存
        end      
        if objct == 4
            fct = fct + 1;
            four(fct,:) = [oy,ox]; %左上の座標
        end
    end
end
toc

oct
twxct
twct
thct
fct

tic
fct2 = 0;
%fourからfour2の作成
if fct > 4
	for i = 1:fct-3
		if four(i,1) + 2 == four(i+1,1) && four(i,2) == four(i+1,2)
			if i+550 < fct %計算時間短縮
				for k = i+2:i+550
					if four(i,1) == four(k,1) && four(i,2) + 2 == four(k,2)
						if four(k,1) + 2  == four(k+1,1)&& four(k,2) == four(k+1,2)
							fct2 = fct2 + 1;
							four_2(fct2,:) = [four(i,1),four(i,2)];
							four(i,:) = [0,0]; four(i+1,:) = [0,0]; four(k,:) = [0,0]; four(k,:) = [0,0];
						end
					end
				end
			else
				for k = i+2:fct
					if four(i,1) == four(k,1) && four(i,2) + 2 == four(k,2)
						if four(k,1) + 2  == four(k+1,1)&& four(k,2) == four(k+1,2)
							fct2 = fct2 + 1;
							four_2(fct2,:) = [four(i,1),four(i,2)];
							four(i,:) = [0,0]; four(i+1,:) = [0,0]; four(k,:) = [0,0]; four(k,:) = [0,0];
						end
					end
				end
			end
		end
	end
end
fct2
fct3 = 0;
if fct2 > 4
	for i = 1:fct2-3
		if four_2(i,1) + 4 == four_2(i+1,1) && four_2(i,2) == four_2(i+1,2)
			if i+550 < fct2 %計算時間短縮
				for k = i+2:i+226
					if four_2(i,1) == four_2(k,1) && four_2(i,2) + 4 == four_2(k,2)
						if four_2(k,1) + 4  == four_2(k+1,1)&& four_2(k,2) == four_2(k+1,2)
							fct3 = fct3 + 1;
							four_3(fct3,:) = [four_2(i,1),four_2(i,2)];
							four_2(i,:) = [0,0]; four_2(i+1,:) = [0,0]; four_2(k,:) = [0,0]; four_2(k,:) = [0,0];
						end
					end
				end
			else
				for k = i+2:fct2
					if four_2(i,1) == four_2(k,1) && four_2(i,2) + 2 == four_2(k,2)
						if four_2(k,1) + 4  == four_2(k+1,1)&& four_2(k,2) == four_2(k+1,2)
							fct3 = fct3 + 1;
							four_3(fct3,:) = [four_2(i,1),four_2(i,2)];
							four_2(i,:) = [0,0]; four_2(i+1,:) = [0,0]; four_2(k,:) = [0,0]; four_2(k,:) = [0,0];
						end
					end
				end
			end
		end
	end
end
fct3
toc

tic
tmp = 0;
for i = 1:fct
	if four(i,1) ~= 0
		tmp = tmp + 1;
		four1(tmp,:) = [four(i,1),four(i,2)];
	end
end
fct = tmp;
clear four;

tmp = 0;
for i = 1:fct2
	if four_2(i,1) ~= 0
		tmp = tmp + 1;
		four2(tmp,:) = [four_2(i,1),four_2(i,2)];
	end
end
fct2 = tmp;
clear four_2;

tmp = 0;
for i = 1:fct3
	if four_3(i,1) ~= 0
		tmp = tmp + 1;
		four3(tmp,:) = [four_3(i,1),four_3(i,2)];
	end
end
fct3 = tmp;
clear four_3;
toc



%[oy, ox] = find(im);
%obj = [ox,oy];
%i = numel(oy);




%holo = 0;
%for i = 1:4
%    cgh{i} = 0;
%end
flag = -1;


%k = 50;
%l = 50;

Zobj = 0.05;

Nwave1 = novelWave(Zobj, initSet, 'novel'); %中心の物体光の計算 %1の座標
    		showWaveRealImagAbsAngle( Nwave1.WAVE, 'novelWave1' );

Nwave2x = novelWave2x(Zobj, Nwave1, initSet, 'novel2x'); %2点(1,4)の座標
            showWaveRealImagAbsAngle( Nwave2x.WAVE, 'novelWave2x' );
          
Nwave2t = novelWave2t(Zobj, Nwave1, initSet, 'novel2'); %2点(1,2)の座標
            showWaveRealImagAbsAngle( Nwave2t.WAVE, 'novelWave2' );

Nwave2y = novelWave2y(Zobj, Nwave1, initSet, 'novel2'); %2点(1,3)の座標
            %showWaveRealImagAbsAngle( Nwave2y.WAVE, 'novelWave2' );

Nwave3t = novelWave3t(Zobj, Nwave1, initSet, 'novel3'); %3点(1,3,4)の座標
            %showWaveRealImagAbsAngle( Nwave3t.WAVE, 'novelWave3' );

Nwave3y = novelWave3y(Zobj, Nwave1, initSet, 'novel3'); %3点(1,2,3)の座標
            showWaveRealImagAbsAngle( Nwave3y.WAVE, 'novelWave3' );

Nwave4 = novelWave4(Zobj, Nwave1, initSet, 'novel4'); %中心の物体光(2*2)の計算 %1234の座標
    		showWaveRealImagAbsAngle( Nwave4.WAVE, 'novelWave4' );
			
Nwave4_2 = novelWave4_2(Zobj, Nwave4, initSet, 'novel4_2'); %中心の物体光(2*2)の計算 %1234の座標
    		showWaveRealImagAbsAngle( Nwave4_2.WAVE, 'novelWave4_2' );

Nwave4_3 = novelWave4_3(Zobj, Nwave4_2, initSet, 'novel4_3'); %中心の物体光(2*2)の計算 %1234の座標
    		showWaveRealImagAbsAngle( Nwave4_3.WAVE, 'novelWave4_3' );


            tic   

            Opwave.WAVE = moveWave_v2(Nwave4, initSet, 'obj', four1, fct);
            if oct > 0
                Opwave.WAVE = Opwave.WAVE + moveWave2_1(Nwave1, initSet, 'obj', one, oct);
            end
            if twxct > 0
                Opwave.WAVE = Opwave.WAVE + moveWave2_2x(Nwave2x, initSet, 'obj', twox, twxct);
            end
            if twct > 0
                Opwave.WAVE = Opwave.WAVE + moveWave2_2(Nwave2t,Nwave2y, initSet, 'obj', two, twct);
            end
            if thct > 0
                Opwave.WAVE = Opwave.WAVE + moveWave2_3(Nwave3t,Nwave3y, initSet, 'obj', three, thct);
			end
            if fct2 > 0
                Opwave.WAVE = Opwave.WAVE + moveWave_v2(Nwave4_2, initSet, 'obj', four2, fct2);
			end
            if fct3 > 0
                Opwave.WAVE = Opwave.WAVE + moveWave_v2(Nwave4_3, initSet, 'obj', four3, fct3);
			end

            toc

%            [obj,i] = objectSearch_v2_2(datafile, initSet);

%Zobj = 0.03;

 %           Nwave = novelWave(Zobj, initSet, 'novel'); %中心の物体光の計算

  %  		showWaveRealImagAbsAngle( Nwave.WAVE, 'novelWave' );


   %         tic

    %        Opwave.WAVE = Opwave.WAVE + moveWave_v2(Nwave, initSet, 'obj', obj, i);

     %       toc

%//////////////////////////for n = 1:i
%            Onewave = moveWave(Nwave, initSet, 'obj', k, l);
%            if flag < 0
%                Opwave = Onewave;
%                flag = 1;
%            else
%                Opwave.WAVE = Opwave.WAVE + Onewave.WAVE;
%            end
%        end
%    end
%end



%for k = 1:N
%    for l = 1:N
%        [Onewave, initSet.INPUT_IM_SIZE] = objectWave( datafile, Zobj, initSet, 'obj', k, l);
%        
%        if initSet.INPUT_IM_SIZE > 0
%            
%            if flag < 0
%                Opwave = Onewave;
%                flag = 1;
%            else
%                Opwave.WAVE = Opwave.WAVE + Onewave.WAVE;
%            end
%        end
%    end
%end


Opwave.Z = Zobj;
Opwave.WAVE = fliplr(Opwave.WAVE);
Opwave.WAVE = flipud(Opwave.WAVE);
Opwave.WAVE = Opwave.WAVE / max(abs(Opwave.WAVE(:)));
    		showWaveRealImagAbsAngle( Opwave.WAVE, 'objWave' );
            

            % 【参照波】
            DHinit_REF;
            Rwave = selectWaveType( Rwave, initSet, 'ref');

            Imax=-1;
         %   for i = 1:4

                %【物体波】と【参照波】との干渉
                [psholo{i}, Zr, Imax] = interferOxR( Opwave, Rwave, initSet, Imax, i-1);
	            
%                if flag < 0
%                    cgh{i} = psholo{i};
%                    flag = 1;
%                else
%                    cgh{i} = cgh{i} + psholo{i};
%                end


                %%% 位相シフト
      %          Rwave.WAVE = Rwave.WAVE * exp(1i * (pi/2) );
	
          %  end

            % 画像読み込みバージョン
%holo = phaseShiftDH(initSet);	% 位相シフト法
holo = noShiftDH(initSet);
%showWaveAmpPhsRecoAmpPhs(holo, 0);

%[cx, cy] = size(holo);

%Icmax = 1.5 * max(cgh{1}(:));

%for i = 1:4
%    filename = sprintf('%s%sOR%02d.tif', SVFOLDER, SVF, i+3);
%    imwrite( uint8(255*cgh{i}/Icmax), filename, 'tif');
%end


%------------------------------------------------------------------
%2^nの形にして再生する
%--------------------------------------------------------------
T = 2048;
Dx = 1920;
Dy = 1080;

temp = zeros(T, T);
temp(T/2-Dy/2+1:T/2+Dy/2, T/2-Dx/2+1:T/2+Dx/2) = holo;
holo = temp;

temp = zeros(T, T);
temp(T/2-Dy/2+1:T/2+Dy/2, T/2-Dx/2+1:T/2+Dx/2) = Rwave.spatialShiftPhase;
Rwave.spatialShiftPhase = temp;

%====================================================================



reconstruction( holo, Rwave, -0.05, initSet );	% 再生
%reconstruction( holo, Rwave, -0.03, initSet );	% 再生
%reconstruction( holo, Rwave, -0.08, initSet );	% 再生

low_filter(holo, Rwave, -Zr, initSet);

% 確認
% holoA = (psholo{4} - psholo{2}) + 1i * (psholo{1} - psholo{3});	% 位相シフト法
% reconstruction( holoA, Rwave, -Zr, initSet );	% 再生
