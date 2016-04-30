function [y,x]=pure_line(a,b,h,k,m)
    
    x = (a:h:b);
    y = k.*x+m;
%     yx = [y;x];
%     len = (b-a)./h;
%     y2 = h*rand(1,len+1)-0.5;
%     y = y + y2;
%     y2 = rand(1,len+2);
%     len+1
%     2*len+1
%     y(len+1:2*len+2) = y2;
%     plot(x,y,'lineWidth',3)
%     hold on
%     x = [x,x];
%     plot([x,x]',y,'r*','lineWidth',3)
end