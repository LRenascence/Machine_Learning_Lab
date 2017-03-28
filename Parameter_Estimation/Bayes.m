clear all;
clc;
load sample_ex3.mat w2;
[row,col]=size(w2);
x2=w2(1:row,2);
%�趨u��delta�ķ�Χ
mu=-5:0.1:5;
delta=-3:0.1:3;
m=length(mu);
n=length(delta);
%��������������
PDTheta=ones(m,n);
PTheta=zeros(m,n);
PProduct=ones(m,n);%PProduct=p(D|theta)*p(theta)
PSum=0;%PSum=Sigma(p(D|theta)*p(theta))
%����P(D|theta)������
for i=1:m
    for j=1:n
        for k=1:row
            PDTheta(i,j)=PDTheta(i,j)*T(x2(k),mu(i),delta(j));
        end
    end
end
for i=1:m
    for j=1:n
        %�ٶ�Mu��Theta���ϸ�˹�ֲ�
        PTheta(i,j)=normpdf(mu(i),0,1)*normpdf(delta(j),0,1);
        PProduct(i,j)=PDTheta(i,j)*PTheta(i,j);
        PSum=PSum+PProduct(i,j);
    end
end
PThetaD=PProduct/PSum;
%�õ�P(theta|D)��,�Ϳ��Լ���P(X|D)��
x=-0.5:0.01:1.5;
PXD=zeros(length(x),1);
for row=1:length(x)
    %P(x|D)=Sigma(P(x|theta)*p(theta|D))
    for i=1:m;
        for j=1:n;
           PXTheta=T(x(row),mu(i),delta(j));
           PXD(row)=PXD(row)+PXTheta*PThetaD(i,j);
        end
    end
    plot(x(row),PXD(row),'b.');
    hold on;
end

