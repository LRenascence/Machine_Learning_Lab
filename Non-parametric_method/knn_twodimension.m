function[]=knn_twodimension(data,k)
[row,~]=size(data);
%��ʼ��������������Ӧ�ĸ����ܶȵ�����
sample=zeros();
probability_density=zeros();
%������ʶ����������
index=1;
%������������[(-1,-1),(4,4)]�м��0.05ȡ
for i=-1:0.05:4
    for j=-1:0.05:4
        dist=zeros(10,1);
        %��ÿ�������㣬�����䵽���ݼ���ÿ����ľ���
        for d=1:10
            dist(d)=sqrt((data(d,1)-i)^2+(data(d,2)-j)^2);
        end
        %�Ծ��������������
        dist=sort(dist);
        %���ݹ�ʽ����������ܶ�
        radius=dist(k);
        volume=radius^2*pi;
        sample(index,1)=i;
        sample(index,2)=j;
        probability_density(index)=k/row/volume;
        index=index+1;
    end
end
%��ͼ
figure;
plot3(sample(:,1),sample(:,2),probability_density,'b');
title(['knn and k=',num2str(k)]);
xlabel('sample x value');
ylabel('sample y value');
zlabel('probability density');