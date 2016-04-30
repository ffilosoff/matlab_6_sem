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
y = k*x+m+0.1*rand(1,length(x));

A(1,1) = sum(x);
A(1,2) = n;
A(2,1) = sum(x.^2);
A(2,2) = sum(x);
B(1,1) = sum(y);
B(1,2) = sum(x.*y);

km = A \ B'

figure
%subplot(2,1,1);
plot(x,y,'*b');
hold on;
plot(x,k*x+m,'-r');
%% ellipse
a = 2;
b = 15;
k = 10;
n = (0:1/k:2*pi+1/k);
[y,x]=elipse(a,b,n,0);
[y3,x3]=elipse(a,b,n,1);
A = zeros(4,4);
A(1,1:5) = [sum(x.^4) sum(x.^2.*y.^2) sum(2*x.^3.*y) sum(2*x.^3) sum(2*x.^2.*y)];
A(2,1:5) = [sum(x.^2.*y.^2) sum(y.^4) sum(2*x.*y.^3) sum(2*x.*y.^2) sum(2*y.^3)];
A(3,1:5) = [sum(x.^3.*y) sum(x.*y.^3) sum(2*x.^2.*y.^2) sum(2*x.^2.*y) sum(2*y.^2.*x)];
A(4,1:5) = [sum(x.^3) sum(y.^2.*x) sum(2*x.*y.^2) sum(2*x.^2) sum(2*y.*x)];
A(5,1:5) = [sum(x.^2.*y) sum(y.^3) sum(2*x.*y.^2) sum(2*x.*y) sum(2*y.^2)];
B(1,1:5) = [sum(x.^2) sum(y.^2) sum(x.*y) sum(x) sum(y)];
c = A \ B';
% d = [c(1) c(3) c(4); c(3) c(2) c(5); c(4) c(5) 1];
% del = det(d);
D = c(1)*c(2)-c(3).^2
I = c(1) + c(2);
a = sqrt((-I+sqrt(I^2-4*D))/2)
b = sqrt(1/(D*a^2))
a = sqrt(1/(b^2*D))

plot(x,y,'*r');
[y2,x2]=elipse(a,b,n,1);
hold on;
plot(x2,y2,'-b');
hold on;
plot(x3,y3,'-g');
%% surface
[z,y,x]=plane(4,2,3,10,1,1);
A = zeros(3,3);
B = zeros(1,3);

A(1,1:3) = [sum(sum(x.^2)) sum(sum(x.*y)) sum(sum(x.*z))];
A(2,1:3) = [sum(sum(x.*y)) sum(sum(y.*y)) sum(sum(y.*z))];
A(3,1:3) = [sum(sum(x.*z)) sum(sum(z.*y)) sum(sum(z.*z))];
B(1,1:3) = -[sum(sum(x)) sum(sum(y)) sum(sum(z))];
%
p = A\B'
plot3(x,y,z,'r*')
hold on
% surf(x,y,z);
% hold on
[z,y,x] = plane(p(1),p(2),p(3),10,1,0);
surf(x,y,z);






