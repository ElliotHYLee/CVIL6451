clc, clear, close all

%% Read an image
img = getImage('img0.jpg');
img = im2double(img);
figure
imshow(img)
gray = rgb2gray(img);


%% super pixel image
[L,N] = superpixels(img, 2);
BW = boundarymask(L);
idx = label2idx(L);


cd_img = zeros(size(img),'like',img);
numRows = size(img,1);
numCols = size(img,2);
for labelVal = 1:N
    redIdx = idx{labelVal};
    greenIdx = idx{labelVal}+numRows*numCols;
    blueIdx = idx{labelVal}+2*numRows*numCols;
    color(labelVal, :) = [mean(img(redIdx)), mean(img(greenIdx)), mean(img(blueIdx))];
    cd_img = updateImg(cd_img, color, idx, labelVal, 3);
end    
 
figure
imshow(imoverlay(cd_img,BW,'cyan'))

spList_cd  = getSPList(img, idx, N);
dlmwrite('data/cd_init.txt', color, 'delimiter','\t')