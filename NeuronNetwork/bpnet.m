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
%开始训练
%设定参数
layer=3;
neuron=5;
maxiteration=1000;
eta=0.01;
w12=rand(2,neuron);
wmid=rand(neuron,neuron,2);
w45=rand(neuron,1);
vmid=zeros(neuron,3);
ymid=zeros(neuron,3);
sigmamid=zeros(neuron,3);
v=0;
y=0;
for i=1:maxiteration
    for ii=1:length(normInput)
        %输入层
        for j=1:neuron
            vmid(j,1)=w12(:,j)'*traininput(:,ii);
            ymid(j,1)=1/(1+exp(-vmid(j,1)));
        end
        %中间层
        for l=1:layer-1
            for j=1:neuron
                vmid(j,l+1)=wmid(:,j,l)'*ymid(:,l);
                ymid(j,l+1)=1/(1+exp(-vmid(j,1+1)));
            end
        end
        %输出层
        v=w45'*ymid(:,3);
        y=1/(1+exp(-v));
        %计算误差
        E=1/2*(normOutput(ii)-y)^2;
        %更新权值
        %输出层
        for j=1:neuron
            sigma=(trainoutput(ii)-y)*y*(1-y);
            w45(j)=w45(j)+eta*sigma*ymid(j,3);
        end
        %输出层前一层
        for j=1:neuron
            sigmamid(j,3)=ymid(j,3)*(1-ymid(j,3))*sigma*w45(j);
            for jj=1:neuron
                wmid(jj,j,2)=wmid(jj,j,2)+eta*sigmamid(j,3)*ymid(jj,2);
            end
        end
        %输出层前两层
        for j=1:neuron
            for k=1:neuron
                sigmamid(j,2)=ymid(j,2)*(1-ymid(j,2))*sigmamid(j,2)+sigmamid(j,3)*wmid(j,k,2);
            end
            for jj=1:neuron
                wmid(jj,j,1)=wmid(jj,j,1)+eta*sigmamid(j,2)*ymid(jj,1);
            end
        end
        %maybe last
        for j=1:neuron
            for k=1:neuron
                sigmamid(j,1)=ymid(j,1)*(1-ymid(j,1))*sigmamid(j,1)*wmid(j,k,1);
            end
            for jj=1:2
                w12(jj,j)=w12(jj,j)+eta*sigmamid(j,1)*traininput(jj,ii);
            end
        end       
    end
end
%模拟
[normtestInput,in]=mapminmax(testinput);
error=0;
resultoutput=zeros(500,1);
for i=1:length(normtestInput)
    for j=1:neuron
        vmid(j,1)=w12(:,j)'*testinput(:,i);
        ymid(j,1)=1/(1+exp(-vmid(j,1)));
    end
    %中间层
    for l=1:layer-1
        for j=1:neuron
            vmid(j,l+1)=wmid(:,j,l)'*ymid(:,l);
            ymid(j,l+1)=1/(1+exp(-vmid(j,1+1)));
        end
    end
    %输出层
    v=w45'*ymid(:,3);
    y=1/(1+exp(-v));
    if y>=0.5 && testoutput(i)==-1
        error=error+1;
    end
    if y<0.5 && testoutput(i)==1
        error=error+1;
    end
    resultoutput(i)=y;
end
for i=1:500
    if resultoutput(i)>=0.5
        plot(testinput(1,i),testinput(2,i),'r.');
        hold on;
    else
        plot(testinput(1,i),testinput(2,i),'b.');
        hold on;
    end
end
percision=(500-error)/500