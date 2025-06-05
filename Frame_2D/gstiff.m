function gemstiff=gstiff(p,a,b,d)
% this program is written to determine the geometric stiffness of frame
% p is axial force vector
% a is member detail
% b is joint detail
% d is member degree of freedom
nn=sum(b(:,5));
wgfnl=zeros(nn);
for i=1:size(a,1)
    wginl=zeros(nn);
    ginl=zeros(6);
    [~,lngt]=lng(a(i,1),a,b);
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
    ginl=ginl*p(i,1);
    trns=mbtrn(a(i,1),a,b);
    gfnl=trns*ginl*trns';
    for j=1:6
        for k=1:6
            wginl(d(i,j),d(i,k))=gfnl(j,k);
        end
    end
    wgfnl=wgfnl+wginl;
end
gemstiff=wgfnl;
    