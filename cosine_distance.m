function [cosine_dist] = cosine_distance(input_vect, output_vect)
for j = 1:3
    for k = 1:3
        prod = output_vect(j,k).*input_vect(j,k);
        abs_out = sum(sum(output_vect(j,k).*output_vect(j,k)));
        abs_in = sum(sum(input_vect(j,k).*input_vect(j,k)));
        cosine_dist = 1 - (prod/(abs_out+abs_in));
    end
end
end
