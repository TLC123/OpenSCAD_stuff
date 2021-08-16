$fn=10;
num=20;
c=concat([[0,0,-70,4],make_points(num,l1=[-10,-10,-2],l2=[10,10,2]),[0,0,-20,4]]

,[[0,0,20,4],[0,0,80,4]]);
l=len3v(c);
echo("c",l);
b=remapv(c);
// fixed=[[0,0,0,30],[0,20,00,30],[0,-20,0,30],[-20,0,00,30],[20,0,0,30]
//
//
//];
//
lb=len3v(b);
echo(lb);

#for(i=[0:len(b)-1 ])translate(take3(b[i]))sphere(b[i][3],$fn=30);
 
 a=collide(b);


 polyline(a);

 
 

// a=collide(b, 80,b);
//
//polyline(a);
//
//translate([50,0,0]) for(i=[0:len(a)-2],j=[0:len(a)-2])if(abs(i-j)>4){
//intersection(){
//hull(){
//translate(take3(a[i]))sphere(a[i][3],$fn=20);
//translate(take3(a[i+1]))sphere(a[i+1][3],$fn=20);}
//hull(){
//translate(take3(a[j]))sphere(a[j][3],$fn=20);
//translate(take3(a[j+1]))sphere(a[j+1][3],$fn=20);}
//
//}}
//*%translate([30,0,0])polyline(b);

//for(i=[0:len(b)-1]){translate(take3(b[i]))sphere(b[i][3]);}







function collide(l,fixed=[],n=1000,iorg)= 

let(org=iorg==undef?l:iorg,coll=concat(l,fixed),movel=[for(i=[1:len(l)-2])
let( 
li=[for(j=[0:len(coll)-1])
let(
p1=take3(l[i])
,p2=take3(coll[j])
,r1=l[i][3]
,r2=coll[j][3]
,d=len3(p1-p2)
//,e=echo(i,j,p1,p2,r1,r2,d,p1-p2,un(p1-p2))
)
 if(i!=j)
 abs(i-j)<4? [0,0,0]
: d<(r1+r2)-1e-16? max(0, (r1+r2)*(1 )-d)*un(p1-p2)  *0.5  // *(1/sqrt(max(1,r1)))  
 :[0,0,0]

]

,
 ,move=addl(li)  
//,ee=echo("li",move)
)
 [move.x,move.y,move.z,0]
],
nl=vblur(l,org)+concat([[0,0,0,0]],movel,[[0,0,0,0]])
//,ee=echo(abs(len3v(nl)-len3v(org)),addl(normlist(movel)/(len(movel))) , addl(normlist(movel) ))
)

n>0
&&addl(normlist(movel)/(len(movel)))>0.005
//||abs(len3v(nl)-len3v(org))>len3v(org)*0.1)
?
collide(nl,fixed,n-1,org):
nl
;



function vblur(v,org)=remapv(lerp(org,lerp(concat([v[0]],[for (i=[1:len(v)-2]) (v[max(0,i-1)] +v[min(len(v)-1,i+1)])/2],[v[len(v)-1]]),v,0.4 ),0.99));

function remapv(v)=let(l=(len(v)-1))[for(cm=[0:1/l:1])  v2t(v,cm*len3v(v))];









function make_points(j=10,l1=[0,0,0],l2=[1,1,1])= 
     ([for(i=[1:j])
[
roundlist(rnd(l1.x,l2.x)),
roundlist(rnd(l1.y,l2.y)),
roundlist(rnd(l1.z,l2.z)/2)+i*l2.z/10,
roundlist(rnd(3,4))

]
]);
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 

function roundlist(v, r = 1) = len(v) == undef ? v - (v % r) : len(v) == 0 ? [] : [
    for (i = [0: len(v) - 1]) roundlist(v[i], r)
];
function take3(i)=[i.x,i.y,i.z];

 

function lerp(start, end, bias) = (end * bias + start * (1 - bias));

function un(v)=v/max(len3(v),1e-16);
function addl(l, c = 0) = c < len(l) - 1 ? l[c] + addl(l, c + 1) : l[c];
function addlnorm(l, c = 0) = c < len(l) - 1 ? len3(l[c]) + addl(l, c + 1) : len3(l[c]);
function normlist(v) =[ for (i = [0: len(v) - 1]) len3(v[i])
];
function listlerp (l,I)=let(f=len(l)-1,start=max(0,min(f,floor(I))),end=max(0,min(f,ceil(I))),bias=I%1) (l[end]* bias + l[start] * (1 - bias));

module polyline(p) {for(i=[0:max(0,len(p)-2)])line(p[i],p[i+1]);
}

module line(p1, p2 ,width=0.5) 
{
    hull() {
        translate(take3(p1)) sphere(max(1e-4,p1[3]));
        translate(take3(p2)) sphere(max(1e-4,p2[3]));
    }
}

function len3v(v,acc=0,p=0)=p+1>len(v)-1?
        acc: len3v(v,acc+len3(take3(v[p])-take3(v[p+1])),p+1)  ;
function len3(v)=  norm([ensure(v.x),ensure(v.y),ensure(v.z)]) ;
function v2t(v,stop,p=0)=p+1>len(v)-1|| len3(v[p]-v[p+1])>stop?  
 v[p]+un(v[p+1]-v[p])*stop:v2t(v,stop-len3(v[p]-v[p+1]),p+1);
function abs3(v) = [abs(v[0]), abs(v[1]), abs(v[2])];
function ensure(a)=a==undef?0:a;
