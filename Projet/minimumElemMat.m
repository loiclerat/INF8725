function [ indexX,indexY ] = minimumElemMat( mat )
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