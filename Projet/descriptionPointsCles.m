function [ matDescripteurs ] = descriptionPointsCles(listOctaves, listKeyPoints)
% Retourne une matrice contenant tous les descripteurs cr��s � partir des
% points cl�s

[m,n,o] = size(listOctaves(:,:,:));

magnitude = zeros(m,n,o);
angle = zeros(m,n,o);

nbDescripteurs = 0;

%Orientation assignment
for z = 1:o
    for x = 2:m-1
        for y = 2:n-1
            magnitude(x,y,z) = sqrt((listOctaves(x+1,y,z) - listOctaves(x-1,y,z))^2 + (listOctaves(x,y+1,z) - listOctaves(x,y-1,z))^2);
            angle(x,y,z) = atan((listOctaves(x,y+1,z) - listOctaves(x,y-1,z))/(listOctaves(x+1,y,z) - listOctaves(x-1,y,z)));
        end
    end
end

[t,u] = size(listKeyPoints);
totalSizeListKeyPoints = t*u;

for z = 1:totalSizeListKeyPoints
    
    sigmaIndex = listKeyPoints{z}(3);
    u = 17;

    % Cr�ation du filtre Gaussien
    G = fspecial('gaussian', [u,u],u/2);

    % Fen�tre de 16x16px autour du point cl� (17x17px)
    x = listKeyPoints{z}(1);
    y = listKeyPoints{z}(2);
    
    indexXMinFen = uint16(x-floor(u/2));
    indexXMaxFen = uint16(x+floor(u/2));
    indexYMinFen = uint16(y-floor(u/2));
    indexYMaxFen = uint16(y+floor(u/2));

    if indexXMinFen > 0 && indexXMaxFen < m-1 && indexYMinFen > 0 && indexYMaxFen < n-1

        fenetreMagn = magnitude(indexXMinFen:indexXMaxFen, indexYMinFen:indexYMaxFen, sigmaIndex);
        fenetreAngle = angle(indexXMinFen:indexXMaxFen, indexYMinFen:indexYMaxFen, sigmaIndex);
        
        % Rotation du syst�me pour garantir l'invariance � la rotation
        fenetreAngleDeg(:,:) = rad2deg(fenetreAngle(:,:)); 
        fenetreAngleDegRot(:,:) = fenetreAngleDeg(:,:) - listKeyPoints{z}(4);
                
        % Pond�ration des magnitudes par la gaussienne
        fenetreMagnPondere = G .* fenetreMagn;
        
        % Cr�ation d'un histogramme pour chaque sous-zone de 4x4 pixels 
        listHisto = [];
        for k = 0:3
            for l = 0:3
                histo = zeros(1,8);
                for i = 1:4
                    for j = 1:4
                        moduloAngle = mod(fenetreAngleDegRot(k*4+i,l*4+j),360);
                        intervalleAngle = moduloAngle/45;
                        ceilIntervalle = floor(intervalleAngle) +1;
                        indexHisto = uint8(ceilIntervalle);
                        histo(indexHisto) = histo(indexHisto) + fenetreMagnPondere(k*4+i,l*4+j);
                    end
                end
                listHisto = [listHisto histo];
            end
        end
        % Normalisation des 16 histogrammes
        listHistoNorm = listHisto/max(listHisto);
        % Seuillage � 0.2
        for i = 1:size(listHisto)
            if listHistoNorm(i) > 0.2
                listHistoNorm(i) = 0.2;
            end
        end
        % Normalisation
        listHistoNormPlafond = listHistoNorm/max(listHistoNorm);
        
        % Cr�ation du descripteur
        nbDescripteurs = nbDescripteurs + 1;
        matDescripteurs{nbDescripteurs} = [x y listHistoNormPlafond];
    end
end

if nbDescripteurs == 0
    matDescripteurs = [];
end



%Rotation syst�me de cordonn�es = orientation keypoint (sens oppos�)

%D�terminer zone 16x16 px autour du keypoint
%Calculer orientation de chaque px -> Fait � l'avance ?
%Histogramme des orientation pour chaque zone 4x4 px
% -> 16 histogrammes � 8 intervalles
%Concat�ner - normaliser - plafonner valeurs � 0.2 - normaliser � nouveau

%Mettre tout dans un vecteur de dim = 128 + 2 (x,y)


end

