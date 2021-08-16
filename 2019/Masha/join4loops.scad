a=translatePoint(makeRing(10),[0,-25,0]);
echo(a);
b= rotateOnY(rotateOnZ(a,90),10);
echo(b);

c=rotateOnZ(b,90);
d=rotateOnY(rotateOnZ(c,90),45);
echo(c);


hull(){
color("red")cloud(a);
color("blue")cloud(b);
color("green")cloud(c);
color("green")cloud(d);
}
module cloud(p)
{
    hull()    polyhedron(p,[[each[0:len(p)-1]]]);
    }
function join3loops(l1,l2,l3)=
[]

;


function makeRing(r)=
[for(i=[0:360/20:360])[sin(i)*r,0,cos(i)*r] ]

;

function rotateOnZ(l,angle)=
[for(p=l)rotatePointOnZ(p,angle)]
;
function rotateOnY(l,angle)=
[for(p=l)rotatePointOnY(p,angle)]
;function rotateOnX(l,angle)=
[for(p=l)rotatePointOnX(p,angle)]
;
function translatePoint(l,t)=
[for(i=l)i+t]
;
function rotatePointOnZ(p,angle)
 = 
    let(cosa = cos(angle), sina = sin(angle))
    [
        p.x * cosa - p.y * sina,
        p.x * sina + p.y * cosa,
        p.z
    ];
function rotatePointOnX(p,angle)
 = 
    let(cosa = cos(angle), sina = sin(angle))
    [   p.x,
        p.y * cosa - p.z * sina,
        p.y * sina + p.z * cosa,
   
    ];
function rotatePointOnY(p,angle)
 = 
    let(cosa = cos(angle), sina = sin(angle))
    [   p.x * cosa - p.z * sina,
        p.y ,
        p.x * sina + p.z * cosa,
   
    ];
function wrapi(x,tak) =  ((x  % tak) + tak) % tak; // wraps index 0 - x 
 function wrap(x,x_max=1,x_min=0) =

 (((x - x_min) % (x_max - x_min)) + (x_max - x_min)) % (x_max - x_min) + x_min; // wraps numbers 



module polyline(p) {for(i=[0:max(0,len(p)-2)])line(p[i],p[wrap(i+1,len(p) )]);}
module polyline_open(p) {
     if (len(p)-1>1)
     for(i=[0:max(0,len(p)-2)])line(p[i],p[   i+1]);
} // polyline plotter

module line(p1,p2 ,width=2) 
{ // single line plotter
hull() {
translate(p1) sphere(width);
translate(p2) sphere(width);
}
}