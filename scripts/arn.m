%riduce alla base canonica di Arnold-Cohen
function X=arn(A)
s=size(A,3);
if s>1 
A1=arn(A(:,:,1));
A2=arn(A(:,:,2:s));
X=ag(A1,A2);
return;
end



for i=1:size(A,2) %no colonna costante
if A(1,i)==A(2,i) 
X=[]; return; end 
for j=i+1:size(A,2)
if (A(1,i)==A(1,j) && A(2,i)==A(2,j))    
X=[]; return; end  %no colonne uguali
end    
end

%metto in ordine standard 
for i=1:size(A,2)-1
if A(1,i)>A(1,i+1)
A(:,[i i+1])=A(:,[i+1 i]); 
X=arn(A);
return;  end 
if A(1,i)==A(1,i+1)   
u=max(A(2,i:i+1));
v=min(A(2,i:i+1));
A1=[A(:,1:i-1),[u;v],[A(1,i);u],A(:,i+2:size(A,2))]; 
A2=[A(:,1:i-1),[u;v],[A(1,i);v],A(:,i+2:size(A,2))]; 
B=cat(3,A1,A2);
X=arn(B);
return; end
end
X=A;


