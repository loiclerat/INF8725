%% Nettoyage du workspace
clear all;
close all;
clc;

%% Exercice IV
% Images binaires, calcul matriciel, convolution et jeu de la vie

f = @(n,e) ((n == 3) + (e .* n ==4));

N = @(map) conv2(map, ones(3,3), 'same');

fenetreJeu = figure('Name', 'Jeu de la vie');
while( ishghandle(fenetreJeu) )
    carte = f(N(carte),carte);
    imagesc(carte);
    pause(0.02);
end