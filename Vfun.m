% Estimation of Lyapunov function

function z = Vfun(x,Dt)

z = 0;

num = max(size(x));

for i=1:num
    
    z = z+norm(x(i,:))^2*Dt;    

end

end