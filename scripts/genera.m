%base della coomologia di spazio di conf nel piano su n punti in dim. k
function XX=genera(n,k)
A=subset(n-1,k)+1; %si parte da 2
 %sara' matrice tripla 2*k*__
XX=[];
for u=1:size(A,1) %riga
X=[];
for i=1:k %posizione nella riga 
Y=[];
for j=1:A(u,i)-1
for ep=1:size(X,3)
Ad=[X(:,:,ep) , [A(u,i);j]  ];
%keyboard
Y=cat(3,Y,Ad);
end    
end    
X=Y;
end    
XX=cat(3,XX,X);
end