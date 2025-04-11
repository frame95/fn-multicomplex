function X = corde(n,k)
% base di Arnold delle k corde che toccano tutti gli n punti
if n>2*k | n<=k
    X=[]; return
end  
if n==2 && k==1  
    X=[2 ; 1]; return
end

X=[]; %inizio niente
if n < 2*k  %otherwise skip
P=corde(n-1,k-1); %previous , must add one chord from n to i
p=size(P,3); %quante
for i=1:n-1
orlo = [n*ones(1,1,p) ; i*ones(1,1,p)];
X=cat(3,X,[P,orlo]);
end
end

if n>k+1 %add one chord n--i where i was not used before
Q=corde(n-2,k-1); 
q=size(Q,3);
for i=1:n-1
orlo = [n*ones(1,1,q) ; i*ones(1,1,q)];
    v=[1:i-1 i+1:n-1]' ;
R= v(Q);
%keyboard
X=cat(3,X,[R,orlo]);    
end   
end
    
    
end

%ora aggiungo quelli piu piccoli 




