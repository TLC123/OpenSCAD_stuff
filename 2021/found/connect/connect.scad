$fn=20;
 for(r=[0:30:360])
rotate([0,r,0])translate([0,0,19])join(2)
{ rotate([0,15,0])translate([5,0,0])torus(1,3);
 mirror([1,0,0])
 rotate([0,15,0])translate([5,0,0])torus(1,3);}
module join(w){
children();
segs=4;
for(i=[0:w/segs:w])
{ planecutX(1+i, 1-(i/w)*0.8) 
children(0);
planecutX(-1-i, 1-(i/w)*0.8)
children(1);}}
module planecutX(offs=0,s=0.75)
{rotate([0,-90,0])
translate([0,0,-offs])
mirror([0,0,min(0,sign(offs))])
linear_extrude( abs(offs),scale=max(0,s))
projection(cut = true) {
translate([0,0,offs])rotate([0,90,0])children();
//translate([0,0,-offs])rotate([0,90,0])children();}}
 module torus(r1=1,r2=3)
{rotate_extrude()
translate([r2,0,0])circle(r1);}