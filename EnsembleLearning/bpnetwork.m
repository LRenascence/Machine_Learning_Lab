function [Output,error]=bpnetwork(traindata,testdata)
%将输入输出分开
traininput=traindata(:,1:11)';
trainoutput=traindata(:,12)';
testinput=testdata(:,1:11)';
testoutput=testdata(:,12)';
%归一化数据
[normInput,~] = mapminmax(traininput,0,1);
[normOutput,~] = mapminmax(trainoutput,0,1);
[normtestInput,~]=mapminmax(testinput,0,1);
[normtestOutput,~]=mapminmax(testoutput,0,1);
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
for i=1:length(Output)
    error=error+abs(Output(i)-normtestOutput(i));
end
error=error/length(Output);