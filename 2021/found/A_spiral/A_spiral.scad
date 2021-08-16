 polyline(D_Apiral_As_Line([rnd(100),rnd(100)],[rnd(100),rnd(100)],turns=rnd(3),exponent=rnd(-1,2),steps= 50,bias=rnd(1.3)-0.1));

module polyline(p) {for(i=[0:max(0,len(p)-2)])line(p[i],p[i+1]);}

module polyplot(p) {for(i=[0:max(0,len(p)-1)])translate(p[i])sphere(1);}

module line(p1, p2 ,width=0.5) { hull() {        
translate(p1) sphere(width,$fn=5);
translate(p2) sphere(width,$fn=5); } }

function L_Spiral (radius = 50,turns =  4,exponent=1.685,start_angle=45,
steps=50,p1,p2)
=  [for(a = [0.5/steps:1/steps: 1  ])[ 
(radius * fx2(1-a, exponent)) * cos(start_angle+ a* turns*360*sign(turns)),
(radius * fx2(1-a, exponent)) * sin(start_angle+a* turns*360*sign(turns) )]+p1 ];

function D_Apiral_As_Line(p1,p2,turns=3,exponent=1.685 ,steps=150,bias=0.392)=


let(p3=lerp(p1,p2,bias) ,
spiral2d=
concat(
reverse(L_Spiral (radius=norm(p1-p3),turns =turns,exponent=exponent,start_angle=atan2((p3-p1).y,(p3-p1).x),steps=steps,p1=p1,p2=p3)),
(L_Spiral (radius=norm(p2-p3),turns =turns,exponent=exponent,start_angle=atan2((p3-p2).y,(p3-p2).x),steps=steps,p1=p2,p2=p3)    ))
)

[for (i=[0:len(spiral2d)-1],j=i/(len(spiral2d)-1))[spiral2d[i].x,spiral2d[i].y,lerp(0,10,  ( smStep(j)))]];


    function smStep (a) =
let (b = clamp(a))(b * b * (3 - 2 * b));
 
function clamp(a, b = 0, c = 1) =is_list(a)? [for (i=a)clamp(i,b,c)] : min(max(a, b), c);

function gauss(x) =  
     x + (x - smStep(x));


function L_Apiral_As_Line(p1,p2,turns=3,exponent=1.685 ,steps=150)=
L_Spiral (radius=norm(p1-p2),turns =turns,exponent=exponent,start_angle=atan2((p2-p1).y,(p2-p1).x),steps=steps,p1=p1,p2=p2);

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