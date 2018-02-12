function[img] = updateImg(img, pixelVal, idx, labelVal, channel)
    numRows = size(img,1);
    numCols = size(img,2);
    redIdx = idx{labelVal};
    greenIdx = idx{labelVal}+numRows*numCols;
    blueIdx = idx{labelVal}+2*numRows*numCols;

    if channel ==3
        img(redIdx) = pixelVal(labelVal,1);
        img(greenIdx) = pixelVal(labelVal,2);
        img(blueIdx) = pixelVal(labelVal,3);
    elseif channel == 1
        img(redIdx) = pixelVal(labelVal,1);
    elseif channel == 4
        img(redIdx) = pixelVal(1);
        img(greenIdx) = pixelVal(2);
        img(blueIdx) = pixelVal(2);
    else 
        dispy('check image channel.')
    end
end