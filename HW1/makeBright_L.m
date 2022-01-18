function [ outImg ]= makeBright_L(current_img, brightness)
    for i = 1:length(current_img)
        for j = 1:size(current_img,2)
            for k = 1:3
                tmp = current_img(i,j,k);
                %disp(tmp);
                tmp = tmp + brightness;
                current_img(i,j,k) = tmp;
                %disp(current_img(i,j,k))
                %break
            end
            %break
        end
        %break
    end
    imwrite(current_img,'hw1_1_dark.png'); 
end