function [ matDescripteurs ] = descriptionPointsCles(image_initiale, listOctaves, listKeypoints)
% Retourne une matrice contenant tous les descripteurs cr��s � partir des
% points cl�s


%Rotation syst�me de cordonn�es = orientation keypoint (sens oppos�)

%D�terminer zone 16x16 px autour du keypoint
%Calculer orientation de chaque px -> Fait � l'avance ?
%Histogramme des orientation pour chaque zone 4x4 px
% -> 16 histogrammes � 8 intervalles
%Concat�ner - normaliser - plafonner valeurs � 0.2 - normaliser � nouveau

%Mettre tout dans un vecteur de dim = 128 + 2 (x,y)


end

