%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  this function Calculate the cosine distance between two vectors
%
%  input_vect  : vector representing the input clip (W x W)
%  output_vect : vector representing the output clip (W x W)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [cosine_dist] = cosine_distance(input_vect, output_vect)

prod = sum(sum(output_vect .* input_vect));
abs_out = sqrt(sum(sum(output_vect .* output_vect)));
abs_in = sqrt(sum(sum(input_vect .* input_vect)));
cosine_dist = 1 - (prod/(abs_out .* abs_in));

end
