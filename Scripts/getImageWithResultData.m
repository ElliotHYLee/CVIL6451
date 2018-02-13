function[img, totalData] = getImageWithResultData(name, scale, imgIndex)
    img = imread(name);
    [h, w, c] = size(img);
    img = imresize(img, [h/scale, w/scale]);
    fname = strcat('frzn_mdcdmscs', int2str(imgIndex+1), '.txt');
    totalData = importdata(fname);
end