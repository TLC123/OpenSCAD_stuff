a=translatePoint(makeRing(10,24),[0,-0,0]);
cp=translatePoint(makeRing(12.7,24),[0,-0,0]);
angl= rnd()*90;
echo(angl);
angl2=0;
 h=15.707;
b=rotateOnX(translatePoint(rotateOnX(rotateOnZ(a,120),angl/2),[0,-0,h]),angl/2);
c=rotateOnX(translatePoint(rotateOnX(rotateOnZ(cp,60),angl/4),[0,-0,h/2]),angl/4);

 b2=rotateOnX(translatePoint(rotateOnX(rotateOnZ(a,-120),angl/2),[0,-0,h]),angl/2);
c2=rotateOnX(translatePoint(rotateOnX(rotateOnZ(cp,-60),angl/4),[0,-0,h/2]),angl/4);
 

 for(i=[0:len(a)-1])
    { 
        bex( 
        [  a[i].x,a[i].y,a[i].z,0.1,[1,0,0]],
        [  c[i].x,c[i].y,c[i].z,0.1,[0,0,1]],
        [  b[i].x,b[i].y,b[i].z,0.1,[0,1,0]],
        0.1);
     
    
        }
 for(i=[0:len(a)-1])
    { 
        bex( 
        [  a[i].x,a[i].y,a[i].z,0.1,[1,0,0]],
        [  c2[i].x,c2[i].y,c2[i].z,0.1,[0,0,1]],
        [  b2[i].x,b2[i].y,b2[i].z,0.1,[0,1,0]],
        0.1);
     
    
        }
 dotplot (a,0.5);
 dotplot (b,0.5);
//dotplot (c,0.5);
module bex(a,b,c,r)
     {l=[for(i=[0:1/10:1.05])  lerp(lerp(a,b,i),lerp(b,c,i),i)];
         polyline_open(l );
            
            
            }
        
        
module cloud(p)
{
    hull()    polyhedron(p,[[each[0:len(p)-1]]]);
    }
function join3loops(l1,l2,l3)=
[]

;


function makeRing(r,n=20)=
[for(i=[0:360/n:360])[sin(i)*r,cos(i)*r,0] ]

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



module polyline(p,r) {for(i=[0:max(0,len(p)-2)]) line(p[i],p[wrap(i+1,len(p) )],r);}
module dotplot(p,r) {for(i=p)translate(i)sphere(r);}
module polyline_open(p) {
     if (len(p)-1>1)
     for(i=[0:max(0,len(p)-2)])line(p[i],p[   i+1]);
} // polyline plotter

module line(p1,p2 ,width=2) 
{ // single line plotter
    color(p1[4])
hull() {
translate(v3(p1)) sphere(p1[3]);
translate(v3(p2)) sphere(p2[3]);
}
}


function dot(v1,v2) = v1[0]* v2[0]+ v1[1]* v2[1]+ v1[2]* v2[2];
function dot4(v1,v2) = v1[0]* v2[0]+ v1[1]* v2[1]+ v1[2]* v2[2]+ v1[3]* v2[3];

function point2plane(p,o,n) =
let (v = o - p) p + (n * (v.x * n.x + v.y * n.y + v.z * n.z)); //proj ap to a plane
function dist_point2plane(p,o,n) =
let (v = p-o) ( (v.x * n.x + v.y * n.y + v.z * n.z)); //proj ap to a plane


function v3(p) = [p.x,p.y,p.z]; // vec3 formatter
function rev(v) = [for (i = [len(v) - 1: -1: 0]) v[i]];
function avrg(l) = len(l) > 1 ? addl(l) / (len(l)) : l;
function avrgp(l) = len(l) > 1 ? addlp(l) / (len(l)) : l;
function addlp(v,i=0,r=[0,0,0]) = i<len(v) ? addlp(v,i+1,r+v[i]) : r;
function lerp(start,end,bias) = (end * bias + start * (1 - bias));
function un(v)=assert (is_list(v)) v/max(norm(v),1e-64) ;
function rndc(a = 1,b = 0,s = [])=[rnd(a,b,s),rnd(a,b,s),rnd(a,b,s)];
function rnd(a = 1,b = 0,s = []) =
s == []?(rands(min(a,b),max(a,b),1)[0]) :(rands(min(a,b),max(a,b),1,s)[0]);
function angle (a,b)=atan2(sqrt((cross(a,b)*cross(a,b))),(a* b));

function rotatePointsAxis(points,axis,angle)=[let(i=points)rotateAxis(i,axis,angle)];
 function rotateAxis(point,axis,angle)=RotateQuat(BuildQuat(axis,angle), point);

function  /*vec4*/  NormQuat(/*vec4*/q)=
 let(     lenSQ =  dot4(q, q),     invLenSQ = 1./lenSQ)     q*invLenSQ;
 

function /*vec4*/ BuildQuat(/*vec3*/  axis,   angle)= 
     NormQuat(concat(axis *sin(angle*0.5),[ cos(angle*0.5)]));


 function /*vec3*/RotateQuat(/*vec4*/q, /*vec3*/v)=
let(    /*vec3*/ t = 2.*cross([q.x,q.y,q.z], v)     )    v + q[3]*t + cross([q.x,q.y,q.z], t);


