function [I,J,pp,tt,ss,n]=fn3ter(n,k)
%MIGLIOR PROGrAMMA per matrice differenziale di fox 
%solo la parte equivariante 



%faccio il differenziale con dfn3 e poi costruisco una matrice




counter=0;

%computes differential in fox neuwirth of R^3
%fn3(n,k) x Sym_n-->fn2(n,k-1) x Sym_n
%in equivariant way 


%k-cells are sequences of 0 and 1 and 2 of length n-1
S=partfox(k,n-1,2); %
ss=size(S,1);

T=partfox(k-1,n-1,2);   %k-1 cells

%if k==1 
%    T=double.empty(1,0); %caso speciale
%else
%    T=subset(n-1,k-1); %position of the ones  in k-1 cells
%end
    tt=size(T,1);

Pe=perms(1:n);

%cp=compperm(n); %composition of permutations

nf=factorial(n);

%N(tt*nf,ss*nf)=uint8(0); %matrix non equivariant
%N=sparse(tt*nf,ss*nf);

for is=1:ss
%is
    [CS , FT] = dfn3(1:n , S(is,:)) ; 
for iu=1:size(CS,1) %ci vuole un altro end
cS=CS(iu,:); 
ft=FT(iu,:);
    
    
%e metterli in una matrice 
%for cS=Sigma'
for it=1:tt
    if ft==T(it,:) 

%for ip=1:factorial(n)
%    if cS==Pe(ip,:) devo uccidere due end

ip=numeroperm(cS);        
        
        
        counter=counter+1; I(counter)=it; J(counter)=is; pp(counter)=ip;   

%for jp=1:nf 
%[is jp]
    %cambiare cp(jp,ip) senza la matrice
%CC=Pe(jp,Pe(ip,:)); 

%for w=1:nf   %trucco perchè l'identita spesso è alla fine
%if isequal(CC,Pe(w,:))
%    break; end
%end

%w=numeroperm(CC); 

    
 %   N(it+(w-1)*tt, is+(jp-1)*ss   )=1; 

%end


%        break; end
%end
break; end
end         
        
    end %i
end
end%t




