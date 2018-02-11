clc, clear, close all

img = getImage('img0.jpg');
imshow(img)

[L,N] = superpixels(img,1000);

figure
BW = boundarymask(L);
imshow(imoverlay(img,BW,'cyan'))





