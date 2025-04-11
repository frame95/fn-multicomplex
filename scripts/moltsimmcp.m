function [Ic,Jc,pc]=moltsimmcp(Ia,Ja,pa,n,Ib,Jb,pb,t,cp)   %moltiplica matrici dell'anello gruppo di Sigma_t per verificare soluzioni sistema lineare
%dev'essere n =colonne A = righe B
%Ia riga A, Ja colonna A, pa= permutazione A
%stessa cosa per B

%versione con cp assegnata

Ic=zeros(0,1);
Jc=zeros(0,1);
pc=zeros(0,1);
%cp=compperm(t);
for i=1:n
i
v=find(Ja==i); %LENTISSIMO!!! Trovare vettorizzazione..
w=find(Ib==i);

for ia=v %funziona? 

%TOLTO ' perchè funziona con le colonne in questo caso !!!!    
    
    
    %for jb=w'
%keyboard
%M=setxor([Ic,Jc,pc],[Ia(ia),Jb(jb),cp(pa(ia),pb(jb))] ,'rows');

%Ic=M(:,1); Jc=M(:,2); pc=M(:,3);    
%end
%end
        
%combinare Ia(v) con Jb(w) in matricione e anche le permutazioni
%e poi reshape
%keyboard
uno=Ia(ia)*ones(1,length(w));
due=Jb(w)';
tre=cp(pa(ia),pb(w)); 
%T=[uno(:),due(:),tre(:)];
%estraggo mod 2
%T1=unique(T,'rows');
%while length(T1)<length(T)



 %keyboard     
%M=[[Ic,Jc,pc];[uno(:),due(:),tre(:)]];

M=setxor([Ic,Jc,pc],[uno(:),due(:),tre(:)],'rows');
Ic=M(:,1); Jc=M(:,2); pc=M(:,3);    

end
end


