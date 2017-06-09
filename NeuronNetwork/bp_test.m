%ʹ��matlab�Դ��Ĺ�����
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
traininput=traindata(1:2,:);
trainoutput=traindata(3,:);
testinput=testdata(1:2,:);
testoutput=testdata(3,:);
%��һ������
[normInput,in] = mapminmax(traininput);
[normOutput,out] = mapminmax(trainoutput);
[normtestInput,in]=mapminmax(testinput);
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