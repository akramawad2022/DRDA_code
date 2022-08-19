function [xs,ys,xt,yt]=Generate_sample2(n,Xs,Ys,Xt,Yt,seed1)

rng(seed1);
Is=randperm(size(Xs,1),n);
rng(seed1);
It=randperm(size(Xt,1),n);
xt=Xt(It,:); 
yt=Yt(It);
xs=Xs(Is,:); 
ys=Ys(Is);

end