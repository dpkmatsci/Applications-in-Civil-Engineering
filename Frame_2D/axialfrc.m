function axlfrc=axialfrc(a,b,c,d,p,e)
% this function is written to determine the axial forces in different
% members of 2D frame a is member detail b is member degree of freedom
% c is joint detail d is displacement vector
% p is axial force vector
% e is unit detail
for i=1:size(b,1)
    for j=1:6
        nwdsp(j,i)=d(b(i,j),1);
    end
end
for i=1:size(a,1)
    trns=mbtrn(i,a,c);
    nwdsp(:,i)=trns'*nwdsp(:,i);
end
for i=1:size(a,1)
    lcstiff=mbstiff(i,a,c,p,e);
    nwfrc(1:6,i)=lcstiff*nwdsp(:,i);
end
for i=1:size(a,1)
    rslt(i,1)=nwfrc(4,i);
end
axlfrc=rslt;

    