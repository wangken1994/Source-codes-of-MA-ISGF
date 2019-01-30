% Program7
% Calculating the parameters of manual segmentation
clear
clc
for i=1:5
    stri=[num2str(i)];
    filename=['...\test' stri '_fusionbinary.mat'];
    load(filename,'-mat');
    boundary=zeros(128,128,64);
    %-------------Boundary coordinates of ROI---------------
    mark=cell(1,64);
    for z=1:1:64
        boundary(:,:,z)=edge(fusionbinary(:,:,z));
        for x=1:1:128                                  
              for y=1:1:128
                  if boundary(x,y,z)==1
                      M=[x,y,z];
                      mark{1,z}=[mark{1,z};M];                  
                  end
              end
        end
    end
    filename1=['...\mark_test' stri '.mat'];
    save ([filename1],'mark')
    R=zeros(1,64);
    Slice=[];
    for z=1:1:64
         if ~isempty(mark{1,z})   
             Slice=[Slice,z];         
             Mark=mark{1,z};
             xmin=min(Mark(:,1));  
             xmax=max(Mark(:,1));
             ymin=min(Mark(:,2));
             ymax=max(Mark(:,2)); 
             r=[(xmax-xmin),(ymax-ymin)];
             R(z)=0.5*min(r);
         end
    end
    zmin=Slice(1);      
    zmax=Slice(end); 
    R(65)=0.5*(zmax-zmin);
    D=[];
    for i=1:1:65
        if R(i)~=0
          D=[D,R(i)];
        end
    end
    Rmin=min(D);
    filename2=['...\Rmin_test' stri '.mat'];
    save ([filename2],'Rmin')
end