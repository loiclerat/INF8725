%% Nettoyage du workspace
clear all;
close all;
clc;

%% Exercice II
% Générer et tracer des signaux

f1 = @(x) sin(x);
f2 = @(x) sin(3*x)/3;
f3 = @(x) sin(5*x)/5;


x = linspace(0, 4*pi, 500);

f4 = @(k,x) sin(k*x)/k; 


y = zeros(size(x));

for i=0:500
    y = y + f4(2*i+1,x);
end


hold on;

plot(x, f1(x), '--');
plot(x, f3(x), '--');
plot(x, f2(x), '--');
plot(x, f1(x)+f2(x)+f3(x), 'LineWidth', 2);

legend("f1","f2", "f3");
title("Exercice 2 - graphe 1");

figure;

plot(x,y);



