I = imread('1.jpg');
I2 = im2double(I);
I3 = im2double(I);

for i = 1:222
    for j = 1:227
            if (i-111)^2 + (j-113.5)^2 <= 400 %+ (k - 1.5)^2 <= 400
                I2(i,j,1) = i*j/((j^2) + (i));
                I2(i,j,2) = ((j^2) + i)/(i*j);
                I2(i,j,3) = i*j/((j^2) * (i));
            end
            
            if (((i-100)/20)^2 + ((j-60)/50)^2) <= 1
                I2(i,j,1) = ((j^2) / (i))/(i*j);
                I2(i,j,2) = ((j^2) - i)/(i*j);
                I2(i,j,3) = i/j/((j^2) * (i));
            end
            
    end
end

subplot(2,2,1)
imshow(I2)

subplot(2,2,2)
imshow(I2(61:161,63:163,:))

subplot(2,2,3)
imshow(I2(10:70,10:70,1))