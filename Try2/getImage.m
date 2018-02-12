function[img] = getImage(name)
    img = imread(name);
    [h, w, c] = size(img);
    img = imresize(img, [h/4, w/4]);
end