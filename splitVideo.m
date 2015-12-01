%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  this function Split a given video into sequence of similar frames
%  kmeans_IDX : K-mean Clustering index array of a video (1 x m)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [clips] = splitVideo(vect, kmeans_IDX, seq_len)
[~,len] = size(kmeans_IDX);
interval = [];
count = 0;
for i = 1: len-1
    if(kmeans_IDX(i)==kmeans_IDX(i+1))
        count = count + 1;
    elseif(count>=seq_len)
        interval(size(interval,2)+1) = i - count;
        interval(size(interval,2)+1) = i ;
        count = 0;
    else
        count = 0;
    end
end
interval(1) = 1;
interval(1, size(interval,2)+1) = len;

k = 1;
[row, col] = size(vect{1});
clips = struct('frame', [],'start', [], 'end', []);

for i=1:size(interval,2)-1
    fstart = interval(i);
    fend = interval(i+1);
    if (fend - fstart)>=5
        for j = fstart:fend
            avg_seq(j,:) = reshape(vect{j}, [1, row*col]);
        end
        clips(k).frame = reshape(mean(avg_seq(fstart:fend, :)),[row, col]);
        clips(k).start = fstart;
        clips(k).end = fend;
        k = k + 1;
        clear avg_seq;
    end
end
end
