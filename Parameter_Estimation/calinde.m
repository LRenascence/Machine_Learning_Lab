function[]=inden(w2)
[row,col]=size(w2);
Mu=mean(w2)
x1=w2(1:row,1);
x2=w2(1:row,2);
x3=w2(1:row,3);
co1=cov(x1,1);
co2=cov(x2,1);
co3=cov(x3,1);
co=diag([co1;co2;co3])