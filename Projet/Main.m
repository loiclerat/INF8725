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


% Q2
%   - Trouver les n plus petites distances

n = 3; %nombre de distances minimales

tempMatDistances = matDistances;


for i = 1:n

    %TODO changer la fonction minmat pour qu'elle soit plus claire
    [x,y] = minmat(tempMatDistances);


    tempMatDistances(x,y) = Inf;
    
    xGauche = descripteursGauche{x}(1);
    yGauche = descripteursGauche{x}(2);
    
    xDroit = descripteursDroite{y}(1);
    yDroit = descripteursDroite{y}(2);
    
    pointGauche = [xGauche,yGauche];
    pointDroit = [xDroit,yDroit];
    
    listePointGauche{i} = pointGauche;
    listePointDroit{i} = pointDroit;
    


end


%   - Afficher sur les images pour vérifier

%TODO couleur différente pour chacun des couples
afficherCouplePoints(imageGauche,listePointGauche);
afficherCouplePoints(imageDroite,listePointDroit);



%Partie 3.0.2 : Homographie

