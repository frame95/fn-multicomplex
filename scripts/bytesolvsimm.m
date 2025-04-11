function [A,r,jb,jbad] = bytesolvsimm(I,J,p,m,n,t,cp,Inoto,pnoto,r)   %r rango iniziale
%parto da matrice m x n di permutazioni p in posto I,J 
%provo a fare riduzione non in bit ma in bytes
%cp= matrice comppermew(t)


%NON RIDUCE l'ULTIMA RIGA ATTENZIONE
%ma la cambia o no???

%si potrebbero anche togliere tutti i pezzi della memoria..

%qui noto sarebbe una serie di permutazioni
%e di posizioni riga

%******
%OCCHIO QUI A è la matrice aumentata!!! m x (n+1)
%***********


%r=0; %initial rank
ft=factorial(t);

A(m,n,ft)=uint8(0);
B(m,1,ft)=uint8(0);


for i=1:length(I)
A(I(i),J(i),p(i))=1;
end

for i=1:length(Inoto)
   B(Inoto(i),1,pnoto(i))=1; 
end

A=cat(2,A,B); %ho aggiunto il termine noto!




invp=uint32(invpermnew(t)); %vector for inverse permutation
pid=ft; %identita

% Loop over the entire matrix.
i=r+1;  
j=1;   
%ib=[];
jb =[]; %cambiato perchè tanto si fa tutto in pezzi
jbad=[];
%RE=[];
%RS=[];
%piv=[];
%molt1=[];
%molt2=[];
%cancella i vecchi dati

%tic
while (i <= m) & (j <= n)
 V=reshape(A(i:m,j,:),m-i+1,ft);
 idx=find(sum(V,2)==1,1); %cerca nel vettore colonna che ricorda il numero di permutazioni gli 1
  
     if isempty(idx)
       if not(isempty(find(sum(V,2))))
       jbad=[jbad j]; %shift del numero di colonne della vecchia matrice   
       end
       
       j=j+1;
 %problema perche' non opera piu'  sulle colonne precedenti..spostarle in fondo..    
                      %non ci sono in questa colonna singole permutazioni: occorre scambiare colonne...maggior grado di difficoltà
      else
      k=idx+i-1;
      r=r+1;
      r*factorial(t) %mostra il rango non equivariante
      jb = [jb j]; %shift del numero di colonne della vecchia matrice
      % Swap i-th and k-th rows.
      
      EX=A(i,:,:); UX=A(k,:,:);
      A(i,:,:)=UX;
      A(k,:,:)=EX;
  %    RE(i)=uint32(k); %row exchange %lo vogliamo memorizzare??NO


%fa la stessa cosa per B      
      
          piv=find(A(i,j,:)); %numero della permutazione 
          %moltiplica la riga per l'inversa del pivot se non e' la
          %permutazione banale
          if not(isequal(piv,pid))
          mix=cp(piv,:);
              A(i,1:n+1,:)=A(i,1:n+1,mix);    
                    end              
          
          W=reshape(A(:,j,:),m,ft);   
       K=setdiff(find(sum(W,2)),i); %finds rows where permutations appear
          if not(isempty(K)) %
    
     %   RS{i}=uint32(K); %store row sum operation : sum i to k rows, k in K
        %massimo 2^32 va bene 
           
       %relevant non-zero elements along the pivot column
      % molti=squeeze(bitget(A(K(ik),j,:),b)); %moltiplicatore visto come sequenza di  0 e 1, forse si può convertire in stringa
%---------------------------prova per risparmiare memoria: no doppia cella
        molti=reshape(A(K,j,:),length(K),ft); %come squeeze ma sono sicuro 
       [ux,uy]=find(molti); % ux=ordine riga diK, uy=permutazione. Così sono già ordinati gli ux
     %  molt1{i}=uint32(ux); %mette in memoria la riga comprimendo
        %stesso di RS pero' posso avere ripetizioni
     %  molt2{i}=uint32(uy); %questa è la permutazione
       
     %-----------------------------------------------------       
    
sigme=unique(uy); ls=length(sigme);
for is=1:ls
    inizio=find(uy==sigme(is),1); fine=find(uy==sigme(is),1,'last');   
riga=ux(inizio:fine);
lr=fine-inizio+1; %=length(riga);    
     
     mix=cp(invp(sigme(is)),:);  
   A(K(riga),1:n+1,:)=xor( A(i*ones(1,lr),1:n+1,mix), A(K(riga),1:n+1,:));
     
            end %is
    end%
       
      i = i + 1;
      j = j + 1;
 end
end
 