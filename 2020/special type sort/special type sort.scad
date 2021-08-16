 
    

//pipe=function(acc,e,i,arr) is_function(e)?e(acc):acc;
//find=function(lookfor,match=function(a,b) a==b)   
//    function(acc,e,i,arr) match(e,lookfor)?concat(acc,[i]):acc; 
//min=function(acc,e,i,arr) ( is_undef(acc) || e < acc ) ? e : acc;
//
//slice=function(low,high) function(acc,e,i,arr) i>=low&&i<high?concat(acc,e):acc;
//
//
//equals=function(a,b) a==b;
//lessoreq=function(a,b) a<=b;
//within=function(v) function(a,b) lessoreq(abs(a-b),v); 
//add=function(a,b) is_undef(b)?a:a+b;
//addtax=function(a) a*1.15; 


////recucers
specialsort1=function(acc,e,i,arr) 
[
    each [for(n=acc)if( !(n.x>e.x || n.y>e.y ))n],
    e,
    each [for(n=acc)if( n.x>e.x || n.y>e.y )n]
    ];
specialsort2=function(acc,e,i,arr) 
[
    each [for(n=acc)if( !(n.x+ n.y>e.x+e.y ))n],
    e,
    each [for(n=acc)if( (n.x+ n.y>e.x+e.y ) )n]
    ];
    
function reduce(l,initalvalue,reducer,i=0) =
i >= len(l) ? initalvalue
       : reduce(l,reducer(acc= initalvalue,e=l[i],i=i,arr=l ),reducer,i+1);
    
    
 
//set=[for([0:12])rands(0,100,2)];
set=[[1.29735, 15.9036], [4.7206, 25.1342], [46.3367, 39.4064], [50.7228, 47.8867], [2.45735, 64.0724], [45.9894, 57.3801], [54.135, 58.1053], [59.0638, 81.8263], [76.2838, 86.711], [94.1577, 50.9707], [37.8645, 91.4939], [98.6917, 18.4831], [37.2511, 98.7479]];
    
    
    set2=reduce(set,[], specialsort1 );

    l=reduce(set,[], specialsort1 );


echo(l);
for (i=[0:len(l)-2]){
    translate(l[i]) cylinder(10,5,5,center=true);
    translate(l[i+1]) cylinder(10,5,5,center=true);
hull(){ translate(l[i]) sphere(3); translate(l[i+1]) sphere(3); }}
 
 