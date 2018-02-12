clc, clear, close all

%% Read an image
img = getImage('img0.jpg');
imshow(img)
greyDummy = rgb2gray(img);

%% super pixel image
[L,N] = superpixels(img,60);
BW = boundarymask(L);
idx = label2idx(L);
% imshow(imoverlay(img,BW,5'cyan'))
outputImage = zeros(size(img),'like',img);
numRows = size(img,1);
numCols = size(img,2);
for labelVal = 1:N
    redIdx = idx{labelVal};
    greenIdx = idx{labelVal}+numRows*numCols;
    blueIdx = idx{labelVal}+2*numRows*numCols;
    color(labelVal, :) = [mean(img(redIdx)), mean(img(greenIdx)), mean(img(blueIdx))];
    outputImage = updateImg(outputImage, color, idx, labelVal, 3);
end    
 
figure
imshow(imoverlay(outputImage,BW,'cyan'))
% imshow(outputImage)

color;
dlmwrite('data/MyMatrix.txt', color, 'delimiter','\t')

%% Read Separated Data -- Diffused

diffused = importdata('data/diffused.txt');
a = 1;
md = diffused(:,1)/a;
cd = diffused(:,2:4)*a;
ld = md.*cd;

md_img = ones(size(greyDummy),'like',greyDummy)*255;
cd_img = ones(size(img),'like',img)*255;
ld_img = zeros(size(img),'like',img);

%% Read Separated Data -- Spectral

spectral = importdata('data/spectral.txt')
ms = spectral(:,1)/a;
cs = [mean(spectral(:,2)), mean(spectral(:,3)), mean(spectral(:,4))]*a;
ls = ms.*cs;

ms_img = zeros(size(greyDummy),'like',greyDummy);
cs_img = zeros(size(img),'like',img);
ls_img = zeros(size(img),'like',img);

for labelVal = 1:N
    md_img = updateImg(md_img, md, idx, labelVal, 1);
    cd_img = updateImg(cd_img, cd, idx, labelVal, 3);
    ld_img = updateImg(ld_img, ld, idx, labelVal, 3);
    
    ms_img = updateImg(ms_img, ms, idx, labelVal, 1);
    cs_img = updateImg(cs_img, cs, idx, labelVal, 4);
    ls_img = updateImg(ls_img, ls, idx, labelVal, 3);
end

figure
imshow(md_img)

figure
imshow(cd_img*10)

figure
imshow(ld_img)

% figure
% imshow(ms_img*10)
% 
% figure
% imshow(cs_img*10)
% 
% figure
% imshow(ls_img)
% 
% 
% figure
% imshow(ls_img + ld_img)






