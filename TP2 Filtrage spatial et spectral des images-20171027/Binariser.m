function [ imageBinariser ] = Binariser( image, seuil, modeInvert )
    
    [m,n] = size(image);
    imageBinariser = zeros(m,n);
    
    if(modeInvert == true)
     for i = 1:m
        for j = 1:n
            if(image(i,j) > seuil)
                imageBinariser(i,j) = 0;
            else
                imageBinariser(i,j) = 255;
            end
        end
     end
    else
      for i = 1:m
        for j = 1:n
            if(image(i,j) < seuil)
                imageBinariser(i,j) = 0;
            else
                imageBinariser(i,j) = 255;
            end
        end
      end
    end

end

