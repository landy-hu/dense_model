
% pool=startmatlabpool(4);
% clear all
% function result=batch_read__save_file(direction,file_type)
clear all
clc
profile on;
direction='C:\Users\pidan\Documents\MATLAB\test\data\obj\';
file_type='.pcd';
file_read=dir(fullfile(direction));
% file_read.name
global A;
% num=15000000;
% A.f_data=zeros(num,3);
% A.v_data=zeros(num,3);
% A.edge_dis=zeros(num,3);

% read_data=cell((length(file_read)),1);
%%%%fortest
if strcmp(file_type, '.pcd')
    for i=3:length(file_read)
        direction='C:\Users\pidan\Documents\MATLAB\test\data\obj\';
%         strcat(direction,file_read(i).name)
        fidin=fopen(strcat(direction,file_read(i).name));
%         if (fidin==NULL)
%             disp('Can not open the file, Please check the input and the PATH !!');
%         end
        
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
                 f_inter_data(ind_f,:)= str2num(tline(3:end));
             end
        end
        fclose(fidin);
        
        f_data=[f_inter_data(:,1),f_inter_data(:,4),f_inter_data(:,7)];
%         size(f_data);

        m=size(f_data,1);
        edge_dis=zeros(size(f_data));
%         edeg_dis(1:m,1)=norm(v_data(f_data(1:m,1),:)-v_data(f_data(1:m,2),:));
%         edeg_dis(1:m,2)=norm(v_data(f_data(1:m,2),:)-v_data(f_data(1:m,3),:));
%         edeg_dis(1:m,3)=norm(v_data(f_data(1:m,3),:)-v_data(f_data(1:m,1),:));
        
        for j=1:size(f_data,1)
             edge_dis(j,1)=norm(v_data(f_data(j,1),:)-v_data(f_data(j,2),:));
             edge_dis(j,2)=norm(v_data(f_data(j,2),:)-v_data(f_data(j,3),:));
             edge_dis(j,3)=norm(v_data(f_data(j,3),:)-v_data(f_data(j,1),:));
        end
        val_normalization=max(max(edge_dis))
        v_data=v_data/val_normalization;
        for j=1:size(f_data,1)
             edge_dis(j,1)=norm(v_data(f_data(j,1),:)-v_data(f_data(j,2),:));
             edge_dis(j,2)=norm(v_data(f_data(j,2),:)-v_data(f_data(j,3),:));
             edge_dis(j,3)=norm(v_data(f_data(j,3),:)-v_data(f_data(j,1),:));
         end
        
        
%         edeg_dis(:,1)=norm(v_data(f_data(1:m,1),:)-v_data(f_data(1:m,2),:));
%         edeg_dis(:,2)=norm(v_data(f_data(1:m,2),:)-v_data(f_data(1:m,3),:));
%         edeg_dis(:,3)=norm(v_data(f_data(1:m,3),:)-v_data(f_data(1:m,1),:));
        
        A.edge_dis=edge_dis;
        A.f_data=f_data;
        A.v_data=v_data;
        %A.range=[X_range;Y_range;Z_range];
        split_triangle(0.005);
        
       lar_dis_a=max(max(A.edge_dis));
       sma_dis_a=min(min(A.edge_dis));
%         size(A.f_data)
        %%  the direction of the saving .pcd and .mat
        %delete .pcd
        file_read(i).name(end-3:end)=[];
        direction(end-3:end)=[];
        %the dir of new_pcd
        file_name_save_obj=strcat(strrep(file_read(i).name,'.pcd',[]),'.obj');
        save_dir_obj=strcat(strcat(direction,'new_obj_2\'),file_name_save_obj);
        obj_write(save_dir_obj,A.v_data,A.f_data);
        % the dir of mat
        file_name_save_mat=strcat(strrep(file_read(i).name,'.pcd',[]),'.mat');
        save_dir_mat=strcat(strcat(direction,'pcd_face\'),file_name_save_mat);
        save(save_dir_mat,'A');
        
%         PtCloud=pcread(file_name{i})
%         Cloud_mat=zeros(PtCloud.Count,3);
%         % class(Cloud_mat)
%         Cloud_mat=PtCloud.Location;
%         read_data{i}=Cloud_mat;
    end % for i=1:length(file_read)
end

 profile viewer