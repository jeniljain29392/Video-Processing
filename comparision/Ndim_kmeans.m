%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  this function cluster the given set of data into similar group. So it
%  cluster a n x p data matrix where n is the number of observations and p 
%  is number of variables, into an array which contains cluster ID 
%
%  video_vect : motion vector of the video from the dataset (k * (W x W))
%  nClusters  : number of clusters needed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [kmeans_IDX] = Ndim_kmeans(video_vect, nClusters)

[~,n] = size(video_vect);
[row, col] = size(video_vect{1});
p = row*col;
for i=1:n
   feat_vect(i,:) = reshape(video_vect{i}, [1, p]);
end

% K-means clustering
kmeans_IDX = kmeans(feat_vect, nClusters);
kmeans_IDX = kmeans_IDX';
end
