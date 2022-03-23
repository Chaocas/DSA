function result=std_fun(x,y,h,C)

result = 0;

for i=1:h
   
    for j=1:h
       
        result = result+C(i,j)*kernel_fun(y,x(i,:))*kernel_fun(y,x(j,:));
        
    end
    
end

result = result+kernel_fun(y,y);

result = sqrt(result);

end