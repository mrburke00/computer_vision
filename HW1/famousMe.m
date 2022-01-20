function [outImg] = famousMe(background_img, foreground_img)
    upper_threshold = 150; %threshold for binary mask
    y = 65; % x and y positioning of foreground image
    x = 150;

    %scale down foreground image to fit in background
    scaled_foreground = scaleBilinear(foreground_img, 0.25);
    % get grayscale of foreground 
    grayscale = luminance_NL(scaled_foreground);
    
    % function implementation doesnt work very well with my image
    % otherwise just use binaryMask()
    % allocate empty 2d matrix of size scaled down foreground image
    binary_mask = zeros(size(scaled_foreground, 1),size(scaled_foreground, 2));
    % if grayscale pixel value is above a threshold then belongs to the
    % white wall and is masked as zero otherwise 1
    binary_mask(grayscale>=upper_threshold) = 0;
    binary_mask(grayscale<upper_threshold) = 1;
    
    outImg = background_img;
    % iterate thru foreground image and if the mapped pixel on the binary
    % mask is a one then we want to retain that pixel because it belongs to
    % the object we want to display on the background image
    for i = 1:size(scaled_foreground,1)
        for j = 1:size(scaled_foreground,2)
            if binary_mask(i,j) == 1
                outImg(i + y, j + x, :) = scaled_foreground(i,j,:);
            end
        end
    end
    
    outImg = uint8(outImg);
    imwrite(outImg,'hw1_famousMe_result.png');

end