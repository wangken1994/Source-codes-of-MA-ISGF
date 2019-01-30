% Program9
% Guide image filtering
clear
clc
for i=1:5
    stri=[num2str(1)];
    filename1=['...\test' stri '-fa.nii.gz'];%Guide image
    load_nii(filename1);                                                          
    guideimage=ans.img;
    filename2=['...\selfsim_test' stri '.mat'];%Suboptimal segmentation
    load(filename2);
    inputimage=P;
    %--------------------------------------------
    r=2;
    eps=0.04^2;
    fp=zeros(128,128,64);
    for i=1:1:64
        I=guideimage(:,:,i);
        p=inputimage(:,:,i);
        fp(:,:,i)=Guided_Image_Filter(I, p, r, eps);
    end
    OptimalGF=zeros(128,128,64);
    for x=1:1:128
            for y=1:1:128
                for z=1:1:64
                    if(fp(x,y,z)>=0.5)
                       OptimalGF(x,y,z)=1;
                    else
                        OptimalGF(x,y,z)=0;
                    end
                end
            end
     end
     filename3=['...\GF_test' stri '.mat'];
     save(filename3,'OptimalGF')%Optimal segmentation
end
