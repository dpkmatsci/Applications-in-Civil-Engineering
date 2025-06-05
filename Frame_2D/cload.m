function rslt=cload(a,b,c,d,e)
% this function is created to calculate the joint load due to conc load on
% members here a is load matrix while b is load detail whether local or
% global. c is member degree of freedom matrix.d is member details
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
        [trns,lngh]=lng(a(i,1),d,e);
        chk=strcmpi('global',b(i,1));
        if chk==1
            loclod=trns*a(i,3:5)';
        else
            loclod=a(i,3:5)';
        end
        loclod=loclod';
        nend(1,1)=loclod(1,1)*subs(n(1,1),{x,l},{a(i,2),lngh});
        fend(1,1)=loclod(1,1)*subs(n(1,2),{x,l},{a(i,2),lngh});
        df=subs(n(1,3:6)',{x,l},{a(i,2),lngh})*loclod(1,2);
        fd=subs(ndsh(1,3:6)',{x,l},{a(i,2),lngh})*loclod(1,3);
        nend(2:3,1)=df(1:2,1)+fd(1:2,1);
        fend(2:3,1)=df(3:4,1)+fd(3:4,1);
        % till now nend and fend represents the nodal forces in member
        % direction .upon multiplication with trns' it converts into global
        % direction.furthur we shall multiply with transformation matrix to
        % convert into load in joint direction
        nend=trns'*nend;
        fend=trns'*fend;
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

        
        
        
            