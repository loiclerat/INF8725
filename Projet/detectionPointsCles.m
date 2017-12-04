function [ liste_pts,counterExtremaDetect,counterFaibleContraste,counterPointsArretes ] = detectionPointsCles( DoG, octave, sigma, seuil_contraste, r_courb_principale, resolution_octave )
% Détecte les extrema de chaque DoG d'un octave et élimine les points de faible
% contraste ainsi que les points d'arêtes. 
% Assigne une orientation aux points clés ainsi déterminés


[m,n,o] = size(DoG(:,:,:));


indexListPoints = 0;

% Compteurs
counterExtremaDetect = 0;
counterFaibleContraste = 0;
counterPointsArretes = 0;

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


%Pour chaque DoG
for z = 2:o-1
    
    Gx = [1;-1];
    Gy = [1, -1];

    %Application du filtre (gradient)
    Dxx = imfilter(imfilter(DoG(:,:,o), Gx, 'symmetric','same'), Gx, 'symmetric','same');
    Dxy = imfilter(imfilter(DoG(:,:,o), Gx, 'symmetric','same'), Gy, 'symmetric','same');
    Dyy = imfilter(imfilter(DoG(:,:,o), Gy, 'symmetric','same'), Gy, 'symmetric','same');
    
    
    for x = 2:m-1
        for y = 2:n-1
            
            %On élimine les points de faible contraste
            if abs(DoG(x,y,z)) > seuil_contraste
                notGreater = false;
                notLower = false;
                equal = false;
                
               
                %Itération à travers les 26 voisins
                for k = z-1:z+1
                    if (notGreater && notLower) || equal
                        %L'intensité du point égale à un voisin OU elle est
                        %supérieure à un voisin et inférieure à un autre
                        % -> le point n'est pas un extremum
                        break;
                    end
                    for i = x-1:x+1
                        if (notGreater && notLower) || equal
                            break;
                        end
                        for j = y-1:y+1
                            if (notGreater && notLower) || equal
                                break;
                            end
                            
                            %On évite de comparer le pixel courant avec
                            %lui-même
                            if x ~= i || y ~= j || z ~= k
                                if DoG(x,y,z) > DoG(i,j,k)
                                    notLower = true;
                                elseif DoG(x,y,z) < DoG(i,j,k)
                                    notGreater = true;
                                else
                                    equal = true;
                                end
                            end
                        end
                    end
                end
                %fin de l'itération à travers les 26 voisins
                
                if(notGreater && ~notLower && ~equal) || (~notGreater && notLower && ~equal)
                    counterExtremaDetect = counterExtremaDetect+1;

                    
                    TraceSurDet = ((Dxx(x,y) + Dyy(x,y))^2)/(Dxx(x,y)*Dyy(x,y) - (Dxy(x,y)^2));
                    ratio = ((r_courb_principale+1)^2)/r_courb_principale;
                    
                    %Elimination des points d'arrêtes
                    if (TraceSurDet < ratio)

                  
                        
                        %Assignation orientation / création nouveau
                        %keypoint si besoin
                        
                        u = ceil(6*sigma(z));
                        if mod(u,2) == 0
                            u = u+1;
                        end
                        
                        % Création du filtre Gaussien
                        G = fspecial('gaussian', [u,u], sigma(z) * 1.5);
                        
                        % Fenêtre 
                        
                        indexXMinFen = uint16(x-floor(u/2));
                        indexXMaxFen = uint16(x+floor(u/2));
                        indexYMinFen = uint16(y-floor(u/2));
                        indexYMaxFen = uint16(y+floor(u/2));
                        
                        if indexXMinFen > 0 && indexXMaxFen < m-1 && indexYMinFen > 0 && indexYMaxFen < n-1
                        
                            fenetreMagn = magnitude(indexXMinFen:indexXMaxFen, indexYMinFen:indexYMaxFen, z);
                            fenetreAngle = angle(indexXMinFen:indexXMaxFen, indexYMinFen:indexYMaxFen, z);



                            fenetreMagnPondere = G .* fenetreMagn;

                            [a,b] = size(fenetreAngle);
                            histo = zeros(1,36);

                            % Création de l'histogramme
                            for i = 1:a
                                for j = 1:b
                                    angleDeg =  rad2deg(fenetreAngle(i,j));
                                    moduloAngle = mod(angleDeg,360);
                                    intervalleAngle = moduloAngle/10;
                                    ceilIntervalle = floor(intervalleAngle) +1;
                                    indexHisto = uint8(ceilIntervalle);
                                    histo(indexHisto) = histo(indexHisto) + fenetreMagnPondere(i,j);
                                end
                            end

                            for i = 1:36
                                if histo(i) >= 0.8*max(histo)
                                    pointExtreme = [x*resolution_octave,y*resolution_octave, z, i*10];
                                    indexListPoints = indexListPoints +1;
                                    liste_pts{indexListPoints} = pointExtreme;
                                end
                            end
                            
                        end

                    else
                        counterPointsArretes = counterPointsArretes+1;
                    end
                end
            else
                 counterFaibleContraste = counterFaibleContraste+1;
            end
        end
    end
end
end

