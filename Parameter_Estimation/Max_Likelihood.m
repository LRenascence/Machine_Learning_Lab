clear all;
clc;
load sample_ex3.mat w1;
load sample_ex3.mat w2;

disp('选取x1');
onedimention(w1,1);
disp('选取x2');
onedimention(w1,2);
disp('选取x3');
onedimention(w1,3);

disp('选取x1,x2');
twodimention(w1,1,2);
disp('选取x1,x3');
twodimention(w1,1,3);
disp('选取x2,x3');
twodimention(w1,2,3);

disp('选取x1,x2,x3')
threedimention(w1);

disp('计算可分离的')
calinde(w2)

