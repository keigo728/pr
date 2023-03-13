%%% INPUT THE IMAGE FILE NAME:

if ~exist('fc')|~exist('cc')|~exist('kc')|~exist('alpha_c'),
    fprintf(1,'No intrinsic camera parameters available.\n');
    return;
end;

KK = [   fc(1)  alpha_c*fc(1)  cc(1);  ...
		   0         fc(2)     cc(2);  ...
		   0          0          1    ];

%%% Compute the new KK matrix to fit as much data in the image (in order to
%%% accomodate large distortions:
r2_extreme = ( nx^2/(4*fc(1)^2) + ny^2/(4*fc(2)^2) );
dist_amount = 1;											 %(1+kc(1)*r2_extreme + kc(2)*r2_extreme^2);
fc_new = dist_amount * fc;

KK_new = [  fc_new(1)  alpha_c*fc_new(1)  cc(1);  ...
		        0          fc_new(2)      cc(2);  ...
				0              0            1    ];

disp('Program that undistorts images');
disp('The intrinsic camera parameters are assumed to be known (previously computed)');

fprintf(1,'\n');

quest = input('Do you want to undistort all the calibration images ([],0) or a new image (1)? ');

% リターンが入力されたら・・・
if isempty(quest),
    quest = 0;
end;

if ~quest,
    
    if n_ima == 0,
        fprintf(1,'No image data available\n');
        return;
    end;
    
	% ファイルが存在しなければ読み込む、たぶんメモリ節約バージョンだね
    if ~exist(['I_' num2str(ind_active(1))]),
        ima_read_calib;
    end;
    
    check_active_images;   
    
    format_image2 = format_image;
    if format_image2(1) == 'j',
        format_image2 = 'bmp';
    end;
    
    for kk = 1:n_ima,
        
        if exist(['I_' num2str(kk)]),
            
            eval(['I = I_' num2str(kk) ';']);
						
			%------------------------------------------------------------
			% 歪みを修正して補間処理を行う
			%------------------------------------------------------------
            [I2] = rect(I,eye(3),fc,cc,kc,KK_new);
            
			%------------------------------------------------------------
			% 名前をつける
			%------------------------------------------------------------
            if ~type_numbering,   
                number_ext =  num2str(image_numbers(kk));
            else
                number_ext = sprintf(['%.' num2str(N_slots) 'd'],image_numbers(kk));
            end;       
            ima_name2 = [calib_name '_rect' number_ext '.' format_image2];          
            fprintf(1,['Saving undistorted image under ' ima_name2 '...\n']);
            
            %------------------------------------------------------------
			% 画像に保存する
			%------------------------------------------------------------
            if format_image2(1) == 'p',
                if format_image2(2) == 'p',
                    saveppm(ima_name2,uint8(round(I2)));
                else
                    savepgm(ima_name2,uint8(round(I2)));
                end;
            else
                if format_image2(1) == 'r',
                    writeras(ima_name2,round(I2),gray(256));
                else
                    imwrite(uint8(round(I2)),gray(256),ima_name2,format_image2);
                end;
            end;
            
            
        end;       
    end;   
    fprintf(1,'done\n');	
end;
