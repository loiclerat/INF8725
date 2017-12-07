function [ indexX,indexY ] = minimumElemMat( mat )

    %Permet de trouver l'index du plus petit élément d'une matrice donnée
    sizeMat=size(mat);
    [~,I]=min(mat(:));
    r=rem(I,sizeMat(1));
    indexX=r;
    indexY=((I-indexX)/sizeMat(1))+1;
    if indexX==0
        indexX=sizeMat(1);
        indexY=indexY-1;
    else
        indexX=r;
        indexY=indexY;
    end
end