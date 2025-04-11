function [F,coinvolti]=ciclofox(C,i)
%la prima riga del risultato dovrebbe essere il rappresentante della base
%di Sinha associato a C (non è la stessa base ma il pairing è perfetto)

%routine che poi serve a ciclofn3
%if size(C,1)>1
%F=[];
 %   for ii=1:size(C,1)
 % F=a   
        
        
        
%costruisce un ciclo che rappresenta una classe di omologia nel complesso
%di fn3, apartire da un diagramma di corde C
%considero solo la parte delle permutazioni, poi gli indici delle
%coordinate saranno sempre 2

%coinvolti: indici degli elementi che si ottengono (pianeti e satelliti)

%inizio: consideriamo i, e i suoi "pianeti" , quindi definiamo
%induttivamente il ciclo, facendo ruotare prima il pianeta più vicino (con i suoi satelliti)
% e via via quelli più lontani 

F=i; %comincio
coinvolti=i;

fi=find(C(2,:)==i);  %posizioni di partenza spigoli i j
if not(isempty(fi))

%caso generale


for k=flip(fi) %deve partire dall'ultimo al più piccolo !
j=C(1,k);
%keyboard
[Fj,coj]=ciclofox(C,j);
coinvolti=[coinvolti coj];
F= incolla(F ,Fj);
end

end
