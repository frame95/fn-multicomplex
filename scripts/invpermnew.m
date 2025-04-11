function in=invpermnew(n)
%table for inverse permutation. Output:vector describing the effect of
%inverse map on the n! rows of perms(1:n) 
P=perms(1:n);
Q=inverse(P);
in=zeros(1,factorial(n));
   for j=1:factorial(n)

       i=numeroperm(Q(j,:));
       
%       if isequal(Q(j,:),P(i,:))
           in(i)=j;
   end
end