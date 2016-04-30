function [ params ] = levenberg_dist_solver(  D, dD, lambda) 
% find param distorsion
    D = D';
    dD = dD';
    k1 = 1;
    k2 = 1;
    d = repmat(sum(D.^2, 2), 1, 2);
    cur_D = dist(D', k1, k2)';
    r = cur_D - dD;
    counter = 0;
    error = max(abs(r));
    v = 2;
     

    while max(abs(r)) > 0.001
        error(counter + 1) = norm(max(abs(r)));
        dk1 = -D.*d; % dr/dk1 = x*(1 + k1*d + k2*d^2) 
        dk2 = -D.*(d.^2);
    
        Jx = [dk1(:, 1)'; dk2(:, 1)']';
        Jy = [dk1(:, 2)'; dk2(:, 2)']';

        Ax = Jx'*Jx;
        Ay = Jy'*Jy;
        
        Dx = diag(Ax);
        Dy = diag(Ay);
        
        lambda = lambda / 2;
        
        dc1 = ((Ax + lambda*eye(2)) \ Jx'*rx);
        dc2 = ((Ay + lambda*eye(2)) \ Jy'*ry);
        
        rx = r(:, 1);
        ry = r(:, 2);
        
               
        Sx = rx'*rx;
        Sy = ry'*ry;
        
        k1 = k1 + mean([help1(1), help2(1)]);
        k2 = k2 + mean([help1(2), help2(2)]);
        
        cur_D = dist(D', k1, k2)';
        r = cur_D - dD;
        counter = counter + 1;
    end
   
    figure
    plot(0:(counter-1), error);
    disp(counter)
    params = [k1, k2];  
end


function [S] = S(r, c)
    S = r
end
