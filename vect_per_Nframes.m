function [vect_per_Nframes] = vect_per_Nframes(vect, n)
[~,nFrames] = size(vect);
[row, col] = size(vect{1});
if(isempty(n))
    for i = 1:nFrames
        reshaped_vect(i,:) = reshape(vect{i}, [1, row*col]);
        vect_per_Nframes = reshape(mean(reshaped_vect), [row, col]);
    end
else
    for i = 1:n:nFrames-n
        for j = 0:n-1
            reshaped_vect(j+1,:) = reshape(vect{i+j}, [1, row*col]);
        end
        vect_per_Nframes{ceil(i/n)} = reshape(mean(reshaped_vect), [row, col]);
    end
end
end
