%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  this function calculate the euclidean distance between two vectors
%
%  input_vect  : vector representing the input clip (W x W)
%  output_vect : vector representing the output clip (W x W)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [eucli_dist] = euclidean_distance(input_vect, output_vect)
[row, col] = size(output_vect);
diff = 0;

for j = 1:row
    for k = 1:col
        diff = diff + (output_vect(j,k) - input_vect(j,k))^2;
    end
end

eucli_dist = sqrt(diff);
end
