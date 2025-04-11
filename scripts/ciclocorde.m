function F=ciclocorde(C,i)
%in realtà è uguale alla parte coinvolti di ciclofox !
%quindi entrambi sono uguali

%simile a ciclofox ma dà solo la
%la prima riga del risultato che dovrebbe essere il rappresentante della base
%di Sinha associato a C (non è la stessa base ma il pairing è perfetto)

%coinvolti: indici degli elementi che si ottengono (pianeti e satelliti)

%inizio: consideriamo i, e i suoi "pianeti" , quindi definiamo
%induttivamente il ciclo, facendo ruotare prima il pianeta più vicino (con i suoi satelliti)
% e via via quelli più lontani 

F=i; %comincio
%coinvolti=i;

fi=find(C(2,:)==i);  %posizioni di partenza spigoli i j
if not(isempty(fi))

%caso generale


for k=flip(fi) %deve partire dall'ultimo al più piccolo !
j=C(1,k);
%keyboard
Fj=ciclocorde(C,j);
%coinvolti=[coinvolti coj];
F= [F ,Fj];
end

end
