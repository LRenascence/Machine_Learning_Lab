clear all;
clc;
%initialization
load 3d-data r;
%load 2d-data r;
k=7;
D=r;
[row,col]=size(D);
center=zeros(k,col);
c=cell(1,k);%cell store cluster
%pick the smallest sum of coordinate as the first center
min=Inf;
index=1;
for i=1:row
    position=0;
    for cc=1:col
        position=position+D(i,cc);
    end
    if position<min
        min=position;
        index=i;
    end
end
center(1,1:col)=D(index,1:col);
%each time pick the furthest point as the next center
for j=2:k
    max=0;
    index=1;
    for i =1:row
        min=Inf;
         for jj=1:j-1
             dis=0;
             for cc=1:col
                 dis=dis+(center(jj,cc)-D(i,cc))^2;
             end
             if dis<min
                 min=dis;
             end
         end
        if min>max
            max=min;
            index=i;
        end
    end
    center(j,1:col)=D(index,1:col);
end
change=true;
count=1;
%loop
while change && count<100
    count=count+1;
    change=false;
    for i=1:row
        min=Inf;
        index=1;
        for j=1:k
            dis=0;
            %calculate the distance
            for cc=1:col
                dis=dis+(D(i,cc)-center(j,cc))^2;
            end
            if dis<min
                min=dis;
                index=j;
            end
        end
        %add point to its cluster
        c{1,index}(1,length(c{1,index})+1)=i;
    end
    for i=1:k
        NewCenter(1,1:col)=D(c{1,i}(1,1),1:col);
        %calculate new center position
        for j=2:length(c{1,i})
            for cc=1:col
                NewCenter(1,cc)=NewCenter(1,cc)+D(c{1,i}(1,j),cc);
            end
        end
        for cc=1:col
            NewCenter(1,cc)=NewCenter(1,cc)/length(c{1,i});
        end
        %judge if center position change
        for cc=1:col
            if NewCenter(1,cc)~=center(i,cc)
                change=true;
            end
        end
        center(i,1:col)=NewCenter(1,1:col);
    end
end
color={'b.','g.','r.','c.','m.','y.','k.'}
if col==2
    for i=1:k
        for j=1:length(c{1,i})
            plot(D(c{1,i}(1,j),1),D(c{1,i}(1,j),2),color{1,i});
            hold on
        end
        plot(center(i,1),center(i,2),'k+');
        hold on
    end
end
if col==3
    for i=1:k
        for j=1:length(c{1,i})
            plot3(D(c{1,i}(1,j),1),D(c{1,i}(1,j),2),D(c{1,i}(1,j),3),color{1,i});
            hold on
        end
        plot3(center(i,1),center(i,2),center(i,3),'k+');
        hold on
    end
end


