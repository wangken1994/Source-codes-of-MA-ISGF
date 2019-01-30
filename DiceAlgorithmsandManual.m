%Program10
%Calculating DSC
clear
clc
%---------------------------------------------------
DSC=zeros(1,5);
for i=1:5
    stri=[num2str(i)];
    filename1=['...\GF_test' stri '.mat'];%Or test' stri '_fusionbinary.mat
    f1=load(filename1,'-mat');
    roi1=cell2mat(struct2cell(f1));
    %-------------------Manual segmentation--------------
    filename2=['...\test' stri '-fa-label-Genu.nii.gz'];
    R2=load_nii(filename2);
    ROI2=R2.img;
    roi2=zeros(128,128,64);
    [x,y,z]=meshgrid(1:128,1:128,1:64);
    for x=1:1:128
        for y=1:1:128
             for z=1:1:64
                 if(ROI2(x,y,z)~=0)
                      roi2(x,y,z)=1;
                 end
             end
        end
    end
%----------------------------------------------------
    and=(roi1&roi2);
    a=sum(and(:));
    b=sum(roi1(:));
    c=sum(roi2(:));
    DSC(1,i)=2*a/(b+c);
end
