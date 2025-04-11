function Z=attacca(X,Y)

Z=[];
%righe di X, righe di Y e viceversa
for i=X'
    for j=Y'
        Z=[Z; [i' j']];
    end
end