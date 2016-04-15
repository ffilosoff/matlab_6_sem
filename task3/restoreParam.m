function [s_res,tetta_res,t_x_res,t_y_res] = restoreParam(y,x,y_rot,x_rot)
    A = zeros(4,4);
    n = length(x);
    A(1,1) = sum(x.^2+y.^2);
    A(1,2) = 0;
    A(1,3) = sum(x);
    A(1,4) = sum(y);
    
    A(2,1) = 0;
    A(2,2) = sum(x.^2+y.^2);
    A(2,3) = -sum(y);
    A(2,4) = sum(x);
    
    A(3,1) = -sum(x);
    A(3,2) = sum(y);
    A(3,3) = -n;
    A(3,4) = 0;
    
    A(4,1) = sum(y);
    A(4,2) = sum(x);
    A(4,3) = 0;
    A(4,4) = n;
    
    B(1) = sum(x.*x_rot+y.*y_rot);
    B(2) = sum(x.*y_rot-y.*x_rot);
    B(3) = -sum(x_rot);
    B(4) = sum(y_rot);
    
    P = A^(-1)*B';
    tetta_res = asin(P(2));
    s_res = P(1)/(cos(tetta_res));
    t_x_res = P(3);
    t_y_res = P(4);
end