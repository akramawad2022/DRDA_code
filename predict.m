function preds=predict(x,y,xs,a,kparam,s)
 
         r= normrnd(0,s,size(x));
    [K,~,~]  = getKernel((x+r)',xs', kparam);
    yfit= K*a;
    preds= mean((yfit-y).^2);

end