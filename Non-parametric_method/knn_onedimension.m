function[]=knn_onedimension(data,k)
[row,~]=size(data);
%初始化存放样本点和相应的概率密度的向量
sample=zeros();
probability_density=zeros();
%用来标识样本点的序号
index=1;
%样本点在区间[-1,4]中间隔0.05取
for i=-1:0.05:4
    dist=zeros(10,1);
    %对每个样本点，计算其到数据集中每个点的距离
    for d=1:10
        dist(d)=abs(data(d)-i);
    end
    %对距离进行升序排列
    dist=sort(dist);
    %根据公式计算其概率密度
    radius=dist(k);
    volume=radius;
    sample(index)=i;
    probability_density(index)=k/row/volume;
    index=index+1;
end
%画图
figure;
plot(sample,probability_density,'b');
title(['knn and k=',num2str(k)]);
xlabel('sample');
ylabel('probability density');