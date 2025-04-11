%riduce da Sn a Sn-1 una matrice sparsa 
function [Ia,Ja,pa,ia,ja]=Smenuno(I,J,p,ii,jj,n,cp);
%da matrice su Sn a matrice su An (gruppo alterno)
%cp=comppermnew(n); %per ora
ip=invpermnew(n);
P=perms(1:n);
nf=factorial(n);

%ciclo=factorial(n)-1; 
lI=length(I);
%Ia=[]; Ja=[]; pa=[];
ia=n*ii;
ja=n*jj;

Ia=[];
Ja=[];
pa=[];

%scegliamo rappresentanti per le classi laterali (sinistre) g_k H del
%sottogruppo H
%che fissa 1: l'identita' ha numero n!
%di quello che manda 1 in 2 è (n-1)! (n-1)
%1 quello che manda 1 in k è (n-1)! (n+1-k)


for i=1:length(I)
%consideriamo elemento e vediamo in che classe laterale sta
k=P(p(i),1); %quindi numero n!(n+1-k)
%ora scriviamo p(i) come g_k h con h in H



pa=[pa cp(ip(factorial(n-1)*(n+1-k)),p(i))-(n-1)*factorial(n-1)];   %numero dell'elemento in Sigma_n Per il numero in Sigma_{n-1} 
%basta togliere (n-1)!(n-1) (c'è uno shift: Sigma_{n-1} permutazioni di
%2....n
%devo inserire tale elemento nel posto Ia=n*(I(i)-1)+k   Ja=n*(J(i)-1)+1
%perche' moltiplicando per elementi in J vado a finire in I, quindi da
%classe 1 a classe k
Ia = [Ia n*(I(i)-1)+k ]; 
Ja=  [Ja n*(J(i)-1)+1] ;



%ora dove vanno a finire gli altri elementi ? cioè oltre a g_1=id,
%g_2,...,g_n  ?
%devo scrivere g_j (g_k h) = g_l h' =permutazione l
for j=2:n 
pl=cp(p(i),factorial(n-1)*(n+1-j));
l=P(pl,1);
pa=[pa cp(ip(factorial(n-1)*(n+1-l)),pl)-(n-1)*factorial(n-1)];   %numero dell'elemento in Sigma_n Per il numero in Sigma_{n-1} 
Ia=[Ia n*(I(i)-1)+ l]; 
Ja=[Ja n*(J(i)-1)+j];

end %j
end%i


%NO IL PRPBLEMA NON E' LA RIDONDANZA MA IL VERSO DELLA COMPOSIZIONE
%QUINDI RIMETTIAMO LE COSE COME SONO..

