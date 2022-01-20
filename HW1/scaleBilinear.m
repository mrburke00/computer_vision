function [outImg] = scaleBilinear( current_img, factor)
    [rows,cols,z] = size(current_img);
    scaledX = floor(rows * factor); % new height and width based on factor input
    scaledY = floor(cols * factor);
    outImg=zeros([scaledX,scaledY,z]);

%   (y2) -------Q12-----------R2----------------Q22
%                |            |                 |
%   (y)  ---------------------P------------------  
%                |            |                 |  
%   (y1) -------Q1------------R1----------------Q21  
%                |            |                 |       
%               (x1)          (x)                (x2)  

    for color = 1:z
        for i = 1:scaledX
            for j = 1:scaledY
                % calculating x,y equations from http://tech-algorithm.com/articles/bilinear-image-scaling/
                % still confused on what these values represent
                % we might use them to find R1 and R2? 
                x = (i-1)*(rows-1) / (factor * rows - 1) + 1;
                y = (j-1)*(cols-1) / (factor * cols - 1) + 1;
                
                % ensure our x and y are in bound of the image 
                if x < 1
                    x = 1;
                end
                if x >= rows
                    x = rows - 0.01;
                end
                if y < 1
                    y = 1;
                end
                if y >=  cols
                    y = cols - 0.01;
                end

                % get coordinates for each of the four points of the box  
                x1 = floor(x);
                x2 = ceil(x);
                y1 = floor(y);
                y2 = ceil(y);
                
                % use those coordinates to map and extract the pixel values
                % from the image 
                q11 = current_img(x1,y1,color);
                q12 = current_img(x1,y2,color);
                q21 = current_img(x2,y1,color);
                q22 = current_img(x2,y2,color);
                
                % calculate the weights used in the bilinear weighted mean equation 
                %f(P) = w11 * f(Q11) + w12 * f(Q12) + w21 * f(Q21) + w22 * f(Q22)
                w11 = (x2 - x)*(y2 - y)/(x2 - x1)*(y2 - y1);
                w12 = (x2 - x)*(y - y1)/(x2 - x1)*(y2 - y1);
                w21 = (x - x1)*(y2 - y)/(x2 - x1)*(y2 - y1);
                w22 = (x - x1)*(y - y1)/(x2 - x1)*(y2 - y1);
                % solve bilinear equation and place result in corresponding
                % pixel of output image
                outImg(i,j,color) = (w11 .* q11) + (w12 .* q12) + (w21 .* q21) + (w22 .* q22);
    
            end
        end
    end
    outImg = uint8(outImg);
    imwrite(outImg,'hw1_scaleBilinear_result.png');
end