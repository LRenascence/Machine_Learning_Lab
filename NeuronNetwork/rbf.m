load Data-Ass2.mat data;
%���ѡȡ2500��������Ϊѵ�������������Ϊ���Լ�
randomindex=randperm(length(data));
traindata=zeros(3,2500);
testdata=zeros(3,500);
for i=1:2500
    traindata(:,i)=data(:,randomindex(i));
end
for i=2501:3000
    testdata(:,i-2500)=data(:,randomindex(i));
end
%����������ֿ�
traininput=traindata(1:2,:)';
trainoutput=traindata(3,:)';
testinput=testdata(1:2,:)';
testoutput=testdata(3,:)';
%����kmeans������ȡ���ĵ�λ��
k=5;
[~,center,~,dist]=kmeans(traininput,k,'Start','uniform');
%ȷ���ҵ�ȡֵ����������֯ѡ��
sigma=zeros(k,1);
for i=1:k
    min=intmax;
    for j=1:k
        if i==j
            continue;
        end
        temp=pdist(center([i,j],:),'euclidean');
        if min>temp
            min=temp;
        end
    end
    sigma(i)=min;
end
%�ø�˹�����������
phi=zeros(2500,k);
for i=1:k
    phi(:,i)=exp(dist(:,i)/(2*sigma(i)^2));
end
%���Ȩֵ
w=inv(phi'*phi)*phi'*trainoutput;
%���Բ�������
error=0;
resultoutput=zeros(500,1);
for i=1:500
    test_phi=zeros(k,1);
    for j=1:k
        test_phi(j)=pdist([testinput(i,:);center(j,:)],'euclidean');
    end
    y=test_phi'*w;
    if y>=0 && testoutput(i)==-1
        error=error+1;
    end
    if y<0 && testoutput(i)==1
        error=error+1;
    end
    resultoutput(i)=y;
end
for i=1:500
    if resultoutput(i)>=0
        plot(testinput(i,1),testinput(i,2),'r.');
        hold on;
    else
        plot(testinput(i,1),testinput(i,2),'b.');
        hold on;
    end
end
for i=1:k
    plot(center(i,1),center(i,2),'k+');
end
percision=(500-error)/500
