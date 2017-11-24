function [ liste_pts ] = detectionPointsCles( DoG, octave, sigma, seuil_contraste, r_courb_principale, resolution_octave )

[m,n,o] = size(DoG(:,:,:));
counterExtremaDetect = 0;
counterFaibleContraste = 0;
counterPointsArretes = 0;
indexListPoints = 0;

for z = 2:o-1
    
    Gx = [1;-1];
    Gy = [1, -1];

    %Application du filtre
    Dxx = imfilter(imfilter(DoG(:,:,o), Gx, 'symmetric','same'), Gx, 'symmetric','same');
    Dxy = imfilter(imfilter(DoG(:,:,o), Gx, 'symmetric','same'), Gy, 'symmetric','same');
    Dyy = imfilter(imfilter(DoG(:,:,o), Gy, 'symmetric','same'), Gy, 'symmetric','same');
    
    for x = 2:m-1
        for y = 2:n-1
            if abs(DoG(x,y,z)) > seuil_contraste
                notGreater = false;
                notLower = false;
                equal = false;
                for k = z-1:z+1
                    if (notGreater && notLower) || equal
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
                if(notGreater && ~notLower && ~equal) || (~notGreater && notLower && ~equal)
                    counterExtremaDetect = counterExtremaDetect+1;

                    
                    TraceSurDet = ((Dxx(x,y) + Dyy(x,y))^2)/(Dxx(x,y)*Dyy(x,y) - (Dxy(x,y)^2));
                    ratio = ((r_courb_principale+1)^2)/r_courb_principale;
                    if (TraceSurDet < ratio)
                        indexListPoints = indexListPoints +1;
                        pointExtreme = [x*resolution_octave;y*resolution_octave;z];
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

