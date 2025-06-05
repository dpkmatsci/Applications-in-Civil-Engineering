function y=globalstiff(x,z,w)
% y is global stiffness matrix for whole truss structure
% x is matrix with member details
% z is matrix with joint co-ordinates
% w is joint support angle matrix.
k=zeros(6);
k(1,1)=1;
k(1,4)=-1;
k(4,4)=1;
k(4,1)=-1;
m=size(x);
n=size(z);
kglobal=zeros(3*n(1,1));
for i=1:m(1,1)
    mksh=zeros(3*n(1,1));
    % creation of transformation matrix  %
    % this is based on the assumption that y' axis makes angle of pi/2 with
    %  z axis. further z' is determined as x'Xy'  %
    [lngth,trns]=trnsfrm(x(i,1),x,w,z);
    klocal=x(i,5)/1000*x(i,4)/lngth*k;
    %--------------------------------------------------------------%
    kmbglbl=trns*klocal*trns';
    % augmentation of global stiffness matrix %
    for rf=1:6
        if rem(rf,3)~=0
             ud=3*(x(i,fix(rf/3)+2)-1)+rem(rf,3);
        else
             ud=3*x(i,(rf/3)+1);
        end
        for ksh=1:6
           if rem(ksh,3)~=0
             ks=3*(x(i,fix(ksh/3)+2)-1)+rem(ksh,3);
           else
             ks=3*x(i,(ksh/3)+1);
           end
            mksh(ud,ks)=kmbglbl(rf,ksh);
        end
    end
kglobal=kglobal+mksh;
    %---------------------------------------%
end
y=kglobal;

    
    