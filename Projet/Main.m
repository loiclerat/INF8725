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


%Partie 2.2 : Détection des points clés
for i = 1:size(listOctaves)
    listPoints{i} = detectionPointsCles( listDoG{i}, listOctaves{i}, vectSigma(i), 0.03 , 10, i );
end 

%TODO les questions partie 2.2