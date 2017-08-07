function voxelGridTDF = pointCloud2TDF(points,xRange,yRange,zRange,voxelSize,voxelMargin)

% Compute voxel grid ????Does we need to fix the original opint.
[gridX,gridY,gridZ] = ndgrid((xRange(1)+voxelSize/2):voxelSize:(xRange(2)-voxelSize/2), ...
                             (yRange(1)+voxelSize/2):voxelSize:(yRange(2)-voxelSize/2), ...
                             (zRange(1)+voxelSize/2):voxelSize:(zRange(2)-voxelSize/2));
%                       save   gridX;
%                       save   gridY;
%                       save   gridZ;
                    

% Build KD-tree and do 1-NN search                         
modelKDT = KDTreeSearcher(points);
[nnInd,nnDist] = knnsearch(modelKDT,[gridX(:),gridY(:),gridZ(:)]);

% Reshape values into voxel grid
voxelGridTDF = reshape(nnDist,size(gridX));

% Apply truncation
% voxelGridTDF = 1.0 - min(voxelGridTDF./(voxelSize*voxelMargin),1.0);
end