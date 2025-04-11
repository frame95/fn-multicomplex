function M=piucorda
%matrice da corde(7,4) a (9,5) aggiungendo una corda dal punto 8 al punto 9
C=corde(7,4);
D=corde(9,5);
for i=1:210
    chi=[C(:,:,i) , [9;8]];
    for j=1:2520
        if isequal(chi,D(:,:,j))
            M(i)=j; break; end
    end
end