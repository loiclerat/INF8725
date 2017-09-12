%% Nettoyage du workspace
clear all;
close all;
clc;
%% Exercice I
% Initialisation des variables
load lab0_data.mat;
mozzarella = mozzarella';
mozzarella(2) = 9.7;
annee = 2000:2009;

hold on;

yyaxis left;
ylim([9,11]);
plot(annee,mozzarella);

xlabel("annee");
ylabel("mozza");

%figure;

yyaxis right;
ylim([400,800]);
scatter(annee,doctorats);
xlabel("annee");
ylabel("doctorants");

grid on;

legend("mozza","doctorants");
title("Étude comparative de l’effet de la consommation de Mozzarella sur les diplômes d’ingénierie civile aux USA.");