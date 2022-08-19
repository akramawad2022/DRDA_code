function [K, param,K2] = getKernel(featuresA, featuresB, param)
if (nargin < 2)
    error('Not enough inputs!\n');
elseif (nargin < 3)
    param = featuresB;
    featuresB = featuresA;
end

[dA nA] = size(featuresA);
[dB nB] = size(featuresB);

assert(dA == dB);

sq_dist = L2_distance_2(featuresA, featuresB);



if(~isfield(param, 'gamma'))    
    
        sigma= sqrt(0.5*mean(mean(sq_dist)));
else 
    sigma=1;

       
end
 gamma     = 1/(2*sigma^2);

K = exp(-sq_dist*gamma);
K2 = exp(-0.5*sq_dist*gamma);
