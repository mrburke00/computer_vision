function [outImg] = binaryMask(current_img)
   maxV = max(current_img,[],'all');
   minV = min(current_img, [], 'all');
   meanV = mean(current_img, 'all');
   outImg = (current_img < (meanV));
   imwrite(outImg,'hw1_8.png');
end