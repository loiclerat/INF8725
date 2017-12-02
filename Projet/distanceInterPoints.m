function [ mat_distances ] = distanceInterPoints( points_image1, points_image2)
%Retourne une matrice contenant toutes les distances Euclidiennes entre les
%descripteurs des deux images.

[a,b] = size(points_image1);
n = a*b;
[a,b] = size(points_image2);
m = a*b;

mat_distances = zeros(n,m);

% On itère sur tous les couples des descripteurs
for i = 1:n
    for j = 1:m
        pt1 = points_image1(i);
        pt2 = points_image2(j);
        desc1 = pt1{1}(3:128);
        desc2 = pt2{1}(3:128);
        
        % Distance Euclidienne entre les 2 descripteurs
        dist = sqrt(sum((desc1-desc2).^2));
        mat_distances(i,j) = dist;
    end
end

