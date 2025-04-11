function A=bousfield(n,k)
%calcola il termine E2 di Bousfield
%G=genera(n,k);
%G=norma(G,n); %tiene solo i normalizzati
G=corde(n,k);
g=size(G,3);
%L=genera(n-1,k);
%L=norma(L,n-1); %tiene solo i normalizzati
L=corde(n-1,k);
l=size(L,3);
A=sparse(g,l) ; %setta le dimensioni della matrice del differenziale
for c=1:g  %prendo classe coomologia 
    c
    T=G(:,:,c); 
DT=[]; %parte vuoto
for i=1:n-1 
B=[1:i i:n-1]; 
DiT=B(T); 
DiT=arn(DiT); %messa in forma normale
DT=ag(DT,DiT); %aggiunge al differenziale d_i
end
if isempty(find(T==1)) %d0 se non trova 1
DT=ag(DT,T-1);    %toglie 1 a tutto e aggiunge al diff
end    
if isempty(find(T==n)) % dn se non trova n
DT=ag(DT,T); 
end
%ora devo mettere un uno nella matrice
      %find summands
if not(isempty(DT))
      for k=1:size(DT,3)
     for j=1:l

         if (L(:,:,j)==DT(:,:,k)) A(c,j)=xor(A(c,j),1); break; end
     end
     
      end
end
end
end