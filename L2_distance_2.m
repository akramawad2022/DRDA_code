function n2 = L2_distance_2(x,c,df)



if nargin < 3
    df = 0;
end
[dimx, ndata] = size(x);
[dimc, ncentres] = size(c);
if dimx ~= dimc
	error('Data dimension does not match dimension of centres')
end

n2 = (ones(ncentres, 1) * sum((x.^2), 1))' + ...
  		ones(ndata, 1) * sum((c.^2),1) - ...
  		2.*(x'*(c));
% make sure result is all real
n2 = real(full(n2)); 
n2(n2<0) = 0;
% force 0 on the diagonal? 
if (df==1)
  n2 = n2.*(1-eye(size(n2)));
end