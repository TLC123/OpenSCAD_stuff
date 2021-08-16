m=500;
n=150;
g=3;
p=[for(i=[1 :n])[rnd(0,m),rnd(0,m),rnd(0,m)] ];
  
for (d=[1:g]){
resize([10,5,5])hull(){
        polyhedron(
p,
[for(i=[1 :m/g])[rnd(0,n),rnd(0,n),rnd(0,n)] ]

)
    ; }}

function rnd(a,b)=a+(rands(0,1,1)[0])*(b-a);     
