clc

I = zeros(100,100);

for i = 1:5
    I((i-1)*20+1:i*20,:) = i - 2;
end

subplot(2,1,1)
imshow(I)

subplot(2,1,2)
imagesc(I)

colorbar
colormap(jet)
colormap