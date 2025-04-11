function v=cambiobase(scremati,Msinha)
%parte lista di 690 termini e costruisce vettore lungo 2520
%devo aggiungo (con xor) un termine se 132 e due termini se 123 e 132
v(2520)=0;
%parte da scremati 690 x 13
% e Msinha 2520 x 13 
for i=1:size(scremati,1) %690

%dipende dalla posizione del 3 : 10 11 12 o 13
%nel primo caso vedo 1,2,3. secondo 3,4,5 , terzo 5,6,7 quarto 7,8,9
scremo=scremati(i,:);
f3=find(scremo(10:13)==3); %1 2 3 4, elementi da vedere sono 2*f3 2*f3+1
if scremo(2*f3)>scremo(2*f3+1)  %caso facile

for j=1:size(Msinha,1)  %2520    
if isequal(Msinha(j,:),scremo)
v(j)=xor(v(j),1);    
break; end    
end
    
else
    
    
    
scremobis=scremo;  %poi scambio
scremobis(2*f3+1)=scremo(2*f3);
scremobis(2*f3)=scremo(2*f3+1);


    %qui ci saranno due contributi
for j=1:size(Msinha,1)  %2520    
if isequal(Msinha(j,:),scremo) | isequal(Msinha(j,:),scremobis)
v(j)=xor(v(j),1);    
%non metto il break perchè non so quale viene prima
end    
end

end
end