function rslt=triload(a,b,c,d,e)
% function is created for determination of joint load due to linearly
% distributed load. a is load matrix while b is load detail like global or
% local. c is member degree of freedom matric while d is member details and
% e is joint details
syms x l;
n(1,1)=1-x/l;
n(1,2)=x/l;
n(1,3)=(2*x^3-3*x^2*l+l^3)/l^3;
n(1,4)=(x^3*l-2*x^2*l^2+x*l^3)/l^3;
n(1,5)=(-2*x^3+3*x^2*l)/l^3;
n(1,6)=(x^3*l-x^2*l^2)/l^3;
ndsh=diff(n,x);
tot=sum(e(:,5));
aa=zeros(tot,1);
if size(a,1)==0
    rslt=aa;
else 
    for i=1:size(a,1)
        ab=zeros(tot,1);
        [asd,lngh]=lng(a(i,1),d,e);
        chk=strcmpi('global',b(i,1));
        inl=[a(i,4);a(i,6);a(i,8)];
        fnl=[a(i,5);a(i,7);a(i,9)];
        if chk==1
            locinl=asd*inl;
            locfnl=asd*fnl;
        else
            locinl=inl;
            locfnl=fnl;
        end
        locinl=locinl';
        locfnl=locfnl';
        axlfnc=locinl(1,1)+(locfnl(1,1)-locinl(1,1))*(x-a(i,2))/(a(i,3)-a(i,2));
        trnsfnc=locinl(1,2)+(locfnl(1,2)-locinl(1,2))*(x-a(i,2))/(a(i,3)-a(i,2));
        momfnc=locinl(1,1)+(locfnl(1,3)-locinl(1,3))*(x-a(i,2))/(a(i,3)-a(i,2));
        zx=subs(axlfnc*n(1,1:2)',l,lngh);
        zx=int(zx,x,a(i,2),a(i,3));
        xc=subs(trnsfnc*n(1,3:6)',l,lngh);
        xc=int(xc,x,a(i,2),a(i,3));
        cv=subs(momfnc*ndsh(1,3:6)',l,lngh);
        cv=int(cv,x,a(i,2),a(i,3));
        vb=xc+cv;
        nend(1,1)=zx(1,1);
        fend(1,1)=zx(2,1);
        nend(2:3,1)=vb(1:2,1);
        fend(2:3,1)=vb(3:4,1);
        % till now nend and fend represents the nodal forces in member
        % direction .upon multiplication with trns' it converts into global
        % direction.furthur we shall multiply with transformation matrix to
        % convert into load in joint direction
        nend=asd'*nend;
        fend=asd'*fend;
        tra=trn(d(a(i,1),2),e);
        trb=trn(d(a(i,1),3),e);
        nend=tra*nend;
        fend=trb*fend;
        ab(c(a(i,1),1),1)=nend(1,1);
        ab(c(a(i,1),2),1)=nend(2,1);
        ab(c(a(i,1),3),1)=nend(3,1);
        ab(c(a(i,1),4),1)=fend(1,1);
        ab(c(a(i,1),5),1)=fend(2,1);
        ab(c(a(i,1),6),1)=fend(3,1);
        aa=aa+ab;
    end
    rslt=aa;
end

        
        