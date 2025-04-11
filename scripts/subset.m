function c=subset(n,s)
% genera le combinazioni di s elementi dei simboli 1..n 
c=[];
if ((n>0) && (s<=n))
if s==1
   for k=1:n
      c(k)=k;
   end
   c=c';
else
   for j=1:n-s+1
       a=subset(n-j,s-1)+j;
       b=j*ones(size(a,1),1);
       c=[c;[b,a]];
   end
end
end