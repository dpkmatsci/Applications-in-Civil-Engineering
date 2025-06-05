function [wtr,crsagr,fnagr,cmnt,fckt]=guimixdsgn(fck,wc,mxsag,agrtyp,fngrd,wrkabl,air,cmsp,fnsp,crsp,fnsrf,crsrf,fnwabs,crwabs)
% this program is for determination of components of mix-design according
% to IS10262-1982 which has more flexibility w.r.t statistical parameters
%fck=input('give grade of concrete:');
% t is a statistical parameter depending upon the accepted proportion of low results and no. of tests. according to 
% IS10262-2009 value of t is fixed as 1.65 for 1 low result among 20 test samples
rw=(fck-10)/5+1;
t=1.65;
load('stdvt2009.mat');
s=sdd(rw,2);
fckt=fck+t*s;
%wc=input('give water cement ratio:');
%mxsag=input('give maximum size of aggregate 10,20 or 40 mm:');
%fngrd=input('what is grade of fine aggregates:');
rwo=log(mxsag/10)/log(2)+1;
  load('wtrcnt.mat');
  load('crsfrcn2009.mat');
  crsfrc=crs(rwo,5-fngrd);
  crsfrc=crsfrc+(.5-wc)/5;
  %wrkabl=input('give desired value of workability in terms of slump(mm):');
  wtr=wtc(rwo,agrtyp);
  wtr=wtr*(1+3/25*(wrkabl-50)/100);
  %rdsn=input('desired water reduction % for superplasticizer use:');
  rdsn=0;
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
  %frcn=input('desired percentage reduction in coarse aggregate for pumping concrete:');
  frcn=0;
  crsfrc=crsfrc*(1-frcn/100);
%air=input('percentage of air entrapped:');
%cmsp=input('give specific gravity of cement:');
%fnsp=input('give specific gravity of fine aggregate:');
%crsp=input('give specific gravity of coarse aggregate:');
aggr=1*(1-air/100)-wtr/1000-spvol-cmnt/(cmsp*1000);
crsagr=aggr*crsfrc*crsp*1000;
fnagr=aggr*(1-crsfrc)*fnsp*1000;
% water absorption and free surface moisture
%fnsrf=input('give percentage of free surface moisture in fine aggregate:');
%crsrf=input('give percentage of free surface moisture in coarse aggregate:');
%crwabs=input('give percentage of water absorption in coarse aggregate:');
%fnwabs=input('give percentage of water absorption in fine aggregate:');
if fnsrf>0
    fnwabs=0;
end
if crsrf>0
    crwabs=0;
end
wtr=wtr+crsagr*(crwabs-crsrf)/100+fnagr*(fnwabs-fnsrf)/100;
crsagr=crsagr*(1+(crsrf-crwabs)/100);
fnagr=fnagr*(1+(fnsrf-fnwabs)/100);
