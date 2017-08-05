clear
direction='C:\Users\pidan\Documents\MATLAB\test\data\pcd_face\';
file_type='.mat';
file_read=dir(fullfile(direction));
Mat(2100,length(file_read)-2)=0;
if strcmp(file_type, '.mat')
    for i=3:length(file_read)
%         direction='C:\Users\pidan\Documents\MATLAB\test\data\obj\';
%         strcat(direction,file_read(i).name)
        load(strcat(direction,file_read(i).name));
        points=A.v_data;
        voxelMargin=0.2;
        A.range(1,:)=[-1,1];
        A.range(2,:)=[-0.3,0.3];
        A.range(3,:)=[-0.5,0.5];  
        voxelSize=(A.range(1,2)-A.range(1,1))/25.00;

%         fprintf('.......................')
        voxelGridTDF = pointCloud2TDF(points,A.range(1,:),A.range(2,:),A.range(3,:),voxelSize,voxelMargin);
%         size(voxelGridTDF)
       size(voxelGridTDF(:))
          Mat(:,i-2)=voxelGridTDF(:);
    end
    
end
[coeff,score,latent,tsquare] = princomp(Mat');