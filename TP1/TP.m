% Lo�c LERAT 1920881
% Simon-Pierre DESJARDINS 1739351


%% Nettoyage du workspace
clear all;
close all;
clc;

%% Exercice I
% Signaux simples

x = 0:pi/13:7*pi;

Y = @(x) sin(x);
C = @(x) 2.8 + 0*x;

moy = 0.1;
varia = 0.4;

B = @(x) moy + sqrt(varia)*randn(size(x));

Z = @(x) (Y(x) + C(x) + B(x));

moyenneZ = mean(Z(x));
varianceZ = var(Z(x));

display(moyenneZ);
display(varianceZ);


hold on;

plot(x, Y(x), '--');
plot(x, C(x), '--');
plot(x, B(x), '--');
plot(x, Z(x));

grid on;
legend("Y","C", "B","Z");
title("Exercice 1 - TP1");



%% Exercice II
% Echantillonage

%1. Nous consid�rons que le signal analogique est compos� de 3 signaux de
%fr�quences diff�rentes. Nous utilisons alors la notion de spectre et la
%forme de chaque signal x(t) = c*cos(2*pi * t/To). 
%Sachant que fo = 1/To, nous avons :
%- 2*pi * t/To =  165*pi*t  ==> fo = 82.5 Hz
%- 2*pi * t/To =  6*pi*t  ==> fo = 3 Hz
%- 2*pi * t/To =  80*pi*t  ==> fo = 40 Hz



%2.

Y = @(t) 2*sin(165*pi*t) + 13*cos(6*pi*t) + 3*cos(80*pi*t);

t = 0:1/20:1;
subplot(2,3,1);
plot(t, Y(t));
title("Exercice 2 - TP1 (20 Hz)");
xlabel("t");
ylabel("Y(t)");

t = 0:1/75:1;
subplot(2,3,2);
plot(t, Y(t));
title("Exercice 2 - TP1 (75 Hz)");
xlabel("t");
ylabel("Y(t)");

t = 0:1/100:1;
subplot(2,3,3);
plot(t, Y(t));
title("Exercice 2 - TP1 (100 Hz)");
xlabel("t");
ylabel("Y(t)");

t = 0:1/160:1;
subplot(2,3,4);
plot(t, Y(t));
title("Exercice 2 - TP1 (160 Hz)");
xlabel("t");
ylabel("Y(t)");

t = 0:1/180:1;
subplot(2,3,5);
plot(t, Y(t));
title("Exercice 2 - TP1 (180 Hz)");
xlabel("t");
ylabel("Y(t)");

t = 0:1/330:1;
subplot(2,3,6);
plot(t, Y(t));
title("Exercice 2 - TP1 (330 Hz)");
xlabel("t");
ylabel("Y(t)");


%3. Plus la fr�quence d'�chantillonage est �lev�e, plus la courbe est pr�cise et se rapproche de la forme
%   r�elle du signal analogique

%4. Sachant que la frequence optimale Fe doit �tre au moins �gale au double
%de la fr�quence maximale du signal analogique (th�or�me de Shannon) et consid�rant que la
%fr�quence maximale de notre signal analogique est 82.5 Hz , notre
%fr�quence d'�chantillonnage doit �tre d'au moins 165Hz. Les seules
%fr�quences d'�chantillonnage qui satisfont le th�or�me de Nyquist-Shannon
%sont 180Hz et 330Hz. 

%La fr�quence d'�chantillonage optimale serait donc 180 Hz



%% Exercice III
% Analyse Spectrale

%1.

Y1 = @(t) 5*sin(2*pi*4*t);
Y2 = @(t) 3*sin(2*pi*45*t);
Y3 = @(t) 2*sin(2*pi*70*t);

t = 0:1/250:1;

hold on;

plot(t, Y1(t), '--');
plot(t, Y2(t), '--');
plot(t, Y3(t), '--');

%2. Par lecture graphique : 
%   Y1 : To = 1/4
%   Y2 : To = 1/40
%   Y3 : To = 1/70
% Valeurs th�oriques (en suivant la m�me m�thode que dans l'exercice pr�c�dent)
%   Y1 : To = 1/4
%   Y2 : To = 1/45
%   Y3 : To = 1/70
% On constate que les valeurs correspondent


%3. En d�finissant notre domaine des x de 0 � 5, nous pouvons
%remarquer que des motifs semblent se r�p�ter � chaque p�riode de 1. De
%mani�re analytique, il suffit de trouver le plus grand diviseur commun des
%fr�quences (4hz, 45hz, 70h), celui-ci est �gal � 1. Cela se traduit en
%une p�riode de 1 ce qui confirme notre lecture graphique.

Z = @(t) (Y1(t) + Y2(t) + Y3(t));

plot(t, Z(t));

legend("Y1","Y2", "Y3", "Z");
title("Exercice 3 - TP1");
xlabel("t");
ylabel("Y(t)");

%4.
figure;

hold on;
%On limite le domaine des fr�quences selon la fr�quence des signaux de Y1,
%Y2, Y3
f = linspace(-125,125,length(t));

%Nous divisions par le nombre de points pour obtenir l'amplitude / 2. Il
%suffit de multiplier par 2 pour obtenir l'amplitude r�elle du signal.
plot(f,fftshift(abs(fft(Y1(t))))/length(t) * 2);
plot(f,fftshift(abs(fft(Y2(t))))/length(t) * 2);
plot(f,fftshift(abs(fft(Y3(t))))/length(t) * 2);

legend("Y1","Y2", "Y3");
title("Exercice 3 (TFD) - TP1");
xlabel("f");
ylabel("Y(f)");

%Nous remarquons que l'abscisse des pics correspond aux fr�quences que nous
%avons trouv� pour chacun des signaux. Nous avons �galement une sym�trie
%des fr�quences que nous avons obtenu avec fftshift. Au d�part, nous avions
%�galement les mauvaises amplitudes, cela �tait caus� par le fait qu'elles 
%�taient multipli�es par le nombre de points dans notre graphique. C'est 
%pourquoi nous avons divis� notre r�sultat de fft par le nombre de points.
%On prend uniquement la partie r�elle de la TFD, la partie imaginaire
%(correspondant � la phase) ne nous int�resse pas ici. Finalement, nous
%remarquons que nous n'avons pas de pics parfaits (dirac). Cela vient du
%fait que notre signal n'est pas infini. Or, la TFD est une convolution du
%sinus et du rectangle de la fen�tre d'analyse. La TFD du sinus est un
%dirac tandis que la TFD de la fen�tre d'analyse est un sinus cardinal.
%Nous obtenons alors un sinus cardinal translat� � la position du dirac.



%5. 

figure;

hold on;
%On limite le domaine des fr�quences selon la fr�quence de Z
f = linspace(-125,125,length(t));

plot(f,fftshift(abs(fft(Z(t))))/length(t) * 2);

legend("Z(t)");
title("Exercice 3 (TFD) - TP1");
xlabel("f");
ylabel("Z(f)");

%On obtient une TFD similaire (les pics sont situ�s aux m�mes fr�quences et
%sont de m�me amplitude). Nous remarquons alors que la TFD est lin�aire, ce
%qui veut dire que la somme des TFD de signaux est �quivalente au TFD de la
%somme des signaux.



%% Exercice IV
% Filtrage audio

%1.
[Data,Fe] = audioread('audio.wav');

%sound(Data,Fe);


%En �coutant le signal, nous entendons un "buzz" tout au long de la chanson
%qui semble �tre un signal de haute fr�quence avec un son tr�s aigu. Il 
%semble �galement y avoir une perturbation de basse fr�quence comme un 
%bourdonnement. 


%2.

f = linspace(0,Fe,length(Data));
TF = abs(fft(Data))/length(Data);

%On a aussi divis� notre graphique pour ne traiter qu'une partie du signal 
%qui nous int�resse qui correspond � la moiti� des valeurs du vecteur TF.
%De base, le graphe pr�sente une sym�trie des fr�quences, pour obtenir
%l'amplitude r�elle, il faudra donc multiplier par 2 les amplitudes dans le
%domaine qui nous int�resse (sauf � l'abscisse 0 car nous sommes sur l'axe
%de sym�trie.

TF(2:length(Data)) = TF(2:length(Data))*2;
plot(f(1:length(f)/2+1),TF(1:length(TF)/2+1));
title("Exercice 4 (TFD) - TP1");
xlabel("f");
ylabel("TF(f)");


%3. Nous percevons clairement deux perturbations (deux pics). La
%perturbation la plus haute fr�quence a une fr�quence de 1244Hz ce qui
%correspond � une note r�# d'octave 5.


%4

b = fir1(128, 950/(Fe/2));
pb = filter(b,1,Data);
TFPB = abs(fft(pb))/length(pb);

TFPB(2:length(pb)) = TFPB(2:length(pb))*2;

figure;
plot(f(1:length(f)/2+1),TFPB(1:length(TFPB)/2+1));

title("Exercice 4 (TFD apr�s filtrage passe-bas) - TP1");
xlabel("f");
ylabel("TF(f)");

%sound(pb,Fe)

%On choisit de mani�re arbitraire une fr�quence de coupure de 950Hz
%pour att�nuer la plus haute fr�quence. Avec cette fr�quence de coupure, on
%semble avoir presque compl�tement att�nu� la perturbation haute fr�quence � l'�coute.
%Nous observons une perte d'information au niveau des hautes fr�quences au
%dessus de 950 Hz correspondant � notre fr�quence de coupure. Les
%fr�quences entre 950 et 1250Hz sont plus ou moins att�nu�es tandis que les
%fr�quences au-dessus ne seront plus perceptibles � l'�coute. Nous perdons
%alors diff�rents sons composant la musique. 
%Pour �viter de perdre trop d'information tout en coupant la fr�quence de
%perturbation, il nous faudrait un filtre cibl�e sur cette fr�quence qui
%n'attenue qu'une certaine zone autour d'elle


%5

cheb = fir1(128,250/(Fe/2),'high', chebwin(129,30));
hamm = fir1(128,250/(Fe/2),'high', hamming(129));
blackm = fir1(128,250/(Fe/2),'high', blackman(129));


%6

freqz([dfilt.dffir(cheb),dfilt.dffir(hamm), dfilt.dffir(blackm)]); 
legend("Chebyshev","Hamming", "Blackman");

%On constate que la r�ponse fr�quentielle diff�re selon le filtre. Ainsi,
%on peut s'attendre � ce que Chebyshev soit le filtre qui attenue le plus
%les basses fr�quences et Blackman est celui qui att�nue le moins. Pour ce
%qui de Hamming, il se situe entre les deux et nous estimons qu'il
%att�nuera mod�r�ment les basses fr�quences. 


%7

chebFilter = filter(cheb,1,pb);
hammFilter = filter(hamm,1,pb);
blackmFilter = filter(blackm,1,pb);
%sound(chebFilter,Fe);
%sound(hammFilter,Fe);
%sound(blackmFilter,Fe);

%On remarque que la perturbation basse fr�quence n'est plus pr�sente apr�s
%filtrage passe-haut. A l'oreille il est difficile de percevoir une
%diff�rence entre les trois types de filtres passe-haut.
%On retrouve un probl�me similaire au filtre passe-bas : en attenuant toutes
%les fr�quences plus basses que 250Hz, cela nous permet d'�liminer la
%perturbation mais on risque de perdre des fr�quences int�ressantes de la
%musique (instruments graves tels que la basse ou la batterie).


%8

%TFD Chebyshev
TFPHC = abs(fft(chebFilter))/length(chebFilter);
TFPHC(2:length(chebFilter)) = TFPHC(2:length(chebFilter))*2;

figure;
plot(f(1:length(f)/2+1),TFPHC(1:length(TFPHC)/2+1));
title("Exercice 4 (TFD apr�s filtrage passe-haut Chebyshev) - TP1");
xlabel("f");
ylabel("TF(f)");

%TFD Hamming
TFPHH = abs(fft(hammFilter))/length(hammFilter);
TFPHH(2:length(hammFilter)) = TFPHH(2:length(hammFilter))*2;

figure;
plot(f(1:length(f)/2+1),TFPHH(1:length(TFPHH)/2+1));
title("Exercice 4 (TFD apr�s filtrage passe-haut Hamming) - TP1");
xlabel("f");
ylabel("TF(f)");

%TFD Blackman
TFPHB = abs(fft(blackmFilter))/length(blackmFilter);
TFPHB(2:length(blackmFilter)) = TFPHB(2:length(blackmFilter))*2;

figure;
plot(f(1:length(f)/2+1),TFPHB(1:length(TFPHB)/2+1));
title("Exercice 4 (TFD apr�s filtrage passe-haut Blackman) - TP1");
xlabel("f");
ylabel("TF(f)");


% On remarque sur les TFD que la fr�quence de perturbation basse est bien
% att�nu�e (l'amplitude diminue nettement). Comme nous le supposions � la 
% question pr�c�dente, Chebyshev est le filtre qui attenue le plus 
%(amplitude de 6.5x10-3), suivi par Hamming(amplitude de 0.036) puis 
%Blackman (amplitude de 0.1). Nous pensons que les spectres correspondent
%�galement � ce que nous avons entendu malgr� que la diff�rence �tait 
%beaucoup plus difficile � distinguer � l'oreille qu'avec les spectres.

