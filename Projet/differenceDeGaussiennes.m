function [ listDoG, listOctaves, vectSigma ] = differenceDeGaussiennes( image_initiale , s, nb_octave)
    % Pour chaque octave, calcule une pyramide de Gaussiennes puis effectue
    % les diff�rences de Gaussiennes. Celles-ci sont stock�es dans listDoG.
    % Les diff�rents sigma utilis�s sont stock�s dans vectSigma.
    % Les images initiales de chaque octave sont stock�es dans listOctaves.
    

    sigma0 = 1.6;
    k = 2^(1/s);
    
    %vectSigma = zeros(s+3);
    imageDepart{1} = image_initiale;
    
    % Calcule des sigmas
    for i = 1:s+3
            sigma = k^(i-1) * sigma0;
            vectSigma(i) = sigma;
    end
    
    
    % Pour chaque octave...
    for o = 1:nb_octave
        %figure;
        %imshow(imageDepart{o});
        
        [m,n] = size(imageDepart{o});
        listGauss = zeros(m,n,s+3);
        listDoGPerOcta = zeros(m,n,s+2);
        
        % Construction de la pyramide
        %figure;
        for i = 1:s+3
            sigma = vectSigma(i);
            
            u = ceil(10*sigma +1);
            % Cr�ation du filtre Gaussien
            G = fspecial('gaussian', [u,u], sigma);

            %Application du filtre
            L = imfilter(imageDepart{o}, G, 'symmetric','same');
            listGauss(:,:,i) = L;
            
            % Affichage de la pyramide
            %subplot(3,2,i);
            %imshow(L);
            %title(['sigma = ' num2str(sigma)]);
            %axis on;
        end

        
        % Diff�rence de Gaussiennes
        %figure;
        for i = 1:s+2
            listDoGPerOcta(:,:,i) = listGauss(:,:,i+1) - listGauss(:,:,i);
            
            %Affichage des DoG
            %subplot(3,2,i);
            %imshow(listDoGPerOcta(:,:,i),[]);
            %axis on;
        end
        
        listOctaves{o} = listGauss;
        listDoG{o} = listDoGPerOcta;
        imageDepart{o+1} = listGauss(1:2:end,1:2:end,s+1);
        
    end
end

