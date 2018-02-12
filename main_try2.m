clc, clear, close all

%% Read an image
obs_img = getImage('img0.jpg');
obs_img = im2double(obs_img);
figure
imshow(obs_img)
gray = rgb2gray(obs_img);


%% super pixel image
[L,N] = superpixels(obs_img, 2);
BW = boundarymask(L);
idx = label2idx(L);