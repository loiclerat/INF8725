% Loïc LERAT 1920881
% Simon-Pierre DESJARDINS 1739351


%% Nettoyage du workspace
clear all;
close all;
clc;

%% Exercice I
% Réhaussement d'images

image = imread('theArtist.png');

imageEgalisee = uint8(Egalisation_Histogramme(image));

imshow(imageEgalisee);

%2-3. Convolution

MasqueGau = 1/90 * [1,2,1,2,1;2,4,8,4,2;1,8,18,8,1;2,4,8,4,2;1,2,1,2,1];
imageConvo = uint8(Convolution(imageEgalisee,MasqueGau));

figure;
imshow(imageConvo);

%4. Rehaussement Contour

figure;

imageRehaussee = uint8(Rehaussement_Contour(imageConvo,1.2));
imshow(imageRehaussee);

%5. En rehaussant les contours, nous avons également rehaussé les
%particules de bruits qui restaient à la suite du filtre Gaussien. Le
%filtre médian permettrait de réduire le bruit impulsionnel de type "poivre
%et sel" que nous observons tout en préservant les contours. 