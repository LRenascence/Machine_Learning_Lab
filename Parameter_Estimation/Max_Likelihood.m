clear all;
clc;
load sample_ex3.mat w1;
load sample_ex3.mat w2;

disp('ѡȡx1');
onedimention(w1,1);
disp('ѡȡx2');
onedimention(w1,2);
disp('ѡȡx3');
onedimention(w1,3);

disp('ѡȡx1,x2');
twodimention(w1,1,2);
disp('ѡȡx1,x3');
twodimention(w1,1,3);
disp('ѡȡx2,x3');
twodimention(w1,2,3);

disp('ѡȡx1,x2,x3')
threedimention(w1);

disp('����ɷ����')
calinde(w2)

