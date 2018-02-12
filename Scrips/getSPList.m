function[spList] = getSPList(img, idx, N)
    for labelVal = 1:N
       spList{labelVal} = getCellAt(labelVal, img, idx);
    end    
end

function[pixList] = getCellAt(cellIndex, img, idx)
    numRows = size(img,1);
    numCols = size(img,2);
    channel = size(img,3);
    if channel ==3
        redIdx = idx{cellIndex};
        greenIdx = idx{cellIndex}+numRows*numCols;
        blueIdx = idx{cellIndex}+2*numRows*numCols;
        r = img(redIdx);
        g = img(greenIdx);
        b = img(blueIdx);
        pixList = [r, g, b];
    else
        redIdx = idx{cellIndex};
        pixList = img(redIdx);
    end
end