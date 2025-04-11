function [t,Ix,px]=solvsimmnew(I,J,p,mm,nn,t,Inoto,pnoto,cpt)
%risolve un sistema lineare con simmetria passando 
%da Sn simmetria a Sn-1...e così via
%migliora bytesolvsymm

%finora mi dice solo a che stadio si interrompe la ricorsione
punti=t; %massimo
r{punti+1}=0; %serve dopo
m{t}=mm;
n{t}=nn;

cp{t}=cpt;   %o meglio dato da input!
[A,r{t},jb{t},jbad{t}] = bytesolvsimm(I,J,p,mm,nn,t,cp{t},Inoto,pnoto,0);
jb{t}=jb{t}';

%A è un tensore m+1 x n x t!
%controlliamo la colonna temrine noto

[is{t},psol{t}]=find(A(:,nn+1,:));
%elementi del termine noto

while max(is{t}) > r{t}     %cioè caso cattivo
%devo aggiungere termine noto alle colonne cattive
%jbad=[jbad n{t}+1];  
        
    %ok e scrivi la souluzione altrimenti
if t==1 | isempty(jbad{t})
    disp('This equation has no solution')
   return 
end

A1= A(1:m{t},jbad{t},:);   %cambio, considero tutte le colonne
I1=[]; J1=[]; p1=[];
%estrarre I,J,p da qui
for ip=1:size(A1,3) %cioè t fattoriale
[i,j]=find(A1(:,:,ip));
for in=1:length(i)
    I1=[I1 ; i(in)]; J1=[J1 ; j(in)];  %COLONNA
end
p1=[p1 ; ip*ones(length(i),1)]; 
    
end

B1= A(1:m{t},n{t}+1,:);   %nuovo termine noto da ridurre 
[Ino,pno]=find(B1(:,1,:)); %in pratica è una matrice
    
%ora riduciamo nuovamente

[Ia,Ja,pa,ia,ja]=Smenuno(I1,J1,p1,m{t},length(jbad{t}),t,cp{t}); 

m{t-1}=ia;
n{t-1}=ja;   

[Inoto,pnoto]=Smenunonoto(Ino,pno,m{t},t,cp{t}); %dovrebbe essere la stessa ia

t=t-1; %e si continua la ricorsione
ft=factorial(t);
%cp=comppermnew(t); %si può anche dedurre direttamente (vedi altri programmi)
cp{t}=cp{t+1}(ft*t+1:ft*(t+1),ft*t+1:ft*(t+1))-ft*t;

%keyboard

[A,r{t},jb{t},jbad{t}] = bytesolvsimm(Ia,Ja,pa,ia,ja,t,cp{t},Inoto,pnoto,r{t+1}*(t+1)); %parte dal rango già fatto
%così viene rango piu grande ovviamente

jb{t}=jb{t}'; %due istruzioni cosi per avere colonne

[is{t},psol{t}]=find(A(:,size(A,2),:));

end
%keyboard
%ora ricostruzione
%sono arrivato a t e devo tornare a "punti"
%mi basta l'informazione di is{t} ma va organizzata..
%for it=t:punti  %taglia cose oltre il rango locale
%dove=find(is{it} <= r{it});
%is{it}=is{it}(dove);
%psol{it}=psol{it}(dove);
%end
%ho dimenticato jbad
%JBad{t}=[]; 
%colonne cattive 
%for jbt=1:length(jbad{t})
%   JBad=[JBad jbad(jbt)r


dove=find(is{t}>r{t+1}*(t+1));
buoni=is{t}(dove); % considera solo quelli
altro=find(is{t}<= r{t+1}*(t+1));
%quelli da usare dopo come indici
Ix=jb{t}(buoni-r{t+1}*(t+1)); 
%devo partire da quel numero...ma se t=punti mi da errore e quindi devo
%agiugngere all'inizio r{punti+1}=0
px=psol{t}(dove);
iy=is{t};
py=psol{t}; %per la ricorsione

for indice=t+1:punti
%aggiusto 
k=rem(Ix-1,indice)+1; 
Ix= (Ix-1-rem(Ix-1,indice))/indice+1; %+  r{indice}; %non basta bisogna inserirlo nei posti di jbad che deve essere cella!!!!!
for ipx=1:length(px) %vettore riga vero?
px(ipx)=cp{indice}(factorial(indice-1)*(indice+1-k(ipx)),px(ipx)+factorial(indice-1)*(indice-1)); 
end
Ix=jbad{indice}(Ix)';  %vediamo se va meglio  

iy=iy(altro);
py=py(altro);
h=rem(iy-1,indice)+1;
iy=(iy-1-rem(iy-1,indice))/indice+1; 
for ipx=1:length(altro); %verificare se è una riga !!!
py(ipx)=cp{indice}(factorial(indice-1)*(indice+1-h(ipx)),py(ipx)+factorial(indice-1)*(indice-1));
end

dove= find(iy>r{indice+1}*(indice+1));
altro=find(iy<= r{indice+1}*(indice+1));
buoni=iy(dove);

Iy=jb{indice}(buoni-r{indice+1}*(indice+1));

Ix=[Ix;Iy];
px=[px ; py(dove)];



end
   
    
    



