function []=parzen(data,x,h)
[row,col]=size(data);
hn=h/sqrt(row);
%��ʼ�����ڲ�ͬ���ĸ���
p=zeros(3,1);
%�Բ�ͬ������ѭ���ж�
for i=1:3
    %��ͬһ������������ѭ���ж�
    for j=1:row
        xi=data(j,[(i-1)*3+1:i*3])';
        %Ϊ��ʹ����Ϊ1���и�1/sqrt(2*pi)�����ӣ������ڽ�������Ƚ��ã���ʵ�Ӳ��Ӳ�Ӱ����
        p(i)=p(i)+1/hn * exp(-(x-xi)'*(x-xi)/(2*hn^2))/sqrt(2*pi);
    end
end
[~,index]=max(p);
disp(['�õ�[',num2str(x(1)),',',num2str(x(2)),',',num2str(x(3)),']���ڵ�',num2str(index),'��,h=',num2str(h)]);
