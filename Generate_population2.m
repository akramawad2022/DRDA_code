function [Xs,Ys,Xt,Yt]= Generate_population2()
n=1e6;ms=1;sigmas=0.5;seed=0;
rng(seed)
Dx= normrnd(ms,sigmas,n,1);
Dy=exp(-0.5*(Dx-ones(length(Dx),1)).^2)-exp(-0.5*(Dx+ones(length(Dx),1)).^2)+ normrnd(0,0.1,n,1);

Is=find(Dx >= 0.5);
Xs=Dx(Is);
Ys=Dy(Is);
It=find(Dx <= 1.5);
Xt=Dx(It);
Yt=Dy(It);

end