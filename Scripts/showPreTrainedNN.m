clc, clear, close all



% gArr = importdata('data/M_fc/predGray.txt');
% recovImg = reshape(gArr, [numRows, numCols, 1]);
% figure
% imshow(recovImg)

% cd_img_rec = zeros(size(img),'like',img);
% recColor = importdata('data/CD_lstm/cd_pred.txt');
% for labelVal = 1:N
%     redIdx = idx{labelVal};
%     greenIdx = idx{labelVal}+numRows*numCols;
%     blueIdx = idx{labelVal}+2*numRows*numCols;
%     color(labelVal, :) = [mean(img(redIdx)), mean(img(greenIdx)), mean(img(blueIdx))];
%     cd_img_rec = updateImg(cd_img_rec, recColor, idx, labelVal, 3);
% end   

% figure
% imshow(cd_img_rec)