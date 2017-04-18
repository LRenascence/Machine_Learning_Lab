function [a]=Newton(data,theta)
%��ȡ������ĸ�����ά��
[row,col]=size(data);
%��ʼ��Ȩ����
a=[1;data(1,:)'];
%��¼��������
kvalue=zeros();
jvalue=zeros();
index=0;
while true
    index=index+1;
    %׼����
    j=0;
    delta_j=zeros(3,1);
    %��ʼ����ɭ����
    H=zeros(3);
    for i=1:row
        %�������������ά
        y=[1;data(i,:)'];
        %�Էִ�ĵ���е���
        if a'*y<0
            j=j+(a'*y)^2;
            delta_j=delta_j+(a'*y)*y;
            H=H+y*y';
        end
    end
    j=0.5*j;
    %��Ȩ����a���и���
    a=a-inv(H)*delta_j;
    kvalue(index)=index;
    jvalue(index)=j;
    %����仯��С����ֵ���˳�
    if abs(inv(H)*delta_j)<theta
        break;
    end
end
figure;
plot(kvalue,jvalue,'b-');
