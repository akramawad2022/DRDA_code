clc;close all,clear all; 


n=200;%sample size
%Parameter's setting
kparam = struct(); kparam.kernel_type = 'gaussian';
eps1 = 1e-6; B = 10^6;
T=20; Lambda_1=5;beta=5; 
nsamples=100;x0=ones(n,1);
RHO=linspace(0,5,50);% noise levels

%% experiment 1
 
[xs,ys,xt,yt]=Generate_sample(n,0);%Generate training data. 

%Plot the source and target domain samples. 
figure
scatter(xs,ys,'filled');hold on;
scatter(xt,yt,'filled');
Zx= linspace(-3,3,1e3);
Zy= model(Zx');
hold on; plot(Zx,Zy,'k--'); xlim([-3 3])
legend('Source domain','Target domain','True model');



[Kss, ~, K2] = getKernel(xs', kparam);
[Kst, ~, ~] = getKernel(xs', xt',kparam);

w1 = calc_kmm(Kss, Kst, eps1, B);

a0    = inv(Kss*Kss+Lambda_1 *eye(n))*Kss*ys;%RLS
a1    = inv(Kss*diag(w1)*Kss+Lambda_1*eye(n))*Kss*diag(w1)*ys;%W-RLS
a2    = CVX_DRDA(xs,ys,xt,x0,eps1,T,Lambda_1,Lambda_1,beta,kparam,B,w1);%DRDA
a3    = CVX_DRO1(xs,ys,x0,Lambda_1,Lambda_1,w1,kparam); %W-DRO

 
for k=1:length(RHO)
    rho=RHO(k);

    for j=1:nsamples
       [~,~,xt,yt]= Generate_sample(n,j);

        error_RLS(j,k)=predict(xt,yt,xs,a0,kparam,rho);
        error_WRLS(j,k)=predict(xt,yt,xs,a1,kparam,rho);
        error_drda(j,k)=predict(xt,yt,xs,a2,kparam,rho);
        error_wdro(j,k)=predict(xt,yt,xs,a3,kparam,rho);

    end
end

error_mean= [  mean(error_RLS);  mean(error_WRLS); mean(error_drda);mean(error_wdro)];
error_std= [ std(error_RLS); std(error_WRLS); std(error_drda); std(error_wdro)];
Total_variation1=[TV( mean(error_RLS)), TV(mean(error_WRLS)), TV(mean(error_drda)),TV(mean(error_wdro)) ] 
PLOT(error_mean,error_std,2)

%% experiment 2
%Plot the source and target domain samples. 
[Xs,Ys,Xt,Yt]= Generate_population2();
[xs,ys,xt,yt]=Generate_sample2(n,Xs,Ys,Xt,Yt,0);%Generate training data. 
Lambda_1=2;beta=2; 
figure
scatter(xs,ys,'filled');hold on;
scatter(xt,yt,'filled');
Zx= linspace(-3,3,1e3);
Zy= model(Zx');
hold on; plot(Zx,Zy,'k--'); xlim([-0.5 3])
legend('Source domain','Target domain','True model');

[Kss, ~, K2] = getKernel(xs', kparam);
[Kst, ~, ~] = getKernel(xs', xt',kparam);

w1 = calc_kmm(Kss, Kst, eps1, B);

a0    = inv(Kss*Kss+Lambda_1 *eye(n))*Kss*ys;%RLS
a1    = inv(Kss*diag(w1)*Kss+Lambda_1*eye(n))*Kss*diag(w1)*ys;%W-RLS
a2    = CVX_DRDA(xs,ys,xt,x0,eps1,T,Lambda_1,Lambda_1,beta,kparam,B,w1);%DRDA
a3    = CVX_DRO1(xs,ys,x0,Lambda_1,Lambda_1,w1,kparam); %W-DRO

for k=1:length(RHO)
    rho=RHO(k);

    for j=1:nsamples
       [~,~,xt,yt]=Generate_sample2(n,Xs,Ys,Xt,Yt,j);
        error_RLS(j,k)=predict(xt,yt,xs,a0,kparam,rho);
        error_WRLS(j,k)=predict(xt,yt,xs,a1,kparam,rho);
        error_drda(j,k)=predict(xt,yt,xs,a2,kparam,rho);
        error_wdro(j,k)=predict(xt,yt,xs,a3,kparam,rho);

    end
end

error_mean= [  mean(error_RLS);  mean(error_WRLS); mean(error_drda);mean(error_wdro)];
error_std= [ std(error_RLS); std(error_WRLS); std(error_drda); std(error_wdro)];
Total_variation2=[TV( mean(error_RLS)), TV(mean(error_WRLS)), TV(mean(error_drda)),TV(mean(error_wdro)) ] 
PLOT(error_mean,error_std,2)

disp("The Total variation of the first experiment for RLS, WRLS, DRDA, W-DRO  respectively is"); disp(Total_variation1)
disp("The Total variation of the second experiment for RLS, WRLS, DRDA, W-DRO  respectively is"); disp(Total_variation2)