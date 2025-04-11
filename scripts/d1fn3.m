function [X,N,XNres,XN,XN0,XNlast]=d1fn3(pe,nu) %d of generator given as permutation + series of 0 and 1, to start

%blocco per più di una riga
if size(pe,1)>1
XNres=[];  XN0=[]; XNlast=[]; 
for i=1:size(pe,2) %n

    XN{i}=[];
end

    for ipe=1:size(pe,1)
ipe
        [Xdull,Ndull,XNresd,XNd,XN0d,XNlastd]=d1fn3(pe(ipe,:),nu(ipe,:));
for i=1:size(pe,2)
   XN{i}=agg(XN{i},XNd{i}); 
end
    XN0=agg(XN0,XN0d)  ;      
    XNlast=agg(XNlast,XNlastd)  ;      
        XNres=agg(XNres,XNresd)  ;      
    end
X=XNres(:,1:size(pe,2)+1); 
N=XNres(:,size(pe,2)+2:2*size(pe,2)+1);
return
    
end
%blocco per una sola riga



%esempio input: pe=[1 3 2] nu=[0 1]
%calcola d1 su fn3 
%ricordare il punto all'infinito !
%check that l(nu)=l(pe)-1
n=length(pe);
if not(length(nu)==n-1)
    disp('error')
return
end

for i=1:n
    XN{i}=[];
end


%parte facile: d_0
X1=[1 pe+1]; 
N1=[0 nu]; 
XN0=[X1 N1];

%d_last
X1=[pe n+1]; N1=[nu 0];
XNlast=[X1 N1];

%d doubling i into i  i+1
for i=1:n
fi=find(pe==i); %position of i
F=find(nu(1:fi-1)==0,1,'last'); %ultimo zero prima
L=find(nu(fi:n-1)==0,1); %primo zero dopo, da rinumerare!
if isempty(F) 
    F=0;
end
if isempty(L)
    L=n;
else
    L=L+fi-1;
end

%cerco 1 tra F e fi (esclusi)
funo=find(nu(F+1:fi-1)==1);
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

funto=find(nu(fi:L-1)==1);
    n1=length(funto);
for ip=1:2^(n1) %si fa anche nel caso vuoto
vd{1,ip}=[]; nd{1,ip}=[];
vd{2,ip}=[]; nd{2,ip}=[];
end

    

if not(isempty(funto))
    funto=funto+fi-1;
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
    %poi i 2 sotto

%parte dei 2 ...    
    
if not(isempty(funo))
    left2=funo(m1)+1; %circa
else
    left2=F+1; %circa
end

if not(isempty(funto))
    right2=funto(1); %per pe
else
    right2=L; 
end

m2=fi-left2;

for i2=1:2^(m2)
q{1,i2}=[]; %sufficiente a pulire tutto quello che serve ?? no
q{2,i2}=[];
nq{1,i2}=[];
nq{2,i2}=[];
end

if m2>0
Q=part(m2,2); 
for ip=1:2^m2 %direttamente
q{1,ip}=pe(left2+Q{1,ip}-1);%potrebbe essere vuoto e far casino ?? 
q{2,ip}=pe(left2+Q{2,ip}-1); %idem
nq{1,ip}=2*ones(1,length(Q{1,ip})) ;  %stessa cardinalità di quello sopra
nq{2,ip}=2*ones(1,length(Q{2,ip})) ;  %stessa cardinalità di quello sopra

end
end

n2=right2-fi; 
for i2=1:2^n2
r{1,i2}=[]; %sufficiente a pulire tutto quello che serve ?? direi di si
r{2,i2}=[];
nr{1,i2}=[];
nr{2,i2}=[];
end

if n2>0
R=part(n2,2); %circa
for ip=1:2^n2
r{1,ip}=pe(fi+R{1,ip});
r{2,ip}=pe(fi+R{2,ip});
nr{1,ip}= 2*ones(1,length(R{1,ip}));
nr{2,ip}= 2*ones(1,length(R{2,ip}));
end
end
%poi suddividere in cella

%anche rinumerare quelli dopo azz..si puo fare alla fine prima della fine
%cicn2lo i
 
%quindi fare tutte le unioni possibili, attenzione al caso vuoto
    
%mi chiedo se non fosse meglio fare i casi separati come con 
%in modo iterato, dividendo in casi: niente 0, 0 a sinistra , 0 a destra,
%niente 0: 1 a sinistra, 1 a destra
%niente 1: 2 a sinistra, 2 a destra
    
%mettere in fila le cose da comporre...

inizio=pe(1:F); 
inizion=nu(1:F);

coda=pe(L+1:n);
codan=nu(L:n-1); %compreso lo 0 eventuale

for ip=1:2^m1
    for jp=1:2^n1
for iq=1:2^m2
    for ir=1:2^n2 
        
Xprov= [inizio vs{1,ip} q{1,iq} i r{1,ir} vd{1,jp}    vs{2,ip} q{2,iq} i r{2,ir} vd{2,jp} coda]; %ripeto i


%TEMPORANEO PER IL CONTROLLO

Xprov=Xprov + double(Xprov>i); %aggiunge 1 da i+1 in poi 
%ora deve spostare il secondo i in i+1
pos=find(Xprov==i,1,'last');
Xprov(pos)=i+1; 


Nprov= [inizion ns{1,ip} nq{1,iq} nr{1,ir} nd{1,jp} 0 ns{2,ip} nq{2,iq} nr{2,ir} nd{2,jp} codan ]; %circa

%keyboard

XN{i}=[XN{i}; [Xprov Nprov]]; %forse agg non necessario sono tutti distinti? direi di si


end
end
end
end



end%i   

%ora metto insieme
XNres=XN0; %d0
for i=1:n
XNres=agg(XNres,XN{i}); %di    
end
XNres=agg(XNres,XNlast); %dlast


X=XNres(:,1:n+1); %uno in piu
N=XNres(:,n+2:2*n+1);