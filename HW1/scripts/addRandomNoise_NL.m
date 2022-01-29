% Names: Devin Burke, Ty Tomlin
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [outImg] = addRandomNoise_NL( current_img)
    % get random integers between -255 and 255 in a 3d matrix the size of
    % the current image
    randA = randi([-255,255], size(current_img));
    randA = double(randA); % had scalar issues so made everything of type double
    current_img = double(current_img);
    outImg = current_img + randA; % add random integers to current image element wise
    imwrite(outImg,'hw1_5.png');
end