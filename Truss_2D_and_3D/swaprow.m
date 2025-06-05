function b=swaprow(a,c,d)
%here c and d row will be replaced by each other
dipak(1,:)=a(c,:);
dipak(2,:)=a(d,:);
a(c,:)=dipak(2,:);
a(d,:)=dipak(1,:);
b=a;
