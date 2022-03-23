%*************************************************
% Online DSA Algorithm 
% PMU data from EPFL-Microgrid  
% http://nanotera-stg2.epfl.ch/data/2019/Apr/01/
% Online GP + Converse Lyapunov Function
% Created by Chao Zhai at CUG  
% Date: March 22, 2022 
%************************************************

%% Parameter Setting 
clear all;
close all;

Dt=0.02;                        % sampling period 
h=10;                           % width of time window
dim=3;                          % input dimension
delta=[0.5 0.8 0.95];           % delta confidence level 
beta=[0.68 1.3 1.65];           % normcdf(beta) = (1+delta)/2  

% X_in=zeros(h,dim);            % training set {Xin, Vout} for GP
% V_out=zeros(h,1);           

%% Obtain training set 
step=70;

Y=train_data1;
X_in=Y(step:step+h,1:3);              % normalized input data
V_out=Y(step:step+h,4);               % output-estimate of Lyapunov function

%% Parameter Updating 

[alph,C] = Update(V_out,X_in,h);

%% Visualisation of ROA 

figure(1);
Vmax=max(V_out);

n_res=11;
x1= linspace(-1,1,n_res);
x2= linspace(-1,1,n_res); 
x3= linspace(-1,1,n_res); 

for i=1:n_res
    
    for j=1:n_res
        
        for k=1:n_res
            
            Yin=[x1(i) x2(j) x3(k)];
            
            mean_fun_val=mean_fun(X_in,Yin,alph,h);
             std_fun_val=std_fun(X_in,Yin,h,C);
            
            mark1=mean_fun_val+beta(1)*std_fun_val-Vmax;
            
            if(mark1<=0)                      % p=0.5
               subplot(3,1,1)
               plot(Yin(1,1),Yin(1,2),'r.');
               axis([-1 1 -1 1]);
               hold on;

               
               subplot(3,1,2)
               plot(Yin(1,2),Yin(1,3),'r.');
               axis([-1 1 -1 1]);
               hold on;
               plot(0,0,'b.','MarkerSize',12);
               hold on
               
               subplot(3,1,3)
               plot(Yin(1,3),Yin(1,1),'r.');
               axis([-1 1 -1 1]);
               hold on;
               plot(0,0,'b.','MarkerSize',12);
               hold on
               
            end
            
        end
           
    end
    
end


for i=1:n_res
    
    for j=1:n_res
        
        for k=1:n_res
            
            Yin=[x1(i) x2(j) x3(k)];
            
            mean_fun_val=mean_fun(X_in,Yin,alph,h);
             std_fun_val=std_fun(X_in,Yin,h,C);
            mark2=mean_fun_val+beta(2)*std_fun_val-Vmax;
            
               
            if(mark2<=0)                      % p=0.8
                
               subplot(3,1,1)
               plot(Yin(1,1),Yin(1,2),'y.');
               hold on;
               axis([-1 1 -1 1]);
               
               subplot(3,1,2)
               plot(Yin(1,2),Yin(1,3),'y.');
               hold on;
               axis([-1 1 -1 1]);
               
               subplot(3,1,3)
               plot(Yin(1,3),Yin(1,1),'y.');
               hold on;
               axis([-1 1 -1 1]); 
               
            end
            
        end
           
    end
    
end


for i=1:n_res
    
    for j=1:n_res
        
        for k=1:n_res
            
            Yin=[x1(i) x2(j) x3(k)];
            
            mean_fun_val=mean_fun(X_in,Yin,alph,h);
             std_fun_val=std_fun(X_in,Yin,h,C);
            mark3=mean_fun_val+beta(3)*std_fun_val-Vmax;
               
            if(mark3<=0)                         % p=0.95
               
               subplot(3,1,1)
               plot(Yin(1,1),Yin(1,2),'g.');
               hold on;
               axis([-1 1 -1 1]);
               plot(0,0,'b.','MarkerSize',12);
               hold on
               
               subplot(3,1,2)
               plot(Yin(1,2),Yin(1,3),'g.');
               hold on;
               axis([-1 1 -1 1]);
               plot(0,0,'b.','MarkerSize',12);
               hold on
               
               subplot(3,1,3)
               plot(Yin(1,3),Yin(1,1),'g.');
               hold on;
               axis([-1 1 -1 1]);
               plot(0,0,'b.','MarkerSize',12);
               hold on
               
            end
            
        end
           
    end
    
end
