
function n=numeroperm(p)
l=length(p);
V=[1:l];
if length(p)==1 
    n=1;

else
    i=p(1);
    V=[1:i i:l-1]; 
    pp=p(2:l);
    pn=V(pp); 
n=(l-i)*factorial(l-1)+numeroperm(pn);
end
