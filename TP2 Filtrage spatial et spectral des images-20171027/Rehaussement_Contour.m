function [ image_rehaussee ] = Rehaussement_Contour( image, K )
%   Detailed explanation goes here

    masqueGaussien = 1/16 * [1,2,1;2,4,2;1,2,1];
    
    Ig = Convolution(image, masqueGaussien);
    
    masqueLaplacien = [-1,-1,-1;-1,8,-1;-1,-1,-1];
    
    ImgLapl = Convolution(Ig,masqueLaplacien);
    
    %[m,n] = size(image);
    %image_rehaussee = zeros(m,n);
    
    image_rehaussee = Ig + K .* ImgLapl;
    
    image_rehaussee(image_rehaussee<0) = 0;


end

