% Program4
% Statistic analysis
clear
clc
%---------------------------------------------------------
load('...\CM_Atlas5.mat');     %Cosine measures among Atlas images
load('...\DSC5.mat');             %Dice similarity coefficients among Lable images
load('...\testCM.mat')           %Cosine measures among Atlas images and Test images
a=DSC;  
b=CM;   
%-----------Atlas images=5----------------------
Aline=[];Bline=[];
[m,n]=size(a);
%--------------Delete diagonal elements---------
for i=1:m
    Aline=[Aline;a(i,[1:i-1 i+1:n])];   
    Bline=[Bline;b(i,[1:i-1 i+1:n])];   
end
A=zeros(1,20);B=zeros(1,20);
k=1;
for i=1:5
    for j=1:4
            A(k)=Aline(i,j); 
            B(k)=Bline(i,j); 
            k=k+1;
    end
end     
%---------------------------------------------------
line=polyfit(B,A,1);
K=line(1);
s=std(A);           
Sbest=max(B);  
%---------------------------------------------------
for i=1:5        %Test images
    for j=1:5    %Atlas images
        Sl(j,i)=testCM(j,i); 
        w(j,i)=0.5*(1-erf(K/(sqrt(2)*s)*(Sbest-Sl(j,i))));
    end
end
save('...\w_Atlas5','w')



