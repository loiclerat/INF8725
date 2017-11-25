% Loïc LERAT 1920881
% Simon-Pierre DESJARDINS 1739351


%% Nettoyage du workspace
clear all;
close all;
clc;

%% 
%Partie 2.1 : Construction des différences de Gaussiennes

image = rgb2gray(imread('droite.jpg'));
image = double(image)/255;
[listDoG, listOctaves, vectSigma] = differenceDeGaussiennes(image, 3, 3);

%TODO mettre legende titre echelle pour pyramide gaussienne et differences
%Q1 et Q2
%Laplacian?

[r,s] = size(listOctaves);
totalSizeListOctaves = r*s;
%Partie 2.2 : Détection des points clés
for i = 1:totalSizeListOctaves-1
    listPoints{i} = detectionPointsCles( listDoG{i}, listOctaves{i}, vectSigma(i), 0.03 , 10, i );
end 

imshow(image);

[t,u] = size(listPoints);
totalSizeListPoints = t*u;
for i = 1:totalSizeListPoints
    [w,x] = size(listPoints{i});
    totalSizeListPointsAtI = w*x;
    for j = 1:totalSizeListPointsAtI
        centerY = listPoints{i}{j}(1); % Je pense que nos x et Y sont inversés, j'ai du les inverser ici pour avoir des positions qui font du sens
        centerX = listPoints{i}{j}(2);  %TODO reste a rajouter les couleurs 
        octave = listPoints{i}{j}(3);
        magnitude = listPoints{i}{j}(4);
        angle = listPoints{i}{j}(5);

        radius = magnitude*1000;

        rectangle('Position',[centerX - radius, centerY - radius, radius*2, radius*2],'Curvature',[1,1]);
        axis square;
    end
end



%Q1 TODO Rapport comme on fait ?  Dxx = imfilter(imfilter(DoG(:,:,o), Gx, 'symmetric','same'), Gx, 'symmetric','same');

%Q2 TODO Rapport compteurs sont fait , reste qu'à les mettre dans un tableau par octave

%Q3 TODO Rapport points dans listPoints selon le {i}

%Q4 Joindre les .mat

%Q5 TODO tracer les lieux