function [lngt,y]=trnsfrm(a,b,w,u)
% as a final result lngt provides length of member
% y gives transformation matrix in following manner:globaldisp=y*localdisp
% a is the member index
% b is matrix containing member details
% w is matrix containing joint angle detail
% u is matrix with joint coordinate
m=size(b);
n=size(u);
o=size(w);
if o(1,1)~=0
    for i=1:n(1,1)
        for j=1:7
            ang(i,j)=nan;
        end
    end
    for i=1:o(1,1)
        ang(w(i,1),:)=w(i,:);
    end
end
lngth=((u(b(a,2),2)-u(b(a,3),2))^2+(u(b(a,2),3)-u(b(a,3),3))^2+(u(b(a,2),4)-u(b(a,3),4))^2)^.5;
xdc(1,1)=(u(b(a,3),2)-u(b(a,2),2))/lngth;
xdc(1,2)=(u(b(a,3),3)-u(b(a,2),3))/lngth;
xdc(1,3)=(u(b(a,3),4)-u(b(a,2),4))/lngth;
 ydc(1,1)=-xdc(1,2);
 ydc(1,2)=xdc(1,1);
 ydc(1,3)=0;
 zdc=cross(xdc,ydc);
  trns=zeros(6);
  for sh=1:2
        t=zeros(3);
        t(:,1)=xdc';
        t(:,2)=ydc';
        t(:,3)=zdc';
        if o(1,1)==0
            u=t;
        else 
            if isnan(ang(b(a,sh+1),1))==1
                u=t;
            else
               pp=ang(b(a,sh+1),2:7);
               km=cross(pp(1,1:3),pp(1,4:6));
               pp(1,7:9)=km;
               for i=1:3
                  for j=1:3
                      mk(i,j)=pp(1,3*i-2:3*i)*t(:,j);
                  end
               end
              u=mk;
            end
        end
        
        if sh==1
           trns(1:3,1:3)=u;
        else
           trns(4:6,4:6)=u;
        end
  end
    y=trns;
lngt=lngth;