
% Sobel filter
function Tamrin2_test2(im)

    % Read in the image and convert to gray
    orig = imread (im);
    grayscale = rgb2gray ( orig );

    subplot(2,3,1);
    %figure(2);
    imshow(orig);
    title('Original image');
    
    
    subplot(2,3,2);
    %figure(1);
    imshow(grayscale);
    title('Gray image');

    % Define the Sobel kernels
    k_v = [-1 0 1; -2 0 2; -1 0 1];
    k_h = [1 2 1; 0 0 0; -1 -2 -1];

    % Convolve the gray image with Sobel kernels , store result in M1 and M2
    M1 = conv2 ( double ( grayscale ), double (k_v ));
    M2 = conv2 ( double ( grayscale ), double (k_h ));

    % Display the horizontal edges and vertical edges separately
    subplot(2,3,3);
    %figure (3);
    imshow ( abs (M1), []) ;
    title('Horizontal edges of image');
    
    subplot(2,3,4);
    %figure (4);
    imshow ( abs (M2), []);
    title('Vertical edges of image');
    
    % Display the normalized vertical and horizontal edges combined
    subplot(2,3,5);
    %figure (5);
    imshow (( M1 .^2+ M2 .^2) .^0.5 , []);
    title('Normalized vertical and horizontal edges combined');

end


