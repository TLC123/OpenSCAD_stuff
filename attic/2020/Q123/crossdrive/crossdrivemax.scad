$fn=36;
color("red")Cbuff();
curl=0;
v1=1;
v2=-2.5;
translate([30.5,0,0])rotate([90,0,0])bung();
translate([30.5*2,16+13.5,0])rotate([90,0,0])bung(21.5);


                rotate([0,curl*v1,0]) translate([30.5,13.5,0])Mbuff();
rotate([0,0,180])rotate([0,curl*v1,0])translate([30.5,13.5,0])Mbuff();




rotate([0,0,180])color("red")
rotate([0,curl*v1,0])
translate([30.5,0,0])
rotate([0,curl*v2,0])
translate([30.5,0,0])
Ebuff();

rotate([0,0,0])color("red")
rotate([0,curl*v1,0])
translate([30.5,0,0])
rotate([0,curl*v2,0])
translate([30.5,0,0])
Ebuff();


module bung(o=13.5){
    render()
    {
        union()  {
 translate([0,0,o])g22();
    difference(){
        cylinder(o,7,7);
    translate([0,0,-0.01]) g22();
        cylinder(o*2,1.65,1.65,center=true);
        translate([0,0,0])  cylinder(5,5,0);
        translate([0,0,3.2])  cylinder(4,4.5,0);
        }
    
    }}}


module  Ebuff() {
    o=8;
 cuff();
    cage45();
    rotate([0,  90,0])translate([0,0,-o])g22();
rotate([0,  -90,0])translate([0,0,-o])g22();
rotate([-90, 0,0])translate([0,0,-o])g22();
rotate([90,0,0])translate([0,0,-o])g22();
 
    rotate([-90, 0,0])translate([0,0,-o-27])g45();
rotate([90,0,0])translate([0,0,-o-27])g45();
}


module  Mbuff() {
translate([0,8,0]){Cdiff();
cage45();
cuff();
}


translate([0,-35,0]){
Mdiff();
    cage();
    cuff();
}
}

module  Cbuff() {
translate([0,8,0]){Cdiff();
cage45();
cuff();
}


translate([0,-8,0]){
Mdiff();
    cage();cuff();
}
}

module cuff()rotate([90,0,0])import("cuff.stl",convexity=20);
module g22()import("22.stl",convexity=20);
module g45()rotate([0,0,7.5])import("45.stl",convexity=20);
module cage45()rotate([90,0,0])import("45cage.stl",convexity=20);
module cage()rotate([90,0,0])import("cage.stl",convexity=20);
 module Cdiff(){
o=8;
rotate([0,  90,0])translate([0,0,-o])g22();
rotate([0,  -90,0])translate([0,0,-o])g22();
rotate([-90, 0,0])translate([0,0,-o])g22();
rotate([90,0,0])translate([0,0,-o-5.5])g45();
} 

module Mdiff(){
o=8;
rotate([0,  90,0])translate([0,0,-o])g22();
rotate([0,  -90,0])translate([0,0,-o])g22();
rotate([-90, 0,0])translate([0,0,-o-5.5])g45();
rotate([90,0,0])translate([0,0,-o])g22();
}