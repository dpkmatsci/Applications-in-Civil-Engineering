function y=forcefab(a,b,c,d)
% in an attempt to solve eqn.
% globalforce=stiffness*globaldisp+forcetemp+forcefab
% this function returns the forcefab arised due to fabrication error
% a is matrix with member details
% b is matrix with details of fabrication error
% c is joint detail
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
        [lngt,trns]=trnsfrm(b(i,1),a,d,c);
        ftm(1,1)=a(b(i,1),4)*a(b(i,1),5)*b(i,2)/lngt;
        ftm(2,1)=0;
        ftm(3,1)=0;
        ftm(4,1)=-ftm(1,1);
        ftm(5,1)=0;
        ftm(6,1)=0;
        ftl=trns*ftm;
        yyy(3*a(b(i,1),2)-2:3*a(b(i,1),2))=ftl(1:3,1);
        yyy(3*a(b(i,1),3)-2:3*a(b(i,1),3))=ftl(4:6,1);
        fans=fans+yyy;
    end
    y=fans;
end

        