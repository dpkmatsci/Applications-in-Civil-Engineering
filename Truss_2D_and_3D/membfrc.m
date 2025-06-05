function [x,y]=membfrc(a,b,c,d,e,f)
%x represents forces in individual members in KN
%y represents strsses in individual members in MPa
% a is member details
% b is global joint displacement
% c is joint co-ordinate details
% d is joint angle details
% e is member fabrication error
% f is member details subjected to temperature difference
 klcl=zeros(6);
 klcl(1,1)=1;
 klcl(1,4)=-1;
 klcl(4,1)=-1;
 klcl(4,4)=1;
ee=size(e);
ff=size(f);
aa=size(a);
if ee(1,1)~=0
   for i=1:aa(1,1)
       enew(i,1)=0;
   end
   for i=1:ee(1,1)
       enew(e(i,1),1)=e(i,2);
   end
end
if ff(1,1)~=0
   for i=1:aa(1,1)
       fnew(i,1)=0;
       fnew(i,2)=0;
   end
   for i=1:ff(1,1)
       fnew(f(i,1),1)=f(i,2);
       fnew(f(i,1),2)=f(i,3);
   end
end
for i=1:aa(1,1)
    [lngt,trns]=trnsfrm(a(i,1),a,d,c);
    gh(1:3,1)=b(3*a(i,2)-2:3*a(i,2),1);
    gh(4:6,1)=b(3*a(i,3)-2:3*a(i,3),1);
    dlocal=trns'*gh;
    plocal=a(i,4)*a(i,5)/(lngt*1000)*klcl*dlocal;
    frc=plocal(4,1);
    if ee(1,1)~=0
        frc=frc-a(i,4)*a(i,5)*enew(i,1)/lngt;
    end
    if ff(1,1)~=0
        frc=frc-a(i,4)*a(i,5)*fnew(i,1)*fnew(i,2);
    end
    xx(i,1)=frc;
    yy(i,1)=frc/a(i,5)*1000;
end
y=yy;
x=xx;
   
    