function [ image_convolue ] = Convolution( image, masque )
%   Detailed explanation goes here

    [m,n] = size(image);
    [k,p] = size(masque);
    
    indexK = (k-1) /2;
    indexP = (p-1) /2;
    image_convolue = zeros(m,n);
    
    padImage = padarray(image,[indexK,indexP],0,'both');
    
    for i = 1:m
        for j = 1:n
            subMat = padImage(i:i+indexK*2,j:j+indexP*2);
            resultMult = double(subMat) .* masque;
            image_convolue(i,j) = sum(sum(resultMult));
        end
    end
    

end

