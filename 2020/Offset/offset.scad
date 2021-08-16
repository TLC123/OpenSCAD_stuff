$fn=8;
a=[for (p=[0:5])rands(-50,50,2)];
a2=[for (p=[0:5])rands(-30,30,2)];
b=    pair (a);
 linear_extrude(0.1)polygon(a);
 
clips=clipself(b);
c=offset(clips,0);

 polyline(c,"red");

for(c=clips)echo (c);
 

function pair(a)=[for (p=[0:len(a)-1])[a[p],a[(p+1)%len(a)]]];
 
function clipself(n)=
let( kres=
[for(l=n)
    [  [0,l[0].x,l[0].y], for(ll=n) 
        if(l!=ll) let(res=IntersectionOfLines(l,ll))if (!is_undef(res))[norm(res-l[0]),res.x,res.y] ] 
        
    
    ],
        sortedpoints=specialsort(kres)
        
        )
        
        pair( flatten (sortedpoints))
        ;
        
        function specialsort(v)=
        
        let(res= [for(i=v)  quicksort_col(i)])  
        let(res= [for(i=res) [for(j=i) [ j.y,j.z]]])
      
              res 
        ;
        
       function quicksort_col(list,col=0)= 
!(len(list)>0)?[]:
let(
pivot = list[floor(len(list)/2)][col],
list_lesser =[ for(i=[0:len(list)-1])if( list[i][col] < pivot )list[i] ],
list_equal  =[ for(i=[0:len(list)-1])if( list[i][col]== pivot )list[i] ],
list_greater=[ for(i=[0:len(list)-1])if( list[i][col] > pivot )list[i] ])

concat(
quicksort_col(list_lesser),
list_equal,
quicksort_col(list_greater));
        
        
        
        
        function flatten(v)=[for(n=v)for( nn=n)nn];
 
module polyline(n,c="blue")
        
{ 
    for(b=n)color(rands(0,1,3))line(b.x,b.y);
}




module line(a,b) {
     hull(){
translate(a)circle(0.5);translate(b)circle(0.5);}
     }
     
function offset(n,r=0)=
         
         [for(b=n) b + dup(CCW(normal(b[1]-b[0]))*r)        ];
         
         
         
         function dup(a)=[a,a];
 function normal (n)=n/max(norm(n),10e-32);
 function CCW(v)=[v.y,-v.x];
         
         
         
         
         
         
         function  IntersectionOfLines(pa, pb)=
         
let(
         pa1=pa[0],
         pa2=pa[1],
         pb1=pb[0],
         pb2=pb[1])
pa2==pb1||pb2==pa1||
pa1==pb2||pb1==pa2
         
         ?undef:

let(
         
da = [(pa1.x-pa2.x),(pa1.y-pa2.y)], 
db = [(pb1.x-pb2.x),(pb1.y-pb2.y)],
the = da.x*db.y - da.y*db.x                 )
(the == 0)? 
undef: /* no in tersection*/
let (
A = (pa1.x * pa2.y - pa1.y * pa2.x),
B = (pb1.x * pb2.y - pb1.y * pb2.x)        ,
P= [( A*db.x - da.x*B ) / the , ( A*db.y - da.y*B ) / the])
P.x< max(pa1.x,pa2.x) && P.x > min(pa1.x , pa2.x)&&
P.x< max(pb1.x,pb2.x) && P.x > min(pb1.x , pb2.x)

?P:undef

;