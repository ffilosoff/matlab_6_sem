%% generating lines
clear;

x_len = 320;
y_len = 240;
f = 400;
k1 = 0.779;
k2 = -5.872;

x = 1:x_len;
y1(1:x_len) = 20;
y2(1:x_len) = 200;

xc = x(floor(length(x)/2));
yc = floor(y_len/2);

x_imgn = (x-xc)/f;
y1_imgn = (y1-yc)/f;
y2_imgn = (y2-yc)/f;

d_y1 = sqrt(x_imgn.^2+y1_imgn.^2);
d_y2 = sqrt(x_imgn.^2+y2_imgn.^2);

x1_imgn_dist = x_imgn.*(1+k1*d_y1.^2+k2*d_y1.^4);
y1_imgn_dist = y1_imgn.*(1+k1*d_y1.^2+k2*d_y1.^4);

x2_imgn_dist = x_imgn.*(1+k1*d_y2.^2+k2*d_y2.^4);
y2_imgn_dist = y2_imgn.*(1+k1*d_y2.^2+k2*d_y2.^4);

plot(x,y1,'-b','LineWidth',2);
hold on;
plot(x,y2,'-b','LineWidth',2);
hold on;
plot(f*x1_imgn_dist+xc,f*y1_imgn_dist+yc,'-r','LineWidth',2);
hold on;
plot(f*x2_imgn_dist+xc,f*y2_imgn_dist+yc,'-r','LineWidth',2);
ylim([0 y_len]);
xlim([0 x_len]);

%% nonlin
close all;
disp(nuton_dist_solver([x_imgn;y1_imgn], [x1_imgn_dist;y1_imgn_dist], 0.1));

%%
close all;
t = 100;
xy = [x_imgn;y1_imgn]';
xy0 = [x1_imgn_dist;y1_imgn_dist]';
alpha = 0.1;
k(1) = 1;
k(2) = 1;
d = sqrt(sum(xy.^2, 2));
xyk = [xy(:,1) .* (1 + k(1)*(d.^2) + k(2)*(d.^4)) , xy(:,2).* (1 + k(1)*(d.^2) + k(2)*(d.^4))];%dist(D', k1, k2)';
d = [d,d];
r = xyk - xy0;
i = 0;
err = zeros(1,t);

for i = 1:t
    err(i) = norm(max(abs(r)));
    dk1 = -xy.*d.^2; 
    dk2 = -xy.*(d.^4);

    Jxk = [dk1(:, 1)'; dk2(:, 1)']';
    Jyk = [dk1(:, 2)'; dk2(:, 2)']';

    Axk = Jxk'*Jxk;
    Ayk = Jyk'*Jyk;

    f_str = alpha * (Axk \ Jxk') * r(:, 1);
    s_str = alpha * (Ayk \ Jyk') * r(:, 2);

    k(1) = k(1) + mean([f_str(1), s_str(1)]);
    k(2) = k(2) + mean([f_str(2), s_str(2)]);
    
    xyk = [xy(:,1) .* (1 + k(1)*(d(:,1).^2) + k(2)*(d(:,1).^4)) , xy(:,2).* (1 + k(1)*(d(:,1).^2) + k(2)*(d(:,1).^4))];
    r = xyk - xy0;
end

figure
plot(0:i-1, err);   


