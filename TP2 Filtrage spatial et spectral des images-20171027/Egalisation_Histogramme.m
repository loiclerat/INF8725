function [ image_egalise ] = Egalisation_Histogramme( image )
%   Detailed explanation goes here
    histo = imhist(image);
    histoCum = cumsum(histo);
    histoNormCum = histoCum/max(histoCum);
    
    [m,n] = size(image);
    image_egalise = zeros(m,n);
    
    for i = 1:m
        for j = 1:n
            image_egalise(i,j) = histoNormCum(image(i,j)+1)*255;
        end
    end
    
end

