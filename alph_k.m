function result = alph_k(alph,i,x)

result = 0;

for j=1:i

    result = result+alph(j,1)*kernel_fun(x(i,:),x(j,:));
    
end

end