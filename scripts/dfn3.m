function [X,N]=dfn3(pe,nu) %d of generator given as permutation + series of 0 and 1, to star
X=[]; N=[];


if size(pe,1)>1
XN=[];
    for ipe=1:size(pe,1)
    [Xpe,Npe]=dfn3(pe(ipe,:),nu(ipe,:));
XN=agg(XN,[Xpe, Npe])  ;      
    end
X=XN(:,1:size(pe,2)); 
N=XN(:,size(pe,2)+1:size(pe,2)+size(nu,2));
return
    
end



if max(nu)==0  %empty boundary, all zero
return
end


%check that l(nu)=l(pe)-1
%esempio pe=[1 3 2] nu=[0 1]
n=length(pe);
if not(length(nu)==n-1)
    disp('error')
end

%differenziale esplicito in fn2

fz=find(nu==0,1); %cerca zero
if isempty(fz)
    %caso speciale con 1 e 2   

  %PARTE UNO 
  funo=find(nu==1);
  
  %PARTE DUE
 if isempty(funo)
%ci sono solo due, in tutto n-1 2 e n punti, devo dividerli in due in tutti
%i modi possibili
Y=part(n,2); %cella di partizioni Y{1,.} e Y{2,.} complementari, secondo indice fino a 2^n, ma devo escludere il primo e l'ultimo (
%(partizione banale)
%metto dei 2  (oppure uso subset e setdiff?? c'era un qualche bug
for i=2:2^n-1
    %devo usare pe
    X=[X; [pe(Y{1,i}) pe(Y{2,i})]]; %shuffle 
m=length(Y{1,i}); %si potrebbe mettere come output di part
riga=[2*ones(1,m-1) 1 2*ones(1,n-m-1)];
    N=[N; riga];
end
    else
    
%se ci sono uni:   
%1) shuffle blocchi di uni
%funo da posizione degli uni (gli altri sono 2)
m1=length(funo); %lunghezza totale
bl{1}=pe(1:funo(1));  %testa
for i=2:m1 %uni dividono in m1+1 blocchi
bl{i}=pe(funo(i-1)+1:funo(i)); 
end
bl{m1+1}=pe(funo(m1)+1:n); %coda
%keyboard
P1=part(m1+1,2); %sono in tutto 2^m1 ma butto primo e ultimo
for i1=2:2^(m1+1) -1 
    %faremo shuffle a blocchi
v=[]; %controllare non appare    
nn=[];
for p1=P1{1,i1} %sono gli elementi 
v=[v bl{p1}]; 
bo=length(bl{p1});
nn=[nn 2*ones(1,bo-1) 1]; %2 tanti quanti con uno in meno
%devo metterci anche un uno qui qausi sempre
 

end
nn(length(nn))=[];  %toglie un uno di troppo alla fine
nn=[nn 0]; %mette lo 0

for p2=P1{2,i1}
v=[v bl{p2}]; 
bu=length(bl{p2});
nn=[nn 2*ones(1,bu-1) 1];
end
nn(length(nn))=[];
%ora vettore è pronto, lo aggiungo
X=[X;v]; 
N=[N;nn];

end

%2) applico dfn3 ai blocchi di 2 e incollo

%prima controllo eventuali 2 prima del primo uno
if funo(1)>1
[X2,N2] = dfn3(pe(1:funo(1)),2*ones(1,funo(1)-1)); %VIRGOLA ALL'INIZIO ???
%ora incolla
for j2=1:size(X2,1); %numero di righe anche uguale a quello di N2

X=[X ;    [ X2(j2,:) pe(funo(1)+1:n)]]; 

N=[N; [ N2(j2,:) nu(funo(1):n-1) ]];      
    end
end    

%ora quelli intermedi
for j1=1:m1-1 
    if funo(j1+1)>funo(j1)+1 
[X2 N2] = dfn3(pe(funo(j1)+1:funo(j1+1)),2*ones(1,funo(j1+1)-funo(j1)-1)); 
for j2=1:size(X2,1); %numero di righe

X=[X ; [pe(1:funo(j1)) X2(j2,:) pe(funo(j1+1)+1:n)            ]];
N=[N;   [nu(1:funo(j1)) N2(j2,:)   nu(funo(j1+1):n-1)       ]];        
end        
        
    end
end

%e poi quello finale
if funo(m1)<n-1 
[X2 N2] = dfn3(pe(funo(m1)+1:n), 2*ones(1,n-1-funo(m1)));
for j2=1:size(X2,1); %numero di righe
  %  keyboard
X = [X ; [pe(1:funo(m1))    X2(j2,:) ]];
N=   [N; [nu(1:funo(m1))    N2(j2,:)  ]];
end


end






    





    
    
end
else
 %quando ci sono 0   
   %ci saranno casi errati di sicuro..
   
pe1=pe(1:fz); %if fz=1 does not contirbute
nu1=nu(1:fz-1); %same
pe2=pe(fz+1:n);   %no contribution if fz=n-1
nu2=nu(fz+1:n-1); %
[X1,N1]=dfn3(pe1,nu1);
for i1=1:size(X1,1)
X=[X;[X1(i1,:) pe(fz+1:n)  ]]; 
N=[N;[N1(i1,:) 0 nu(fz+1:n-1)]];%sbagliato proprio
end

[X2,N2]=dfn3(pe2,nu2);
    for i2=1:size(X2,1)
X=[X;[pe(1:fz)    X2(i2,:)   ]]; 
        N=[N;[ nu(1:fz-1)  0 N2(i2,:) ]];%sbagliato proprio
    end




end



    
    