clc, clear, close all

%% Read an image
img = getImage('img0.jpg');

img = im2double(img);
figure
imshow(img)
gray = rgb2gray(img);
figure
imshow(gray)

%% super pixel image
[L,N] = superpixels(img, 500);
BW = boundarymask(L);
idx = label2idx(L);

cd_img = zeros(size(img),'like',img);
numRows = size(img,1);
numCols = size(img,2);
for labelVal = 1:N
    redIdx = idx{labelVal};
    pixelNumList(labelVal, :) = size(redIdx);
    greenIdx = idx{labelVal}+numRows*numCols;
    blueIdx = idx{labelVal}+2*numRows*numCols;
    color(labelVal, :) = [mean(img(redIdx)), mean(img(greenIdx)), mean(img(blueIdx))];
    cd_img = updateImg(cd_img, color, idx, labelVal, 3);
end    
 
figure
imshow(imoverlay(cd_img,BW,'cyan'))

%% lstm data gen --- CD
spList_cd  = getSPList(img, idx, N);
min = 99999;
for i =1:1:N
   spixel = spList_cd{i};
   if length(spixel) < min
       min = length(spixel);
   end
   dlmwrite(strcat('data/CD_lstm/cd_input', int2str(i-1), '.txt'), spixel, 'delimiter',' ')
end
min
% dlmwrite('data/CD_lstm/cd_init.txt', color, 'delimiter',' ')
% dlmwrite('data/CD_lstm/cd_info.txt', [min, N], 'delimiter',' ')
% 
% %% FC data gen -- Ms & md
% imgArray = reshape(img, [numRows*numCols, 3]);
% grayArray = reshape(gray, [numRows*numCols, 1]);
% % img(1,1,:)
% % img(2,1,:)
% 
% dlmwrite('data/M_fc/color.txt', imgArray, 'delimiter',' ')
% dlmwrite('data/M_fc/gray.txt', grayArray, 'delimiter',' ')
% 
% 
% gArr = importdata('data/M_fc/predGray.txt');
% recovImg = reshape(gArr, [numRows, numCols, 1]);
% figure
% imshow(recovImg)
% 
% 
% 
% cd_img_rec = zeros(size(img),'like',img);
% recColor = importdata('data/CD_lstm/cd_pred.txt');
% for labelVal = 1:N
%     redIdx = idx{labelVal};
%     greenIdx = idx{labelVal}+numRows*numCols;
%     blueIdx = idx{labelVal}+2*numRows*numCols;
%     color(labelVal, :) = [mean(img(redIdx)), mean(img(greenIdx)), mean(img(blueIdx))];
%     cd_img_rec = updateImg(cd_img_rec, recColor, idx, labelVal, 3);
% end   
% 
% figure
% imshow(cd_img_rec)


pixelNumList = pixelNumList(:,1)
md_img = zeros_like(gray);
cd_img = zeros_like(img);
ms_img = zeros_like(gray);
cs_img = zeros_like(img);
totalData = importdata('mdcdmscs2.txt');
start = 1
for labelVal = 1:N
    last = start + pixelNumList(labelVal) - 1
    sp_md{labelVal} = totalData(start:last, 1);
    sp_cd{labelVal} = totalData(start:last, 2:4);
    sp_ms{labelVal} = totalData(start:last, 5);
    sp_cs{labelVal} = totalData(start:last, 6:8);
    start = last + 1
end

md_img = concatSP(sp_md, md_img, idx);
cd_img = concatSP(sp_cd, cd_img, idx);
ms_img = concatSP(sp_ms, ms_img, idx);
cs_img = concatSP(sp_cs, cs_img, idx);

figure
imshow(md_img)

figure
imshow(cd_img)

figure
imshow(ms_img)

figure
imshow(cs_img)


figure
imshow(md_img.*cd_img)

figure
imshow(ms_img.*cs_img)

figure
imshow(md_img.*cd_img + ms_img.*cs_img)






