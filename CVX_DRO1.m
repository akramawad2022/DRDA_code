function [a,fval]=CVX_DRO1(xs,ys,x0,lambda1,lambda2,w,param)

[Kss, ~ ,K2] = getKernel(xs', param);
ns=length(xs);

% 
para = struct('Kss',Kss,'K2',K2,'w', w,'ns',ns,'ys',ys,'lambda1',lambda1,'lambda2',lambda2);
save('para.mat','para');
options = optimoptions("fminunc",HessianApproximation="lbfgs",...
    SpecifyObjectiveGradient=true);
[a,fval] = fminunc(@myfunDRO,x0,options);




end
