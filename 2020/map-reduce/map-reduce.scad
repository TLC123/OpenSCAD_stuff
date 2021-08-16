// 
//echo(all ([true,true,true],function(a,b)!= ));
//echo(all ([false,true,true]));
//echo(all ([false,false,true]));
//echo(all ([true,false,false]));
// 
//function all(list,condition =(function(a,b) a!=b), i = 1) =
// 
//    i >= len(list) ? list[0]
//                   :  condition(list[0] , list [i]) ?all (list,condition, i + 1): false;
 
map =function (f,l) [for(i=l) f(i) ];
filter =function (f,l) [for(i=l) if(f(i))i ];
    
////recucers
sort=function(acc,e,i,arr) [each [for(i=acc)if(i<=e)i],e,each [for(i=acc)if(i> e)i]];
pipe=function(acc,e,i,arr) is_function(e)?e(acc):acc;
find=function(lookfor,match=function(a,b) a==b)   
    function(acc,e,i,arr) match(e,lookfor)?concat(acc,[i]):acc; 
min=function(acc,e,i,arr) ( is_undef(acc) || e < acc ) ? e : acc;

slice=function(low,high) function(acc,e,i,arr) i>=low&&i<high?concat(acc,e):acc;


equals=function(a,b) a==b;
lessoreq=function(a,b) a<=b;
within=function(v) function(a,b) lessoreq(abs(a-b),v); 
add=function(a,b) is_undef(b)?a:a+b;
addtax=function(a) a*1.15; 

function reduce(l,initalvalue,reducer,i=0) =
i >= len(l) ? initalvalue
       : reduce(l,reducer(acc= initalvalue,e=l[i],i=i,arr=l ),reducer,i+1);

fns=[addtax,add,1];
l=reduce([0,2,1,1,5,4],[], sort );
echo(reduce(l,[], sort ));
echo(reduce(l,[], slice(0,3) ));
echo(reduce(l,[], find(1,within(.5)) ));
echo(reduce(fns,10, pipe ));
echo(within(2)(7,9));
 