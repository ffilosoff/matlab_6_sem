function [z,y,x]=plane(a,b,c,d,l,step,mu,sigma)
    t = (0:step:l);
    [x,y] = meshgrid(t);
    z = (-a*x-b*y-d)./c;
    z2 =  z + normrnd(mu,sigma,length(x),length(y)) - 0.5;
    plot3(x,y,z2,'r*')
    hold on
    surf(x,y,z);
end