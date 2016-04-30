%% init
clear all;
close all;

f = 400;
line1 = get_line(-160, 160, 120) / f;
line2 = get_line(-160, 160, -120) / f;

%% dist
k1 = 5;
k2 = 10;
dist_line1 = dist(line1, k1, k2);
dist_line2 = dist(line2, k1, k2);

%% plotting
figure
plot(dist_line1(1, :) * f, dist_line1(2, :) * f, '.b');
hold on;
plot(dist_line2(1, :) * f, dist_line2(2, :) * f, '.b');
hold on;
%%
plot(line1(1, :) * f, line1(2, :) * f, '.r');
hold on;
plot(line2(1, :) * f, line2(2, :) * f, '.r');
hold on;

%% nuton_dist_solver_test
disp(nuton_dist_solver(line1, dist_line1, 0.1));