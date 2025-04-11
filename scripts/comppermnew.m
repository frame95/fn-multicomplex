function ciuccio=comppermnew(n)
ciuccio(factorial(n),factorial(n))=uint64(0); %setta la dimensione
%table for composition of permutations. Output: a matrix describing effect
%on rows of perms(1:n)
P=perms(1:n);

for i=1:factorial(n)
i;
    for j=1:factorial(n)
        C=P(i,P(j,:));
w=numeroperm(C);
        %        for w=1:factorial(n)
%            if isequal(C,P(w,:))
                ciuccio(i,j)=w; 
                
%            end
 %       end
    end
end
