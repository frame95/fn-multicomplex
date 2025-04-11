function V=recog2(X,B) %vector represented by sequence of distinct
%rows in matrix
x=size(X,1); b=size(B,1);
V=zeros(b,1);
for i=1:x
for j=1:b
    if isequal(X(i,:),B(j,:)) 
        V(j,1)=1; break; end
end
end

