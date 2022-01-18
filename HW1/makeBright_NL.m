function [ outImg ]= makeBright_NL(current_img, brightness)
    current_img=current_img + brightness;
    imwrite(current_img,'hw1_2_dark.png'); 
end