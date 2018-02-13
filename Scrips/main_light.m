clc, clear, close all
%% Read an image
imgIndex = 2  % available imgs: 0, 1, 2

if imgIndex == 0
    [img, totalData] = getImageWithResultData('img0.jpg', 5, 0);
elseif imgIndex ==1
    [img, totalData] = getImageWithResultData('img1.jpg', 2, 1);
elseif imgIndex ==2 
    [img, totalData] = getImageWithResultData('img2.jpg', 4, 2);
end

img = im2double(img);
showImg('Observed', img)
gray = rgb2gray(img);

%% super pixel image
[sp_img, numRows, numCols, N, idx, meanColor, pixelNumList] = getSuperPixel(img, 10000);
showImg('SuperPixel', sp_img)
% imshow(imoverlay(cd_img,BW,'cyan'))

%% Show Separated Images
pixelNumList = pixelNumList(:,1);
md_img = zeros_like(gray);
cd_img = zeros_like(img);
ms_img = zeros_like(gray);
cs_img = zeros_like(img);

start = 1;
for labelVal = 1:N
    last = start + pixelNumList(labelVal) - 1;
    sp_md{labelVal} = totalData(start:last, 1);
    sp_cd{labelVal} = totalData(start:last, 2:4);
    sp_ms{labelVal} = totalData(start:last, 5);
    sp_cs{labelVal} = totalData(start:last, 6:8);
    start = last + 1;
end

md_img = concatSP(sp_md, md_img, idx);
cd_img = concatSP(sp_cd, cd_img, idx);
ms_img = concatSP(sp_ms, ms_img, idx);
cs_img = concatSP(sp_cs, cs_img, idx);

showImg('mD', md_img);
showImg('cD', cd_img);
showImg('mS', ms_img)
showImg('cS', cs_img)
showImg('LD', md_img.*cd_img)
showImg('LS', ms_img.*cs_img)
showImg('L', md_img.*cd_img + ms_img.*cs_img)
