% Loïc LERAT 1920881
% Simon-Pierre DESJARDINS 1739351


%% Nettoyage du workspace
clear all;
close all;
clc;

%% 
%Partie 2.1 : Construction des différences de Gaussiennes

image = rgb2gray(imread('gauche.jpg'));
image = double(image)/255;
[listDoG, listOctaves, vectSigma] = differenceDeGaussiennes(image, 3, 3);

%TODO Ça serait pas plutôt S+2 pour avoir 5 sigma et non 6?


%Partie 2.2 : Détection des points clés

[r,s] = size(listOctaves);
totalSizeListOctaves = r*s;

for i = 1:totalSizeListOctaves
    [listPoints{i},counterExtremaDetect{i},counterFaibleContraste{i},counterPointsArretes{i}] = detectionPointsCles( listDoG{i}, listOctaves{i}, vectSigma, 0.04 , 10, i );
end 

imshow(image);

[t,u] = size(listPoints);
totalSizeListPoints = t*u;
for i = 1:totalSizeListPoints
    [w,x] = size(listPoints{i});
    totalSizeListPointsAtI = w*x;
    for j = 1:totalSizeListPointsAtI
        centerY = listPoints{i}{j}(1); % Je pense que nos x et Y sont inversés, j'ai du les inverser ici pour avoir des positions qui font du sens
        centerX = listPoints{i}{j}(2);
        sigmaPoint = listPoints{i}{j}(3);
        %magnitude = listPoints{i}{j}(4);
        angle = listPoints{i}{j}(4);

        radius = sigmaPoint*10;
        
        x2=centerX+(radius*cos(deg2rad(angle)));
        y2=centerY+(radius*sin(deg2rad(angle)));
        
        
        
        if sigmaPoint == vectSigma(1)
            rectangle('Position',[centerX - radius, centerY - radius, radius*2, radius*2],'Curvature',[1,1], 'EdgeColor', 'k' );
            line([centerX,x2],[centerY,y2], 'Color', 'k','LineWidth',2);
        elseif sigmaPoint == vectSigma(2)
             rectangle('Position',[centerX - radius, centerY - radius, radius*2, radius*2],'Curvature',[1,1], 'EdgeColor', 'r' );
             line([centerX,x2],[centerY,y2], 'Color', 'r','LineWidth',2);
        elseif sigmaPoint == vectSigma(3)
             rectangle('Position',[centerX - radius, centerY - radius, radius*2, radius*2],'Curvature',[1,1], 'EdgeColor', 'g' );
             line([centerX,x2],[centerY,y2], 'Color', 'g','LineWidth',2);
        else %find a better way if more than 3 octaves
             rectangle('Position',[centerX - radius, centerY - radius, radius*2, radius*2],'Curvature',[1,1], 'EdgeColor', 'b' );
             line([centerX,x2],[centerY,y2], 'Color', 'b','LineWidth',2);
        end
    end
end

%descriptionPointsCles (**,listeOctave{i},listeKeyPoints{i}

%Q1 TODO Rapport comme on fait ?  Dxx = imfilter(imfilter(DoG(:,:,o), Gx, 'symmetric','same'), Gx, 'symmetric','same');

%Q2 TODO Rapport compteurs sont fait , reste qu'à les mettre dans un tableau par octave

%Q3 TODO Rapport points dans listPoints selon le {i}

%Q4 Joindre les .mat

%Q5 Done

%===================
% A Demander :  
%   - Comment faire la rotation (descripteurs) ?
%   - Q1 (Hessienne)

