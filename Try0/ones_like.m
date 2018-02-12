function[result] = ones_like(img)
    result =  ones(size(img),'like',img);
end