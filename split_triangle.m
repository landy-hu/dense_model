function split_triangle(voxel_size)
 global A;
 while 1%(size(A.v_data,1)<num)&&(size(A.f_data,1)<num)&&(size(A.edge_dis,1)<num)
%% find the illegal edge

     [M,I]= max(A.edge_dis,[],2);
     lar_edge_x=find(M>=voxel_size);
     lar_edge_y=zeros(size(lar_edge_x,1),1);
     for j=1:size(lar_edge_x)
         lar_edge_y(j)=I(lar_edge_x(j));
     end
      %lar_edge_y;
%% split the triangle

     for j=1:size(lar_edge_x)
         % the index of the new vertice
         ind_new=size(A.v_data,1)+1;
         ind_new_e=size(A.edge_dis,1)+1;
         % update the data
         update_data_2(lar_edge_x(j),lar_edge_y(j),ind_new,ind_new_e);
     end
%% break the loop
     lar_dis_a=max(max(A.edge_dis));
%      sma_dis_a=min(min(A.edge_dis));
     if lar_dis_a<=voxel_size%||size(A.edge_dis,1)>300000
         break
     end
 end
 