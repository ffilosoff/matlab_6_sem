function [y,x]=line(a,b,h,k,m,coeff)
    
    x = (a:h:b);
    y = k.*x+m;
    len = (b-a)./h;
    y2 = h*rand(1,len+1);
    y = y + y2;
    len2 = floor(coeff*len);
    y2 = rand(1,len2)*k*(b-a)+y(1);
    y(len+1:len+len2) = y2;
%     plot(x,y,'lineWidth',3)
%     hold on
    x = [x,a+(b-a)*rand(1,len2-1)];
%     plot(x,y,'r*','lineWidth',2)
end