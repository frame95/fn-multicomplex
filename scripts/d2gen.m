function XN=d2gen(pe,nu);
%%general formulaB
%coppia di indici con almeno 1 (e non zeri) in mezzo: faccio come d1veloce (ma con due sdoppiati) e
%poi  distribuisco gli altri (collane di 2 come in 1, e 1 come in 1)
    XN=[];
%per questa parte vedere se è più efficiente convertire in [I,p] con
%recofox ciascuna riga e poi fare xor
%blocco per più di una riga
if size(pe,1)>1
for ipe=1:size(pe,1) %n
XN =agg(XN,d2gen(pe(ipe,:),nu(ipe,:)));
    end
       return
    end
%PARTE CON UNA RIGA SOLA
%esempio input: pe=[1 3 2 4] nu=[2 2 0]
%check that l(nu)=l(pe)-1
n=length(pe);
if not(length(nu)==n-1)
    disp('error')
return
end
%CICLO PRINCIPALE 
for i=1:n
    for j=i+1:n
        fi=find(pe==i); 
        fj=find(pe==j);
fmin=min(fi,fj); mi=pe(fmin);
fmax=max(fi,fj); mj=pe(fmax); 

bound=min(nu(fmin:fmax-1)); 
if bound==0 
    continue; end

if bound==2
       
poidue=find(nu(1:fmin-1)<2,1,'last'); %l'ultimo che è minore di 2
%quindi devo distribuire quanti 2?: 
if isempty(poidue)
poidue=0;
end
m2=fmin-1-poidue;
     if m2>0 
Q=part(m2,3); 
for iq=1:3^m2 %direttamente
q{1,iq}=pe(poidue+Q{1,iq});%potrebbe essere vuoto e far casino ?? no
q{2,iq}=pe(poidue+Q{2,iq}); %idem
q{3,iq}=pe(poidue+Q{3,iq}); %idem

nq{1,iq}=2*ones(1,length(Q{1,iq})) ;  %stessa cardinalità di quello sopra
nq{2,iq}=2*ones(1,length(Q{2,iq})) ;  %stessa cardinalità di quello sopra
nq{3,iq}=2*ones(1,length(Q{3,iq})) ;  %stessa cardinalità di quello sopra
end
     else
         q{1,1}=[];
         q{2,1}=[];
         q{3,1}=[];
nq{1,1}=[];
nq{2,1}=[];
nq{3,1}=[];

     end
%cosa simile per quelli *dopo* fmax
%dunque 
poidue=find(nu(fmax:n-1)<2,1);   %cerca fino a dove
if isempty(poidue)
poidue=fmax;  %che non c'è in nu
n2=n-fmax;
else
n2=poidue-1; 
poidue=poidue+fmax-1;
end
     if n2>0
R=part(n2,3);
for ir=1:3^n2
    r{1,ir}=pe(R{1,ir}+fmax);
    r{2,ir}=pe(R{2,ir}+fmax);
   r{3,ir}=pe(R{3,ir}+fmax);

    nr{1,ir}=2*ones(1,length(R{1,ir}));
nr{2,ir}=2*ones(1,length(R{2,ir}));
nr{3,ir}=2*ones(1,length(R{3,ir}));

end
     else
         r{1,1}=[];
         r{2,1}=[];
         r{3,1}=[];
nr{1,1}=[];
nr{2,1}=[];
nr{3,1}=[];

     end

%ora quelli in mezzo vanno suddivisi in tre parti...     
    u2=fmax-fmin-1;
if u2>0
V=part(u2,3);    
    for iv=1:3^u2
        for ipic=1:3 %ciclo per far prima
        v{ipic,iv}=pe(V{ipic,iv}+fmin);
        nv{ipic,iv}=2*ones(1,length(V{ipic,iv}));
        end 
    end
    else
    %metti solo vuoto
    for ipic=1:3
    v{ipic,1}=[];
    nv{ipic,1}=[];
    end
    end
 
%ora ci vogliono le shuffles , prima e poi dopo
%a partire da: 
F=find(nu(1:fmin-1)==0,1,'last');   %ultimo zero prima, poi c'è il caso vuoto
if isempty(F)
    F=0;
end

funo=find(nu(F+1:fmin-1)==1);
m1=length(funo);
for ip=1:2^(m1) %si fa anche nel caso vuoto
vs{1,ip}=[]; ns{1,ip}=[];
vs{2,ip}=[]; ns{2,ip}=[];
end

if not(isempty(funo)) %c ci sono blocchi da permutare
funo=funo+F; %numero corretto    
%i blocchi da permutare sono fino agli uni  (da uno prima o da zero)
bl=[]; bu=[];
bl{1}=pe(F+1:funo(1)); %da aggiustare
bu{1}=nu(F+1:funo(1)-1); %saranno tutti 2 o vuoto
for in=2:m1
    bl{in}=pe(funo(in-1)+1:funo(in));
bu{in}=nu(funo(in-1)+1:funo(in)-1);  %scelta di non metterci l'uno poi andrà comunque aggiunto...
end %in

P=part(m1,2);  %dividi in due parti
%prepara la stringa
for ip=1:2^(m1)
for p1=P{1,ip} %sono gli elementi 
vs{1,ip}=[vs{1,ip} bl{p1}]; ns{1,ip}=[ns{1,ip} bu{p1} 1]; %uno a destra ecco qui
end
for p2=P{2,ip} %sono gli elementi 
vs{2,ip}=[vs{2,ip} bl{p2}]; ns{2,ip}=[ns{2,ip} bu{p2} 1];
end
end %ip
end %se non vuoto funo

%poi c'è la parte dopo!

L=find(nu(fmax:n-1)==0,1);
if isempty(L)
    L=n;
else
    L=L+fmax-1;
end

funto=find(nu(fmax:L-1)==1);
    n1=length(funto);
for ip=1:2^(n1) %si fa anche nel caso vuoto
vd{1,ip}=[]; nd{1,ip}=[];
vd{2,ip}=[]; nd{2,ip}=[];
end


if not(isempty(funto))
    funto=funto+fmax-1;
bl=[]; bu=[];
for in=1:n1-1
bl{in}=pe(funto(in)+1:funto(in+1));
bu{in}=nu(funto(in)+1:funto(in+1)-1); %due o vuoto
end
%ultimo a mano
    bl{n1}=pe(funto(n1)+1:L); 
    bu{n1}=nu(funto(n1)+1:L-1);  

P=part(n1,2);  %dividi in due parti
%prepara la stringa
for ip=1:2^(n1)
for p1=P{1,ip} %sono gli elementi 
vd{1,ip}=[vd{1,ip} bl{p1}]; nd{1,ip}=[nd{1,ip} 1 bu{p1} ]; %uno a sinistra
end%p1
for p2=P{2,ip} %sono gli elementi 
vd{2,ip}=[vd{2,ip} bl{p2}]; nd{2,ip}=[nd{2,ip} 1 bu{p2} ];
end %p2
end %ip
end %se non vuoto funto
    

   inizio=pe(1:F);        
   inizion= nu(1:F); 
   coda=pe(L+1:n);
   codan=nu(L:n-1); 
    
    
for iq=1:3^m2
for ir=1:3^n2
for iv=1:3^u2 

for ip=1:2^m1
for jp=1:2^n1
        
Xprov= [inizio vs{1,ip} q{1,iq} mi  v{1,iv}  mj  r{1,ir}  vd{1,jp}     vs{2,ip}    q{2,iq} mi v{2,iv}  r{2,ir}    q{3,iq}   v{3,iv}   mj r{3,ir} vd{2,jp} coda]; %ripeto i
nprov=[inizion ns{1,ip} nq{1,iq}  nv{1,iv}  2  nr{1,ir}   nd{1,jp}  0  ns{2,ip}   nq{2,iq}   nv{2,iv} nr{2,ir}  1 nq{3,iq} nv{3,iv} nr{3,ir}  nd{2,jp}  codan]; %notare l'uno

Xprov=Xprov+ double(Xprov>i); 
Xprov=Xprov+double(Xprov>j+1);
posj=find(Xprov==j+1,1,'last'); %2
Xprov(posj)=j+2;  %
posi=find(Xprov==i,1,'last'); 
Xprov(posi)=i+1;

%if not(length([Xprov nprov])==size(XN,2)) && not(isempty(XN))
%keyboard
%end
    
XN= agg(XN , [Xprov nprov]);    
    
%parte "con indici rovesciati"        
Xprov=[inizio  vs{1,ip}  q{1,iq} v{1,iv} mj  r{1,ir}   q{2,iq}  mi  v{2,iv} r{2,ir}  vd{1,jp}  vs{2,ip}   q{3,iq} mi v{3,iv} mj r{3,ir} vd{2,jp} coda ];    
nprov=[inizion  ns{1,ip}  nq{1,iq} nv{1,iv} nr{1,ir} 1 nq{2,iq} nv{2,iv} nr{2,ir}    nd{1,jp}   0 ns{2,ip} nq{3,iq} 2 nv{3,iv} nr{3,ir} nd{2,jp} codan];     
   
Xprov=Xprov+ double(Xprov>i); 
Xprov=Xprov+double(Xprov>j+1);
posj=find(Xprov==j+1,1,'last'); %2
Xprov(posj)=j+2;  %
posi=find(Xprov==i,1,'last');
Xprov(posi)=i+1;

XN= agg(XN , [Xprov nprov]);    
    
end
end
end
end
end


else
    
    %bound==1 qui invece si spezzano in 2 le comuni e shuffle di quelle con
    %una, come in d1

%mutuato da d1 
F=find(nu(1:fmin-1)==0,1,'last'); %ultimo zero prima
L=find(nu(fmax:n-1)==0,1); %primo zero dopo, da rinumerare!
if isempty(F) 
    F=0;
end
if isempty(L)
    L=n;
else
    L=L+fmax-1;
end
%era 80
funo=find(nu(F+1:fmin-1)==1);
m1=length(funo);
for ip=1:2^(m1) %si fa anche nel caso vuoto
vs{1,ip}=[]; nvs{1,ip}=[];
vs{2,ip}=[]; nvs{2,ip}=[];

end

if not(isempty(funo)) %c ci sono blocchi da permutare
funo=funo+F; %numero corretto    
%i blocchi da permutare sono fino agli uni  (da uno prima o da zero)
bl=[]; bu=[];
bl{1}=pe(F+1:funo(1)); %da aggiustare
bu{1}=nu(F+1:funo(1)-1); %saranno tutti 2 o vuoto
for in=2:m1
    bl{in}=pe(funo(in-1)+1:funo(in));
bu{in}=nu(funo(in-1)+1:funo(in)-1);  %scelta di non metterci l'uno poi andrà comunque aggiunto...
end %in

P=part(m1,2);  %dividi in due parti
%prepara la stringa
for ip=1:2^(m1)
for p1=P{1,ip} %sono gli elementi 
vs{1,ip}=[vs{1,ip} bl{p1}]; nvs{1,ip}=[nvs{1,ip} bu{p1} 1]; %uno a destra ecco qui
end
for p2=P{2,ip} %sono gli elementi 
vs{2,ip}=[vs{2,ip} bl{p2}]; nvs{2,ip}=[nvs{2,ip} bu{p2} 1];
end
end %ip
end %se non vuoto funo
%112
funto=find(nu(fmax:L-1)==1);
    n1=length(funto);
for ip=1:2^(n1) %si fa anche nel caso vuoto
vd{1,ip}=[]; nd{1,ip}=[];
vd{2,ip}=[]; nd{2,ip}=[];
end

if not(isempty(funto))
    funto=funto+fmax-1;
bl=[]; bu=[];
for in=1:n1-1
bl{in}=pe(funto(in)+1:funto(in+1));
bu{in}=nu(funto(in)+1:funto(in+1)-1); %due o vuoto
end
%ultimo a mano
    bl{n1}=pe(funto(n1)+1:L); 
    bu{n1}=nu(funto(n1)+1:L-1);  

P=part(n1,2);  %dividi in due parti
%prepara la stringa
for ip=1:2^(n1)
for p1=P{1,ip} %sono gli elementi 
vd{1,ip}=[vd{1,ip} bl{p1}]; nd{1,ip}=[nd{1,ip} 1 bu{p1} ]; %uno a sinistra
end%p1
for p2=P{2,ip} %sono gli elementi 
vd{2,ip}=[vd{2,ip} bl{p2}]; nd{2,ip}=[nd{2,ip} 1 bu{p2} ];
end %p2
end %ip
end %se non vuoto funto
%143    
%dobbiamo fare una cosa simile per i blocchi in mezzo
furca=find(nu(fmin:fmax-1)==1);
    furca=furca+fmin-1;
o1=length(furca)-1;   %uno in meno !!!!! uno c'è di sicuro
for ip=1:2^(o1) %si fa anche nel caso vuoto
vo{1,ip}=[]; no{1,ip}=[];
vo{2,ip}=[]; no{2,ip}=[];
end
if o1>0
bl=[]; bu=[];
for in=1:o1
bl{in}=pe(furca(in)+1:furca(in+1));
bu{in}=nu(furca(in)+1:furca(in+1)-1); %due o vuoto
end
%ultimo a mano  %VERIFICARE I BOUND QUI !!!!!!!!!!! %circa
%    bl{o1}=pe(funto(o1)+1:L); 
%    bu{o1}=nu(funto(o1)+1:L-1);  

P=part(o1,2);  %dividi in due parti
%prepara la stringa
for ip=1:2^(o1)
for p1=P{1,ip} %sono gli elementi 
vo{1,ip}=[vo{1,ip} bl{p1}]; no{1,ip}=[no{1,ip} 1 bu{p1} ]; %uno a sinistra
end%p1
for p2=P{2,ip} %sono gli elementi 
vo{2,ip}=[vo{2,ip} bl{p2}]; no{2,ip}=[no{2,ip} 1 bu{p2} ];
end %p2
end %ip

end %se non vuoto furca

    
%poi faremo i 2 per ciascuno
%parte dei 2 ...  da modificare (cioè si fa sia per fmin che per fmax)  
poidue=find(nu(1:fmin-1)<2,1,'last'); %l'ultimo che è minore di 2
%quindi devo distribuire quanti 2?: 
if isempty(poidue)
poidue=0;
end
m2=fmin-poidue-1;
     if m2>0 
Q=part(m2,2); 
for iq=1:2^m2 %direttamente
q{1,iq}=pe(poidue+Q{1,iq});%potrebbe essere vuoto e far casino ?? no
q{2,iq}=pe(poidue+Q{2,iq}); %idem
nq{1,iq}=2*ones(1,length(Q{1,iq})) ;  %stessa cardinalità di quello sopra
nq{2,iq}=2*ones(1,length(Q{2,iq})) ;  %stessa cardinalità di quello sopra
end
     else
         q{1,1}=[];
         q{2,1}=[];
nq{1,1}=[];
nq{2,1}=[];
     end
%cosa simile per quelli odpo fmin
%dunque 

n2=furca(1)-fmin;

if n2>0
R=part(n2,2);
for ir=1:2^n2
    r{1,ir}=pe(R{1,ir}+fmin);
    r{2,ir}=pe(R{2,ir}+fmin);
  
    nr{1,ir}=2*ones(1,length(R{1,ir}));
    nr{2,ir}=2*ones(1,length(R{2,ir}));

end
     else
         r{1,1}=[];
         r{2,1}=[];
nr{1,1}=[];
nr{2,1}=[];

end
%ora quelli prima del secondo

poidue=furca(length(furca)); %circa
%circa 
s2=fmax-poidue-1; %circa

if s2>0 
Q=part(s2,2); 
for iq=1:2^s2 %direttamente
s{1,iq}=pe(poidue+Q{1,iq});%potrebbe essere vuoto e far casino ?? no
s{2,iq}=pe(poidue+Q{2,iq}); %idem
ns{1,iq}=2*ones(1,length(Q{1,iq})) ;  %stessa cardinalità di quello sopra
ns{2,iq}=2*ones(1,length(Q{2,iq})) ;  %stessa cardinalità di quello sopra
end
     else
         s{1,1}=[];
         s{2,1}=[];
ns{1,1}=[];
ns{2,1}=[];
     end

  poidue=find(nu(fmax:n-1)<2,1); %primo che è minore di 2
%quindi devo distribuire quanti 2?: 
if isempty(poidue)
t2=n-fmax;
else
t2=poidue-1;    
end
%t2=poidue-1;
%poidue=poidue+fmax;
     if t2>0 
Q=part(t2,2); 
for iq=1:2^t2 %direttamente
t{1,iq}=pe(fmax+Q{1,iq});%potrebbe essere vuoto e far casino ?? no
t{2,iq}=pe(fmax+Q{2,iq}); %idem
nt{1,iq}=2*ones(1,length(Q{1,iq})) ;  %stessa cardinalità di quello sopra
nt{2,iq}=2*ones(1,length(Q{2,iq})) ;  %stessa cardinalità di quello sopra
end
     else
         t{1,1}=[];
         t{2,1}=[];
nt{1,1}=[];
nt{2,1}=[];
     end
   


%costruzione del vettore
inizio=pe(1:F); 
inizion=nu(1:F);

coda=pe(L+1:n);
codan=nu(L:n-1); %compreso lo 0 eventuale

for ip=1:2^m1
    for jp=1:2^n1
for kp=1:2^o1
        for iq=1:2^m2
    for ir=1:2^n2 
   for  is=1:2^s2
    for  it=1:2^t2


Xprov= [inizio vs{1,ip} q{1,iq} mi r{1,ir} vo{1,kp} s{1,is} mj t{1,it} vd{1,jp}    vs{2,ip} q{2,iq} mi r{2,ir} vo{2,kp} s{2,is} mj t{2,it} vd{2,jp} coda]; %ripeto i

Nprov= [inizion nvs{1,ip} nq{1,iq} nr{1,ir} 1 no{1,kp}  ns{1,is}   nt{1,it} nd{1,jp} 0 nvs{2,ip} nq{2,iq} nr{2,ir} 1 no{2,kp} ns{2,is}  nt{2,it}  nd{2,jp} codan ]; %circa

%keyboard

%aggiusta
Xprov=Xprov+ double(Xprov>i); 
Xprov=Xprov+double(Xprov>j+1);
posj=find(Xprov==j+1,1,'last'); %2
Xprov(posj)=j+2;  %
posi=find(Xprov==i,1,'last');
Xprov(posi)=i+1;

XN=agg(XN,[Xprov Nprov]);


    end
   end
    end
        end
end
    end
end

end %if

    end %j
end %i


%coppia di indici con solo 2 in mezzo (e non 1 e 0) : faccio come triald2 e
%poi distribuisco gli altri ( i 2 come in triald2 e gli uni come in d1)





