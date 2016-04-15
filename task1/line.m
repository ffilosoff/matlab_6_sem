function [y,x]=line(a,b,h,k)
    
    x = (a:h:b);
    y = k.*x;
    len = (b-a)./h;
    y2 = rand(1,len+1)-0.5;
    y2 = y + y2;
    plot(x,y,'lineWidth',3)
    hold on
    plot(x,y2,'r+','lineWidth',3)
end