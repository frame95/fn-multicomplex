function [I,p]=recofox(F);
%mette in forma equivariante (con l'azione sinistra...) 
%una combinazione lineare di (distinti) celle di Fox
%base di fox

l=size(F,2); 
n=(l+1)/2; %numero di punti
d=sum(F(1,n+1:2*n-1)); %dimensione cella (guarda la prima riga)

basis=partfox(d,n-1,2);
ib=size(basis,1);

s=size(F,1); 
I(s)=0; p(s)=0; %setta dimensione
for i=1:s
p(i)=numeroperm(F(i,1:n));
for j=1:ib
    if isequal(basis(j,:),F(i,n+1:2*n-1))
        I(i)=j;
        break; end
end
end
