%aggiunge a matrice Z riga R senza ripetizioni
function T=agg(Z,R)
T=Z;
for yu=R'
RR=yu';
    
c=0;
for r=1:size(T,1)
if (T(r,:)==RR) T(r,:)=[];  c=1; break ;end %cancella se due righe uguali
end %r
if (c==0)  T=[T;RR]; end

end