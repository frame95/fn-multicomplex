function [dev,quanto] = sinha1(pe,nu)
%permutazione standard (elementi associati a base di Sinha) e partizione
%COSTRUITO PER il vettore d3fn3(vas)

dev=[];
quanto=[];
n=size(pe,2);
[un,ia,ic]=unique(nu,'rows');



 
F=find(ic==1)'; % 2 0 2 0 2 0 2 2
 for i=F
if pe(i,1)<pe(i,2) && pe(i,3)<pe(i,4) && pe(i,5)<pe(i,6) && pe(i,7)<pe(i,8) && pe(i,7) < pe(i,9)
bl{1}=[pe(i,1) pe(i,2)]; 
bl{2}=[pe(i,3) pe(i,4)];
bl{3}=[pe(i,5) pe(i,6)]; 
bl{4}=[pe(i,7) pe(i,8) pe(i,9)];
[V,dove]=sort([pe(i,1) pe(i,3) pe(i,5)  pe(i,7)]);
dev= [dev ; bl{dove(1)} bl{dove(2)} bl{dove(3)} bl{dove(4)}]; 
quanto = [quanto ; length(bl{dove(1)}) length(bl{dove(2)}) length(bl{dove(3)}) length(bl{dove(4)})  ];
end
 end 

F=find(ic==2)'; % 2 0 2 0 2 2 0 2
 for i=F
if pe(i,1)<pe(i,2) && pe(i,3)<pe(i,4) && pe(i,5)<pe(i,6) && pe(i,5)<pe(i,7) && pe(i,8) < pe(i,9)
bl{1}=[pe(i,1) pe(i,2)]; 
bl{2}=[pe(i,3) pe(i,4)];
bl{3}=[pe(i,5) pe(i,6) pe(i,7)]; 
bl{4}=[pe(i,8) pe(i,9)];
[V,dove]=sort([pe(i,1) pe(i,3) pe(i,5)  pe(i,8)]);
dev= [dev ; bl{dove(1)} bl{dove(2)} bl{dove(3)} bl{dove(4)}]; 
quanto = [quanto ; length(bl{dove(1)}) length(bl{dove(2)}) length(bl{dove(3)}) length(bl{dove(4)})  ];
end
 end 

 
F=find(ic==3)'; % 2 0 2 2 0 2 0 2
 for i=F
if pe(i,1)<pe(i,2) && pe(i,3)<pe(i,4) && pe(i,3)<pe(i,5) && pe(i,6)<pe(i,7) && pe(i,8) < pe(i,9)
bl{1}=[pe(i,1) pe(i,2)]; 
bl{2}=[pe(i,3) pe(i,4) pe(i,5)];
bl{3}=[pe(i,6) pe(i,7)]; 
bl{4}=[pe(i,8) pe(i,9)];
[V,dove]=sort([pe(i,1) pe(i,3) pe(i,6)  pe(i,8)]);
dev= [dev ; bl{dove(1)} bl{dove(2)} bl{dove(3)} bl{dove(4)}]; 
quanto = [quanto ; length(bl{dove(1)}) length(bl{dove(2)}) length(bl{dove(3)}) length(bl{dove(4)})  ];
end
 end 
 
F=find(ic==4)'; % 2 2 0 2 0 2 0 2
 for i=F
if pe(i,1)<pe(i,2) && pe(i,1)<pe(i,3) && pe(i,4)<pe(i,5) && pe(i,6)<pe(i,7) && pe(i,8) < pe(i,9)
bl{1}=[pe(i,1) pe(i,2) pe(i,3)]; 
bl{2}=[pe(i,4) pe(i,5)];
bl{3}=[pe(i,6) pe(i,7)]; 
bl{4}=[pe(i,8) pe(i,9)];
[V,dove]=sort([pe(i,1) pe(i,4) pe(i,6)  pe(i,8)]);
dev= [dev ; bl{dove(1)} bl{dove(2)} bl{dove(3)} bl{dove(4)}]; 
quanto = [quanto ; length(bl{dove(1)}) length(bl{dove(2)}) length(bl{dove(3)}) length(bl{dove(4)})  ];
end
 end 
