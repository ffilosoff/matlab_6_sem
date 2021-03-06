%% task5 - line
clear;
acc = 99/100;
a = 1;
b = 20;
h = 0.01;
k = 3;
m = 5;
[y,x] = line(a, b,h, k,m,acc);
% plot(x,y,'*b');
% hold on;
%% RANSAC
close all;
yx = [y;x];
[k,m,K] = ransac(yx,acc);
[y2,x2] = pure_line(a,b,h,k,m);
plot(x,y,'*b');
xlim([a b]);
ylim([min(y),max(y)]);
hold on;
plot(x2,y2,'-r','LineWidth', 2);
disp(['k = ' num2str(k) ' m = ' num2str(m)]);

