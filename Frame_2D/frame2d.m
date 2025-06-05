% this program is written for calculation of reactions and displacement as
% well as rotation at joints. provide each and every data regarding joint
% and member in prescribed manner
% provide all joint load in terms of joint global directions while properly
% specify in case of member loads
% regarding units displacement obtained is in mm and rotation is in radian
% provide loads in KN and moment in KNm
% after all actual data provided in joint displacement and joint load
% provide extra 0 in last col. and row
% provide joint settlement in terms of m
clear all;
unit=input('give nature of unit (si/fps):','s');
% give nature of unit as si or fps
us=strcmpi('si',unit);
%memb=load('membdet.txt');
%joint=load('jntdet.txt');
[memb,~,~]=xlsread('membdt.xlsx');
[joint,~,~]=xlsread('jntdt.xlsx');
[pinjoint,~,~]=xlsread('pinned.xlsx');
[kglobal,mdof,jdof]=stiffness(memb,joint,pinjoint,unit);
conctxt=importdata('membcload.txt');
as=conctxt.textdata;
if size(as,1)>5 
    conc=conctxt.data;
    cdet=as(6:end,1);
else
    conc=zeros(0,0);
    cdet=zeros(0,0);
end
jntcnc=cload(conc,cdet,mdof,memb,joint);
tritxt=importdata('trload.txt');
 ad=tritxt.textdata;
if size(ad,1)>5
   
     tri=tritxt.data;
     trdet=ad(6:end,1);
else
    tri=zeros(0,0);
    trdet=zeros(0,0);
end
jnttri=triload(tri,trdet,mdof,memb,joint);
jnttot=jntcnc+jnttri;
[jointdisp,~,~]=xlsread('jntdisp.xlsx','1:3');
if size(jointdisp,2) < 4
    jointdisp(:, size(jointdisp,2)+1:4)=NaN;
end
[jointfrc,~,~]=xlsread('jntload.xlsx');
[adfrc,forc,dspl]=forcedisp(jointdisp,jointfrc,jnttot,jdof);
a=input('what is dimension of problem:');
if a==1
    for i=1:size(jdof,1)
        forc(jdof(i,1),1)=0;
        dspl(jdof(i,1),1)=0;
    end
end
for ite=1:6
    if ite==1
        axlfrc=zeros(size(memb,1),1);
    end
    gglobal=gstiff(axlfrc,memb,joint,mdof);
    overstiff=kglobal+gglobal;
    [frc,dsp]=albert(forc,dspl,overstiff);
    axlfrc=axialfrc(memb,mdof,joint,dsp,axlfrc,unit);
   axilfrc(:,ite)=axlfrc;
end
 disp(axilfrc);
for i=1:size(frc,1)
    frc(i,1)=frc(i,1)-adfrc(i,1);
end
if us==1
    mult=1000;
else
    mult=12;
end
for i=1:size(jdof,1)
    jntdspl(i,1)=i;
    jntdspl(i,2)=mult*dsp(jdof(i,1),1);
    jntdspl(i,3)=mult*dsp(jdof(i,2),1);
end
for i=1:size(mdof,1)
    memrot(i,1)=i;
    memrot(i,2)=dsp(mdof(i,3),1);
    memrot(i,3)=dsp(mdof(i,6),1);
end
k=1;
for i=1:size(jdof,1)
    zx=max(jdof(i,:));
    xc=jdof(i,1);
    for j=1:zx-xc+1
        jntrctn(k,1)=i;
        jntrctn(k,2)=jdof(i,j);
        jntrctn(k,3)=frc(jdof(i,j),1);
        k=k+1;
    end
end
rslt=strcat('framedeformationresult','.txt');
fid=fopen(rslt,'w');
fprintf(fid,'------------------JOINT DISPLACEMENTS--------------------\r\n');
if us==1
     fprintf(fid,' %11s %15s %15s \r\n ','joint','xdisp(mm)','ydisp(mm)');
else
     fprintf(fid,' %11s %15s %15s \r\n ','joint','xdisp(in)','ydisp(in)');
end
fprintf(fid,' %9d %18.3f %18.3f\r\n',jntdspl');
fprintf(fid,'------------------MEMBER ROTATIONS--------------------\r\n');
fprintf(fid,' %12s %18s %18s \r\n ','member','nendrot(rad)','fendrot(rad)');
fprintf(fid,' %9d %18.6f %18.6f\r\n',memrot');
fclose(fid);
rslt=strcat('framereactionresult','.txt');
fid=fopen(rslt,'w');
fprintf(fid,'-----------------------JOINT REACTIONS-----------------------\r\n');
if us==1
     fprintf(fid,'%11s %23s %27s\r\n ','joint','degree of freedom','force(KN)/moment(KNm)');
else
     fprintf(fid,'%11s %23s %27s\r\n ','joint','degree of freedom','force(k)/moment(kft)');
end
fprintf(fid,' %9d %23.3f %23.3f\r\n',jntrctn');
fclose(fid);
% all displacements and rotations shown here are in corresponding joint
% directions as earlier specified external joint load and displacements are
% to be provided in joint directions
%--------------------------------THANK YOU------------------------------%

