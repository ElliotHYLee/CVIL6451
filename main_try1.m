clc, clear, close all

%% Read an image
obs_img = getImage('img0.jpg');
obs_img = im2double(obs_img);
figure
imshow(obs_img)
gray = rgb2gray(obs_img);


%% super pixel image
[L,N] = superpixels(obs_img, 2);
BW = boundarymask(L);
idx = label2idx(L);

%% Prep Img Matrix
md_img = ones_like(gray)*rand();
cd_img = ones_like(obs_img)*rand();
ms_img = ones_like(gray)*rand();
cs_img = ones_like(obs_img)*rand();

spList_obs = getSPList(obs_img, idx, N);
spList_cd  = getSPList(cd_img, idx, N);
spList_md =  getSPList(md_img, idx, N);
spList_cs =  getSPList(cs_img, idx, N);
spList_ms =  getSPList(ms_img, idx, N);

%% Optimize
cs_val = [1,1,1];

for i=1:1:50
    [spList_cd_next, spList_md_next, cs_val_next, spList_ms_next] = myFit(spList_obs, spList_cd, spList_md, cs_val, spList_ms, N );
    spList_cd = spList_cd_next;
    spList_md = spList_md_next;
    cs_val = cs_val_next
    spList_ms = spList_ms_next;
    disp('------------------')
end

cd_img = concatSP(spList_cd, cd_img, idx);
imshow(cd_img)
cd_img(:,:,1)


