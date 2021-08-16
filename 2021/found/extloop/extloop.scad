include<polytools.scad>
 loop=[for(i=[20:15:360])[sin(i)*rnd(20,30),cos(i)*rnd(20,30),0]];
E=[0,0,10];
p=loopextrude(loop,E);
p2=loopextrude(looptranslate(loop,E),E);

e=loopcapend(looptranslate(loop,E*2));
g=loopcapgo(loop);


t=combinepolyhedron(g,combinepolyhedron(p,combinepolyhedron(p2,e)));
//echo(p);
//polyhedron(t[0],t[1]);

function loopcapend(l)=[l,[[for(i=[0:len(l)-1])i]]];
function loopcapgo (l)=[l,[ [for(i=[0:len(l)-1])len(l)-1-i]]];


function loopextrude(l,t)=
let(ll=len(l))
[concat(l,looptranslate(l,t))
,flatten(
[
for(i=[0:ll])
let(
p0=i%ll,
p1=(i+1)%ll,
p2=((i+1)%ll)+ll,
p3=(i%ll)+ll
)
[[p0,p1,p2],[p0,p2,p3]]
]

)];

function looptranslate(l,t,s=[1,1])=[for(i=l)[i.x*s.x,i.y*s.y,i.z]+t];


polyline(loop);

for(i=[-13:4:46]){
oloop=offsetloop(loop,i);
echo(looplen(oloop));
color("red")polyline(oloop);
//echo(oloop);
}
function offsetloop(l,o )=
 

let(
lastlll=looplen(l),
ll=len(l)
// ,e=echo(o,ll)
,newl=flatten([for(i=[0:(ll-1)])
let( 
 pa=offsetseg(l[i],l[wrap(i+1,ll)],o)
,pb=offsetseg(l[wrap(i-1,ll)] ,l[i],o)
,iol=IntersectionOfLines(pa[0], pa[1], pb[0], pb[1])
,ds=norm(l[i]-iol)
,nol=un(l[i]-iol) 
,dota=(1+dot(un(pa[0]-pa[1]),un(pb[0]-pb[1])))

//,e=echo(iol)
)
dota>0.0||sign(o)<1 ?[iol] :[pb[1] ,pa[0] ]])

)
  (  mergeclose (mergeclose (mergeclose (newl,3,o),3,o) ,3,o)  ) 
 
;

//function offsetloop(l,o,lastll=1)=
//o!=0&&len(l)>3&&(looplen(l)-(  (lastll-looplen(l))))>1 ?
//
//let(
//lastlll=looplen(l),
//ll=len(l)
//// ,e=echo(o,ll)
//,newl=flatten([for(i=[0:(ll-1)])
//let( 
// pa=offsetseg(l[i],l[wrap(i+1,ll)],sign(o)*0.125)
//,pb=offsetseg(l[wrap(i-1,ll)] ,l[i],sign(o)*0.125)
//,iol=IntersectionOfLines(pa[0], pa[1], pb[0], pb[1])
//,ds=norm(l[i]-iol)
//,nol=un(l[i]-iol) 
//,dota=(1+dot(un(pa[0]-pa[1]),un(pb[0]-pb[1])))
//
////,e=echo(iol)
//)
//dota>0.65||sign(o)<1 ?[iol] :[pb[1] ,pa[0] ]])
//
//)
// offsetloop( ( mergeclose (mergeclose (newl,0.056,o),0.056,o) ), (o)-sign(o)*0.125,lastlll)
//:
//l
//;

function looplen(l)=let(ll=len(l))
 
addl([for(i=[0:ll-1])
 let( next=wrap(i+1,ll,0)) 
norm(l[i]-l[next])])
;

function sm(l,n)=
let(ll=len(l)
)
[for(i=[0:ll-1])
let(
 next=wrap(i+1,ll,0)
,prev=wrap(i-1,ll,0)
,bl=( l[next]+l[prev])/2)

lerp(l[i],bl,n)


];
function mergeclose(l,d=1.56,o)=
let(ll=len(l)
)
[for(i=[0:ll-1])
let(
 next=wrap(i+1,ll,0)
,prev=wrap(i-1,ll,0)
,ds=norm(l[prev]-l[i])
,dv=norm(l[next]-l[i])
,dota=(1+dot(un(l[i]-l[next]),un(l[i]-l[prev])))
// ,e=echo(ds)

)
//     
//        [ 2>d?  
//                        l[i]:  
//                        (l[i]+l[next])/2 ]   
//if(!(sign(o)<1&&ds <d)&&(ds >d &&!(sign(o)<1&&dota>1.85)))  dv>d?l[i]:(l[i]+l[next])*0.5
if( ds >d)  dv>d?l[i]:(l[i]+l[next])*0.5

]
;


function offsetseg(p1,p2,o)=let(n=un(p2-p1),fn=[-n.y,n.x]*o)[p1+fn,p2+fn];
function  IntersectionOfLines(pa1, pa2, pb1, pb2)=
let(
da = [(pa1.x-pa2.x),(pa1.y-pa2.y)], 
db = [(pb1.x-pb2.x),(pb1.y-pb2.y)],
the = da.x*db.y - da.y*db.x                 )
(the == 0)? 
pa1: /* no in tersection*/
let (
A = (pa1.x * pa2.y - pa1.y * pa2.x),
B = (pb1.x * pb2.y - pb1.y * pb2.x)         )
[( A*db.x - da.x*B ) / the , ( A*db.y - da.y*B ) / the]

;




 module polyline(p) {for(i=[0:max(0,len(p)-1)])line(p[i],p[wrap(i+1,len(p)  )]);
} // polyline plotter

module line(p1, p2 ,width=0.5) 
{ // single line plotter
    hull() {
        translate(p1) sphere(width);
        translate(p2) sphere(width);
    }
}


function rnd(a = 1, b = 0, s = []) =
s == [] ?
  (rands(min(a, b), max(
    a, b), 1)[0]) :
  (rands(min(a, b), max(a, b), 1, s)[0]);