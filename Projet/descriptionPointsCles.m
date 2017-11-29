function [ matDescripteurs ] = descriptionPointsCles(image_initiale, listOctaves, listKeypoints)
% Retourne une matrice contenant tous les descripteurs créés à partir des
% points clés


%Rotation système de cordonnées = orientation keypoint (sens opposé)

%Déterminer zone 16x16 px autour du keypoint
%Calculer orientation de chaque px -> Fait à l'avance ?
%Histogramme des orientation pour chaque zone 4x4 px
% -> 16 histogrammes à 8 intervalles
%Concaténer - normaliser - plafonner valeurs à 0.2 - normaliser à nouveau

%Mettre tout dans un vecteur de dim = 128 + 2 (x,y)


end

