function X=inverse(Y) 
%inverte le righe che sono permutazioni di una trimatrice
sx=size(Y,1);sy=size(Y,3); n=size(Y,2);
X=zeros(sx,n,sy);
for x=1:sx
    for y=1:sy
        for i=1:n
    X(x,i,y)=find(Y(x,:,y)==i) ;
        end; end; end
        