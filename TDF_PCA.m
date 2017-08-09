clear 
direction='C:\Users\pidan\Documents\MATLAB\test\data\pcd_face\';
direction='C:\Users\pidan\Documents\MATLAB\test\data\cap\mat_cap\';
file_type='.mat';
file_read=dir(fullfile(direction));
if strcmp(file_type, '.mat')
    for i=3:length(file_read)
        load(strcat(direction,file_read(i).name));
        points=A.v_data;
        voxelMargin=0.02;
        A.range(1,:)=[-1,1];
        A.range(2,:)=[-0.3,0.3];
        A.range(3,:)=[-1,1];  
        A.range(2,:)=[-0.25,0.25];
        A.range(3,:)=[-0.31,0.31];  
%         voxelSize=(A.range(1,2)-A.range(1,1))/50.00;
        %voxelsize is very important
        voxelSize=0.01;
%         fprintf('.......................')
        voxelGridTDF = pointCloud2TDF(points,A.range(1,:),A.range(2,:),A.range(3,:),voxelSize,voxelMargin);
        if i==length(file_read)
            Mat_test=reshape(voxelGridTDF,[size(voxelGridTDF,1)*size(voxelGridTDF,2)*size(voxelGridTDF,3),1]);
        else
            Mat(i-2,:)=voxelGridTDF(:);
        end
        
    end
    
end
%apply the pca
%% 1-pca;2-fastpca
% [mat_mean,aff_mat]=fastPCA(Mat,2);
% Mat_test=aff_mat'*(Mat_test-mat_mean');%low dimmension
% Mat_low=Mat*aff_mat;
% Mat_low=Mat_low';
% mat_test_app=Mat_low*inv(Mat_low'*Mat_low)*Mat_low'*Mat_test;
% norm(mat_test_app-Mat_test)
save voxelGridTDF
% save mat_test_app
% save Mat_test
% save aff_mat
% save mat_mean
% save Mat_low



