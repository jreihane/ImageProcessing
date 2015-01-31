
img1 = imread('pout.tif');
nPixel = numel(img1);

mu = 50;
sigma = 100;
H = @(x) exp(-1/(2*sigma^2)*(x - mu).^2);

x = 0:255;
hgram = H(x);

hgram = round(nPixel * hgram/sum(hgram));

img2 = histeq(img1,hgram);
subplot(2,2,1)
imshow(img1)

subplot(2,2,2)
imhist(img1);

subplot(2,2,3);
imshow(img2);

subplot(2,2,4);
imhist(img2);
% stem(x,hgram);


