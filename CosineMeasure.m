% Program1
% Cosine measure
clear
clc
CM=zeros(5,5);
%----------------------------------------------------
for i=1:5
    %-------------------------------------------------
    for j=1:5
        if i==j
            CM(i,j)=1;
        else
            stri=[num2str(i)];
            strj=[num2str(j)];
            filename1=['...\' stri 'to' strj '-syn-fa.nii.gz'];
            a=load_nii(filename1);
            filename2=['...\' strj '-fa.nii.gz'];
            b=load_nii(filename2);
            F=a.img;
            M=b.img;
            A=sum(sum(sum((F).*(M))));
            B=sqrt((sum(sum(sum((F).^2))))*(sum(sum(sum((M).^2)))));
            Cm=A/B;
            CM(i,j)=Cm;
        end
    end
end  
save('...\CM_Atlas5','CM')