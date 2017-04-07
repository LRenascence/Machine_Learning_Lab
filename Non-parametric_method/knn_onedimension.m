function[]=knn_onedimension(data,k)
[row,~]=size(data);
%��ʼ��������������Ӧ�ĸ����ܶȵ�����
sample=zeros();
probability_density=zeros();
%������ʶ����������
index=1;
%������������[-1,4]�м��0.05ȡ
for i=-1:0.05:4
    dist=zeros(10,1);
    %��ÿ�������㣬�����䵽���ݼ���ÿ����ľ���
    for d=1:10
        dist(d)=abs(data(d)-i);
    end
    %�Ծ��������������
    dist=sort(dist);
    %���ݹ�ʽ����������ܶ�
    radius=dist(k);
    volume=radius;
    sample(index)=i;
    probability_density(index)=k/row/volume;
    index=index+1;
end
%��ͼ
figure;
plot(sample,probability_density,'b');
title(['knn and k=',num2str(k)]);
xlabel('sample');
ylabel('probability density');