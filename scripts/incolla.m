function Z=incolla(X,Y)

Z=attacca(X,Y);
Z=[Z; attacca(Y,X)];
end