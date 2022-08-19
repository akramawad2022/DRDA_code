function [Xs,Ys,Xt,Yt]= Generate_population()
n=1e5;ms=1;sigmas=0.5;mt=-1;sigmat=0.6;seed=0;
rng(seed)
Xs= normrnd(ms,sigmas,n,1);
rng(seed)
Xt= normrnd(mt,sigmat,n,1);
Ys=exp(-0.5*(Xs-ones(length(Xs),1)).^2)-exp(-0.5*(Xs+ones(length(Xs),1)).^2)+ normrnd(0,0.1,n,1);
Yt=exp(-0.5*(Xt-ones(length(Xt),1)).^2)-exp(-0.5*(Xt+ones(length(Xt),1)).^2)+ normrnd(0,0.1,n,1);

end
