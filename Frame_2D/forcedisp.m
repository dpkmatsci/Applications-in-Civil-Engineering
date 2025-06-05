function [adfr,frc,dsp]=forcedisp(a,b,c,d)
% this function is created to determine the force and displacement matrix
% as Q and D from Q=KD and adfrc determines the additional forces to be
% added to determine the perfect joint reaction
% a is joint displacement data b is joint load data
% c is total joint forces due to member concentrated and linearly varying
% forces d is joint degree of freedom matrix
dof=max(d(size(d,1),:));
dps=nan(dof,1);
pns(:,1)=c;
pns(1:dof,2)=zeros(dof,1);
for i=1:size(b,1)
    zx=max(d(b(i,1),:));
    xc=d(b(i,1),1);
    for j=1:zx-xc+1
        pns(d(b(i,1),j),2)=b(i,j+1);
    end
end
for i=1:size(a,1)
    zx=max(d(a(i,1),:));
    xc=d(a(i,1),1);
    for j=1:zx-xc+1
        dps(d(a(i,1),j),1)=a(i,j+1);
    end
end
for i=1:dof
    if isnan(dps(i,1))==0
        if isnan(pns(i,2))==0
            snp(i,1)=nan;
            adfrc(i,1)=sum(pns(i,:));
        else
            snp(i,1)=nan;
            adfrc(i,1)=pns(i,1);
        end
    else
        snp(i,1)=sum(pns(i,:));
        adfrc(i,1)=0;
    end
end
adfr=adfrc;
frc=snp;
dsp=dps;

    