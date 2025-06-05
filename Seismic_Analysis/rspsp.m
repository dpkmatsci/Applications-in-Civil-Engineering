function a=rspsp(b,c,d)
% this function is created to get displacement spectrum 
% b is matrix with time and corresponding ground acceleration
% c is maximum time period upto which we want spectrum
% d is damping constant
syms inac slac t zi indsp invel somg somgd 
u=inac/somg^2+slac*t/somg^2-2*zi*slac/(somg)^3+exp(-zi*somg*t)*((indsp-inac/somg^2+2*zi*slac/somg^3)*cos(somgd*t)+(invel/somgd-slac/(somg^2*somgd)+zi*somg/somgd*(indsp-inac/somg^2+2*zi*slac/somg^3))*sin(somgd*t));
udot=diff(u,t);
ft=ceil(b(size(b,1),1));
tms=b;
if ft>b(size(b,1),1)
    nwtm=b(size(b,1),1):0.02:ft;
    tms(size(b,1)+1:size(b,1)+size(nwtm,2)-1,1)=nwtm(1,2:end)';
    tms(size(b,1)+1:size(b,1)+size(nwtm,2)-1,2)=zeros(size(nwtm,2)-1,1);
end
tms(:,2)=tms(:,2)*981;
qw=0:0.5:c;
a=qw';
a(1,2)=0;
a(1,3)=0;
a(1,4)=0;
for i=2:size(qw,2)
    omg=2*pi/qw(1,i);
    omgd=omg*(1-d^2)^0.5;
    dsp(1,1)=0;
    vel(1,1)=0;
        for j=2:size(tms,1)
            cnst(1,1)=tms(j-1,2);
            cnst(1,2)=(tms(j,2)-tms(j-1,2))/(tms(j,1)-tms(j-1,1));
            cnst(1,3)=tms(j,1)-tms(j-1,1);
            cnst(1,4)=d;
            cnst(1,5)=dsp(j-1,1);
            cnst(1,6)=vel(j-1,1);
            cnst(1,7)=omg;
            cnst(1,8)=omgd;
            dsp(j,1)=subs(u,{inac slac t zi indsp invel somg somgd},cnst);
            vel(j,1)=subs(udot,{inac slac t zi indsp invel somg somgd},cnst);
        end
        a(i,2)=max(abs(dsp(:,1)));
        a(i,3)=a(i,2)*omg;
        a(i,4)=a(i,2)*omg^2/981;
end
