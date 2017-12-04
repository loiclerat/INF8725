function [ ] = afficherKeypoints(image, listPoints )
% Affiche des cercles correspondants aux points clés avec leurs orientations. 
%La taille et la couleur varient selon le sigma.

    figure;
    imshow(image);

    % Affichage des points clés sur l'image
    [t,u] = size(listPoints);
    totalSizeListPoints = t*u;
    for i = 1:totalSizeListPoints
        [w,x] = size(listPoints{i});
        totalSizeListPointsAtI = w*x;
        for j = 1:totalSizeListPointsAtI
            centerY = listPoints{i}{j}(1);
            centerX = listPoints{i}{j}(2);
            sigmaIndexPoint = listPoints{i}{j}(3);
            angle = listPoints{i}{j}(4);

            radius = sigmaIndexPoint*10;

            x2=centerX+(radius*cos(deg2rad(angle)));
            y2=centerY+(radius*sin(deg2rad(angle)));

            % On crée un cercle de couleur différente pour chaque sigma.
            % L'angle est représenté par un rayon dans le cercle
            if sigmaIndexPoint == 1
                rectangle('Position',[centerX - radius, centerY - radius, radius*2, radius*2],'Curvature',[1,1], 'EdgeColor', 'k' );
                line([centerX,x2],[centerY,y2], 'Color', 'k','LineWidth',2);
            elseif sigmaIndexPoint == 2
                 rectangle('Position',[centerX - radius, centerY - radius, radius*2, radius*2],'Curvature',[1,1], 'EdgeColor', 'r' );
                 line([centerX,x2],[centerY,y2], 'Color', 'r','LineWidth',2);
            elseif sigmaIndexPoint == 3
                 rectangle('Position',[centerX - radius, centerY - radius, radius*2, radius*2],'Curvature',[1,1], 'EdgeColor', 'g' );
                 line([centerX,x2],[centerY,y2], 'Color', 'g','LineWidth',2);
            else 
                 rectangle('Position',[centerX - radius, centerY - radius, radius*2, radius*2],'Curvature',[1,1], 'EdgeColor', 'b' );
                 line([centerX,x2],[centerY,y2], 'Color', 'b','LineWidth',2);
            end
        end
    end

end

