function [outImg] = scaleNearest( current_img, factor)
    [x,y,z] = size(current_img);
    scaledX = floor(x * factor); % new height and width based on factor input
    scaledY = floor(y * factor);
    outImg=zeros([scaledX,scaledY,z]);
    % https://www.imageeprocessing.com/2017/11/nearest-neighbor-interpolation.html
    %  |10 20 30 |
    %  |40 50 60 |
    %  |70 80 90 |
    % find ratio between scaled and original size for row and column
    ratio_x = scaledX/x;
    ratio_y = scaledY/y;
    
    % normalize pixel positions based on new size
    % i.e. [1 2 3 4 5 6] ---> [0.5 1 1.5 2 2.5 3]
    norm_x = [1:(x*ratio_x)]./(ratio_x);
    norm_y = [1:(y*ratio_y)]./(ratio_y);
    
    % use ceiling function to get least integer to the new normalize value
    % i.e. [0.5 1 1.5 2 2.5 3] ---> [1 1 2 2 3 3]
    % gives interpolated positions for final interpolation
    inter_x = ceil(norm_x);
    inter_y = ceil(norm_y);
    
    % use original image to map to interpolated positions for each color
    % first row-wise for each column 
    % i.e. [10 40 70] ---> [10 10 40 40 70 70]
    % then column wise interpolation using each row in new row-interpolated
    % matrix
    % i.e. [10 20 30] ---> [10 10 20 20 30 30]
    for color = 1:z
        temp = current_img(:,:,color); 
        channel = temp(inter_x, :);
        channel = channel(:,inter_y);
        outImg(:,:,color)=channel;
    end
    
    outImg = uint8(outImg);
    imwrite(outImg,'hw1_scaleNearest_result.png');
end