% pool=startmatlabpool(4);
clear all
% function result=batch_read__save_file(direction,file_type)
profile on;
direction_file='C:\Users\pidan\Documents\MATLAB\test\data\cap\02954340_cap\';
direction_save_obj='C:\Users\pidan\Documents\MATLAB\test\data\cap\obj_cap\';
direction_save_mat='C:\Users\pidan\Documents\MATLAB\test\data\cap\mat_cap\';
file_type='.obj';
file_read=dir(fullfile(direction_file));

global A;

if strcmp(file_type, '.obj')
    for i=3:length(file_read)
        v_data=[];
        f_data=[];
%         f_inter_data=[];

        fidin=fopen(strcat(direction_file,file_read(i).name));
        if (~fidin)
            disp('Can not open the file, Please check the input and the PATH !!');
        end
        
        ind_v=0;
        ind_f=0;
        while ~feof(fidin)% 判断是否为文件末尾
             tline=fgetl(fidin); % 从文件读行
             %% reading the vertices and faces
             if (strcmp(tline(1),'v')==1)
                 ind_v=ind_v+1;
                 v_data(ind_v,:)= str2num(tline(3:end));
             else
                 ind_f=ind_f+1;
                 tline=strrep(tline,'/',' ');
                 tline=str2num(tline(2:end));
                 
                 if size(tline,2)==9
                     num=[tline(1),tline(4),tline(7)];
                 elseif size(tline,2)==6
                     num=[tline(1),tline(3),tline(5)];
                 else
                     num=tline;
                 end
                 f_data(ind_f,:)= num;
             end
        end
        fclose(fidin);  
        %% 9 datas
%         f_data=[f_inter_data(:,1),f_inter_data(:,4),f_inter_data(:,7)];
        %% 6 datas
        
%           f_data=[f_inter_data(:,1),f_inter_data(:,3),f_inter_data(:,5)];

        %% to normalize the point cloud
        point_dis=zeros(size(v_data));     
        for j=1:size(v_data,1)
             point_dis(j,1)=norm(v_data(j,:));
             point_dis(j,2)=norm(v_data(j,:));
             point_dis(j,3)=norm(v_data(j,:));
        end
        val_normalization=max(max(point_dis));
         v_data=v_data/val_normalization;
         
         X_range=[(min(v_data(:,1))),(max(v_data(:,1)))]
         Y_range=[(min(v_data(:,2))),(max(v_data(:,2)))]
         Z_range=[(min(v_data(:,3))),(max(v_data(:,3)))]
         size(v_data)
         size(f_data)
        %% calculate the edge distance
        edge_dis=zeros(size(f_data));
        for j=1:size(f_data,1)
             edge_dis(j,1)=norm(v_data(f_data(j,1),:)-v_data(f_data(j,2),:));
             edge_dis(j,2)=norm(v_data(f_data(j,2),:)-v_data(f_data(j,3),:));
             edge_dis(j,3)=norm(v_data(f_data(j,3),:)-v_data(f_data(j,1),:));
        end
        %% the global variable
        A.edge_dis=edge_dis;
        A.f_data=f_data;
        A.v_data=v_data;
        A.range=[X_range;Y_range;Z_range];
%         lar_dis=max(max(A.edge_dis))
%         sma_dis=min(min(A.edge_dis))
        voxelsize=(A.range(1,2)-A.range(1,1))/50.00;
        split_triangle(voxelsize);
        %%orientation
%         Centroid(1,3)=0;
%         ver_size=size(A.v_data,1);
%         Centroid(1)=sum(A.v_data(:,1))/ver_size;
%         Centroid(2)=sum(A.v_data(:,2))/ver_size;
%         Centroid(3)=sum(A.v_data(:,3))/ver_size;
% %         A.v_data=bsxfun(@minus,A.v_data,Centroid);
%         convariance_matrix=cov(A.v_data);
%         [V,E]=eig(convariance_matrix);
%         T(4,4)=0;
%         T(1:3,1)=V(:,3);
%         T(1:3,2)=V(:,2);
%         T(1:3,3)=V(:,1);
%         T(4,4)=1;
%         point_cloud=pointCloud(A.v_data);
%         A.v_data=pctransform(pointCloud(A.v_data),affine3d(T));
%         A.v_data=A.v_data.Location;
        
        
%        lar_dis_a=max(max(A.edge_dis));
%        sma_dis_a=min(min(A.edge_dis));
%         size(A.f_data)
       %% the direction of the saving .pcd and .mat
          save_dir_obj=strcat(direction_save_obj,file_read(i).name)       
          obj_write(save_dir_obj,A.v_data,A.f_data);
        % the dir of mat
          file_name_save_mat=strcat(strrep(file_read(i).name,'.obj',[]),'.mat');
          save_dir_mat=strcat(direction_save_mat,file_name_save_mat)
          save(save_dir_mat,'A');

    end % for i=1:length(file_read)
end

 profile viewer