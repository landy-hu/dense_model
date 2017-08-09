clear all
load voxelGridTDF
% load mat_test_app;
% load aff_mat;
% load mat_mean;
% mat_app=lsqlin(aff_mat',mat_test_app)+mat_mean';
% mat_app=inv(aff_mat*aff_mat')*aff_mat*mat_test_app+mat_mean';
% voxelGrid=reshape(mat_app,[40,12,20])
% % voxelGrid=(voxelGridTDF<0.05);
VoxelGridTDF=(voxelGridTDF<0.015);
v_data=[];
for i=1:size(VoxelGridTDF,3)
    [x,y]=find(VoxelGridTDF(:,:,i)==1);
    new=[x,y,(ones(size(x))*i)];
    v_data=[v_data;new];
end
v_data(:,1)=-1+0.01*v_data(:,1);
v_data(:,2)=-0.3+0.01*v_data(:,2);
v_data(:,3)=-0.5+0.01*v_data(:,3);
ptCloud=pointCloud(v_data);
pcshow(ptCloud)



