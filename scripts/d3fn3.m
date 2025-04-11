function XN=d3fn3(pe,nu) 
    XN=[];
%d3 per ora limitato a elementi con solo blocchi di 3 o 4 allineati in
%verticale, (icoè con 2 e 0 in nu)

if size(pe,1)>1
for ipe=1:size(pe,1) %n
ipe
XN =agg(XN,d3fn3(pe(ipe,:),nu(ipe,:)));  %PROVVISORIO velocizzare con recofox xor
    end
       
return
    
end

%check that l(nu)=l(pe)-1
n=length(pe);
if not(length(nu)==n-1)
    disp('error')
return
end

Z=find(nu==0); %tutte le posizioni di zero
%nu è lugno n-1
Z=[0 Z n]; %formalmente mette inizio fine così guarderemo in mezzo..
for iz=1:length(Z)-1
tri=[Z(iz)+1 : Z(iz+1)]; %posizioni due in pe da considerare
if length(tri)==3 
%vanno raddoppiati appropriatamente    

pet=pe(tri);
i=min(pet); k=max(pet); j=setdiff(pet,[i k]);


Xprov= [pe(1:Z(iz))  pet(1)       pet(2)    pet(1)     pet(3)      pet(2)    pet(3)    pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))            2          0          2           0         2         nu(Z(iz+1):n-1) ];


%aggiusto indici

Xprov=rinumera(Xprov,i,j,k);

XN= agg(XN , [Xprov nprov]);

Xprov= [pe(1:Z(iz))  pet(2)       pet(3)    pet(1)     pet(3)      pet(1)    pet(2)    pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))            2          0          2           0         2         nu(Z(iz+1):n-1) ];

Xprov=rinumera(Xprov,i,j,k);

XN= agg(XN , [Xprov nprov]);
end

%ora i blocchi da quattro
if length(tri)==4
%quattro casi, divisi in due
%caso in cui il punto estra è il primo
pet=pe(tri);
peo=pet(2:4); 
i=min(peo); k=max(peo); j=setdiff(peo,[i k]);

Xprov= [pe(1:Z(iz))  pet(1)       pet(2)    pet(3)     pet(2)      pet(4)    pet(3)   pet(4)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))            2        2          0          2           0         2         nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

Xprov= [pe(1:Z(iz))  pet(2)    pet(3)  pet(1)     pet(2)      pet(4)    pet(3)   pet(4)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))          2        0        2         2          0          2                 nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

Xprov= [pe(1:Z(iz))  pet(2)    pet(3)       pet(2)      pet(4)   pet(1)  pet(3)   pet(4)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))          2        0              2          0      2       2                 nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

Xprov= [pe(1:Z(iz))  pet(1)       pet(3)    pet(4)     pet(2)      pet(4)    pet(2)   pet(3)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))            2        2          0          2           0         2         nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

Xprov= [pe(1:Z(iz))  pet(3)    pet(4)  pet(1)     pet(2)      pet(4)    pet(2)   pet(3)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))          2        0        2         2          0          2                 nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

Xprov= [pe(1:Z(iz))  pet(3)    pet(4)       pet(2)      pet(4)   pet(1)  pet(2)   pet(3)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))          2        0              2          0      2       2                 nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

%ORA IL CASO IN cui il punto extra è l'ultimo
peo=pet(1:3); 
i=min(peo); k=max(peo); j=setdiff(peo,[i k]);

Xprov= [pe(1:Z(iz))  pet(1)       pet(2)    pet(4)     pet(1)      pet(3)    pet(2)   pet(3)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))            2        2          0          2           0         2         nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

Xprov= [pe(1:Z(iz))  pet(1)    pet(2)  pet(1)     pet(3)      pet(4)    pet(2)   pet(3)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))          2        0        2         2          0          2                 nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

Xprov= [pe(1:Z(iz))  pet(1)    pet(2)       pet(1)      pet(3)   pet(2)  pet(3)   pet(4)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))          2        0              2          0      2       2                 nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

Xprov= [pe(1:Z(iz))  pet(2)       pet(3)    pet(4)     pet(1)      pet(3)    pet(1)   pet(2)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))            2        2          0          2           0         2         nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

Xprov= [pe(1:Z(iz))  pet(2)    pet(3)  pet(1)     pet(3)      pet(4)    pet(1)   pet(2)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))          2        0        2         2          0          2                 nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

Xprov= [pe(1:Z(iz))  pet(2)    pet(3)       pet(1)      pet(3)   pet(1)  pet(2)   pet(4)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))          2        0              2          0      2       2                 nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

%ora consieriamo punto extra = secondo
peo=pet([1 3 4]); 
i=min(peo); k=max(peo); j=setdiff(peo,[i k]);

Xprov= [pe(1:Z(iz))  pet(1)       pet(2)    pet(3)     pet(1)      pet(4)    pet(3)   pet(4)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))            2        2          0          2           0         2         nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

Xprov= [pe(1:Z(iz))  pet(1)    pet(3)  pet(1)     pet(2)      pet(4)    pet(3)   pet(4)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))          2        0        2         2          0          2                 nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

Xprov= [pe(1:Z(iz))  pet(1)    pet(3)       pet(1)      pet(4)   pet(2)  pet(3)   pet(4)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))          2        0              2          0      2       2                 nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

Xprov= [pe(1:Z(iz))  pet(2)       pet(3)    pet(4)     pet(1)      pet(4)    pet(1)   pet(3)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))            2        2          0          2           0         2         nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

Xprov= [pe(1:Z(iz))  pet(3)    pet(4)  pet(1)     pet(2)      pet(4)    pet(1)   pet(3)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))          2        0        2         2          0          2                 nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

Xprov= [pe(1:Z(iz))  pet(3)    pet(4)       pet(1)      pet(4)   pet(1)  pet(2)   pet(3)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))          2        0              2          0      2       2                 nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

%caso in cui il punto extra è il terzo
peo=pet([1 3 4]); 
i=min(peo); k=max(peo); j=setdiff(peo,[i k]);

peo=pet([1 2 4]); 
i=min(peo); k=max(peo); j=setdiff(peo,[i k]);

Xprov= [pe(1:Z(iz))  pet(1)       pet(2)    pet(3)     pet(1)      pet(4)    pet(2)   pet(4)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))            2        2          0          2           0         2         nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

Xprov= [pe(1:Z(iz))  pet(1)    pet(2)  pet(1)     pet(3)      pet(4)    pet(2)   pet(4)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))          2        0        2         2          0          2                 nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

Xprov= [pe(1:Z(iz))  pet(1)    pet(2)       pet(1)      pet(4)   pet(2)  pet(3)   pet(4)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))          2        0              2          0      2       2                 nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

Xprov= [pe(1:Z(iz))  pet(2)       pet(3)    pet(4)     pet(1)      pet(4)    pet(1)   pet(2)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))            2        2          0          2           0         2         nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

Xprov= [pe(1:Z(iz))  pet(2)    pet(4)  pet(1)     pet(3)      pet(4)    pet(1)   pet(2)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))          2        0        2         2          0          2                 nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

Xprov= [pe(1:Z(iz))  pet(2)    pet(4)       pet(1)      pet(4)   pet(1)  pet(2)   pet(3)     pe(Z(iz+1)+1:n) ];   
nprov=[ nu(1:Z(iz))          2        0              2          0      2       2                 nu(Z(iz+1):n-1) ];
Xprov=rinumera(Xprov,i,j,k);
XN= agg(XN , [Xprov nprov]);

end
end
    



