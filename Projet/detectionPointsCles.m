function [ liste_pts ] = detectionPointsCles( DoG, octave, sigma, seuil_contraste, r_courb_principale, resolution_octave )

[m,n,o] = size(DoG(:,:,:));
indexListPoints = 0;

% Compteurs
counterExtremaDetect = 0;
counterFaibleContraste = 0;
counterPointsArretes = 0;

magnitude = zeros(m,n,o);
angle = zeros(m,n,o);

%Orientation assignment
for z = 2:o-1
    for x = 2:m-1
        for y = 2:n-1
            magnitude(x,y,z) = sqrt((DoG(x+1,y,z) - DoG(x-1,y,z))^2 + (DoG(x,y+1,z) - DoG(x,y-1,z))^2);
            angle(x,y,z) = atan((DoG(x,y+1,z) - DoG(x,y-1,z))/(DoG(x+1,y,z) - DoG(x-1,y,z)));
        end
    end
end

%TODO histogramme avec les orientations??


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
                
                %TODO : préciser dans le rapport qu'on vérifie d'abord le
                %contraste
               
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
                        indexListPoints = indexListPoints +1;
                        pointExtreme = [x*resolution_octave,y*resolution_octave, z, magnitude(x,y,z), angle(x,y,z)];
                        liste_pts{indexListPoints} = pointExtreme;
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

