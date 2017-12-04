function [ listDescriptors ] = analyseImage( image, isLeft )
% Calcule les descripteurs SIFT d'une image


    %Partie 2.1 : Construction des diff�rences de Gaussiennes
    
    disp('- Diff�rence de Gaussiennes...');
    [listDoG, listOctaves, vectSigma] = differenceDeGaussiennes(image, 3, 3);

    %Partie 2.2 : D�tection des points cl�s
    
    disp('- D�tection des points cl�s...');
    [r,s] = size(listOctaves);
    totalSizeListOctaves = r*s;
    for i = 1:totalSizeListOctaves
        [listPoints{i},counterExtremaDetect{i},counterFaibleContraste{i},counterPointsArretes{i}] = detectionPointsCles( listDoG{i}, listOctaves{i}, vectSigma, 0.04 , 10, i );
    end 

    if isLeft == 1
        save('keypointsLeft.mat','listPoints');
    else
        save('keypointsRight.mat','listPoints');     
    end
    
    % Affichage des points cl�s
    %afficherKeypoints(image, listPoints);


    % Partie 2.2.1 : Calcul des descripteurs
    
    disp('- Cr�ation des descripteurs...');
    listDescriptors = [];
    for i = 1:totalSizeListOctaves
        descriptors = descriptionPointsCles (listOctaves{i},listPoints{i});
        if ~(isempty(descriptors))
            listDescriptors = [listDescriptors descriptors];
        end
    end
    disp('Analyse termin�e !');
    disp(' ');
end

