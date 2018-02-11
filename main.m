clc, clear, close all

img = imread('img0.jpg');
[h, w, c] = size(img)
img = imresize(img, [h/2, w/2]);
imshow(img)









