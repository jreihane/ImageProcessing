% Author: Reihane Zekri

% implementing article:
% An Efficient Algorithm for Lip Segmentation in Color Face Images
%       Based on Local Information
%  Hashem Kalbkhani*, Mehdi Chehel Amirani, 2012


close all;
clear;
clc;


face0 = im2double(imread('face1.jpg'));
size0 = size(face0(:,:,1));

% Remove first half of image because we know that lips are not in upper
% half of image
face1 = face0(size0(1)/2:end, :,:);

% convert rgb to YCbCr and HSI
face1ycbcr = rgb2ycbcr(face1);
face1hsi = rgb2hsi(face1);

% We only need the Saturation parameter of HSI color space
S = face1hsi(:,:,2);

Cb = face1ycbcr(:,:,2);
Cr = face1ycbcr(:,:,3);

% Normalize needed values
Cr2 = (Cr .^2) ./ sum(sum(Cr.^2));
CrCb = (Cr ./ Cb) ./ sum(sum(Cr./Cb));

% Compute Etha
etha = .95 .* (sum(sum(Cr .^2))./ sum(sum(Cr./Cb)));

% Compute Lip-Map
LipMap = Cr.^2 .* (Cr.^2 - etha .* (CrCb)).^2;

% For better separation, multiply saturation to lip-map
EnLipMap = S.*LipMap;

% Use built-in function of top-hat algorithm to find the area of lip
% I think we do not need it!
% IM2 = imtophat(EnLipMap,strel('rectangle', [50 50]));

% Thresholding
IMFinal = EnLipMap > 0.0270;

[row,col] = find(IMFinal);
% Make lip area white
% It seems 'find' function is not working properly!
face0(row + round(size0(1)/2),col,:) = 1;

% Show final results

figure;
subplot(2,3,1)
imshow(LipMap);title('Lip Map');

subplot(2,3,2)
imshow(EnLipMap);title('EnLip Map');

subplot(2,3,3)
imshow(IMFinal);title('After Threshold');

subplot(2,3,4)
imshow(face0);title('Final Image');







