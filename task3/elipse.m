function [y,x]=elipse(a,b,n,p)
    x = a*cos(n);
    y = b*sin(n);
    if(p~=1)
        x = x+0.7*(rand(1,length(n))-0.5);
        y = y+0.7*(rand(1,length(n))-0.5);
    end
%     plot(x,y,'lineWidth',3);
%     hold on
%     plot(x2,y2,'r+');
%     plot(x,y,'lineWidth',3)
end