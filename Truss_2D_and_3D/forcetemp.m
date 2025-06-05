function y=forcetemp(a,b,c,d)
% in an attempt to solve eqn.
% globalforce=stiffness*globaldisp+forcetemp+forcefab
% this function creates forcetemp col matrix
%a is member details
%b is matrix containing members subjected to temp. variation
%c is joint detail
% d is joint angle detail
aa=size(a);
bb=size(b);
cc=size(c);
dd=size(d);
 for i=1:3*cc(1,1)
       yy(i,1)=0;
       fans(i,1)=0;
 end
if bb(1,1)==0
   y=fans;
else
    for i=1:bb(1,1)
        yyy=yy;
        ktm(1,1)=b(i,2)*b(i,3)*a(b(i,1),4)*a(b(i,1),5);
        ktm(2,1)=0;
        ktm(3,1)=0;
        ktm(4,1)=-ktm(1,1);
        ktm(5,1)=0;
        ktm(6,1)=0;
        [lmu,trns]=trnsfrm(b(i,1),a,d,c);
        ios=trns*ktm;
        yyy(3*a(b(i,1),2)-2:3*a(b(i,1),2),1)=ios(1:3,1);
        yyy(3*a(b(i,1),3)-2:3*a(b(i,1),3),1)=ios(4:6,1);
        fans=fans+yyy;
    end
    y=fans;
end

        
        