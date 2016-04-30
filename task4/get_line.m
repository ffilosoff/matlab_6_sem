function [ line ] = get_line( min_x, max_x, const_y )
    x = min_x : 1: max_x;
    y = const_y * ones(1, length(x));
    line = [x; y];
end