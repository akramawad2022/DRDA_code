function y= model(x)
y=exp(-0.5*(x-ones(length(x),1)).^2)-exp(-0.5*(x+ones(length(x),1)).^2);
end