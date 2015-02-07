clc;
clear;
close all;

% Create image

f = zeros(32,32);

for i=1:100
    x = randi([1 size(f,1)]);
    y = randi([1 size(f,2)]);
    
    r = unifrnd(.2,1);
    A = [.2 .4 1];
    j = randi([1 numel(A)]);
    f(x,y) = A(j);
    
end

PSF = [-1 -1 -1;-1 8 -1;-1 -1 -1];

% point detection using imfilter
g1 = imfilter(f,PSF);

subplot(1,2,1)
imshow(f);
subplot(1,2,2)
imshow(g1);

figure;

% point detection using ordfilt2
g2min = ordfilt2(f,1,ones(3,3));
g2max = ordfilt2(f,9,ones(3,3));

g2 = g2max - g2min;

th2 = .7;
g2th = double(g2 >=th2);

subplot(2,3,1)
imshow(f);
subplot(2,3,2)
imshow(g2);
subplot(2,3,5);
imshow(g2th);









