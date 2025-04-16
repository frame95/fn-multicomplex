%main routine
K=ker(bousfield(7,4)); 
C=corde(6,4); 
vas = ciclofn3(C(:,:,find(K(:,7))));
[pe1,nu1]=d1fn3veloce(vas(:,1:6),vas(:,7:11));
[Inoto,pnoto]=recofox([pe1 nu1]);
cp7=comppermnew(7);
ip7=invpermnew(7);
pnoto=ip7(pnoto);
[I7,J7,p7,ii7,jj7]=fn3ter(7,9);
p7=ip7(p7);
[dull,Isol,psol]=solvsimmnew(I7,J7,p7,ii7,jj7,7,Inoto,pnoto,cp7);
psol=ip7(psol);
base=partfox(9,6,2);
P7=perms(1:7);
pe7=P7(psol,:); 
nu7=base(Isol,:);
[pe8,nu8]=d1fn3veloce(pe7,nu7);
[I,p]=recofox([pe8 nu8] );
ip8=invpermnew(8);
p=ip8(p);
d2=triald2fn3(vas(:,1:6),vas(:,7:11));
[Ierr,perr]=recofox(d2);
perr=ip8(perr);
compl=agg([I',p'],[Ierr',perr']);  
Icompl=compl(:,1)'; 
pcompl=compl(:,2)';
[Ib,Jb,pb,ib,jb]= fn3ter(8,10); 
pb=ip8(pb);
cp8=comppermnew(8);
[dull,Ifine,pfine]=solvsimmnew(Ib,Jb,pb,266,161,8,Icompl,pcompl,cp8);
pfine=ip8(pfine);
P8=perms(1:8); 
prima=P8(pfine,:); 
basis=partfox(10,7,2); 
seconda=basis(Ifine,:)
[pe,nu]=d1fn3veloce(prima,seconda);
[Ieh,Jeh]=find(nu==1); 
Ieh=unique(Ieh); 
buoni=setdiff(1:4631462,Ieh); 
pebuoni=pe(buoni,:); 
nubuoni=nu(buoni,:);
[dev,quanto]=sinha(pebuoni,nubuoni);
[undev,iad,icd]=unique([dev quanto],'rows');
for indice=1:7079; nice(indice)=nnz(icd==indice); end 
nice=mod(nice,2); scremati=undev(find(nice),:);
Msinha=cordesinha(corde(9,5));
vettore=cambiobase(scremati,Msinha);
XN=d3fn3(vas(:,1:6),vas(:,7:11));
[dev1,quanto1]=sinha1(XN(:,1:9),XN(:,10:17));
vettore1=cambiobase([dev1 quanto1],Msinha);
vettoretot=xor(vettore,vettore1);
bou105=bousfield(10,5);
bou95=bousfield(9,5);
ra0=bitrango32(bou95);
ra1=bitrango32([bou95 vettoretot;]);
C=corde(9,5); %checks non triviality projecting to Emb from here
v1=recog(cat(3,[3 4 5 7 9; 2 1 2 6 8] ,[3 4 5 7 9; 1 1 2 6 8  ]),C); 
v2=recog( [4 5  6  8  9; 1  3  2  7 7]     ,C); 
v3= recog( [2 3 5 7 9; 1 1 4 6 8]  ,C); 
v4=recog(  [3 4 6 7 9; 1 2 5 5 8] ,C); 
K=ker(bousfield(8,4));
piuc=piucorda;
v5(2520)=0; 
v6(2520)=0; 
v7(2520)=0; 
v5(piuc(K(:,22)))=1; 
v6(piuc(K(:,30)))=1;
v7(piuc(K(:,32)))=1; 
M=[bou95 v1' v2' v3' v4' v5' v6' v7'];
ra2=bitrango32(M);
ra3=bitrango32([M vettoretot']);







