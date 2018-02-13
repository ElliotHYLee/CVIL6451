function[img] = getImage(name, scale)
    img = imread(name);
    [h, w, c] = size(img);
    img = imresize(img, [h/scale, w/scale]);
end