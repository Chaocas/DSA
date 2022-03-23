function result=sigma2_x(i,C,x)

result = 0;

sigma2_0 = 0.01;  % or 0.01

for j=1:i
   
    for k=1:i
       
        result = result+C(j,k)*kernel_fun(x(i,:),x(j,:))*kernel_fun(x(i,:),x(k,:));
        
    end
    
end

result = result+sigma2_0;

end