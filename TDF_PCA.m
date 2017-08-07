clear 
direction='C:\Users\pidan\Documents\MATLAB\test\data\pcd_face\';
file_type='.mat';
file_read=dir(fullfile(direction));
if strcmp(file_type, '.mat')
    for i=3:length(file_read)
        load(strcat(direction,file_read(i).name));
        points=A.v_data;
        voxelMargin=0.2;
        A.range(1,:)=[-1,1];
        A.range(2,:)=[-0.3,0.3];
        A.range(3,:)=[-0.5,0.5];  
%         voxelSize=(A.range(1,2)-A.range(1,1))/50.00;
        voxelSize=0.1;
%         fprintf('.......................')
        voxelGridTDF = pointCloud2TDF(points,A.range(1,:),A.range(2,:),A.range(3,:),voxelSize,voxelMargin);
        if i==length(file_read)
            Mat_test=voxelGridTDF(:);
        else
            Mat(i-2,:)=voxelGridTDF(:);
        end
        
    end
    
end
%apply the pca
[mat_mean,aff_mat]=fastPCA(Mat);
Mat_test=aff_mat'*(Mat_test-mat_mean');
Mat_low=Mat*aff_mat;
mat_test_app=Mat_low'*inv(Mat_low*Mat_low')*Mat_low*Mat_test;
norm(mat_test_app-Mat_test)
