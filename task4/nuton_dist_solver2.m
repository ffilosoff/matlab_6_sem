function [ params ] = nuton_dist_solver( D, dD, alpha)
% find param distorsion
    D = D';
    dD = dD';
    k1 = 1;
    k2 = 1;
    d = repmat(sum(D.^2, 2), 1, 2);
    cur_D = dist(D', k1, k2)';
    r = cur_D - D;
    counter = 0;
    error = max(abs(r));
    
    while max(abs(r)) > 0.001
        error(counter + 1) = norm(max(abs(r)));
        dk1 = -dD.*d/(1 + k1*d + k2*d.^2).^2; % dr/dk1 = -х'd/(1 + k1*d + k2*d^2)^2 
        dk2 = -dD.*d/(1 + k1*d + k2*d.^2).^2; % dr/dk1 = -х'd^2/(1 + k1*d + k2*d^2)^2
    
        Jx = [dk1(:, 1)'; dk2(:, 1)']';
        Jy = [dk1(:, 2)'; dk2(:, 2)']';

        Ax = Jx'*Jx;
        Ay = Jy'*Jy;
        
        help1 = alpha * (Ax \ Jx') * r(:, 1);
        help2 = alpha * (Ay \ Jy') * r(:, 2);
       
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

