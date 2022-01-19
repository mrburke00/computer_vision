function [outImg] = scaleNearest( current_img, factor)
    [x,y,z] = size(current_img);
    scaledX = round(x * factor); % new height and width based on factor input
    scaledY = round(y * factor);
    outImg = zeros(scaledX, scaledY, z); % 3d matrix of zeros allocated for new image
    for i = 1:scaledX
        for j = 1:scaledY
            outImg(i,j,:) = sampleNearest(inImg, factor, i, j)
        end   
    end
    imwrite(outImg,'hw1_scaleNearest_result.png');
end