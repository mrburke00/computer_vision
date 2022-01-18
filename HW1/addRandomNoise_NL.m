function [outImg] = addRandomNoise_NL( current_img)
    randA = randi([-255,255], size(current_img));
    disp(size(randA));
    disp(size(current_img));
    randA = double(randA);
    current_img = double(current_img);
    current_img = current_img + randA;
    imwrite(current_img,'hw1_5.png');
end