function membtrn=mbtrn(a,b,c)
% function create transformation matrices
% membtrn is 6X6 matrix such that kglobal=membtrn*klocal*membtrn'
% a is member index
% b is member details
% c is joint details
membtrn=zeros(6);
[w,~]=lng(a,b,c);
w=w';
e=trn(b(a,2),c);
h=e*w;
membtrn(1:3,1:3)=h;
e=trn(b(a,3),c);
h=e*w;
membtrn(4:6,4:6)=h;