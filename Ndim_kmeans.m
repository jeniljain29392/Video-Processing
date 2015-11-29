function [kmeans_IDX] = Ndim_kmeans(vect, nClusters)
[~,n] = size(vect);
[row, col] = size(vect{1});
p = row*col;
for i=1:n
   feat_vect(i,:) = reshape(vect{i}, [1, p]);
end
kmeans_IDX = kmeans(feat_vect, nClusters);
kmeans_IDX = kmeans_IDX';
end
