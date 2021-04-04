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

input = high;

tic
I = edgeAware(input, 2, lambda, W, alpha, sigma);
toc

imshow([input I]);
% imwrite(I, folder_3 + "p1/high_3cbZ.jpg");

pair_number = 4; % 1-5

if pair_number == 1
    flash = im2double(imread(folder_2 + 'carpet_00_flash.jpg'));
    no_flash = im2double(imread(folder_2 + 'carpet_01_noflash.jpg'));
elseif pair_number == 2
    flash = im2double(imread(folder_2 + 'cave01_00_flash.jpg'));
    no_flash = im2double(imread(folder_2 + 'cave01_01_noflash.jpg'));
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

lambda = 1;
W = 10;
alpha = 2;
sigma = 0.005;

tic
% lambda = 5; W = 10; alpha = 2; sigma = 0.1; % a,d,e
% lambda = 3; W = 10; alpha = 2; sigma = 0.1; % b,c
% I = edgeAware(no_flash, 5, lambda, W, alpha, sigma);
% imwrite(I, folder_3 + "p2/d2_itselfZ.jpg");

% lambda = 1; W = 10; alpha = 2; sigma = 0.005; % a,d,e (p3)
% lambda = 0.1; W = 10; alpha = 2; sigma = 0.005; % b
% lambda = 2; W = 10; alpha = 2; sigma = 0.005; % c
% I = cross(no_flash, 5, lambda, W, alpha, sigma, flash);
% imwrite(I, folder_3 + "p2/e1_cross.jpg");
toc

% imshow([no_flash I]);

% tic
% lambda = 1; W = 10; alpha = 2; sigma = 0.005;
% I = cross(low, 5, lambda, W, alpha, sigma, high);
% imwrite(I, folder_3 + "p3/1Z.jpg");
% toc
