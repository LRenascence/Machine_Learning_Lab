function [a,k]=Gradient_Decent(data,eta,theta);

%获取样本点的个数和维度
[row,col]=size(data);
%初始化权向量
a=[1;data(1,:)'];
%记录相关值来画图
kvalue=zeros();
jvalue=zeros();
index=0
while true
    index=index+1;
    %准则函数
    j=0;
    delta_j=zeros(3,1);
    for i=1:row
        %将数据点升维
        y=[1;data(i,:)'];
        %对于分错的点才进行迭代
        if a'*y<0
            j=j+power(a'*y-1,2)/power(norm(y),2);
            delta_j=delta_j+((a'*y-1)/power(norm(y),2)*y);
        end
    end
    j=0.5*j;
    %对权向量a进行更新
    a=a-eta*delta_j;
    kvalue(index)=index;
    jvalue(index)=j;
    %如果变化量小于设定阈值，退出
    if abs(eta*delta_j)<theta
        break;
    end
end
k=kvalue(index);
%第三问需将下列语句注释，否则会产生大量结果图
figure;
plot(kvalue,jvalue,'b-');

