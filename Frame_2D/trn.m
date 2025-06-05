function trns=trn(a,b)
% this function is created to generate the transformation matrix T in such
% a manner that joint direction load=T*global load
% a is joint no. b is joint detail
trns=zeros(3);
trns(1,1)=cosd(b(a,4));
trns(2,2)=trns(1,1);
trns(3,3)=1;
trns(2,1)=-sind(b(a,4));
trns(1,2)=-trns(2,1);