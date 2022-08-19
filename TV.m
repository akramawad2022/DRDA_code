function T=TV(a)
T=0; mu=movmean(a,5); 
a1=a-mu;
for i=1:length(a1)-1
   T = T+ abs(a1(i+1)-a1(i));
 
end

end