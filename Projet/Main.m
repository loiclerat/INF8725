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
descripteursGauche = analyseImage(imageGauche,1);
save('descripteursGauche.mat','descripteursGauche');

disp('Analyse image droite...');
descripteursDroite = analyseImage(imageDroite,0);
save('descripteursDroite.mat','descripteursDroite');

%Partie 3 : Matching et homographie
%Partie 3.0.1 : Recherche de couples amis

% Recherche des couples amis
disp('Calcul des distances inter points...');
matDistances = distanceInterPoints(descripteursGauche, descripteursDroite);

% Affichage de la matrice obtenue
%figure;
%imshow(matDistances); 
%title('Matrice des distances');
%axis on;


% Recherche des n plus petites distances

disp('Recherche des distances minimales..');
n = 5; %nombre de distances minimales à calculer

tempMatDistances = matDistances;

% Pour les n distances minimales, on retrouve le couple et on assigne une 
% couleur aux points  
for i = 1:n
    
    %Fonction qui trouve l'index de l'élément le plus petit d'une matrice
    [x,y] = minimumElemMat(tempMatDistances);

    
    %Remplace la valeur par l'infini dans une matrice temporaire pour
    %trouver le prochain minimum
    tempMatDistances(x,y) = Inf;
    
    xGauche = descripteursGauche{x}(1);
    yGauche = descripteursGauche{x}(2);
    
    xDroit = descripteursDroite{y}(1);
    yDroit = descripteursDroite{y}(2);
    
    pointGauche = [xGauche,yGauche];
    pointDroit = [xDroit,yDroit];
    
    listePointGauche{i} = pointGauche;
    listePointDroit{i} = pointDroit;
    
    %On associe une couleur aléatoire au couple de points
    r = rand;
    g = rand;
    b = rand;
 
    couleurPoint = [r,g,b];
    listeCouleur{i} = couleurPoint;

end


% Afficher sur les images pour vérifier

%disp('Affichage des couples de points..');
%afficherCouplePoints(imageGauche,listePointGauche,listeCouleur);
%afficherCouplePoints(imageDroite,listePointDroit,listeCouleur);



%Partie 3.0.2 : Homographie

% Construction de la matrice A
A = zeros(2*n, 9);
for i = 1:n
    x1 = listePointGauche{i}(1);
    y1 = listePointGauche{i}(2);
    x2 = listePointDroit{i}(1);
    y2 = listePointDroit{i}(2);
    xx = -x2*x1;
    xy = -x2*y1;
    yx = -y2*x1;
    yy = -y2*y1;

    A(2*i-1,:) = [x1 y1 1 0 0 0 xx xy -x2];
    A(2*i,:) = [x1 y1 1 0 0 0 yx yy -y2];
end

% Obtention de la matrice de transformation
AT = transpose(A);
ATA = AT*A;

[U,S,V] = svd(A);
VT = transpose(V);

valeursPropres = eig(ATA);
[vecteursPropres,D] = eig(ATA);
[min, argmin] = min(valeursPropres);
Hflat = vecteursPropres(:,argmin);

% Vérifier que le dernier vecteur de VT correspond à Hflat -> Ne marche pas

HfaltNorm = Hflat/Hflat(end);
Hnorm = reshape(HfaltNorm, [3,3]);
    
% Réalisation du panorama
    % Comment appliquer homographie et placer les images ??
