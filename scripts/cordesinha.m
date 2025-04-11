function FN=cordesinha(C) 
%elemento di sinha associato a una generatore di omologia corda
%per esempio porta 
%[3 4 5;1 2 1] in   1 5 3 2 4   3 2
if size(C,3)>1
FN=[];
    for iC=1:size(C,3)  
iC    
FN=[FN; cordesinha(C(:,:,iC))];
    end
return    
end



n=max(max(C)); %numero di indici
k=size(C,2); %lunghezza stringa 
F=ciclocorde(C,1);
%N= 2*ones(size(F,1),size(F,2)-1); %considera i 2
N=length(F);

nuovi=setdiff([1:n],F); 
while not(isempty(nuovi))
i=min(nuovi);
Fi=ciclocorde(C,i);
Ni=length(Fi);

F=[F Fi]; %attacca solo le righe invece di fare scambia 
%N=attacca(N,attacca(0,2*ones(size(Fi,1),size(Fi,2)-1)));    
N=[N Ni];


nuovi=setdiff(nuovi,Fi);

end

FN=[F N];
