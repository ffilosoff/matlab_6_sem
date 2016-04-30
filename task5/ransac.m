function [k,m,K]=ransac(points,acc)
    [~,M] = size(points);
    x = points(2,:);
    y = points(1,:);
    max_pos_points = 0;
    point1 = ceil(M * rand());
    point2 = ceil(M * rand());
    while (point1 == point2)
        point2 = ceil(M * rand());
    end
    hyp = [x(point1),y(point1),x(point2)-x(point1),y(point2)-y(point1)];
    good_hyp = hyp;
    K = 1;
    i = 0;
    while i < K
        pos_points = sum(abs(((x-hyp(1))/hyp(3))-((y-hyp(2))/hyp(4))) < 0.1);
        if(pos_points > max_pos_points)
            good_hyp = hyp;
            max_pos_points = pos_points;
        end
        e = 1-pos_points/M;
        if(log10(1-(1-e)^2) ~= 0)
            K = log10(1-acc)/log10(1-(1-e)^2);
        end
        point1 = ceil(M * rand());
        point2 = ceil(M * rand());
        while (point1 == point2)
            point2 = ceil(M * rand());
        end
        hyp = [x(point1),y(point1),x(point2)-x(point1),y(point2)-y(point1)];
        i = i + 1;
    end
    k = good_hyp(4)/good_hyp(3);
    m = good_hyp(2)-k*good_hyp(1);
end