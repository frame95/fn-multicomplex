function XN=triald2fn3(pe,nu) %d of generator given as permutation + series of 0 and 1, to start
    XN=[];

%d2 per ora limitato a elementi che vengono da cicli (con 2 e 0 e non uni)

%per questa parte vedere se è più efficiente convertire in [I,p] con
%recofox ciascuna riga e poi fare xor
%blocco per più di una riga
if size(pe,1)>1
for ipe=1:size(pe,1) %n

XN =agg(XN,triald2fn3(pe(ipe,:),nu(ipe,:)));
    end
       
return
    
end

%esempio input: pe=[1 3 2 4] nu=[2 2 0]
%check that l(nu)=l(pe)-1
n=length(pe);
if not(length(nu)==n-1)
    disp('error')
return
end




%qui facciamo diversamente: vediamo dove sono i blocchi (separati dagli
%zeri)  e oer ciascun blocco scegliamo due valori, e li raddoppiamo

Z=find(nu==0); %tutte le posizioni di zero
%nu è lugno n-1
Z=[0 Z n]; %formalmente mette inizio fine così guarderemo in mezzo..
for iz=1:length(Z)-1
dui=[Z(iz)+1 : Z(iz+1)]; %posizioni due in pe da considerare
for ii=1:length(dui)
%ii
    for ij=ii+1:length(dui)
%ij
        i=pe(dui(ii));
 j=pe(dui(ij));
%ora devo sdoppiare gli elementi prima di posi  

%devo settarli tutti vuoti..
m2=ii-1; %circa
     if m2>0 
Q=part(m2,3); 
for ip=1:3^m2 %direttamente
q{1,ip}=pe(Z(iz)+Q{1,ip});%potrebbe essere vuoto e far casino ?? no
q{2,ip}=pe(Z(iz)+Q{2,ip}); %idem
q{3,ip}=pe(Z(iz)+Q{3,ip}); %idem

nq{1,ip}=2*ones(1,length(Q{1,ip})) ;  %stessa cardinalità di quello sopra
nq{2,ip}=2*ones(1,length(Q{2,ip})) ;  %stessa cardinalità di quello sopra
nq{3,ip}=2*ones(1,length(Q{3,ip})) ;  %stessa cardinalità di quello sopra

end

     else
         q{1,1}=[];
         q{2,1}=[];
         q{3,1}=[];

         nq{1,1}=[];
nq{2,1}=[];
nq{3,1}=[];

     end
        
%cosa simile per quelli *dopo* ij
n2=length(dui)-ij;     
     if n2>0
R=part(n2,3);
for ir=1:3^n2
    r{1,ir}=pe(R{1,ir}+dui(ij));
    r{2,ir}=pe(R{2,ir}+dui(ij));
   r{3,ir}=pe(R{3,ir}+dui(ij));

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
    u2=ij-ii-1;
if u2>0
V=part(u2,3);    
    for iv=1:3^u2
        for ipic=1:3 %ciclo per far prima
        v{ipic,iv}=pe(V{ipic,iv}+dui(ii));
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
      %fine della suddivisione , adesso mettiamo insieme
  
   inizio=pe(1:Z(iz));
   coda =pe(Z(iz+1)+1:n);
    inizion= nu(1:Z(iz));
    codan=nu(Z(iz+1):n-1);
    
for ip=1:3^m2
    for ir=1:3^n2
    for iv=1:3^u2 
        
Xprov= [inizio  q{1,ip} i  v{1,iv}  j  r{1,ir}      q{2,ip} i v{2,iv}  r{2,ir}    q{3,ip}   v{3,iv}   j r{3,ir}  coda]; %ripeto i
 nprov=[inizion nq{1,ip}  nv{1,iv}  2  nr{1,ir}  0   nq{2,ip}   nv{2,iv} nr{2,ir}  1 nq{3,ip} nv{3,iv} nr{3,ir} codan]; %notare l'uno

 
 %OCCHIO POSSONO ESSERCI CANCELLAZIONI: usare agg, o meglio recofox e xor


mj=max(i,j);
mi=min(i,j);
Xprov=Xprov+ double(Xprov>mi); 
Xprov=Xprov+double(Xprov>mj+1);
posj=find(Xprov==mj+1,1,'last'); %2
Xprov(posj)=mj+2;  %
posi=find(Xprov==mi,1,'last');
Xprov(posi)=mi+1;

XN= agg(XN , [Xprov nprov]);

 %DA MODIFICARE
%Xprov=Xprov + double(Xprov>i); %aggiunge 1 da i+1 in poi 
%ora deve spostare il secondo i in i+1
%pos=find(Xprov==i,1,'last');
%Xprov(pos)=i+1; 
%poi c'è altro termine       
Xprov=[inizio  q{1,ip} v{1,iv} j  r{1,ir}   q{2,ip}  i  v{2,iv} r{2,ir}  q{3,ip} i v{3,iv} j r{3,ir} coda ];    
nprov=[inizion  nq{1,ip} nv{1,iv} nr{1,ir} 1 nq{2,ip} nv{2,iv} nr{2,ir}  0 nq{3,ip} 2 nv{3,iv} nr{3,ir} codan];     

mj=max(i,j);
mi=min(i,j);
Xprov=Xprov+ double(Xprov>mi); 
Xprov=Xprov+double(Xprov>mj+1);
posj=find(Xprov==mj+1,1,'last'); %2
Xprov(posj)=mj+2;  %
posi=find(Xprov==mi,1,'last');
Xprov(posi)=mi+1;



XN=agg(XN, [Xprov nprov]);


%suppongo i<j. No più furbo: aggiungo 1 ai piu grandi i , e poi 1 ai piu'
%grandi di j
%1) aggiungo 2 da j+1 in poi
%2) aggiungo 2 al secondo j
%3) aggiungo 1 da i+1 a j
%4) aggiungo 1 al secondo i
    end
    end
end
    end
end
end
    
    
    
%fine    
%