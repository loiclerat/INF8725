% Loïc LERAT 1920881
% Simon-Pierre DESJARDINS 1739351


%% Nettoyage du workspace
clear all;
close all;
clc;

%%
% Partie 2.1 : Construction des différences de Gaussiennes

image = rgb2gray(imread('droite.jpg'));
image = double(image)/255;
[A,B,C] = differenceDeGaussiennes(image, 2, 3);

%TODO mettre legende titre echelle pour pyramide gaussienne et differences
%Q1 et Q2
%Laplacian?