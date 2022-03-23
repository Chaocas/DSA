% spherical RBF kernels

function z = kernel_fun(x,y)

d=3;                        % input dimensions 
sigma_k=1.5;                  % kernel width

z=exp(-norm(x-y)^2/(2*d*sigma_k^2));

end