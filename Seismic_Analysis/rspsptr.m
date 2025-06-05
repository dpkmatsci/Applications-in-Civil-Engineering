function a=rspsptr(b,c,e)
% this function is created to get displacement spectrum 
% b is matrix with time and corresponding ground acceleration
% c is maximum time period upto which we want spectrum
% e is damping constant array
ft=ceil(b(size(b,1),1));
tms=b;
if ft>b(size(b,1),1)
    nwtm=b(size(b,1),1):0.02:ft;
    tms(size(b,1)+1:size(b,1)+size(nwtm,2)-1,1)=nwtm(1,2:end)';
    tms(size(b,1)+1:size(b,1)+size(nwtm,2)-1,2)=zeros(size(nwtm,2)-1,1);
end
tms(:,2)=tms(:,2)*981;
qw=0:0.01:c;
a=qw';
for k=1:size(e,2)
   a(1,2+(k-1)*3)=0;
   a(1,3+(k-1)*3)=0;
   a(1,4+(k-1)*3)=0;
   d=e(1,k);
  for i=2:size(qw,2)
    omg=2*pi/qw(1,i);
    omgd=omg*(1-d^2)^0.5;
    cone=d/(1-d^2)^0.5;
    ctwo=omg/(1-d^2)^0.5;
    uit(1,1)=0;
    uit(2,1)=0;
        for j=2:size(tms,1)
            delt=(tms(j,1)-tms(j-1,1));
            cthr=2*d/(omg*delt);
            cfr=(1-2*d^2)/(omgd*delt);
            x(1,1)=exp(-d*omg*delt)*(cone*sin(omgd*delt)+cos(omgd*delt));
            x(1,2)=exp(-d*omg*delt)*((1/omgd)*sin(omgd*delt));
            x(2,1)=-exp(-d*omg*delt)*ctwo*sin(omgd*delt);
            x(2,2)=exp(-d*omg*delt)*(-cone*sin(omgd*delt)+cos(omgd*delt));
            y(1,1)=(cthr+exp(-d*omg*delt)*((cfr-cone)*sin(omgd*delt)-(1+cthr)*cos(omgd*delt)))/omg^2;
            y(1,2)=(1-cthr+exp(-d*omg*delt)*(-cfr*sin(omgd*delt)+cthr*cos(omgd*delt)))/omg^2;
            y(2,1)=(-1/delt+exp(-d*omg*delt)*((ctwo+cone/delt)*sin(omgd*delt)+1/delt*cos(omgd*delt)))/omg^2;
            y(2,2)=(1-exp(-d*omg*delt)*(cone*sin(omgd*delt)+cos(omgd*delt)))/(delt*omg^2);
            uit(1:2,j)=x*uit(1:2,j-1)+y*tms(j-1:j,2);
        end
        a(i,2+(k-1)*3)=max(abs(uit(1,:)));
        a(i,3+(k-1)*3)=a(i,2+(k-1)*3)*omg;
        a(i,4+(k-1)*3)=a(i,3+(k-1)*3)*omg/981;
  end
end


            
            
        