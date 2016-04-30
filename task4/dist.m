function [ res ] = dist( line, k1, k2 )
    x = line(1, :);
    y = line(2, :);
    d = sqrt(x.^2 + y.^2);
    
    x = x .* (1 + k1*(d.^2) + k2*(d.^4));
    y = y .* (1 + k1*(d.^2) + k2*(d.^4));
    
    res = [x; y];
end

