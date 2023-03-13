function [twoholo,t_holo] = niti(holo)
twoholo = zeros(1080,1920);
Imax = 1.5 * max(holo(:));
holo = (255.*holo)./Imax;
for dx = 485:1564
    for dy = 65:1984
        if holo(dx, dy) >= 80 
            twoholo(dx-484, dy-64) = 255;
        else
            twoholo(dx-484, dy-64) = 0;
        end
    end
end

t_holo = zeros(2048,2048);

for dx = 1:2048
    for dy = 1:2048
        if holo(dx, dy) >= 128
            t_holo(dx, dy) = 255;
        else
             t_holo(dx, dy) = 0;
        end
    end
end



