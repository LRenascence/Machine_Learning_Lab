function value=T(x,mu,delta)
if abs(x-mu)<delta
    value=(delta-abs(x-mu))/delta^2;
else
    value=0;
end