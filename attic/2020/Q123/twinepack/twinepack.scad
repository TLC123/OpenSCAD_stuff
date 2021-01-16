pointcount=150;
side=.9*sqrt(pointcount)/2;
l=constrain([for(a=[1:pointcount])[ 2+sin(360/pointcount*a)*10, +cos(360/pointcount*a)*10]
    +(rnd2(1)-[.5,.5])*.015]
);
    iterations=pointcount/.5;
ld=push_list(l,iterations);
polyline(ld);
echo (ld);


 function push_list(l,c=1)=
c>0?
 let( ll1=len(l)-1 ,l= [for(i=[0:len(l)-1])  lerp(lerp(l[wrap(i+1,ll1) ],l[wrap(i-1,ll1) ],0.75),l[i],0.5)   ] )   
 let(l=[for(p=l) (p+ (sum_push(p,l)) ) ])
let (l=constrain(l))
push_list(l,c-1)
:l
;

function sum_push(p,l)=let(
all=[for(pi=l)if(p!=pi)  let(d=pi-p,v=(d.x*d.x+d.y*d.y) )  if(v<4 && v!=0) d/-sqrt(v)   ]
    ) (addl(concat(all,[[0,0]])))/len(all);
    
function addl(l)=[for(i=l)1]*l;

function constrain(l)=[for(i=l)constp(i)+(rnd2(1)-[.5,.5])*.0051];
function    constp(i)=[clamp(-side,side,i.x),clamp(-side,side,i.y)];
function rnd2(s=100)=[rnd(s),rnd(s)];


function after(l,i)=l[wrap(i+1,len(l)-1) ];
function before(l,i)=l[wrap(i-1,len(l)-1) ];
function wrap(x,x_max=1,x_min=0) = (((x - x_min) % (x_max - x_min)) + (x_max - x_min)) % (x_max - x_min) + x_min; // wraps numbers inside boundaries



function last(i)=len(i)-1;// shorthand sugar for len(i)-1

module polyline(p,r=.1) {for(i=[0:max(0,len(p)-2)])line(p[i],p[wrap(i+1,len(p) )],r);}

module polyline_open(p,r=.1) {
     if (len(p)-1>1)
     for(i=[0:max(0,len(p)-2)])line(p[i],p[   i+1],r);
} // polyline plotter

module line(p1,p2 ,width=.1) 
{ // single line plotter
    color(rndc())
hull() {
translate(v3(p1)) sphere(width);
translate(v3(p2)) sphere(width);
}
}
function clamp(a, b, c) = min(max(a, min(b, c)), max(b, c));
    function lerp( v1, v2, bias) = (1-bias)*v1 + bias*v2;
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];
  function rndR()=rands(-360,360,3) ;
function rnd(a = 1,b = 0,s = []) =
s == []?(rands(min(a,b),max(a,b),1)[0]) :(rands(min(a,b),max(a,b),1,s)[0]);
function v3(p)=[is_undef(p.x)?0:p.x,is_undef(p.y)?0:p.y,is_undef(p.z)?0:p.z];
function un(v) = assert(is_list(v)) v / max(norm(v), 1e-64);
