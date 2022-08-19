function PLOT(error_mean,error_std,r,TV)
figure
Lower=error_mean - r*error_std;
Upper=error_mean + r*error_std;
colors=["r","b","k","m"];
Fc = [0.92 0.82 0.82;0.73 0.78 0.94;0.9 0.9 0.9;0.9 0.83 0.9];
S=linspace(0,5,50);

hold all
for i=1:4
    
    L=Lower(i,:);U=Upper(i,:);
patch([S  fliplr(S)], [L fliplr(U)],Fc(i,:),'EdgeColor','white')


end

for i=1:4
  
    plot(S,error_mean(i,:),'LineWidth',1,'Color',colors(i));
end
hold off

legend("","","","","R-LS","WRLS","DRDA","W-DRO")
box on

