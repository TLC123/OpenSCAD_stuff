linear_extrude 
(10,scale=[0.75,1]) 
offset( 0.4,$fn=20)offset(-0.8,$fn=20)offset( 0.4,$fn=20) difference(){
union(){
translate([0,5])square(10,true);
translate([0,9.5])square([13,2],true);}
translate([0,7])square([5,9],true);}

color("Red")translate([0,14.5])rotate([0,0,180])
linear_extrude 
(10,scale=[0.75,1 ]) 
offset( 0.4,$fn=20)offset(-0.8,$fn=20)offset( 0.4,$fn=20) difference(){
 
translate([0,5])square([17,6],true);
 
translate([0,5])square([14,3],true);
translate([0,7])square([10,5],true);
}

color("Red")translate([0,14.5,10])rotate([0,0,180])
scale ([0.75,1 ])linear_extrude 
(1,scale=[1-(0.25/7),1 ]) hull(){
offset( 0.4,$fn=20)offset(-0.8,$fn=20)offset( 0.4,$fn=20) difference(){
 
translate([0,5])square([17,6],true);
 
translate([0,5])square([14,3],true);
translate([0,7])square([10,5],true);
}}


translate([0,0,-1] )linear_extrude 
(1 ) 
hull(){offset( 0.4,$fn=20)offset(-0.8,$fn=20)offset( 0.4,$fn=20) difference(){
union(){
translate([0,5])square(10,true);
translate([0,9.5])square([13,2],true);}
translate([0,7])square([5,9],true);}}

module plate(){}
module finn(){}
module stop(){}
module snap(){}