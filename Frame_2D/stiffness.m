function [kglobal,mdof,jdof]=stiffness(a,b,c,d)
% this function creates the global stiffness matrix
% a is member details
% b is joint details
% c is pin joint details 
% d is unit detail
su=strcmpi('si',d);
if su==1
    mult=1000000;
else
    mult=144;
end
m=size(a);
n=size(b);
nn=sum(b(:,5));
ksum=zeros(nn);
nmx=max(b(:,5));
if size(c,1)~=0
    actc=nan(n(1,1),nmx-2);
    for i=1:size(c,1)
        actc(c(i,1),:)=c(i,2:end);
    end
end
jdof=nan(n(1,1),nmx);
k=1;
for i=1:n(1,1)
    for j=1:b(i,5)
        jdof(i,j)=k;
        k=k+1;
    end
end
mdof=nan(m(1,1),6);
for i=1:m(1,1)
        q=a(i,2:3);
        if b(q(1,1),5)==3
            mdof(i,1:3)=jdof(q(1,1),1:3);
        else
            mdof(i,1:2)=jdof(q(1,1),1:2);
            for j=1:size(actc,2)
                if actc(q(1,1),j)==a(i,1)
                    mdof(i,3)=jdof(q(1,1),j+2);
                    break;
                end
            end
        end
        if b(q(1,2),5)==3
            mdof(i,4:6)=jdof(q(1,2),1:3);
        else
            mdof(i,4:5)=jdof(q(1,2),1:2);
            for j=1:size(actc,2)
                if actc(q(1,2),j)==a(i,1)
                    mdof(i,6)=jdof(q(1,2),j+2);
                    break;
                end
            end
        end
end
for i=1:m(1,1)
    kin=zeros(nn);
    kloc=zeros(6);
    [~,lngt]=lng(i,a,b);
    kloc(1,1)=a(i,4)*a(i,6)/(lngt);
    kloc(2,2)=12*a(i,5)*a(i,6)/(mult*lngt^3);
    kloc(2,3)=6*a(i,5)*a(i,6)/(mult*lngt^2);
    kloc(3,3)=4*a(i,5)*a(i,6)/(mult*lngt);
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
    trns=mbtrn(i,a,b);
    kgl=trns*kloc*trns';
    for as=1:6
        for sd=1:6
            kin(mdof(i,as),mdof(i,sd))=kgl(as,sd);
        end
    end
    ksum=ksum+kin;
end
kglobal=ksum;
    
                
            
            