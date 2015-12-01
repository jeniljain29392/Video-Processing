function [cosine_dist] = cosine_distance(input_vect, output_vect)
prod = sum(sum(output_vect.*input_vect));
abs_out = sum(sum(output_vect.*output_vect));
abs_in = sum(sum(input_vect.*input_vect));
cosine_dist = 1 - (prod/(abs_out .* abs_in));
end

