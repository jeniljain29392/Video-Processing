function [eucli_dist] = euclidean_distance(input_vect, output_vect)
diff = 0;
for j = 1:3
    for k = 1:3
        diff = diff + (output_vect(j,k) - input_vect(j,k))^2;
    end
end
eucli_dist = sqrt(diff);
end
