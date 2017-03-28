function[]=twodimention(w1,pickcol1,pickcol2)
[row,col]=size(w1);
x=w1(1:row,[pickcol1,pickcol2]);
Mu=mean(x)
co=cov(x,1)
