function [r,A,jb,RE,RS] = bitrango32(As) %specify top memory size for I and J
%function [r,jb] = bitrango32(As) %specify top memory size for I and J
As=mod(As,2);
%occhio deve essere data matrice di 0 e 1


%rango a pezzi, in gruppi di 4 bytes. il passo iniziale e' un calcolo del rango 
%tic


[m,ns] = size(As);
r=0;

n=(ns-1-rem(ns-1,32))/32+1;

A(m,n)=uint32(0); %definisce nuova matrice di bytes


%parte da una matrice sparsa e la trasforma in matrice di bit
[I,J]=find(As);
for i=1:length(I)
j=(J(i)-1-rem(J(i)-1,32))/32+1;    %int8((J(i)-1)/8)+1;
A(I(i),j)=bitset(A(I(i),j) , 32-rem(J(i)-1,32));
end

%keyboard


% Loop over the entire matrix.
i=1;  %i = 1;
js=1;   %j = 1;
ib=[];
jb =[];
while (i <= m) & (js <= ns)
 j=(js-1-rem(js-1,32))/32+1;
 b=32-rem(js-1,32);
 V=bitget(A(i:m,j),b);
 
    idx=find(V); %cambio
 
% keyboard     
   
   if isempty(idx)
      js = js + 1;
 else
     idx=idx(1); 
     k=idx+i-1;  %row with non trivial element
      %warning : it could be >i but still there is element in row i
      % Remember row and column index
      
      r=r+1; %provvisorio senza ;
      ib=[ib i]; %non è necessario
      jb = [jb js];

%      if rem(i,1000)==1 %provvisorio
 %          keyboard
  %    end
      
     
      
      % Swap i-th and k-th rows.
      
      A([i k],:)=A([k i],:);
      RE(i)=k; %row exchange
      
      W=bitget(A(:,j),b);
       K=setdiff(find(W),i); %this puts an ordering
    
       RS{i}=K; %row sum operation : sum i to k rows, k in K
 %       keyboard  
   %   [i js length(K)]
       for k=K'
        %relevant non-zero elements along the pivot column
      
      A(k,:)=bitxor(A(i,:),A(k,:));
     % keyboard
       end      
%tentativo di velocizzare
 %keyboard
%A(K,j:n)=bitxor(uint8(ones(length(K),1))*A(i,j:n), A(K,j:n));
       
       
       
  %troppi cambi di j..
      i = i + 1;
      js = js + 1;
 end
end

 %keyboard

%somma i risultati
%jb=[ja jb+n];%colonne dei pivot
%RE=[REA RE];%row exchanges
%RS=[RSA RS];%row sums


%toc
 