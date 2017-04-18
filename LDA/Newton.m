function [a]=Newton(data,theta)
%获取样本点的个数和维度
[row,col]=size(data);
%初始化权向量
a=[1;data(1,:)'];
%记录迭代次数
kvalue=zeros();
jvalue=zeros();
index=0;
while true
    index=index+1;
    %准则函数
    j=0;
    delta_j=zeros(3,1);
    %初始化何森矩阵
    H=zeros(3);
    for i=1:row
        %对样本点进行升维
        y=[1;data(i,:)'];
        %对分错的点进行迭代
        if a'*y<0
            j=j+(a'*y)^2;
            delta_j=delta_j+(a'*y)*y;
            H=H+y*y';
        end
    end
    j=0.5*j;
    %对权向量a进行更新
    a=a-inv(H)*delta_j;
    kvalue(index)=index;
    jvalue(index)=j;
    %如果变化量小于阈值，退出
    if abs(inv(H)*delta_j)<theta
        break;
    end
end
figure;
plot(kvalue,jvalue,'b-');
