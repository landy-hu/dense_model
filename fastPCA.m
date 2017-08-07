function [mat_mean,aff_mat]=fastPCA(Mat)
% mat number of rows is the number of the samples, number of the column is
% the number of the feature dimmension.
% mat_mean is the mean of the feature.
% aff_mat is the affine matrix
% convariance matrix
 mat_mean=mean(Mat);
 Mat_off_mean=bsxfun(@minus,Mat,mat_mean);
% [V,B]=eig(Mat_off_mean'*Mat_off_mean);
% B
 Cov_matrix=Mat_off_mean'*Mat_off_mean;
 [aff_mat,E]=eig(Cov_matrix);
% aff_mat=Mat_off_mean'*aff_mat;
% select the eigenvector
 eigenval=sort(diag(E),'descend');

 SelectNum = cumsum(eigenval)./sum(eigenval);
 index = find(SelectNum >= 0.99);
% aff_mat=aff_mat(:,size(eigenval,1)-index(1)+1:end);
aff_mat=aff_mat(:,1180:end);
 
% aff_mat=aff_mat(:,(end-10):end);
 for i=1:size(aff_mat,2)
     aff_mat(:,i)=aff_mat(:,i)/norm(aff_mat(:,i));
 end
 
end