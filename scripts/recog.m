function V=recog(X,B) %vector represented by sequence of distinct basis elements
%X and B are trimatrices
x=size(X,3); b=size(B,3);
V=zeros(1,b);
for i=1:x
for j=1:b
    if isequal(X(:,:,i),B(:,:,j)) 
        V(j)=1; break; end
end
end
