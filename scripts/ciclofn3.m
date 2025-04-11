function FN=ciclofn3(C) %cicli geometrici che rappresentano classe di omologia (corda) di fox-neuwirth_3 (conf. in R^3)
%la prima riga è l'elemento della base di Sinha associato (in top dimension
%dello spazio di configurazioni)


if size(C,3)>1  %trimatrice
FN=[];
    for it=1:size(C,3)
     FN=agg(FN,ciclofn3(C(:,:,it)));
    end
    return
end


        

%per R^m basta sostituire 2 con m-1
n=max(max(C)); %numero di indici
k=size(C,2); %lunghezza stringa 
[F,coin]=ciclofox(C,1);
N= 2*ones(size(F,1),size(F,2)-1); %considera i 2

nuovi=setdiff([1:n],coin); 
while not(isempty(nuovi))
i=min(nuovi);
[Fi,coini]=ciclofox(C,i);

F=attacca(F,Fi); %attacca solo le righe invece di fare scambia 
N=attacca(N,attacca(0,2*ones(size(Fi,1),size(Fi,2)-1)));    


nuovi=setdiff(nuovi,coini);

end

FN=[F N];
