clc, clear, close all

img = getImage('img0.jpg');
imshow(img)
greyDummy = rgb2gray(img);


[L,N] = superpixels(img,10000);
figure
BW = boundarymask(L);
imshow(imoverlay(img,BW,'cyan'))


outputImage = zeros(size(img),'like',img);
idx = label2idx(L);
numRows = size(img,1);
numCols = size(img,2);
for labelVal = 1:N
    redIdx = idx{labelVal};
    greenIdx = idx{labelVal}+numRows*numCols;
    blueIdx = idx{labelVal}+2*numRows*numCols;
    
    r = round(mean(img(redIdx)));
    g = round(mean(img(greenIdx)));
    b = round(mean(img(blueIdx)));
    color(labelVal, :) = [r, g, b];
    outputImage(redIdx) = r;
    outputImage(greenIdx) = g;
    outputImage(blueIdx) = b;
end    
 
figure
% imshow(imoverlay(outputImage,BW,'cyan'))
imshow(outputImage)

color;
% dlmwrite('MyMatrix.txt', color, 'delimiter','\t')

diffused = importdata('diffused.txt');
m = diffused(:,1)/16;
c = diffused(:,2:4)*16;
mc = m.*c;

md = ones(size(greyDummy),'like',greyDummy)*255;
cd = ones(size(img),'like',img)*255;
myoutput = zeros(size(img),'like',img);

for labelVal = 1:N
    redIdx = idx{labelVal};
    greenIdx = idx{labelVal}+numRows*numCols;
    blueIdx = idx{labelVal}+2*numRows*numCols;
    
    temp = mc(labelVal,:);
    md(redIdx) = diffused(labelVal,1);
    
    cd(redIdx) = c(labelVal,1);
    cd(greenIdx) = c(labelVal,2);
    cd(blueIdx) = c(labelVal,3);
    
    myoutput(redIdx) = temp(1);
    myoutput(greenIdx) = temp(2);
    myoutput(blueIdx) = temp(3);
end


figure
imshow(md)

figure
imshow(cd)

figure
imshow(myoutput)












