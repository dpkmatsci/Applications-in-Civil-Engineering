function [frcenew,dispnew]=issac(a,b,c,d,e)
%here we are going to solve equation: a=c*b+d+e
% frcenew and dispnew represents solved a and b respectively
% a represents force matrix
% b represents displacement matrix
% c is global stiffness matrix
% d representd forcetemp matrix
% e is forcefab matrix
aa=size(a);
qw=isnan(a);
wq=isnan(b);
t=1;
for i=1:aa(1,1)
    if qw(i,1)==0 && wq(i,1)==1
        ty(t,1)=i;
        t=t+1;
    end
end
t=size(ty,1);
ttt=t;
for i=1:aa(1,1)
    if qw(i,1)==1 && wq(i,1)==0
        t=t+1;
        ty(t,1)=i;
    end
end
t=size(ty,1);
tt=t;
if t<aa(1,1)
    for i=1:aa(1,1)
       if qw(i,1)==0 && wq(i,1)==0
           t=t+1;
           ty(t,1)=i;
       end
    end
end
for i=1:tt
    anew(i,1)=a(ty(i,1),1);
    bnew(i,1)=b(ty(i,1),1);
    dnew(i,1)=d(ty(i,1),1);
    enew(i,1)=e(ty(i,1),1);
    cinl(i,:)=c(ty(i,1),:);
end
% here it should be noted that force and displacement matrices are arranged
% in rows only while stiffness matrix is arranged in both direction row as
% well as columns.
for j=1:tt
    cnew(:,j)=cinl(:,ty(j,1));
end
bnew(1:ttt,1)=cnew(1:ttt,1:ttt)\(anew(1:ttt,1)-dnew(1:ttt,1)-enew(1:ttt,1)-cnew(1:ttt,ttt+1:tt)*bnew(ttt+1:tt,1));
anew(ttt+1:tt,1)=cnew(ttt+1:tt,:)*bnew(:,1)+dnew(ttt+1:tt,1)+enew(ttt+1:tt,1);
for i=1:aa(1,1)
    fcnw(i,1)=0;
    dspnw(i,1)=0;
end
for i=1:tt
    fcnw(ty(i,1),1)=anew(i,1);
    dspnw(ty(i,1),1)=bnew(i,1);
end
frcenew=fcnw;
dispnew=dspnw;






        

