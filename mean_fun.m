function result = mean_fun(x,y,alph,h)

result=0;

for i=1:h

    result = result+alph(i,1)*kernel_fun(x(i,:),y);
    
end

end