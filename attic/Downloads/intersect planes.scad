a=[[1,2,1],un(rands(-1,1,3))];
b=[[2,1,0],un(rands(-1,1,3))];
m=(a+b)/2;
translate(a[0])sphere(.1);
translate(m[0])sphere(.1);
translate(b[0])sphere(.1);
solution=intersectPlanes(a,b);

translate(solution )sphere(.1);
 
 
echo(solution);
 #translate(a[0]) look_at(a[1])cube([1,1,.001]*5 ,center=true);
 #translate(b[0]) look_at(b[1])cube([1,1,.001]*5 ,center=true);


function intersectPlanes(p1,p2)=
let( 
np3=cross(p1[1],p2[1]),
bp1=baseform(p1),bp2=baseform(p2),
det= norm(np3)*norm(np3),
m=(p1[0]+p2[0])/2,
point=-(( cross(np3,bp2[0]) * bp1[1]) + (cross(bp1[0],np3) * bp2 [1])) / det
 )
   point_to_line(m ,point,point+np3 )
; 
function baseform(pn)=[pn[1],distance_point2plane(pn[0],[0,0,0], pn[1]) ];
function point_to_line( p, a, b )=let(ap = p-a, ab = b-a) a + dot(ap,ab)/dot(ab,ab) * ab ;
function distance_point2plane(point, planes_origin, planes_normal) =
let (v = point - planes_origin) v.x * planes_normal.x + v.y * planes_normal.y + v.z * planes_normal.z ; 


function un(v) = v / max(norm(v), 0.000001) * 1; // div by zero safe unit normal

function dot(a,b)=a*b;
function clamp(a, b = 0, c = 1) = min(max(a, b), c);



 module look_at(lookpoint,origin=[0,0,0],rotatefrom=[0,0,1]){
rotations=look_at(lookpoint,origin ,rotatefrom);
rotate(rotations[0],rotations[1]) children();
}
function look_at(p,o=[0,0,0],up=[0,0,1])=
let(
a=up,
b=p-o,
c=cross(a,b) ,
d=angle(a,b))
[d,c];

function angle (a,b)=
atan2(
sqrt((cross(a, b)*cross(a, b))), 
(a* b)
);