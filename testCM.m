% Program3
% Cosine measure among Atlas images and Test images
clear
clc
testCM=zeros(5,5);
%----------------------------------------------------
for i=1:5
    %-------------------------------------------------
    for j=1:5
            stri=[num2str(i)];
            strj=[num2str(j)];
            filename1=['...\' stri '-test' strj '-fa.nii.gz'];
            a=load_nii(filename1);
            filename2=['...\test' strj '-fa.nii.gz'];
            b=load_nii(filename2);
            F=a.img;
            M=b.img;
            A=sum(sum(sum((F).*(M))));
            B=sqrt((sum(sum(sum((F).^2))))*(sum(sum(sum((M).^2)))));
            Cm=A/B;
            testCM(i,j)=Cm;
        end
    end
end  
save('...\testCM','testCM')