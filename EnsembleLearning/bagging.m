load sample_exp7.mat white;
data=white;
%随机选取4000个样本作为训练集，其余的作为测试集
randomindex=randperm(length(data));
traindata=zeros(4000,12);
testdata=zeros(898,12);
for i=1:4000
    traindata(i,:)=data(randomindex(i),:);
end
for i=4001:4898
    testdata(i-4000,:)=data(randomindex(i),:);
end
n=length(traindata);
%循环次数
k=10;
FinalOutput=zeros(898,1)';
Error=zeros(k,1);
for i=1:k
    %从训练样本集中有放回的取出n个样本，n为训练样本集大小
    y=randsample(n,n,1);
    subtraindata=zeros(n,12);
    for ii=1:n
        subtraindata(ii,:)=data(y(ii),:);
    end
    [TempOutput,TempErr]=bpnetwork(subtraindata,testdata);
    FinalOutput=FinalOutput+TempOutput;
    Error(i)=TempErr;
end
FinalOutput=FinalOutput/k;
testoutput=testdata(:,12)';
[normtestOutput,testout]=mapminmax(testoutput,0,1);
error=0;
for i=1:length(FinalOutput)
    error=error+abs(FinalOutput(i)-normtestOutput(i));
end
error=error/length(FinalOutput);

[~,NormalError]=bpnetwork(traindata,testdata);




