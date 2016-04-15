close all;
%% random points
n = 100;
s = 1;
tetta = 10;
t_x = 0;
t_y = 0;
[y,x] = generatePoints(n);
[y_rot,x_rot] = rotatePoints(y,x,s,tetta,t_x,t_y);
[s_res,tetta_res,t_x_res,t_y_res] = restoreParam(y,x,y_rot,x_rot);
[y_rot2,x_rot2] = rotatePoints(y,x,s,tetta,t_x,t_y);
figure;
plot(x,y,'+');
hold on;
plot(x_rot,y_rot,'+');
hold on;
plot(x_rot2,y_rot2,'*');
%% line
k = 1;
m = 0;
n = 100;
accuracy = 0.1;
x = (0:accuracy:n*accuracy);
y = k*x+m+rand(1,length(x));


figure
subplot(2,1,1);
plot(x,y,'*');
subplot
%%





