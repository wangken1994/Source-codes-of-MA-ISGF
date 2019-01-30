% Program6
% Distance maps fusion
clear
clc
%---------------------------------------------------
load ('...\w_Atlas5.mat') %Weights
W=sum(w);
dismapW=cell(5,5);
for i=1:5   %Test images
    %-----------------Atlas images-------------------
    for j=1:5
        stri=[num2str(i)];
        strj=[num2str(j)];
        filename=['...\' strj '_test' stri '_distance.mat'];
        f2=load(filename,'-mat');
        F2=cell2mat(struct2cell(f2));
        dismapW(j,i)={w(j,i)*F2};
    end
end 
% ----------------cell to double--------------------
for i=1:5       
    stri=[num2str(i)];
    sumdismap=zeros(128,128,64);
    for j = 1:5
        %--------------Distance maps fusion---------
         sumdismap=sumdismap+dismapW{j,i}/W(i); 
    end
    %----------------Fusion results------------------
    filename=['...\test' stri '_fusion.mat'];
    save([filename],'sumdismap');
    %----------------Binarization--------------------
    fusionbinary=zeros(128,128,64);
    for x=1:1:128
        for y=1:1:128
             for z=1:1:64
                if(sumdismap(x,y,z)>0)
                     fusionbinary(x,y,z)=1;
                end
             end
        end
    end
    stri=[num2str(i)];
    filename=['...\test' stri '_fusionbinary.mat'];
    save([filename],'fusionbinary');%Initial segmentation Q
end


