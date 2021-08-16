$fn=30;
turns=4;
steps=70;
ex=-1.285;
ex2=0.5685 ;
wall=5;
height2=100;
w2=50;

 difference(){
shell(0.02)profile();
 difference(){
shell(0.01, 5)profile();
shell(0.01+0.5, 0)profile();
 }}
module profile(){
union(){
scale([0.5,1])circle(1);
scale([1,0.5])circle(1);
}
}
module shell(startturn=0,wall=0)
{
for(i=[(1/turns)*startturn:1/steps:0.99]){
hull(){
p1=L_Spiral (i,w2,height2);
v1=L_Spiral (i,w2,height2)-L_Spiral (i-(1/steps),w2,height2);
r1=max(0.01,norm([p1.x,p1.y]) ) ;
translate([p1.x,p1.y,power(i )*height2])look_at(v1)
linear_extrude(0.01+wall)offset(r=-wall)scale(r1)children();

p2=L_Spiral (i-(1/steps),w2,height2);
v2=L_Spiral (i-(1/steps),w2,height2)-L_Spiral (i-2*(1/steps),w2,height2);
r2=max(0.01,norm([p2.x,p2.y])) ;
 translate([p2.x,p2.y,power(i-1/steps )*height2])look_at(v2)
linear_extrude(0.01+wall)offset(r=-wall)scale(r2)children();
}}
}








 function arc1 (x,n=0) = let(a= n>0? arc1(x,(n-1)):x) clamp(sqrt(1-(1-a)*(1-a)));
 function clamp(a, b = 0, c = 1) = min(max(a, b), c);



      function power(x,n=ex) = n<0?pow(x,1/abs(min(-1,n-1) )):pow(x,max(1,n+1))   ;


 




function L_Spiral (a,radius = 50,heigth=100,turns =  4,xpnt=ex2,start_angle=45)
= let( fx = xpnt<0?
pow(max(0,1-a),1/abs(min(-1,xpnt-1) )): pow(max(0,1-a),max(1,xpnt+1))   ) 
[(radius * fx ) * cos(start_angle+ a* turns*360*sign(turns)),
 (radius * fx ) * sin(start_angle+ a* turns*360*sign(turns)),a*heigth];

//for(j=[0:1/60:1]){hull(){
// translate(L_Spiral (j, 50,-150,  4, 1.685, 0 ))sphere();
// translate(L_Spiral (j+1/60, 50,-150, 4, 1.685, 0 ))sphere();
//}}
// 
//Lookatpoint=[rnd(-20,20),rnd(-20,20),rnd(-20,20)];
//Origin=[rnd(-20,20),rnd(-20,20),rnd(-20,20)];
//translate(Lookatpoint)color("red")sphere(2);
//translate(Origin)color("blue")sphere(2);
//translate(Origin)look_at(Lookatpoint ,Origin ){
//translate([0,0,5])cylinder(7,2,0);
//translate([0,0,-3])cylinder(9,1,1);
//}
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