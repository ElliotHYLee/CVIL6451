clc, clear, close all

img = getImage('img0.jpg');
imshow(img)

[L,N] = superpixels(img,100);

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
    outputImage(redIdx) = mean(img(redIdx));
    outputImage(greenIdx) = mean(img(greenIdx));
    outputImage(blueIdx) = mean(img(blueIdx));
end    
 
figure
% imshow(outputImage)
imshow(imoverlay(outputImage,BW,'cyan'))
