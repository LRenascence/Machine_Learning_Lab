%使用自带的svm工具箱
load Data-Ass2.mat data;
%随机选取2500个样本作为训练集，其余的作为测试集
randomindex=randperm(length(data));
traindata=zeros(3,2500);
testdata=zeros(3,500);
for i=1:2500
    traindata(:,i)=data(:,randomindex(i));
end
for i=2501:3000
    testdata(:,i-2500)=data(:,randomindex(i));
end
%将输入输出分开
traininput=traindata(1:2,:)';
trainoutput=traindata(3,:)';
testinput=testdata(1:2,:)';
testoutput=testdata(3,:)';
%训练模型
figure;
model=svmtrain(traininput,trainoutput,'showplot',true);
%用测试数据集模拟
resultoutput=svmclassify(model,testinput);
figure;
error=0;
for i=1:500
    if resultoutput(i)>=0 && testoutput(i)==-1
        error=error+1;
    end
    if resultoutput(i)<0 && testoutput(i)==1
        error=error+1;
    end
    if resultoutput(i)>=0
        plot(testinput(i,1),testinput(i,2),'r.');
        hold on;
    else
        plot(testinput(i,1),testinput(i,2),'b.');
        hold on;
    end
end
result=(500-error)/500