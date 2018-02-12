function[sp_img, numRows, numCols, N, idx, color, pixelNumList] = getSuperPixel(img, input)
    [L,N] = superpixels(img, input);
    BW = boundarymask(L);
    idx = label2idx(L);

    sp_img = zeros(size(img),'like',img);
    numRows = size(img,1);
    numCols = size(img,2);
    for labelVal = 1:N
        redIdx = idx{labelVal};
        pixelNumList(labelVal, :) = size(redIdx);
        greenIdx = idx{labelVal}+numRows*numCols;
        blueIdx = idx{labelVal}+2*numRows*numCols;
        color(labelVal, :) = [mean(img(redIdx)), mean(img(greenIdx)), mean(img(blueIdx))];
        sp_img = updateImg(sp_img, color, idx, labelVal, 3);
    end    
end