function face_normal(point_a,point_b,point_c)=
let(u=point_a-point_b,v=point_a-point_c)
un([u[1]*v[2]-u[2]*v[1],u[2]*v[0]-
u[0]*v[2],u[0]*v[1]-u[1]*v[0]]);

function un(v)=v/max(norm(v),1e-64);

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
(a* b)  );

function rnd(a = 1, b = 0, s = []) =
s == [] ?
(rands(min(a, b), max(
a, b), 1)[0]) :
(rands(min(a, b), max(a, b), 1, s)[0]);

function Great_circle_axis(p1,p2,r)=
let(v1=face_normal([0,0,0],p1,p2))
v1;

module Great_circle(p1,p2,r){
v1=face_normal([0,0,0],p1,p2);
look_at(v1)torus(r,0.05);
}
module Concentric_small_circle(p1,p2,r,r2){
v1=face_normal([0,0,0],p1,p2);
look_at(v1)translate([0,0,sign(r2)*r*cos(90*(r2/r))])torus(r*sin(90*(r2/r)),0.05);
}

module torus(r1,r2)
{rotate_extrude($fn=40)translate([r1,0,0])circle(r2,$fn=12);
}
module look_at(lookpoint,origin=[0,0,0],rotatefrom=[0,0,1]){
rotations=look_at(lookpoint,origin ,rotatefrom);
rotate(rotations[0],rotations[1]) children();
}
radius=5;
small_radius=radius*rnd();
#sphere(5,$fn=40);
lat1=rnd(-90,90);
long1=rnd(0,360);
lat2=rnd(-90,90);
long2=rnd(0,360);

p1= ([sin(long1),cos(long1)*sin(lat1),cos(lat1)])*radius;
p2= ([sin(long2),cos(long2)*sin(lat2),cos(lat2)])*radius;
echo(p1,p2);
translate(p1) sphere(0.3,$fn=40);
translate(p2) sphere(0.3,$fn=40);

Great_circle(p1,p2,radius);
Concentric_small_circle(p1,p2,radius,-small_radius);
Concentric_small_circle(p1,p2,radius,small_radius);