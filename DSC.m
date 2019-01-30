% Program2
% Dice similarity coefficient
clear
clc
%---------------------------------------------------
DSC=zeros(5,5);
for i=1:5
    for j=1:5
        if i==j
            DSC(i,j)=1;
        else
            stri=num2str(i);
            strj=num2str(j);
            filename=['...\' stri 'to' strj '-syn-Genu.nii.gz'];%Deformed label
            t=load_nii(filename);
            ROI=t.img;
            label1=zeros(128,128,64);
            [x,y,z]=meshgrid(1:128,1:128,1:64);
            for x=1:1:128
                for y=1:1:128
                    for z=1:1:64
                        if(ROI(x,y,z)~=0)
                           label1(x,y,z)=1;
                        end
                    end
                end
            end
            filename=['...\' strj '-fa-label-Genu.nii.gz'];
            t1=load_nii(filename);
            ROI1=t1.img;
            label=zeros(128,128,64);
            [x,y,z]=meshgrid(1:128,1:128,1:64);
            for x=1:1:128
                for y=1:1:128
                    for z=1:1:64
                        if(ROI1(x,y,z)~=0)
                           label(x,y,z)=1;
                        end
                    end
                end
            end
            common=(label&label1);
            a=sum(common(:));
            b=sum(label1(:));
            c=sum(label(:));
            DSC_ratio=2*a/(b+c);
            DSC(i,j)=DSC_ratio;
        end
    end
end
save('...\DSC5','DSC')



