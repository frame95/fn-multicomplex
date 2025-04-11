%PARTIZIONI ordinate di d come somma di p numeri tra 0 e b (con p>0)



function X=partfox(d,p,b)
X=[];


if p<1 | d<0 
    return; end

if p==1 && d<=b
X=d;
        return; end
if p==1 && d>b
   return; end


    
for i=0:b
Y=partfox(d-i,p-1,b);
for R=Y'

X=[X; [i  R']];
end
    
    

        end
    
   