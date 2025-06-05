%this program is written for solving 3d truss structure
%various details should be provided in notepad or excel as per prscribed manner
%here it is to be noted that joint load should be in terms of local XYZ
%coordinates in case of joint at an arbitrary angle with global directions
% provide support settlement in terms of mm
clear all
close all
memb=load('membdet.txt');
joint=load('jntdet.txt');
jntang=load('jntangle.txt');
jnt=size(joint);
kglobal=globalstiff(memb,joint,jntang);
[jointdisp,yh,ik]=xlsread('jntdisp.xlsx');
[jointload,gh,rf]=xlsread('jntload.xlsx');
[adfrc,forc,displ]=forcedisp(jointdisp,jointload,jnt(1,1));
% here we shall create column matrix for temperature difference
% forcetmp indicates forces induced due to temperature difference
%forcefab indicates forces induced due to fabrication error
membtmp=load('membtemp.txt');
membfb=load('membfab.txt');
forcetmp=forcetemp(memb,membtmp,joint,jntang);
forcefb=forcefab(memb,membfb,joint,jntang);
d=input('give the dimension of problem:');
if d==2
    for i=1:jnt(1,1)
        forc(3*i,1)=0;
        displ(3*i,1)=0;
        forcetmp(3*i,1)=0;
        forcefb(3*i,1)=0;
        adfrc(3*i,1)=0;
    end
end
[fnforc,fndispl]=issac(forc,displ,kglobal,forcetmp,forcefb);
%for i=1:3*jnt(1,1)
    %if adfrc(i,1)~=0
    %    adfrc(i,1)=forc(i,1)-adfrc(i,1);
   % end
%end
[membforce,membstress]=membfrc(memb,fndispl,joint,jntang,membfb,membtmp);
% regarding units member force is in KN while stress is in MPa
% creation of final result matrices
% member detail forces and stresses
for i=1:size(memb,1)
    finlmemdet(i,1)=i;
    finlmemdet(i,2)=membforce(i,1);
    finlmemdet(i,3)=membstress(i,1);
end
% joint displacement
for i=1:jnt(1,1)
    finljntdisp(i,1)=i;
    finljntdisp(i,2)=fndispl(3*i-2,1);
    finljntdisp(i,3)=fndispl(3*i-1,1);
    finljntdisp(i,4)=fndispl(3*i,1);
end
% determination of joint reaction forces
t=1;
for i=1:3:size(adfrc,1)
        finljntrctn(t,1)=t;
        finljntrctn(t,2)=fnforc(i,1)-adfrc(i,1);
        finljntrctn(t,3)=fnforc(i+1,1)-adfrc(i+1,1);
        finljntrctn(t,4)=fnforc(i+2,1)-adfrc(i+2,1);
        t=t+1;
    
end
% printing results in the following manner 
% member memberforce memberstress 
% joint displacement 
% joint reaction
rslt=strcat('trussresult','.txt');
fid=fopen(rslt,'w');
fprintf(fid,'-------------MEMBER FORCES & STRESSES------------\n\n');
fprintf(fid,' %12s %15s %17s\r\n','member','force(KN)','stress(MPa)');
fprintf(fid,' %9d %18.3f %18.3f\r\n',finlmemdet');
fprintf(fid,'\n\n------------------- JOINT DISPLACEMENT -------------\n\n');
fprintf(fid,' %12s %16s %16s %16s\r\n','joint','xdisp(mm)','ydisp(mm)','zdisp(mm)');
fprintf(fid,' %9d %18.3f %18.3f %18.3f\r\n',finljntdisp');
fprintf(fid,'\n\n------------------- JOINT REACTION -------------\n\n');
fprintf(fid,' %12s %16s %16s %16s\r\n','joint','xrctn(KN)','yrctn(KN)','zrctn(KN)');
fprintf(fid,' %9d %18.3f %18.3f %18.3f\r\n',finljntrctn');
fclose(fid);
%*******************************THANK YOU *********************************







        
    







