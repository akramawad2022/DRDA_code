clc;close all;clear all;
addpath('.\utils_1');
n=100;%sample size for training
%Parameter's setting
kparam = struct(); kparam.kernel_type = 'gaussian';
eps1 = 1e-6; B = 10^6;
T=20; Lambda_1=5;beta=5; 
nsamples=50;x0=ones(n,1);
RHO=linspace(0,5,50);% noise levels
nt=1000;%testing sample size.  
%% experiment 1

[Xs,Ys,Xt,Yt]= Generate_population();


xtt=Xt(length(Xt)-nt:length(Xt),:); 
ytt=Yt(length(Xt)-nt:length(Xt));
 
I=1:length(Xt)-nt;
for j=1:nsamples

[xs,ys,xt,yt]=Generate_sample2(n,Xs,Ys,Xt(I,:),Yt(I),j);


[Kss, ~, K2] = getKernel(xs', kparam);
[Kst, ~, ~] = getKernel(xs', xt',kparam);

w1 = calc_kmm(Kss, Kst, eps1, B);


a0    = inv(Kss*Kss+Lambda_1 *eye(n))*Kss*ys;
a1    = inv(Kss*diag(w1)*Kss+Lambda_1*eye(n))*Kss*diag(w1)*ys;
a2  = CVX_DRDA(xs,ys,xt,x0,eps1,T,Lambda_1,Lambda_1,beta,kparam,B,w1);
a3    = CVX_DRO1(xs,ys,x0,Lambda_1,Lambda_1,w1,kparam);
 
for k=1:length(RHO)
    rho=RHO(k);

   

     
        error_RLS(j,k)=predict(xtt,ytt,xs,a0,kparam,rho);
        error_WRLS(j,k)=predict(xtt,ytt,xs,a1,kparam,rho);
        error_drda(j,k)=predict(xtt,ytt,xs,a2,kparam,rho);
        error_wdro(j,k)=predict(xtt,ytt,xs,a3,kparam,rho);



end

end

  


error_mean= [  mean(error_RLS);  mean(error_WRLS); mean(error_drda);mean(error_wdro)];
error_std= [ std(error_RLS); std(error_WRLS); std(error_drda); std(error_wdro)];
Total_variation1=[TV( mean(error_RLS)), TV(mean(error_WRLS)), TV(mean(error_drda)),TV(mean(error_wdro)) ] 

PLOT(error_mean,error_std,1.96/sqrt(nsamples));
%% experiment 2:
[Xs,Ys,Xt,Yt]= Generate_population2();


xtt=Xt(length(Xt)-nt:length(Xt),:); 
ytt=Yt(length(Xt)-nt:length(Xt));
 
I=1:length(Xt)-nt;
for j=1:nsamples

[xs,ys,xt,yt]=Generate_sample2(n,Xs,Ys,Xt(I,:),Yt(I),j);


[Kss, ~, K2] = getKernel(xs', kparam);
[Kst, ~, ~] = getKernel(xs', xt',kparam);

w1 = calc_kmm(Kss, Kst, eps1, B);


a0    = inv(Kss*Kss+Lambda_1 *eye(n))*Kss*ys;
a1    = inv(Kss*diag(w1)*Kss+Lambda_1*eye(n))*Kss*diag(w1)*ys;
a2  = CVX_DRDA(xs,ys,xt,x0,eps1,T,Lambda_1,Lambda_1,beta,kparam,B,w1);
a3    = CVX_DRO1(xs,ys,x0,Lambda_1,Lambda_1,w1,kparam);
 
for k=1:length(RHO)
    rho=RHO(k);

   

     
        error_RLS(j,k)=predict(xtt,ytt,xs,a0,kparam,rho);
        error_WRLS(j,k)=predict(xtt,ytt,xs,a1,kparam,rho);
        error_drda(j,k)=predict(xtt,ytt,xs,a2,kparam,rho);
        error_wdro(j,k)=predict(xtt,ytt,xs,a3,kparam,rho);



end

end

  


error_mean= [  mean(error_RLS);  mean(error_WRLS); mean(error_drda);mean(error_wdro)];
error_std= [ std(error_RLS); std(error_WRLS); std(error_drda); std(error_wdro)];
Total_variation2=[TV( mean(error_RLS)), TV(mean(error_WRLS)), TV(mean(error_drda)),TV(mean(error_wdro)) ] 

PLOT(error_mean,error_std,1.96/sqrt(nsamples));

disp("The Total variation of the first experiment for RLS, WRLS, DRDA, W-DRO  respectively is"); disp(Total_variation1)
disp("The Total variation of the second experiment for RLS, WRLS, DRDA, W-DRO  respectively is"); disp(Total_variation2)