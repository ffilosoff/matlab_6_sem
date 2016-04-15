function [y,x]=elipse(a,b,t)
    
    x = a*cos(t);
    y = b*sin(t);
    x2 = x+rand(1,length(t))-0.5;
    y2 = y+rand(1,length(t))-0.5;
    plot(x,y,'lineWidth',3);
    hold on
    plot(x2,y2,'r+');
%     plot(x,y,'lineWidth',3)
end