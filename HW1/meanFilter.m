function [outImg] = meanFilter(current_img, kernel_size)
    %pad image based on kernel size
    pad = floor(kernel_size/2);
    [x,y,z] = size(current_img);
    %add zeroes to each side of image
    lr_edge = zeros(x, pad, z);
    new_img = horzcat(current_img, lr_edge);
    new_img = horzcat(lr_edge, new_img);

    %add zeroes to top and bottom of image (add 2 here instead of sides)
    tb_edge = zeros(pad, y+(2*pad), z);
    new_img = vertcat(new_img, tb_edge);
    new_img = vertcat(tb_edge, new_img);
    %https://stackoverflow.com/questions/31025506/average-filter-matlab
    outImg = zeros(x,y,z);   
    [x,y,z] = size(new_img);
    for i = 1:z % ensures we don't mix colors
        for j = 1 + pad:x - pad % don't want to iterate on pads %row
            for k = 1 + pad:y - pad % column
                sum = 0;
                for kernel_row = j - pad:j + pad % now extract kernel values with pad included
                    for kernel_column = k - pad: k + pad %kernel column
                        % get sum of kernel area for single color 
                        sum = sum + new_img(kernel_row, kernel_column, i);
                    end                    
                end
                avg = sum/(kernel_size * kernel_size);
                outImg(j - pad, k - pad, i) = avg;
            end
        end
    end
    imwrite(outImg,'hw1_9.png');
end