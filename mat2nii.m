%Program12
%Mat to NII
clear
clc
load('...\test' stri '_fusionbinary.mat.mat');%Or GF_test' stri '.mat
img=label;
adnii=make_nii(img);
save_nii(adnii,'...\test' stri '_fusionbinary.nii.gz');%Or GF_test' stri '.nii.gz