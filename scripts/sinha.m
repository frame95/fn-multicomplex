function [dev,quanto] = sinha(pe,nu)
%permutazione standard e partizione 
%comincio con la prima
%COSTRUITO PER UN VETTORE PRECISO che viene da vas con zig zag


dev=[];
quanto=[];
n=size(pe,2);
[un,ia,ic]=unique(nu,'rows');



%un(1,:)= 0 2 0 2 0 2 2 2
F=find(ic==1)';
for i=F
if pe(i,2)<pe(i,3) && pe(i,4)<pe(i,5) && pe(i,6)<pe(i,7) && pe(i,6)<pe(i,8) && pe(i,6) < pe(i,9)
bl{1}=[pe(i,2) pe(i,3)]; 
bl{2}=[pe(i,4) pe(i,5)];
bl{3}=[pe(i,6) pe(i,7) pe(i,8) pe(i,9)];
[V,dove]=sort([pe(i,2) pe(i,4) pe(i,6)]);
dev= [dev ; bl{dove(1)} bl{dove(2)} bl{dove(3)} pe(i,1)]; 
quanto = [quanto ; length(bl{dove(1)}) length(bl{dove(2)}) length(bl{dove(3)}) 1 ];
end
%va fatto per gli altri 10 (uff)
end    

F=find(ic==3)'; % 2 0 0 2 0 2 2 2
for i=F
if pe(i,1)<pe(i,2) && pe(i,4)<pe(i,5) && pe(i,6)<pe(i,7) && pe(i,6)<pe(i,8) && pe(i,6) < pe(i,9)
bl{1}=[pe(i,1) pe(i,2)]; 
bl{2}=[pe(i,4) pe(i,5)];
bl{3}=[pe(i,6) pe(i,7) pe(i,8) pe(i,9)];
[V,dove]=sort([pe(i,1) pe(i,4) pe(i,6)]);
dev= [dev ; bl{dove(1)} bl{dove(2)} bl{dove(3)} pe(i,3)]; 
quanto = [quanto ; length(bl{dove(1)}) length(bl{dove(2)}) length(bl{dove(3)}) 1 ];
end
end

F=find(ic==5)'; % 2 0 2 0 0 2 2 2
for i=F
if pe(i,1)<pe(i,2) && pe(i,3)<pe(i,4) && pe(i,6)<pe(i,7) && pe(i,6)<pe(i,8) && pe(i,6) < pe(i,9)
bl{1}=[pe(i,1) pe(i,2)]; 
bl{2}=[pe(i,3) pe(i,4)];
bl{3}=[pe(i,6) pe(i,7) pe(i,8) pe(i,9)];
[V,dove]=sort([pe(i,1) pe(i,3) pe(i,6)]);
dev= [dev ; bl{dove(1)} bl{dove(2)} bl{dove(3)} pe(i,5)]; 
quanto = [quanto ; length(bl{dove(1)}) length(bl{dove(2)}) length(bl{dove(3)}) 1 ];
end
end

F=find(ic==8)'; %2 0 2 0 2 2 2 0
for i=F
if pe(i,1)<pe(i,2) && pe(i,3)<pe(i,4) && pe(i,5)<pe(i,6) && pe(i,5)<pe(i,7) && pe(i,5) < pe(i,8)
bl{1}=[pe(i,1) pe(i,2)]; 
bl{2}=[pe(i,3) pe(i,4)];
bl{3}=[pe(i,5) pe(i,6) pe(i,7) pe(i,8)];
[V,dove]=sort([pe(i,1) pe(i,3) pe(i,5)]);
dev= [dev ; bl{dove(1)} bl{dove(2)} bl{dove(3)} pe(i,9)]; 
quanto = [quanto ; length(bl{dove(1)}) length(bl{dove(2)}) length(bl{dove(3)}) 1 ];
end
end

F=find(ic==2)'; % 0 2 0 2 2 0 2 2
for i=F
if pe(i,2)<pe(i,3) && pe(i,4)<pe(i,5) && pe(i,4)<pe(i,6) && pe(i,7)<pe(i,8) && pe(i,7) < pe(i,9)
bl{1}=[pe(i,2) pe(i,3)]; 
bl{2}=[pe(i,4) pe(i,5) pe(i,6)];
bl{3}=[pe(i,7) pe(i,8) pe(i,9)];
[V,dove]=sort([pe(i,2) pe(i,4) pe(i,7)]);
dev= [dev ; bl{dove(1)} bl{dove(2)} bl{dove(3)} pe(i,1)]; 
quanto = [quanto ; length(bl{dove(1)}) length(bl{dove(2)}) length(bl{dove(3)}) 1 ];
end
end

F=find(ic==4)'; % 2 0 0 2 2 0 2 2
 for i=F
if pe(i,1)<pe(i,2) && pe(i,4)<pe(i,5) && pe(i,4)<pe(i,6) && pe(i,7)<pe(i,8) && pe(i,7) < pe(i,9)
bl{1}=[pe(i,1) pe(i,2)]; 
bl{2}=[pe(i,4) pe(i,5) pe(i,6)];
bl{3}=[pe(i,7) pe(i,8) pe(i,9)];
[V,dove]=sort([pe(i,1) pe(i,4) pe(i,7)]);
dev= [dev ; bl{dove(1)} bl{dove(2)} bl{dove(3)} pe(i,3)]; 
quanto = [quanto ; length(bl{dove(1)}) length(bl{dove(2)}) length(bl{dove(3)}) 1 ];
end
end
 
F=find(ic==6)'; % 2 0 2 0 2 0 2 2
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

F=find(ic==7)'; % 2 0 2 0 2 2 0 2
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

F=find(ic==9)'; % 2 0 2 2 0 0 2 2
  for i=F
if pe(i,1)<pe(i,2) && pe(i,3)<pe(i,4) && pe(i,3)<pe(i,5) && pe(i,7)<pe(i,8) && pe(i,7) < pe(i,9)
bl{1}=[pe(i,1) pe(i,2)]; 
bl{2}=[pe(i,3) pe(i,4) pe(i,5)];
bl{3}=[pe(i,7) pe(i,8) pe(i,9)];
[V,dove]=sort([pe(i,1) pe(i,3) pe(i,7)]);
dev= [dev; bl{dove(1)} bl{dove(2)} bl{dove(3)} pe(i,6)]; 
quanto = [quanto ; length(bl{dove(1)}) length(bl{dove(2)}) length(bl{dove(3)}) 1 ];
end
end

 
F=find(ic==10)'; % 2 0 2 2 0 2 0 2
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
 
F=find(ic==11)'; % 2 0 2 2 0 2 2 0
  for i=F
if pe(i,1)<pe(i,2) && pe(i,3)<pe(i,4) && pe(i,3)<pe(i,5) && pe(i,6)<pe(i,7) && pe(i,6) < pe(i,8)
bl{1}=[pe(i,1) pe(i,2)]; 
bl{2}=[pe(i,3) pe(i,4) pe(i,5)];
bl{3}=[pe(i,6) pe(i,7) pe(i,8)];
[V,dove]=sort([pe(i,1) pe(i,3) pe(i,6)]);
dev= [dev ; bl{dove(1)} bl{dove(2)} bl{dove(3)} pe(i,9)]; 
quanto = [quanto ; length(bl{dove(1)}) length(bl{dove(2)}) length(bl{dove(3)}) 1 ];
end
end
