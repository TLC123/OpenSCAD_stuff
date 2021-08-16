 volute();


module volute()
{
path=DS_Apiral_As_Line([rnd(60),rnd(60)],[rnd(60)+40,rnd(60)+40],turns=1.5+rnd(0.5),exponent=rnd(-3,3),steps= 40,bias= (0.5) );
for(i=[0:max(0,len(path)-2)]) 
hull()
{
d1=path[i+1]-path[i];
v1=atan2(d1.y,d1.x);
d2=path[i+2]-path[i+1];
v2=atan2(d2.y,d2.x);
translate(path[i])rotate ([0,0,v1]) cube([6,6,6],center=true);
translate(path[i+1])rotate ([0,0,v2]) cube([6,6,6],center=true);
}
}



module polyline(p) {for(i=[0:max(0,len(p)-2)])line(p[i],p[i+1]);}

module polyplot(p) {for(i=[0:max(0,len(p)-1)])translate(p[i])sphere(1);}

module line(p1, p2 ,width=0.5) { hull() {        
translate(p1) sphere(width,$fn=5);
translate(p2) sphere(width,$fn=5); } }

function L_Spiral (radius = 50,turns ,exponent=1.685,start_angle=45,
steps=50,p1,p2)
=  [for(a = [1/steps:1/steps: 1  ])[ 
(radius * fx2(1-a, exponent)) * cos(start_angle+ a* abs(turns)*360*sign(turns)),
(radius * fx2(1-a, exponent)) * sin(start_angle+a* abs(turns)*360*sign(turns) )]+p1 ];

//function D_Apiral_As_Line(p1,p2,turns=3,exponent=1.685 ,steps=150,bias=0.392)=
//let(p3=lerp(p1,p2,bias) )concat(
//reverse(L_Spiral (radius=norm(p1-p3),turns =2*turns*(bias),exponent=exponent,start_angle=atan2((p3-p1).y,(p3-p1).x),steps=steps,p1=p1,p2=p3)),
//(L_Spiral (radius=norm(p2-p3),turns =2*turns*(1-bias),exponent=exponent,start_angle=atan2((p3-p2).y,(p3-p2).x),steps=steps,p1=p2,p2=p3)    ));

function DS_Apiral_As_Line(p1,p2,turns=3,exponenti=1.685 ,steps=150,bias=0.392)=
let(p3=lerp(p1,p2,bias) )concat(
reverse
(L_Spiral (radius=norm(p1-p3)*0.9,turns =- turns ,exponent=exponent,start_angle=atan2((p3-p1).y,(p3-p1).x)-70,steps=steps,p1=p1,p2=p3)),
(L_Spiral (radius=norm(p2-p3)*0.9,turns =( turns ),exponent=exponent,start_angle=atan2((p3-p2).y,(p3-p2).x)+70,steps=steps,p1=p2,p2=p3)    ));

//
//function L_Apiral_As_Line(p1,p2,turns=3,exponent=1.685 ,steps=150)=
//L_Spiral (radius=norm(p1-p2),turns =turns,exponent=exponent,start_angle=atan2((p2-p1).y,(p2-p1).x),steps=steps,p1=p1,p2=p2);

function fx2(x,n) = n<0?pow(max(0,x),1/abs(min(-1,n-1) )):pow(max(0,x),max(1,n+1))   ;
function reverse(l) = len(l)>0 ? 
[ for(i=[len(l)-1:-1:0]) l[i] ] : len(l)==0 ? [] : undef; 
function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function rnd(a = 1, b = 0, s = []) = 
s == [] ? 
(rands(min(a, b), max(   a, b), 1)[0]) 
: 
(rands(min(a, b), max(a, b), 1, s)[0])
; 