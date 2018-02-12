function[img] = getImage(name)
    img = imread(name);
    [h, w, c] = size(img);
    img = imresize(img, [h/10, w/10]);
end