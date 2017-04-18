load sample_ex5.mat w1 w3
%认为w1为正例，w3为负例
w3=-w3;
data=[w1;w3];
%基本梯度下降法
[a,k]=Gradient_Decent(data,0.1,1e-5)
%牛顿法
a=Newton(data,1e-5);
% %运行第三问需先将梯度下降函数中相关语句注释
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
