clc
clear variables
close all

lambda = 10; % 0.1, 1, 10
W = 10; % 5, 10, 20

alpha = 2;
sigma = 0.5;

folder_1 = "data_1/";
folder_2 = "data_2/";
folder_3 = "results/";

high = im2double(imread(folder_1 + 'high.jpg'));
low = im2double(imread(folder_1 + 'low.jpg'));
lena = im2double(imread('../lena.jpg'));

input = low;

% tic
% I = edgeAware(input, 1, lambda, W, alpha, sigma);
% toc

% imshow([input I]);
% imshow([input imbilatfilt(input)]);
% imwrite(I, folder_3 + "p1/low_3c.jpg");

pair_number = 2; % 1-5

if pair_number == 1
    flash = im2double(imread(folder_2 + 'carpet_00_flash.jpg'));
    no_flash = im2double(imread(folder_2 + 'carpet_01_noflash.jpg'));
elseif pair_number == 2
    flash = im2double(imread(folder_2 + 'cave01_00_flash.jpg'));
    no_flash = im2double(imread(folder_2 + 'cave01_01_noflash.jpg'));
    lambda = 3;
    W = 10;
    alpha = 2;
    sigma = 0.1;
elseif pair_number == 3
    flash = im2double(imread(folder_2 + 'lamp_00_flash.jpg'));
    no_flash = im2double(imread(folder_2 + 'lamp_01_noflash.jpg'));
elseif pair_number == 4
    flash = im2double(imread(folder_2 + 'potsdetail_00_flash.jpg'));
    no_flash = im2double(imread(folder_2 + 'potsdetail_01_noflash.jpg'));
elseif pair_number == 5
    flash = im2double(imread(folder_2 + 'puppets_00_flash.jpg'));
    no_flash = im2double(imread(folder_2 + 'puppets_01_noflash.jpg'));
else
    error("Invalid pair number");
end

input = low;
guide = high;

lambda = 3; % 0.1, 1, 10
W = 10; % 5, 10, 20
alpha = 2;
sigma = 0.1;

tic
I = edgeAware(no_flash, 5, lambda, W, alpha, sigma);
% I = edgeAware(no_flash, 5, lambda, W, alpha, sigma, flash);
toc

imshow([no_flash I]);
imwrite(I, folder_3 + "p2/b1_crossZZZ.jpg");

