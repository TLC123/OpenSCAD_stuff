S=4;

mx=4;
m= saneRound([for(i=[1:mx])r(mx) ]) ;
    function r(n)=un([for(n=[1:n])rands(-1,1,1)[0]]);
n=saneRound(inv(m));
    
        echo("");
 prettym(m);
    echo("");
 prettym(n);
     echo(""); 
    
    prettym(saneRound(saneRound(1/n)*saneRound(1/m)));
     echo("");
function saneRound(m,d=.001)=[for(v=m)[for(i=v) i-(i%d)]];// within precition zero
function inv(m )=[for(v=m)un([for(i=v) 1/i])];// within precition zero


module prettym(m,a=""){
for(n=[0:len(m)-1] ) echo(str(m[n],str( chr(32),   is_list(a[n])? a[n]:0 )) );}

function  prettym(m,a="")=[
for(n=[0:len(m)-1] ) echo(str(m[n],str( chr(32),   is_list(a[n])? a[n]:0 )) )];
    
     function un(v) = v / max(norm(v), 0.000001) * 1; // div by zero safe unit normal

 