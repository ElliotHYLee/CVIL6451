function[img] = getImage(name)
    img = imread(name);
    [h, w, c] = size(img);
    img = imresize(img, [h/5, w/5]);
end