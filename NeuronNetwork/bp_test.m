%使用matlab自带的工具箱
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
traininput=traindata(1:2,:);
trainoutput=traindata(3,:);
testinput=testdata(1:2,:);
testoutput=testdata(3,:);
%归一化数据
[normInput,in] = mapminmax(traininput);
[normOutput,out] = mapminmax(trainoutput);
[normtestInput,in]=mapminmax(testinput);
% 设置网络参数  
NodeNum1 = 20; % 隐层第一层节点数     
NodeNum2 = 40;   % 隐层第二层节点数    
TypeNum = 1;   % 输出维数  
TF1 = 'tansig';TF2 = 'tansig'; TF3 = 'tansig';%各层传输函数，TF3为输出层传输函数  
net=newff(minmax(normInput),[NodeNum1,NodeNum2,TypeNum],{TF1 TF2 TF3},'traingdx');%创建四层BP网络
% 设置训练参数  
net.trainParam.epochs=10000;%训练次数设置  
net.trainParam.goal=1e-6;%训练目标设置   
net.trainParam.lr=0.01;%学习率设置
net.trainfcn='traingdm';  
%开始训练
[net,tr] = train(net,normInput,normOutput);
%用测试数据集进行模拟

[Output]=sim(net,normtestInput);
error=0;
for i=1:500
    if Output(i)>=0 && testoutput(i)==-1
        error=error+1;
    end
    if Output(i)<0 && testoutput(i)==1
        error=error+1;
    end
    if Output(i)>=0
        plot(testinput(1,i),testinput(2,i),'r.');
        hold on;
    else
        plot(testinput(1,i),testinput(2,i),'b.');
        hold on;
    end
end
result=(500-error)/500