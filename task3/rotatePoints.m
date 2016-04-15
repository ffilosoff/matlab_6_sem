function [y_rotated,x_rotated]=rotatePoints(y,x,s, tetta, t_x, t_y)
    tetta = tetta*pi/180;
    x_rotated = s .* x .* cos(tetta) - y .* sin(tetta) + t_x;%+rand(1,length(x));
    y_rotated = x .* sin(tetta) + s .* y .* cos(tetta) + t_y;%+rand(1,length(y));
%     plot(x_rotated,y_rotated,'+');
end