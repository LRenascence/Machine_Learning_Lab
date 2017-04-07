function []=parzen(data,x,h)
[row,col]=size(data);
hn=h/sqrt(row);
%初始化属于不同类别的概率
p=zeros(3,1);
%对不同类别进行循环判断
for i=1:3
    %对同一类别的样本进行循环判断
    for j=1:row
        xi=data(j,[(i-1)*3+1:i*3])';
        %为了使积分为1，有个1/sqrt(2*pi)的因子，但由于结果是作比较用，其实加不加不影响结果
        p(i)=p(i)+1/hn * exp(-(x-xi)'*(x-xi)/(2*hn^2))/sqrt(2*pi);
    end
end
[~,index]=max(p);
disp(['该点[',num2str(x(1)),',',num2str(x(2)),',',num2str(x(3)),']属于第',num2str(index),'类,h=',num2str(h)]);
