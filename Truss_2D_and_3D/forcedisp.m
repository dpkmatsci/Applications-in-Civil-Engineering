function [s,p,d]=forcedisp(x,y,z)
% this function file is created for generation of force displacement column
% matrix for unsolved truss structure. x is jointdisplcement data while y
% is joint load given.z is total no. of joint.
% s is matrix consisting of 3 columns.1st column indicates joint no.
% 2nd col. indicates 1,2,3 w.r.t joint x,y,z axis while 3rd col indicates
% external forces applied on supports
m=size(x);
n=size(y);
for i=1:3*z
    snp(i,1)=0;
    ss(i,1)=0;
    dps(i,1)=nan;
end
if n(1,1)~=0
  for i=1:n(1,1)
    for j=1:3
        snp(3*y(i,1)+j-3,1)=y(i,j+1);
    end
  end
end
for i=1:m(1,1)
    for j=1:3
       dps(3*x(i,1)-3+j,1)=x(i,j+1);
       if isnan(x(i,j+1))~=1 && isnan(snp(3*x(i,1)-3+j,1))~=1
           ss(3*x(i,1)-3+j,1)=snp(3*x(i,1)-3+j,1);
          snp(3*x(i,1)-3+j,1)=nan;
       end
    end
end
p=snp;
d=dps;
s=ss;

