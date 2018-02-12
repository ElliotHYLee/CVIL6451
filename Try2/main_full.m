clc, clear, close all
imgIndex = 0  % available imgIndex = 0, 1, 2
superPixelNum = 10000
%% Read an image
if imgIndex == 0
    img = getImage('img0.jpg', 5);
elseif imgIndex == 1
    img = getImage('img1.jpg', 2);
elseif imgIndex == 2
    img = getImage('img2.jpg', 4);
end

img = im2double(img);

gray = rgb2gray(img);

%% super pixel image
[sp_img, numRows, numCols, N, idx, meanColor, pixelNumList] = getSuperPixel(img, superPixelNum);

% imshow(imoverlay(cd_img,BW,'cyan'))

disp('Generating data for Keras/Tensorflow Optimizer...')
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
dlmwrite('data/CD_lstm/cd_init.txt', meanColor, 'delimiter',' ')
dlmwrite('data/CD_lstm/cd_info.txt', [min, N], 'delimiter',' ')

%% FC data gen -- mS & mD (Gray pretrain)
imgArray = reshape(img, [numRows*numCols, 3]);
grayArray = reshape(gray, [numRows*numCols, 1]);
dlmwrite('data/M_fc/color.txt', imgArray, 'delimiter',' ')
dlmwrite('data/M_fc/gray.txt', grayArray, 'delimiter',' ')

%% Moving to Python Keras/Tensorflow
cd python
cmd = char(strcat('python NN_dicho.py', {' '}, int2str(imgIndex)))
out = system(cmd);
cd ..

%% Read results from Keras/Tensorflow Optimizer
totalData = importdata('mdcdmscs.txt');
pixelNumList = pixelNumList(:,1);
md_img = zeros_like(gray);
cd_img = zeros_like(img);
ms_img = zeros_like(gray);
cs_img  = zeros_like(img);

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


showImg('Observed', img)
showImg('SuperPixel', sp_img)
showImg('mD', md_img);
showImg('cD', cd_img);
showImg('mS', ms_img)
showImg('cS', cs_img)
showImg('LD', md_img.*cd_img)
showImg('LS', ms_img.*cs_img)
showImg('L', md_img.*cd_img + ms_img.*cs_img)

disp('end of program')




