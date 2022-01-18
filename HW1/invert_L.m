function [outImg] = invert_L( current_img)
    for i = 1:length(current_img)
        for j = 1:size(current_img,2)
            for k = 1:3
                tmp = current_img(i,j,k);
                tmp = 255 - tmp;
                current_img(i,j,k) = tmp;
            end
        end
    end
    imwrite(current_img,'hw1_3.png'); 
end