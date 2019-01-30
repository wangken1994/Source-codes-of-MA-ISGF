% Program11
% Error rate
clear
clc
ER=zeros(1,5);
for i=1:5
    %-------------------------------------------------
    stri=[num2str(i)];
    filename1=['...\GF_test' stri '.mat'];%Or test' stri '_fusionbinary.mat
    f1=load(filename1,'-mat');
    fusionbinary=cell2mat(struct2cell(f1));
    %----------manual segmentation---------------
    filename2=['...\test' stri '-fa-label-Genu.nii.gz'];
    R=load_nii(filename2);
    ROI=R.img;
    manual=zeros(128,128,64);
    [x,y,z]=meshgrid(1:128,1:128,1:64);
    for x=1:1:128
        for y=1:1:128
             for z=1:1:64
                 if(ROI(x,y,z)~=0)
                      manual(x,y,z)=1;
                 end
             end
        end
    end
 %---------------------------------------------------
  com=(fusionbinary-(manual&fusionbinary));
  a=sum(com(:));
  com2=(manual | fusionbinary);
  b=sum(com2(:));
  ER(1,i)=a/b;
end
  