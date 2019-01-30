% Program8
% Self-similarity optimization
clear
clc
selfsimDSC=zeros(1,5);
for i=1:5
    stri=[num2str(i)];
    filename=['...\test' stri '-fa.nii.gz'];  %Test image
    load_nii(filename);
    I=ans.img;
    S=zeros(128,128,64);
    filename2=['...\test' stri '_fusion.mat'];%MA-IS result
    load (filename2,'-mat') 
    filename3=['...\mark_test' stri '.mat'];%Boundary coordinates of ROI
    load (filename3,'-mat')    
    filename4=['...\Rmin_test' stri '.mat'];%Half minimum in x y z direction
    load (filename4,'-mat')   
    % ------------------------------------------------
    Slice=[];
    xmin=[];
    ymin=[];
    xmax=[];
    ymax=[];
    for z=1:1:64
         if ~isempty(mark{1,z})
             Slice=[Slice;z];        
             Mark=mark{1,z};
             xmin=[xmin;min(Mark(:,1))];  
             xmax=[xmax;max(Mark(:,1))];
             ymin=[ymin;min(Mark(:,2))];  
             ymax=[ymax;max(Mark(:,2))];
         end
    end
    xmin=min(xmin);   
    xmax=max(xmax);
    ymin=min(ymin);
    ymax=max(ymax); 
    zmin=Slice(1);       
    zmax=Slice(end);   
    Rmin=ceil(Rmin); 
    v1=zeros(Rmin);
    S1=zeros(Rmin);
    P1=zeros(Rmin);
    P=zeros(128,128,64);
    for z=zmin:1:zmax 
        for x=(xmin-Rmin):1:(xmax+Rmin)
            for y=(ymin-Rmin):1:(ymax+Rmin)
                  P(x,y,z)=0;
                  for i=1:1:Rmin
                      D1=[I(x-1,y-1,z)-I(x-1,y+i-1,z),I(x-1,y,z)-I(x-1,y+i,z),I(x-1,y+1,z)-I(x-1,y+i+1,z),I(x,y-1,z)-I(x,y+i-1,z),I(x,y+1,z)-I(x,y+i+1,z),...
                          I(x+1,y-1,z)-I(x+1,y+i-1,z),I(x+1,y,z)-I(x+1,y+i,z),I(x+1,y+1,z)-I(x+1,y+i+1,z)];%Gray value differences
                      Dp1(i)=sum(D1.^2);         
                      v1(i)=std(D1);                   
                      S1(i)=exp(-Dp1(i)/v1(i));    %Self-similarity to weight
                      P1(i)=S1(i)*sumdismap(x,y+i,z);%Self-similarity weighting

                      D2=[I(x-1,y-1,z)-I(x-1-i,y-1+i,z),I(x-1,y,z)-I(x-i-1,y+i,z),I(x-1,y+1,z)-I(x-i-1,y+i+1,z),I(x,y-1,z)-I(x-i,y+i-1,z),I(x,y+1,z)-I(x-i,y+i+1,z),...
                          I(x+1,y-1,z)-I(x-i+1,y+i-1,z),I(x+1,y,z)-I(x-i+1,y+i,z),I(x+1,y+1,z)-I(x-i+1,y+i+1,z)]; 
                      Dp2(i)=sum(D2.^2);
                      v2(i)=std(D2);
                      S2(i)=exp(-Dp2(i)/v2(i));
                      P2(i)=S2(i)*sumdismap(x-i,y+i,z);

                      D3=[I(x-1,y-1,z)-I(x-i-1,y-1,z),I(x-1,y,z)-I(x-i-1,y,z),I(x-1,y+1,z)-I(x-i-1,y+1,z),I(x,y-1,z)-I(x-i,y-1,z),I(x,y+1,z)-I(x-i,y+1,z),...
                          I(x+1,y-1,z)-I(x-i+1,y-1,z),I(x+1,y,z)-I(x-i+1,y,z),I(x+1,y+1,z)-I(x-i+1,y+1,z)];
                      Dp3(i)=sum(D3.^2);
                      v3(i)=std(D3);
                      S3(i)=exp(-Dp3(i)/v3(i));
                      P3(i)=S3(i)*sumdismap(x-i,y,z);

                      D4=[I(x-1,y-1,z)-I(x-1-i,y-1-i,z),I(x-1,y,z)-I(x-i-1,y-i,z),I(x-1,y+1,z)-I(x-i-1,y-i+1,z),I(x,y-1,z)-I(x-i,y-i-1,z),I(x,y+1,z)-I(x-i,y-i+1,z),...
                          I(x+1,y-1,z)-I(x-i+1,y-i-1,z),I(x+1,y,z)-I(x-i+1,y-i,z),I(x+1,y+1,z)-I(x-i+1,y-i+1,z)];
                      Dp4(i)=sum(D4.^2);
                      v4(i)=std(D4);
                      S4(i)=exp(-Dp4(i)/v4(i));
                      P4(i)=S4(i)*sumdismap(x-i,y-i,z);

                      D5=[I(x-1,y-1,z)-I(x-1,y-i-1,z),I(x-1,y,z)-I(x-1,y-i,z),I(x-1,y+1,z)-I(x-1,y-i+1,z),I(x,y-1,z)-I(x,y-i-1,z),I(x,y+1,z)-I(x,y-i+1,z),...
                          I(x+1,y-1,z)-I(x+1,y-i-1,z),I(x+1,y,z)-I(x+1,y-i,z),I(x+1,y+1,z)-I(x+1,y-i+1,z)];
                      Dp5(i)=sum(D5.^2);
                      v5(i)=std(D5);
                      S5(i)=exp(-Dp5(i)/v5(i));
                      P5(i)=S5(i)*sumdismap(x,y-i,z);

                      D6=[I(x-1,y-1,z)-I(x-1+i,y-1-i,z),I(x-1,y,z)-I(x+i-1,y-i,z),I(x-1,y+1,z)-I(x+i-1,y-i+1,z),I(x,y-1,z)-I(x+i,y-i-1,z),I(x,y+1,z)-I(x+i,y-i+1,z),...
                          I(x+1,y-1,z)-I(x+i+1,y-i-1,z),I(x+1,y,z)-I(x+i+1,y-i,z),I(x+1,y+1,z)-I(x+i+1,y-i+1,z)];
                      Dp6(i)=sum(D6.^2);
                      v6(i)=std(D6);
                      S6(i)=exp(-Dp6(i)/v6(i));
                      P6(i)=S6(i)*sumdismap(x+i,y-i,z);

                      D7=[I(x-1,y-1,z)-I(x+i-1,y-1,z),I(x-1,y,z)-I(x+i-1,y,z),I(x-1,y+1,z)-I(x+i-1,y+1,z),I(x,y-1,z)-I(x+i,y-1,z),I(x,y+1,z)-I(x+i,y+1,z),...
                          I(x+1,y-1,z)-I(x+i+1,y-1,z),I(x+1,y,z)-I(x+i+1,y,z),I(x+1,y+1,z)-I(x+i+1,y+1,z)];
                      Dp7(i)=sum(D7.^2); 
                      v7(i)=std(D7);
                      S7(i)=exp(-Dp7(i)/v7(i));
                      P7(i)=S7(i)*sumdismap(x+i,y,z);

                      D8=[I(x-1,y-1,z)-I(x-1+i,y-1+i,z),I(x-1,y,z)-I(x+i-1,y+i,z),I(x-1,y+1,z)-I(x+i-1,y+i+1,z),I(x,y-1,z)-I(x+i,y+i-1,z),I(x,y+1,z)-I(x+i,y+i+1,z),...
                          I(x+1,y-1,z)-I(x+i+1,y+i-1,z),I(x+1,y,z)-I(x+i+1,y+i,z),I(x+1,y+1,z)-I(x+i+1,y+i+1,z)];
                      Dp8(i)=sum(D8.^2);
                      v8(i)=std(D8);
                      S8(i)=exp(-Dp8(i)/v8(i));
                      P8(i)=S8(i)*sumdismap(x+i,y+i,z);

                      P(x,y,z)=P1(i)+ P2(i)+ P3(i)+ P4(i)+ P5(i)+ P6(i)+ P7(i)+ P8(i)+P(x,y,z);
                  end
                  P(x,y,z)=P(x,y,z)/(sum(Dp1)+sum(Dp2)+sum(Dp3)+sum(Dp4)+sum(Dp5)+sum(Dp6)+sum(Dp7)+sum(Dp8));
            end
        end
    end
    for x=1:1:128
        for y=1:1:128
             for z=1:1:64
                if(P(x,y,z)>0)
                    P(x,y,z)=1;
                else
                    P(x,y,z)=0; 
                end
             end
        end
    end
    filename5=['...\selfsim_test' stri '.mat'];%Suboptimal segmentation T
    save([filename5],'P')
end
