//DC explaneatot
translate([ 160+80,0,0]){
 polyhedron(points=[
[26,34,24] ,
 [25,-25,25],
 [-25,-25,25],
 [ -25 , 25 , 25 ],
 [25, 25,-25],
 [25,-25,-25]
,[50,50,0]]
,
faces=[[0,1,2,3],[0,4,5,1]]
, convexity = 10);}

translate([ 80,0,0]){
translate([0,0,0])sphere(3);
translate([0,50,0])sphere(3);
color("Red")translate([50,0,0])sphere(3);
translate([50,50,0])sphere(3);

color("Red")translate([0,0,50])sphere(3);
color("Red")translate([50,0,50])sphere(3);
translate([50,50,50])sphere(3);
translate([0,50,50])sphere(3);


#color(0.25){
 translate([0,0,25]) rotate([15,12,18])cube([80,80,1],center=true);
translate([25,0,0])rotate([15,-12,-18]) cube([1,80,80],center=true);

translate([0,25,50])rotate([15,12,18]) cube([80,1,80],center=true);
translate([50,25,0]) rotate([-15,12,18])cube([80,1,80],center=true);
translate([50,25,50])rotate([15,-12,-18]) cube([80,1,80],center=true);}

translate([0,0,25]) cube([1,1,50],center=true);
translate([25,0,0]) cube([50,1,1],center=true);

translate([0,25,50]) cube([1,50,1],center=true);
translate([50,25,0]) cube([1,50,1],center=true);
translate([50,25,50]) cube([1,50,1],center=true);

color("Orange")translate([37,4,30]) cube(3,center=true);
color("Orange")translate([31,15,29]) cube(3,center=true);
color("Orange")translate([28,25,27]) cube(3,center=true);
color("Orange")translate([26,29,25]) cube(3,center=true);
color("blue")translate([26,34,24]) cube(8,center=true);

}




translate([-160+80,0,0]){
translate([0,0,0])sphere(3);
translate([0,50,0])sphere(3);
color("Red")translate([50,0,0])sphere(3);
translate([50,50,0])sphere(3);

color("Red")translate([0,0,50])sphere(3);
color("Red")translate([50,0,50])sphere(3);
translate([50,50,50])sphere(3);
translate([0,50,50])sphere(3);



 translate([0,0,25]) rotate([15,12,18])cube([30,30,1],center=true);
translate([25,0,0])rotate([15,-12,-18]) cube([1,30,30],center=true);

translate([0,25,50])rotate([15,12,18]) cube([30,1,30],center=true);
translate([50,25,0]) rotate([-15,12,18])cube([30,1,30],center=true);
translate([50,25,50])rotate([15,-12,-18]) cube([30,1,30],center=true);

translate([0,0,25]) cube([1,1,50],center=true);
translate([25,0,0]) cube([50,1,1],center=true);

translate([0,25,50]) cube([1,50,1],center=true);
translate([50,25,0]) cube([1,50,1],center=true);
translate([50,25,50]) cube([1,50,1],center=true);

 

}

translate([-160-80,0,0]){
translate([0,0,0])sphere(3);
translate([0,50,0])sphere(3);
color("Red")translate([50,0,0])sphere(3);
translate([50,50,0])sphere(3);

color("Red")translate([0,0,50])sphere(3);
color("Red")translate([50,0,50])sphere(3);
translate([50,50,50])sphere(3);
translate([0,50,50])sphere(3);



translate([0,0,25]) cube([50,50,1],center=true);
translate([25,0,0]) cube([1,50,50],center=true);

translate([0,25,50]) cube([50,1,50],center=true);
translate([50,25,0]) cube([50,1,50],center=true);
translate([50,25,50]) cube([50,1,50],center=true);

translate([0,0,25]) cube([1,1,50],center=true);
translate([25,0,0]) cube([50,1,1],center=true);

translate([0,25,50]) cube([1,50,1],center=true);
translate([50,25,0]) cube([1,50,1],center=true);
translate([50,25,50]) cube([1,50,1],center=true);


color("Orange")translate([25,25,25]) cube([10,10,10],center=true);

} 