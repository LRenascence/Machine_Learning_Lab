load sample_ex5.mat w1 w3
%��Ϊw1Ϊ������w3Ϊ����
w3=-w3;
data=[w1;w3];
%�����ݶ��½���
[a,k]=Gradient_Decent(data,0.1,1e-5)
%ţ�ٷ�
a=Newton(data,1e-5);
% %���е��������Ƚ��ݶ��½�������������ע��
% figure;
% x=zeros();
% y=zeros();
% index=1;
% for eta=0:0.01:0.7
%     [~,k]=Gradient_Decent(data,eta,1e-10);
%     x(index)=eta;
%     y(index)=k;
%     index=index+1;
% end
% plot(x,y,'b-');
% hold on;
