function [f,g]= myfun(a)

load para.mat
K2=para.K2; Kss=para.Kss; ys=para.ys; w=para.w;lambda1=para.lambda1;lambda2=para.lambda2;
ns=para.ns; nt= para.nt;
T1=diag(a)*K2;
f=(Kss*a-ys)' *diag(w)*(Kss*a-ys)+ lambda2*a'*Kss*a+ lambda1* trace(T1.^4)^(0.5);
g1=2*Kss'*diag(w)*(Kss*a-ys);
g2=2*Kss*a;
g3= (2*trace((diag(a)*K2).^4)^(-0.5))*diag(eye(ns).*(T1.^3)*K2); 
g= g1+lambda1*g3+lambda2*g2; 
end