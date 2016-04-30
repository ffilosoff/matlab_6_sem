function [z,y,x]=plane(a,b,c,l,step,p)
    t = (0:step:l);
    [x,y] = meshgrid(t);
    z = (-a*x-b*y-1)./c;
    if(p~=0)
        z =  z + (rand(length(x),length(y)) - 0.5);
    end
    
end