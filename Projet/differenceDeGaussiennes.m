function [ listDoG, listOctaves, vectSigma ] = differenceDeGaussiennes( image_initiale , s, nb_octave)
    % Pour chaque octave, calcule une pyramide de Gaussiennes puis effectue
    % les différences de Gaussiennes. Celles-ci sont stockées dans listDoG.
    % Les différents sigma utilisés sont stockés dans vectSigma.
    % Les images initiales de chaque octave sont stockées dans listOctaves.
    

    sigma0 = 1.6;
    k = 2^(1/s);
    
    vectSigma = zeros(s+3);
    listOctaves{1} = image_initiale;
    
    % Calcule des sigmas
    for i = 1:s+3
            sigma = k^(i-1) * sigma0;
            vectSigma(i) = sigma;
    end
    
    % Pour chaque octave...
    for o = 1:nb_octave
        %figure;
        %imshow(listOctaves{o});
        
        [m,n] = size(listOctaves{o});
        listGauss = zeros(m,n,s+3);
        listDoGPerOcta = zeros(m,n,s+2);
        
        % Construction de la pyramide
        for i = 1:s+3
            sigma = vectSigma(i);
            
            u = ceil(10*sigma +1);
            % Création du filtre Gaussien
            G = fspecial('gaussian', [u,u], sigma);

            %Application du filtre
            L = imfilter(listOctaves{o}, G, 'symmetric','same');
            listGauss(:,:,i) = L;
            
            % Affichage de la pyramide
           % figure;
            %imshow(L);
            %title(['sigma = ' num2str(sigma)]);
            %axis on;
        end

        % Différence de Gaussiennes
        for i = 1:s+2
            listDoGPerOcta(:,:,i) = listGauss(:,:,i+1) - listGauss(:,:,i);
            
            % Affichage des DoG
            %figure;
            %imshow(listDoGPerOcta(:,:,i),[]);
        end
        
        listDoG{o} = listDoGPerOcta;
        listOctaves{o+1} = listGauss(1:2:end,1:2:end,s+1);
        
    end
end

