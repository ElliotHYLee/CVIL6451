function[img] = concatSP(sp, img, idx)
    numRows = size(img,1);
    numCols = size(img,2);
    channel = size(img,3);
    
    for cellIndex = 1:1:length(sp)
        redIdx = idx{cellIndex};
        greenIdx = idx{cellIndex}+numRows*numCols;
        blueIdx = idx{cellIndex}+2*numRows*numCols;
        eachCell = sp{cellIndex};
        size(img(redIdx))
        size(eachCell(:,1))
        img(redIdx) = eachCell(:,1);
        if channel ==3
            img(greenIdx) = eachCell(:,2);
            img(blueIdx) = eachCell(:,3);
        end
    end
    
end