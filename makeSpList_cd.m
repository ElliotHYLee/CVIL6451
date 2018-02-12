function[result] = makeSpList_cd(matrix, cd)
    [r,c] = size(matrix);
    result = ones(r,c);
    result(:,1) = cd(1);
    result(:,2) = cd(2);
    result(:,3) = cd(3);
end