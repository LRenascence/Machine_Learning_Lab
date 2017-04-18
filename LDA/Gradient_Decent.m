function [a,k]=Gradient_Decent(data,eta,theta);

%��ȡ������ĸ�����ά��
[row,col]=size(data);
%��ʼ��Ȩ����
a=[1;data(1,:)'];
%��¼���ֵ����ͼ
kvalue=zeros();
jvalue=zeros();
index=0
while true
    index=index+1;
    %׼����
    j=0;
    delta_j=zeros(3,1);
    for i=1:row
        %�����ݵ���ά
        y=[1;data(i,:)'];
        %���ڷִ�ĵ�Ž��е���
        if a'*y<0
            j=j+power(a'*y-1,2)/power(norm(y),2);
            delta_j=delta_j+((a'*y-1)/power(norm(y),2)*y);
        end
    end
    j=0.5*j;
    %��Ȩ����a���и���
    a=a-eta*delta_j;
    kvalue(index)=index;
    jvalue(index)=j;
    %����仯��С���趨��ֵ���˳�
    if abs(eta*delta_j)<theta
        break;
    end
end
k=kvalue(index);
%�������轫�������ע�ͣ����������������ͼ
figure;
plot(kvalue,jvalue,'b-');

