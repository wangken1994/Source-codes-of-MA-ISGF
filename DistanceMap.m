% Program5
% Calculating Distance maps
clc
clear
%---------------------------------------------------
for i=1:5
    for j=1:5
        stri=[num2str(i)];
        strj=[num2str(j)];
        filename=['...\' stri '-test' strj '-Genu.nii.gz'];% Deformed label image
        load_nii(filename);
        ROI=ans.img;
        label=zeros(128,128,64);
        label1=zeros(128,128,64);
        [x,y,z]=meshgrid(1:128,1:128,1:64);
        % ---------------Binarization-----------------
         for x=1:1:128
            for y=1:1:128
                 for z=1:1:64
                    if(ROI(x,y,z)~=0)
                       label(x,y,z)=1;
                    end
                 end
            end
         end
        % ------------Boundary coordinates--------
         mark=cell(1,64);
         for z=1:1:64
               label1(:,:,z)=edge(label(:,:,z));
              for x=1:1:128                       
                  for y=1:1:128
                      if label1(x,y,z)==1
                          M=[x,y,z];
                          mark{1,z}=[mark{1,z};M];                     
                      end
                  end
              end
         end
         % ------------Distance maps calculation----------
         R=zeros(1,64);
         for z=1:1:64
             if ~isempty(mark{1,z})
                 Mark=mark{1,z};
                 xmin=min(Mark(:,1));
                 xmax=max(Mark(:,1));
                 ymin=min(Mark(:,2));
                 ymax=max(Mark(:,2));
                 r=[(xmax-xmin),(ymax-ymin)];
                 R(z)=0.5*min(r);
                 M=[M;Mark];
                 for x=1:1:128
                     for y=1:1:128
                             m=[x,y,z];  
                      if label(x,y,z)==0
                             minValue=matchest(M,m);
                             label(x,y,z)=-minValue;
                      else
                             minValue=matchest(M,m);
                             label(x,y,z)=minValue;
                      end
                  end
               end
             end
         end
         filename=['...\' stri '_test' strj '_distance.mat'];
         save([filename],'label');
    end
end