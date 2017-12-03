function [ ] = afficherCouplePoints(image, listPoints )
% Affiche des cercles correspondants aux points clés avec leurs orientations. 
%La taille et la couleur varient selon le sigma.

    figure;
    imshow(image);

    % Affichage des points clés sur l'image
    [t,u] = size(listPoints);
    totalSizeListPoints = t*u;
    for i = 1:totalSizeListPoints
            centerY = listPoints{i}(1);
            centerX = listPoints{i}(2);

            radius = 30;

            rectangle('Position',[centerX - radius, centerY - radius, radius*2, radius*2],'Curvature',[1,1], 'EdgeColor', 'r' );

    end

end

