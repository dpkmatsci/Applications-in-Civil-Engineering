% this program is for determination of components of mix-design according
% to IS10262-1982 which has more flexibility w.r.t statistical parameters
codeflx=input('give year of IS10262 1982 or 2009:');
fck=input('give grade of concrete:');
% t is a statistical parameter depending upon the accepted proportion of low results and no. of tests. according to 
% IS10262-2009 value of t is fixed as 1.65 for 1 low result among 20 test samples
rw=(fck-10)/5+1;
if codeflx==1982
t=input('give value of t:');
load('qltcntrl.mat');
qlttrl=input('give degree of quality control','s');
tf=strcmpi('qlttrl','verygood');
if tf==1
    s=sdf(rw,2);
end
tff=strcmpi('qlttrl','good');
if tff==1
    s=sdf(rw,3);
end
ftf=strcmpi('qlttrl','fair');
if ftf==1
    s=sdf(rw,4);
end
else
    t=1.65;
    load('stdvt2009.mat');
    s=sdd(rw,2);
end
fckt=fck+t*s;
fprintf('target strength is');
disp(fckt);
wc=input('give water cement ratio:');
mxsag=input('give maximum size of aggregate 10,20 or 40 mm:');
fngrd=input('what is grade of fine aggregates:');
rwo=log(mxsag/10)/log(2)+1;
if codeflx==2009
  load('wtrcnt.mat');
  load('crsfrcn2009.mat');
  crsfrc=crs(rwo,5-fngrd);
  crsfrc=crsfrc+(.5-wc)/5;
  wrkabl=input('give desired value of workability in terms of slump(mm):');
  wtr=wtc(rwo,1);
  wtr=wtr*(1+3/25*(wrkabl-50)/100);
  rdsn=input('desired water reduction % for superplasticizer use:');
  wtr=wtr*(1-rdsn/100);
  cmnt=wtr/wc;
  if rdsn~=0
      spden=input('what is specific gravity of superplasticizer:');
      spfrc=input('what is percentage of superplasticizer w.r.t cement:');
      spamnt=cmnt*spfrc/100;
      spvol=spamnt/(spden*1000);
  else
      spamnt=0;
      spvol=0;
  end
  frcn=input('desired percentage reduction in coarse aggregate for pumping concrete:');
  crsfrc=crsfrc*(1-frcn/100);
end
air=input('percentage of air entrapped:');
cmsp=input('give specific gravity of cement:');
fnsp=input('give specific gravity of fine aggregate:');
crsp=input('give specific gravity of coarse aggregate:');
aggr=1*(1-air/100)-wtr/1000-spvol-cmnt/(cmsp*1000);
crsagr=aggr*crsfrc*crsp*1000;
fnagr=aggr*(1-crsfrc)*fnsp*1000;
% water absorption and free surface moisture
fnsrf=input('give percentage of free surface moisture in fine aggregate:');
crsrf=input('give percentage of free surface moisture in coarse aggregate:');
if fnsrf>0
    fnwabs=0;
else
    fnwabs=input('give percentage of water absorption in fine aggregate:');
end
if crsrf>0
    crwabs=0;
else
    crwabs=input('give percentage of water absorption in coarse aggregate:');
end
wtr=wtr+crsagr*(crwabs-crsrf)/100+fnagr*(fnwabs-fnsrf)/100;
crsagr=crsagr*(1+(crsrf-crwabs)/100);
fnagr=fnagr*(1+(fnsrf-fnwabs)/100);
disp(wtr);
disp(cmnt);
disp(crsagr);
disp(fnagr);
fprintf('the ratio is %f:1:%f:%f',wtr/cmnt,fnagr/cmnt,crsagr/cmnt);
vol=input('give vol of concrete in cubim:');
twtr=wtr*vol;
tcmnt=cmnt*vol;
tcrsagr=crsagr*vol;
tfnagr=fnagr*vol;
disp(twtr);
disp(tcmnt);
disp(tcrsagr);
disp(tfnagr);
