function [Output,error]=bpnetwork(traindata,testdata)
%����������ֿ�
traininput=traindata(:,1:11)';
trainoutput=traindata(:,12)';
testinput=testdata(:,1:11)';
testoutput=testdata(:,12)';
%��һ������
[normInput,~] = mapminmax(traininput,0,1);
[normOutput,~] = mapminmax(trainoutput,0,1);
[normtestInput,~]=mapminmax(testinput,0,1);
[normtestOutput,~]=mapminmax(testoutput,0,1);
% �����������  
NodeNum1 = 20; % �����һ��ڵ���     
NodeNum2 = 40;   % ����ڶ���ڵ���    
TypeNum = 1;   % ���ά��  
TF1 = 'tansig';TF2 = 'tansig'; TF3 = 'tansig';%���㴫�亯����TF3Ϊ����㴫�亯��  
net=newff(minmax(normInput),[NodeNum1,NodeNum2,TypeNum],{TF1 TF2 TF3},'traingdx');%�����Ĳ�BP����
% ����ѵ������  
net.trainParam.epochs=10000;%ѵ����������  
net.trainParam.goal=1e-6;%ѵ��Ŀ������   
net.trainParam.lr=0.01;%ѧϰ������
net.trainfcn='traingdm';  
%��ʼѵ��
[net,tr] = train(net,normInput,normOutput);
%�ò������ݼ�����ģ��
[Output]=sim(net,normtestInput);
error=0;
for i=1:length(Output)
    error=error+abs(Output(i)-normtestOutput(i));
end
error=error/length(Output);