function[]=knn_threedimension(w1,w2,w3,k,x)
[row,col]=size(w1);
index=1;
dist=zeros(30,2);
%�����������w1���ݼ������е�ľ��룬�������������ʹ洢
for i=1:row
    for j=1:col
        dist(index,1)=dist(index,1)+(w1(i,j)-x(j))^2;
    end
    dist(index,1)=sqrt(dist(index,1));
    dist(index,2)=1;
    index=index+1;
end
%�����������w2���ݼ������е�ľ��룬�������������ʹ洢
for i=1:row
    for j=1:col
        dist(index,1)=dist(index,1)+(w1(i,j)-x(j))^2;
    end
    dist(index,1)=sqrt(dist(index,1));
    dist(index,2)=2;
    index=index+1;
end
%�����������w3���ݼ������е�ľ��룬�������������ʹ洢
for i=1:row
    for j=1:col
        dist(index,1)=dist(index,1)+(w1(i,j)-x(j))^2;
    end
    dist(index,1)=sqrt(dist(index,1));
    dist(index,2)=3;
    index=index+1;
end
%%�Ծ��������������
dist=sortrows(dist,1);
%ͳ���ھ��������ǰk�����У�ѡ��ͬһ�����ִ���������Ŀ��Ϊki
table=tabulate(dist(1:k,2));
ki=max(table(:,2));
%���ݹ�ʽ��������ܶ�
radius=dist(k);
volume=3/4*pi*radius^3;
probability_density=ki/(row*3)/volume;
disp(['�õ�[',num2str(x(1)),',',num2str(x(2)),',',num2str(x(3)),']�ĸ����ܶ�',num2str(probability_density),',k=',num2str(k)]);

