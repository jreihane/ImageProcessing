% Author: Reihane Zekri
% Email: reihane.zekri@gmail.com

% Main function to call different filters
function Tamrin2(im)
    close all;
    
    % Read in the image and convert to gray
    orig = imread (im);
    
    % Apply Sober filter
    Sober(orig)

    figure;
    
    Gaussian(orig,9,3,'salt & pepper')
    %Gaussian(orig,10,3,'gaussian')
    
end

function Sober(orig)
    
    grayscale = rgb2gray ( orig );
    
    % Show original image
    subplot(3,3,1);
    imshow(orig);
    title('Original image');
    
    % Show grayscale image
    subplot(3,3,2);
    imshow(grayscale);
    title('Gray image');

    % Define the Sobel kernels
    k_v = double([-1 0 1; -2 0 2; -1 0 1]);
    k_h = double([1 2 1; 0 0 0; -1 -2 -1]);

    % ******************************************************
    % Convolve the gray image with Sobel kernels , store result in conved1
    % and conved2
    conved1 = conv_customized(double(grayscale),k_v);
    conved2 = conv_customized(double(grayscale),k_h);
    % ******************************************************

    % Display the horizontal edges and vertical edges separately
    subplot(3,3,4);
    imshow ( abs (conved1), []) ;
    title('Horizontal edges of image');

    subplot(3,3,5);
    imshow ( abs (conved2), []);
    title('Vertical edges of image');

    % Display the normalized vertical and horizontal edges combined
    subplot(3,3,6);
    imshow (( conved1 .^2+ conved2 .^2) .^0.5 , []);
    title('Normalized vertical and horizontal edges combined');
    
    % Test with Matlab conv2 function
    M1 = conv2 ( double ( grayscale ), double (k_v ));
    M2 = conv2 ( double ( grayscale ), double (k_h ));
    
    % Display the horizontal edges and vertical edges separately
    subplot(3,3,7);
    imshow (abs(M1), []);
    title('Horizontal edges of image with MATLAB');
    
    subplot(3,3,8);
    imshow (abs(M2), []);
    title('Vertical edges of image with MATLAB');
    
    % Display the normalized vertical and horizontal edges combined
    subplot(3,3,9);
    imshow (( M1 .^2+ M2 .^2) .^0.5 , []);
    title('Combined convolution with MATLAB');
end

% Apply convolution operations
% img       :   grayscaled image to be convolved
% kernel    :   kernel matrix, usually 3*3, as the reference for convolution
function [new_image] =  conv_customized(img, kernel)

    new_image = zeros(size(img));
    
    zero_to_row_num = zeros(1,size(img,2));
    zero_to_col_num = zeros(size(img,1) + 2,1);
    
    zero_border_img = [zero_to_row_num;img;zero_to_row_num];
    zero_border_img = double([zero_to_col_num zero_border_img zero_to_col_num]);
    
    kernel_row_num = size(kernel,1);
    kernel_col_num = size(kernel,2);
    
    img_size = size(zero_border_img);
    
    for i = 1:img_size(1)-kernel_row_num
        for j = 1:img_size(2)-kernel_col_num
            new_image(i,j) = sum(sum(zero_border_img(i:i+kernel_row_num-1,j:j+kernel_col_num-1) .* kernel));
        end
    end
    
    new_image;
end


function Gaussian(orig, sigma, size, noiseType)

    grayscale = rgb2gray ( orig );
    
    % Add noise to the grayscale image and display
    noisyImage = imnoise ( grayscale , noiseType );
    
    subplot(2,2,1);
    imshow ( noisyImage );
    
    % Gaussian filtering formula is:
    % exp(-1*(i^2+j^2)/2*(sigma^2))
    
    %noisyImgSize = size(noisyImage);
    kernel = zeros(size);
    
    noisyImage = double(noisyImage);
    
%     kernel = (-1 * noisyImage(1).^2 + noisyImage(2).^2)./(2*sigma^2);
%     kernel = exp(kernel);
%     kernel = expm(kernel);
    
%     for i = 2:noisyImgSize(1)-1
    for i = 1:size
        for j = 1:size
%         for j = 2:noisyImgSize(2)-1
            
            % Create kernel
%             kernel(i,j) = exp(-1 * (noisyImage(i,j-1)^2 + noisyImage(i,j+1)^2+...
%                 noisyImage(i-1,j)^2 + noisyImage(i+1,j)^2)/(2*sigma^2));
            
            %kernel(i,j) = exp(-1 * (noisyImage(i,j-1)^2 + noisyImage(i,j+1)^2)/(2*sigma^2));
            kernel(i,j) = exp(-1*(i^2 + (j)^2)/(2*(sigma^2)));
        end
    end
    
    %kernel = kernel/sum(kernel(:));
    %kernel
    %new_image = conv_customized2 (noisyImage, kernel);
    %new_image = noisyImage ./ kernel;
    new_image = conv_customized(noisyImage,kernel);
    
    subplot(2,2,2);
    imshow ((new_image .^2) .^0.5 , []);
    
    subplot(2,2,3);
    imshow(kernel);
    title('kernel');
end



% function [kernel] = CustomFSpecial(size)
% 
% end









