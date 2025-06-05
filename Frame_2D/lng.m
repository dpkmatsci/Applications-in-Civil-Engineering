function [lodtrn,lngt]=lng(a,b,c)
% this function is written to calculate the length of ath member with b as
% memeber details and c as joint details
% lodtrn is 3X3 matrix in such a manner load in memberdirection=lodtrn*load in global direction 
q=b(a,2:3);
w=c(q(1,1),2:3);
e=c(q(1,2),2:3);
lngt=norm(w-e);
lodtrn=zeros(3);
lodtrn(3,3)=1;
lodtrn(1,1)=(e(1,1)-w(1,1))/lngt;
lodtrn(2,2)=lodtrn(1,1);
lodtrn(1,2)=(e(1,2)-w(1,2))/lngt;
lodtrn(2,1)=-lodtrn(1,2);