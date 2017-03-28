function[]=onedimention(w1,pickcol)
[row,col]=size(w1);
x=w1(1:row,pickcol);
Mu=mean(x)
co=cov(x,1)