function membstiff=mbstiff(a,b,c,p,e)
% this progra is written for calculation of member stiffness matrix
% including geometric stiffness in local member co-ordinate
% a is member index
% b is member detail
% c is joint detail
% p is axial force vector
% e is unit detail
su=strcmpi('si',e);
if su==1
    mult=1000000;
else
    mult=144;
end
[~,lngt]=lng(a,b,c);
ginl=zeros(6);
    ginl(2,2)=1.2/lngt;
    ginl(2,3)=.1;
    ginl(2,5)=-1.2/lngt;
    ginl(2,6)=.1;
    ginl(3,2)=.1;
    ginl(3,3)=2*lngt/15;
    ginl(3,5)=-.1;
    ginl(3,6)=-lngt/30;
    ginl(5,2)=-1.2/lngt;
    ginl(5,3)=-.1;
    ginl(5,5)=1.2/lngt;
    ginl(5,6)=-.1;
    ginl(6,2)=.1;
    ginl(6,3)=-lngt/30;
    ginl(6,5)=-.1;
    ginl(6,6)=2*lngt/30;
    ginl=ginl*p(a,1);
    kloc=zeros(6);
    kloc(1,1)=b(a,4)*b(a,6)/(lngt);
    kloc(2,2)=12*b(a,5)*b(a,6)/(mult*lngt^3);
    kloc(2,3)=6*b(a,5)*b(a,6)/(mult*lngt^2);
    kloc(3,3)=4*b(a,5)*b(a,6)/(mult*lngt);
    kloc(4,4)=kloc(1,1);
    kloc(1,4)=-kloc(1,1);
    kloc(4,1)=kloc(1,4);
    kloc(2,5)=-kloc(2,2);
    kloc(2,6)=kloc(2,3);
    kloc(3,2)=kloc(2,3);
    kloc(3,5)=-kloc(3,2);
    kloc(3,6)=.5*kloc(3,3);
    kloc(5,2)=kloc(2,5);
    kloc(5,3)=kloc(3,5);
    kloc(5,5)=kloc(2,2);
    kloc(5,6)=kloc(5,3);
    kloc(6,2)=kloc(2,6);
    kloc(6,3)=kloc(3,6);
    kloc(6,5)=kloc(5,6);
    kloc(6,6)=kloc(3,3);
    membstiff=kloc+ginl;
