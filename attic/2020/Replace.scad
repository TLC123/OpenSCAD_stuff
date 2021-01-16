n=replace ([for(a= [0:1000])0] ,10,10);
    

echo( (n));

m=replace(n,10,1);
    echo (m, len(m));

function replace(n,i,v)=
n
-concat([for(a=[0:i-1])a]*0 ,[n[i]],[for(a=[i+1:len(n)])a]*0 )
+concat([for(a=[0:i-1])a]*0 ,[v] ,[for(a=[i+1:len(n)])a]*0 );