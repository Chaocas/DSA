% Parameter updating

function [alph,C] = Update(V,x,h)

Kh=zeros(h,h);

C=0;
alph=0;

for i=1:h
    
    for j=1:h
    
        Kh(i,j) = kernel_fun(x(i,:),x(j,:));
    
    end
    
end

I=eye(h,h);

for i=1:(h-1)
    
    q = (V(i,1)-alph_k(alph,i,x))/sigma2_x(i,C,x);

    r = -1/sigma2_x(i,C,x);
    
    s = [C*Kh(1:i,i);0]+I(1:i+1,i+1);  
    
 alph = [alph;0] +q*s;
 
    C = I(1:(i+1),1:i)*C*I(1:(i+1),1:i)'+r*(s*s');
    
end


end