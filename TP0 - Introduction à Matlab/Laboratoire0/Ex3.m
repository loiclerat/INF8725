%% Nettoyage du workspace
clear all;
close all;
clc;

%% Exercice III
% Images, fonctions et histogrammes

image = imread('chat.png');
%imshow(image);

min(image(:));
max(image(:));
size(image(:));

subplot(2,3,1);
imshow(FunctionEx3(image,1));
subplot(2,3,2);
imshow(FunctionEx3(image,2));
subplot(2,3,3);
imshow(FunctionEx3(image,3));

subplot(2,3,4);
DispHistogramme(image, 1);
subplot(2,3,5);
DispHistogramme(image, 2);
subplot(2,3,6);
DispHistogramme(image, 3);
