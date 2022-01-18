function [outImg] = invert_NL( current_img)
    current_img = 255 - current_img;
    imwrite(current_img,'hw1_4.png'); 
end