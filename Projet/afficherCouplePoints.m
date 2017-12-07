function [ ] = afficherCouplePoints(image, listPoints,listeCouleur )
% Affiche des cercles correspondants aux couples de points.
%La couleur varie selon le couple de points

    figure;
    imshow(image);

    % Affichage des couples de points sur l'image
    [t,u] = size(listPoints);
    totalSizeListPoints = t*u;
    for i = 1:totalSizeListPoints
            centerY = listPoints{i}(1);
            centerX = listPoints{i}(2);

            radius = 30;
            
            r = listeCouleur{i}(1);
            g = listeCouleur{i}(2);
            b = listeCouleur{i}(3);

            rectangle('Position',[centerX - radius, centerY - radius, radius*2, radius*2],'Curvature',[1,1], 'EdgeColor', [r g b] );

    end

end

