clc
clear variables
close all

lambda = 10; % 0.1, 1, 10
W = 10; % 5, 10, 20

alpha = 2;
sigma = 0.5;

folder_1 = "data_1/";
folder_2 = "data_2/";

high = im2double(imread(folder_1 + 'high.jpg'));
low = im2double(imread(folder_1 + 'low.jpg'));
lena = im2double(imread('../lena.jpg'));

input = high;

tic
I = edgeAware(input, 5, lambda, W, alpha, sigma);
toc

imshow([input I]);
% imshow([input imbilatfilt(input)]);
% imwrite(I, "z10_rgb.jpg");