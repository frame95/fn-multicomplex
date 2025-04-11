%PARTIZIONI IN 2 PEZZI
function X=part(n,p)
X=cell(p,p^n); %cambio con p^n
for i=0:p^n-1 %anche qui
T=i;
  for j=1:n %trasforma in numero p-adico
  R(j)=mod(T,p);
  T=(T-R(j))/p;
  end
  for j=1:p
  X{j,i+1}=find(R==j-1);
  end
end
