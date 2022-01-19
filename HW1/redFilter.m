function [outImg] = redFilter(current_img, redVal)
    other = (1 - redVal)/2;
    %red = 0.299*redVal + 0.587*(other/2) + 0.114*(other/2);
    %current_img(:,:,:) = redVal;
    %current_img(:,:,2) = other/2;
    %current_img(:,:,3) = other/2;
    red = 0.299*redVal;
    blue = 0.587*other;
    green = 0.114*other;
    outImg = current_img(:,:,1)*red + current_img(:,:,2)*blue + current_img(:,:,3)*green;
    imwrite(outImg,'hw1_7.png');
end