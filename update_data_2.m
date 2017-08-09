function update_data_2(ind_row,ind_col,ind_new,ind_new_e)
%ind_col-relate to the largest coordiante of y
%ind_new=number 'th' of the new data you need to add
%1--2;2--3;3--1;
global A;
if ind_col==1
     %the related index of the other vertice of edge
     v_r_1=A.f_data(ind_row,1);
     v_r_2=A.f_data(ind_row,2);
     v_u_3=A.f_data(ind_row,3);
     %the third vertice
     ind_r=3;
     %% add the new vertice
     new_v=0.500*(A.v_data(v_r_1,:)+A.v_data(v_r_2,:));
     A.v_data(ind_new,:)=new_v;
    
    %% add the new triangle
     A.f_data(ind_row,ind_col)=ind_new;
 
     new_triangle=[v_r_1,ind_new,v_u_3];
     A.f_data(ind_new_e,:)=new_triangle;
 
   %% add the new edge_dis
    temp1=A.edge_dis(ind_row,ind_col)/2.0;
    temp2=A.edge_dis(ind_row,ind_r);
     A.edge_dis(ind_row,ind_col)=A.edge_dis(ind_row,ind_col)/2.0;
     A.edge_dis(ind_row,ind_r)=norm(new_v-A.v_data(v_u_3,:));

     new_edge_dis=[temp1,norm(new_v-A.v_data(v_u_3,:)),temp2];
     A.edge_dis(ind_new_e,:)=new_edge_dis;
    
    
elseif ind_col==2
    %the related index of the other vertice of edge
    v_r_1=A.f_data(ind_row,2);
    v_r_2=A.f_data(ind_row,3);
    v_u_3=A.f_data(ind_row,1);
    %the third vertice
    ind_r=1;
    
    %% add the new vertice
     new_v=0.5*(A.v_data(v_r_1,:)+A.v_data(v_r_2,:));
     A.v_data(ind_new,:)=new_v;
             %% add the new triangle
     A.f_data(ind_row,ind_col)=ind_new;

     new_triangle=[v_u_3,v_r_1,ind_new];
     A.f_data(ind_new_e,:)=new_triangle;

     %% add the new edge_dis
    temp1=A.edge_dis(ind_row,ind_col)/2.0;
    temp2=A.edge_dis(ind_row,ind_r); %1-2
     A.edge_dis(ind_row,ind_col)=A.edge_dis(ind_row,ind_col)/2.0;
     A.edge_dis(ind_row,ind_r)=norm(new_v-A.v_data(v_u_3,:));

     new_edge_dis=[temp2,temp1,norm(new_v-A.v_data(v_u_3,:))];
     A.edge_dis(ind_new_e,:)=new_edge_dis;
else
    %the related index of the other vertice of edge
    v_r_1=A.f_data(ind_row,3);
    v_r_2=A.f_data(ind_row,1);
    v_u_3=A.f_data(ind_row,2);
    %the third vertice
    ind_r=2;
    %% add the new vertice
     new_v=0.5*(A.v_data(v_r_1,:)+A.v_data(v_r_2,:));
     A.v_data(ind_new,:)=new_v;
        %% add the new triangle
     A.f_data(ind_row,ind_col)=ind_new;

     new_triangle=[ind_new,v_u_3,v_r_1,];
     A.f_data(ind_new_e,:)=new_triangle;

     %% add the new edge_dis
    temp1=A.edge_dis(ind_row,ind_col)/2.0;
    temp2=A.edge_dis(ind_row,ind_r); %1-2
     A.edge_dis(ind_row,ind_col)=A.edge_dis(ind_row,ind_col)/2.0;
     A.edge_dis(ind_row,ind_r)=norm(new_v-A.v_data(v_u_3,:));

     new_edge_dis=[norm(new_v-A.v_data(v_u_3,:)),temp2,temp1];
     A.edge_dis(ind_new_e,:)=new_edge_dis;
end

end
