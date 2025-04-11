function Xprov=rinumera(Xprov,i,j,k);
%rinumera per d3

Xprov=Xprov+ double(Xprov>i); 
Xprov=Xprov+double(Xprov>j+1);
Xprov=Xprov+double(Xprov>k+2);
posk=find(Xprov==k+2,1,'last'); %2
Xprov(posk)=k+3;  %
posj=find(Xprov==j+1,1,'last'); %2
Xprov(posj)=j+2;  %
posi=find(Xprov==i,1,'last');
Xprov(posi)=i+1;
