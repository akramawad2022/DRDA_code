function [a,w,obj]= CVX_DRDA(xs,ys,xt,x0,epslion,T,lambda1,lambda2,beta,param,B,w)
ns=length(xs); nt=length(xt);
[Kss, ~, K2] = getKernel(xs', param);
[Kst, ~, ~] = getKernel(xs', xt',param);


f1=sum(Kst,2);
 x0=ones(ns,1);


for i=1:T
para = struct('Kss',Kss,'K2',K2,'w', w,'ns',ns,'nt',nt,'ys',ys,'lambda1',lambda1,'lambda2',lambda2);
save('para.mat','para');
options = optimoptions("fminunc",HessianApproximation="lbfgs",...
    SpecifyObjectiveGradient=true);

[a,f] = fminunc(@myfun,x0,options);

x0=a;

r=(Kss*a-ys);



cvx_begin quiet
variable w(ns)
minimize ((r' *diag(w)*r)+ beta*(1/ns)^2 * w'* Kss*w - (2/(ns*nt)) *f1'* w*beta)
subject to
        w<= B*ones(ns,1); 
        w >= zeros(ns,1);
        w'*ones(ns,1)<= ns*(1+epslion); 
         w'*ones(ns,1)>= ns*(1-epslion);
cvx_end

end

