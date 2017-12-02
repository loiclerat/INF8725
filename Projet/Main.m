% Loïc LERAT 1920881
% Simon-Pierre DESJARDINS 1739351


%% Nettoyage du workspace
clear all;
close all;
clc;

%% 
%Partie 2 : Détection des extremas et descripteurs

imageGauche = rgb2gray(imread('gauche.jpg'));
imageDroite = rgb2gray(imread('droite.jpg'));
imageGauche = double(imageGauche)/255;
imageDroite = double(imageDroite)/255;

disp('Analyse image gauche...');
descripteursGauche = analyseImage(imageGauche);
disp('Analyse image droite...');
descripteursDroite = analyseImage(imageDroite);


%Q1 TODO Rapport comme on fait ?  Dxx = imfilter(imfilter(DoG(:,:,o), Gx, 'symmetric','same'), Gx, 'symmetric','same');
%Q2 TODO Rapport compteurs sont fait , reste qu'à les mettre dans un tableau par octave
%Q3 TODO Rapport points dans listPoints selon le {i}
%Q4 Joindre les .mat
%Q5 Done



%Partie 3 : Matching et homographie
%Partie 3.0.1 : Recherche de couples amis

% Recherche des couples amis
disp('Calcul des distances inter points...');
matDistances = distanceInterPoints(descripteursGauche, descripteursDroite);

% Q1 TODO
%   - Tracer matrice
% Q2 TODO
%   - Trouver les n plus petites distances
%   - afficher sur les images pour vérifier


%Partie 3.0.2 : Homographie

