%******************************************************
% Construct training set for online GP approach to DSA 
% Using PMU data on http://nanotera-stg2.epfl.ch/data/
% Date: July 9, 2020
% Created by Chao Zhai
%******************************************************

close all;
clear all;

Dt=0.02;                   % sampling period 
n_point=1500;              % number of sample points
ep=0.03;                   % boundary of equilibrium

addpath D:\科研论文\IEEE_TASE\Code\Mar21;

pmu1=importdata('2019-03-21_02h_UTC_PMUID10.txt');     % 7-8  VA Mag-Phase   11-12 VB-Mag-Phase   15-16 VC-Mag-Phase

X=0.02:0.02:(Dt*n_point);
V1_mag=pmu1.data(1:n_point,7);
V1_pha=pmu1.data(1:n_point,8);
V1_omg=diff(V1_pha)/Dt;
V1_omg=[V1_omg(1,1);V1_omg];

norm_V1_mag=V1_mag/max(abs(V1_mag));
norm_V1_pha=V1_pha/max(abs(V1_pha));
norm_V1_omg=V1_omg/max(abs(V1_omg));

%% PMU data

figure(1)
subplot(3,1,1);
plot(X,V1_mag,'b','LineWidth',1.2);
grid on;
xlabel('Time [s]');
ylabel('U [V]')
% line([0 Dt*n_point],[0 0],'color','r');

subplot(3,1,2);
plot(X,V1_pha,'b','LineWidth',1.2);
grid on;
axis([0 Dt*n_point 0 2.6]);
xlabel('Time [s]');
ylabel('\theta [rad]')
% line([0 Dt*n_point],[0 0],'color','r');

subplot(3,1,3);
plot(X,V1_omg,'b','LineWidth',1.2);
grid on;
xlabel('Time [s]');
ylabel('\omega [rad/s]')
% line([0 Dt*n_point],[0 0],'color','r');

%% The 1st order time derivative for equilibrium

V1_mag_dt=diff(V1_mag)/Dt;
V1_mag_dt=[V1_mag_dt(1,1);V1_mag_dt];

V1_pha_dt=diff(V1_pha)/Dt;
V1_pha_dt=[V1_pha_dt(1,1);V1_pha_dt];

V1_omg_dt=diff(V1_omg)/Dt;
V1_omg_dt=[V1_omg_dt(1,1);V1_omg_dt];

norm_V1_mag_dt=V1_mag_dt/max(abs(V1_mag_dt));
norm_V1_pha_dt=V1_pha_dt/max(abs(V1_pha_dt));
norm_V1_omg_dt=V1_omg_dt/max(abs(V1_omg_dt));

tem=[norm_V1_mag_dt norm_V1_pha_dt norm_V1_omg_dt];
dist=zeros(n_point,1);

for i=1:n_point
    dist(i,1)=norm(tem(i,:));
end

figure(2)
subplot(3,1,1);
plot(X,V1_mag_dt,'b','LineWidth',1.2);
grid on;
xlabel('Time [s]');
h=ylabel('$\dot{U}$ [V/s]');
set(h,'Interpreter','latex');
% line([0 Dt*n_point],[0 0],'color','r');

subplot(3,1,2);
plot(X,V1_pha_dt,'b','LineWidth',1.2);
grid on;
% axis([0 Dt*n_point 0 2.6]);
xlabel('Time [s]');
h=ylabel('$\dot{\theta}$ [rad/s]');
set(h,'Interpreter','latex');
% line([0 Dt*n_point],[0 0],'color','r');

subplot(3,1,3);
plot(X,V1_omg_dt,'b','LineWidth',1.2);
grid on;
xlabel('Time [s]');
h=ylabel('$\dot{\omega}$ [rad/$s^2$]');
set(h,'Interpreter','latex');
% line([0 Dt*n_point],[0 0],'color','r');

figure(3)
% ep=0.05;
x1=plot(X,dist,'b','LineWidth',1.2);
hold on
grid on;
xlabel('Time [s]');
h=ylabel('$d$');
set(h,'Interpreter','latex');
x2=line([0 Dt*n_point],[ep ep],'color','g','LineWidth',2);
hold on
plot(946*Dt,ep,'r*','LineWidth',3);
legend('Distance to equilibrium','Threshold \epsilon=0.03');

%% Identify the qusi-equilibrium 

Index_sat = find(dist-ep<=0);
ind = Index_sat(1,1);

x_mag = norm_V1_mag-ones(n_point,1)*norm_V1_mag(ind,1);
%x_mag = x_mag/max(abs(x_mag));

x_pha = norm_V1_pha-ones(n_point,1)*norm_V1_pha(ind,1);
%x_pha = x_pha/max(abs(x_pha));

x_omg = norm_V1_omg-ones(n_point,1)*norm_V1_omg(ind,1);
%x_omg = x_omg/max(abs(x_omg));
%% Obtain traning set {x,V(x)}
                    
samp=ceil(200*rand(200,1));        % select 120 initial points from 150 samples
samp=sort(samp);
samp_ind=unique(samp);

x_tra=[x_mag(1:ind) x_pha(1:ind) x_omg(1:ind)];

X_in=zeros(numel(samp_ind),3);      % initial position of trajectory
V_out=zeros(numel(samp_ind),1);     % estimate of Lyapunov function

for k=1:numel(samp_ind)
    
    X_in(k,:)=x_tra(samp_ind(k,1),:);
    Y_in=x_tra(samp_ind(k,1):end,:);
    V_out(k,1)=Vfun(Y_in,Dt);
    
end

sol = [X_in V_out];










