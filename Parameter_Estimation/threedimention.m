function[]=threedimention(w1)
[row,col]=size(w1);
x=w1(1:row,1:col);
Mu=mean(x)
co=cov(x,1)