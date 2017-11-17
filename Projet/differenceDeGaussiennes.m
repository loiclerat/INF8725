function [ listDoG, listOctaves, vectSigma ] = differenceDeGaussiennes( image_initiale , s, nb_octave)
    
    sigma0 = 1.6;
    k = 2^(1/s);
    
    
    vectSigma = zeros(s+3);


    listOctaves{1} = image_initiale;
    for i = 1:s+3
            sigma = k^(i-1) * sigma0;
            vectSigma(i) = sigma;
    end
    
    for o = 1:nb_octave
        %figure;
        %imshow(listOctaves{o});
        [m,n] = size(listOctaves{o});
        listGauss = zeros(m,n,s+3);
        listDoGPerOcta = zeros(m,n,s+3);
        for i = 1:s+3
            sigma = vectSigma(i);
            
            u = ceil(10*sigma +1);
            G = fspecial('gaussian', [u,u], sigma);

            L = imfilter(listOctaves{o}, G, 'symmetric','same');
            listGauss(:,:,i) = L;
            %figure;
            %imshow(L);
        end

        for i = 1:s+2
            listDoGPerOcta(:,:,i) = listGauss(:,:,i+1) - listGauss(:,:,i);
            figure;
            imshow(listDoGPerOcta(:,:,i),[]);
        end
        
        listDoG{o} = listDoGPerOcta;

        listOctaves{o+1} = listGauss(1:2:end,1:2:end,s+1);
        
        
    end
    
   
    
    
    


end

