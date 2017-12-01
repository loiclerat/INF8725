function [ matDescripteurs ] = descriptionPointsCles(image_initiale, listOctaves, listKeypoints)
% Retourne une matrice contenant tous les descripteurs créés à partir des
% points clés

[m,n,o] = size(image_initiale(:,:,:));

magnitude = zeros(m,n,o);
angle = zeros(m,n,o);

%Orientation assignment
for z = 1:o+1
    for x = 2:m-1
        for y = 2:n-1
            magnitude(x,y,z) = sqrt((octave(x+1,y,z) - octave(x-1,y,z))^2 + (octave(x,y+1,z) - octave(x,y-1,z))^2);
            angle(x,y,z) = atan((octave(x,y+1,z) - octave(x,y-1,z))/(octave(x+1,y,z) - octave(x-1,y,z)));
        end
    end
end

[t,u] = size(listKeypoints);
totalSizeListKeyPoints = t*u;

for z = 1:size(totalSizeListKeyPoints)
    
    sigma = listKeyPoints{z}(3);
    u = 8+1;
    %if mod(u,2) == 0
     %   u = u+1;
    %end

    % Création du filtre Gaussien
    G = fspecial('gaussian', [u,u],8); %sigma x 1.5 ? or 8

    % Fenêtre 
    x = listKeyPoints{z}(1);
    y = listKeyPoints{z}(2);
    
    indexXMinFen = uint16(x-floor(u/2));
    indexXMaxFen = uint16(x+floor(u/2));
    indexYMinFen = uint16(y-floor(u/2));
    indexYMaxFen = uint16(y+floor(u/2));

    if indexXMinFen > 0 && indexXMaxFen < m-1 && indexYMinFen > 0 && indexYMaxFen < n-1

        fenetreMagn = magnitude(indexXMinFen:indexXMaxFen, indexYMinFen:indexYMaxFen, z);
        fenetreAngle = angle(indexXMinFen:indexXMaxFen, indexYMinFen:indexYMaxFen, z);



        fenetreMagnPondere = G .* fenetreMagn;

        [a,b] = size(fenetreAngle);
        histo = zeros(1,8);

        % Création de l'histogramme
        for i = 1:a
            for j = 1:b
                angleDeg =  rad2deg(fenetreAngle(i,j));
                moduloAngle = mod(angleDeg,360);
                intervalleAngle = moduloAngle/45;
                ceilIntervalle = floor(intervalleAngle) +1;
                indexHisto = uint8(ceilIntervalle);
                histo(indexHisto) = histo(indexHisto) + fenetreMagnPondere(i,j);
            end
        end
    end
end



%Rotation système de cordonnées = orientation keypoint (sens opposé)

%Déterminer zone 16x16 px autour du keypoint
%Calculer orientation de chaque px -> Fait à l'avance ?
%Histogramme des orientation pour chaque zone 4x4 px
% -> 16 histogrammes à 8 intervalles
%Concaténer - normaliser - plafonner valeurs à 0.2 - normaliser à nouveau

%Mettre tout dans un vecteur de dim = 128 + 2 (x,y)


end

