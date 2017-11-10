function [ sommeMonnaie ] = Compter_Monnaie( image )


se = strel('disk',90);
image90 = imerode(image,se);

[L,nombrePiece90] = bwlabel(image90);


se = strel('disk',110);
image110 = imerode(image,se);

[L,nombrePiece110] = bwlabel(image110);

se = strel('disk',120);
image120 = imerode(image,se);

[L,nombrePiece120] = bwlabel(image120);

se = strel('disk',140);
image140 = imerode(image,se);

[L,nombrePiece140] = bwlabel(image140);

se = strel('disk',200);
image200 = imerode(image,se);

[L,nombrePiece200] = bwlabel(image200);

somme10sous = (nombrePiece90 - nombrePiece110)*0.10;
somme5sous = (nombrePiece110 - nombrePiece120) * 0.05;
somme25sous = (nombrePiece120 - nombrePiece140) * 0.25;
somme2dollars = (nombrePiece140 - nombrePiece200) * 2;

sommeMonnaie = somme10sous + somme5sous + somme25sous + somme2dollars;

end

%10 5 25 2$