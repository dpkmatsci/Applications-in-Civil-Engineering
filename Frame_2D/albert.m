function [frc,dsp]=albert(a,b,c)
% this function is created to solve the matrix 
% a is force matrix
% b is displacement matrix
% c is global stiffness matrix  a=c*b
q=isnan(a);
w=isnan(b);
k=1;
for i=1:size(a,1)
    if q(i,1)==0 && w(i,1)==1
        ty(1,k)=i;
        k=k+1;
    end
end
t=k-1;
for i=1:size(a,1)
    if q(i,1)==1 && w(i,1)==0
        ty(1,k)=i;
        k=k+1;
    end
end
tt=k-1;
for i=1:size(a,1)
    if q(i,1)==0 && w(i,1)==0
        ty(1,k)=i;
        k=k+1;
    end
end
ttt=k-1;
for i=1:size(ty,2)
    anew(i,1)=a(ty(1,i),1);
    bnew(i,1)=b(ty(1,i),1);
    cnn(i,:)=c(ty(1,i),:);
end
for i=1:size(ty,2)
    cnew(:,i)=cnn(:,ty(1,i));
end
bnew(1:t,1)=cnew(1:t,1:t)\(anew(1:t,1)-cnew(1:t,t+1:tt)*bnew(t+1:tt,1));
anew(t+1:tt,1)=cnew(t+1:tt,1:tt)*bnew(1:tt);
aanw=zeros(ttt,1);
bbnw=zeros(ttt,1);
for i=1:size(ty,2)
    aanw(ty(1,i),1)=anew(i,1);
    bbnw(ty(1,i),1)=bnew(i,1);
end
frc=aanw;
dsp=bbnw;
