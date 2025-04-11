%aggiunge trimatrici mod 2
function T=ag(A,R)
T=A;
if isempty(A) T=R; return; end
if isempty(R) T=A; return; end

    
for r=1:size(R,3)
c=0;
for t=1:size(T,3)
if  (T(:,:,t)==R(:,:,r)) T(:,:,t)=[];  c=1; break ;end %cancella se due righe uguali
end %r
if (c==0) 
T=cat(3,T,R(:,:,r)); 

end
end