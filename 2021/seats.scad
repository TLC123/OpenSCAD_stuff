Lookatpoint=[rnd(-20,20),rnd(-20,20),rnd(-20,20)];
Origin=[rnd(-20,20),rnd(-20,20),rnd(-20,20)];
translate(Lookatpoint)color("red")sphere(2);
translate(Origin)color("blue")sphere(2);
translate(Origin)look_at(Lookatpoint ,Origin ){
    
arrow();
}

module arrow ()
{

color ("red")look_at([1,0,0]){
translate([0,0,5])cylinder(7,2,0);
translate([0,0,-3])cylinder(9,1,1);
 }
 
color ("green")look_at([0,1,0]){
translate([0,0,5])cylinder(7,2,0);
translate([0,0,-3])cylinder(9,1,1);
 }
 
color ("blue")look_at([0,0,1]){
translate([0,0,5])cylinder(7,2,0);
translate([0,0,-3])cylinder(9,1,1);
 }
    }



module look_at(lookpoint,origin=[0,0,0],rotatefrom=[0,0,1]){
rotations=look_at(lookpoint,origin ,rotatefrom);
rotate(rotations[0],rotations[1]) children();
}
function look_at(p,o=[0,0,0],up=[0,0,1])=let(a=up,b=p-o,c=cross(a,b) ,d=angle(a,b))[d,c];

function angle (a,b)=atan2(sqrt((cross(a, b)*cross(a, b))), (a* b));


function rnd(a = 1, b = 0, s = []) =
s == [] ?
  (rands(min(a, b), max(
    a, b), 1)[0]) :
  (rands(min(a, b), max(a, b), 1, s)[0]);
