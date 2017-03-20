clear all;
clc;
load sample.mat w1;
load sample.mat w2;
[row,col]=size(w1);
k=3%feature number
%prior probability
pw1=1/2;
pw2=1/2;
d=k;%vector dimention
x1=(w1(1:row,1:k)');
x2=(w2(1:row,1:k)');
%calculate expectation
Mu1=mean(x1,2);
Mu2=mean(x2,2);
%calculate covariance matrix
c1=cov(w1(1:row,1:k));
c2=cov(w2(1:row,1:k));
wrong=0;
for i=1:row
    x=(w1(i,1:k)');
    %ignore the constant
    g1=-1/2*(x-Mu1)'*inv(c1)*(x-Mu1)-1/2*log(det(c1))+1/2*log(pw1);
    g2=-1/2*(x-Mu2)'*inv(c2)*(x-Mu2)-1/2*log(det(c2))+1/2*log(pw2);
    if g1<g2
        wrong=wrong+1;
    end
    x=(w2(i,1:k)');
    g1=-1/2*(x-Mu1)'*inv(c1)*(x-Mu1)-1/2*log(det(c1))+1/2*log(pw1);
    g2=-1/2*(x-Mu2)'*inv(c2)*(x-Mu2)-1/2*log(det(c2))+1/2*log(pw2);
    if g1>g2
        wrong=wrong+1;
    end
end
result=wrong/(row*2)