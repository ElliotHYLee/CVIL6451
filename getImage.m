function[img] = getImage(name)
    img = imread(name);
    [h, w, c] = size(img);
    img = imresize(img, [h/2, w/2]);
end