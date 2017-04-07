function[]=knn_threedimension(w1,w2,w3,k,x)
[row,col]=size(w1);
index=1;
dist=zeros(30,2);
%计算样本点对w1数据集中所有点的距离，并将其所属类型存储
for i=1:row
    for j=1:col
        dist(index,1)=dist(index,1)+(w1(i,j)-x(j))^2;
    end
    dist(index,1)=sqrt(dist(index,1));
    dist(index,2)=1;
    index=index+1;
end
%计算样本点对w2数据集中所有点的距离，并将其所属类型存储
for i=1:row
    for j=1:col
        dist(index,1)=dist(index,1)+(w1(i,j)-x(j))^2;
    end
    dist(index,1)=sqrt(dist(index,1));
    dist(index,2)=2;
    index=index+1;
end
%计算样本点对w3数据集中所有点的距离，并将其所属类型存储
for i=1:row
    for j=1:col
        dist(index,1)=dist(index,1)+(w1(i,j)-x(j))^2;
    end
    dist(index,1)=sqrt(dist(index,1));
    dist(index,2)=3;
    index=index+1;
end
%%对距离进行升序排列
dist=sortrows(dist,1);
%统计在距离最近的前k个点中，选出同一类别出现次数最多的数目作为ki
table=tabulate(dist(1:k,2));
ki=max(table(:,2));
%根据公式计算概率密度
radius=dist(k);
volume=3/4*pi*radius^3;
probability_density=ki/(row*3)/volume;
disp(['该点[',num2str(x(1)),',',num2str(x(2)),',',num2str(x(3)),']的概率密度',num2str(probability_density),',k=',num2str(k)]);

