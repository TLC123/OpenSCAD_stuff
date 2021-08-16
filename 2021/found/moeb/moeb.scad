module profile(){linear_extrude (0.1)circle(1,$fn=3);}


module ring(){
for (i=[0:12:360]){
ii=i-(12);
hull(){
rotate([0,0,i])translate([8,0,0]) rotate([90,0,0])rotate([0,0,i/3])profile();
rotate([0,0,ii])translate([8,0,0]) rotate([90,0,0])rotate([0,0,ii/3])profile();}


}}

rotate([0,$t*-360])translate([-8,0,0])rotate([0,0,$t*360*3])ring();


rotate([0,0,0])
translate([-1.5,0,0])rotate([0,0,$t*360*-3])cylinder(1.6,center=true,$fn=13);
rotate([0,120,0])
translate([-1.5,0,0])rotate([0,0,$t*360*-3])cylinder(1.6,center=true,$fn=13);
rotate([0,120*2,0])
translate([-1.5,0,0])rotate([0,0,$t*360*-3])cylinder(1.6,center=true,$fn=13);



rotate([0,60,0])
translate([-2.5,0,0])
rotate([90,0,0])rotate([0,0,$t*360*-3])cylinder(1,1,1,center=true,$fn=13);
rotate([0,60+120,0])
translate([-2.5,0,0])
rotate([90,0,0])rotate([0,0,$t*360*-3])cylinder(1,1,1,center=true,$fn=13);
rotate([0,60+240,0])
translate([-2.5,0,0])
rotate([90,0,0])rotate([0,0,$t*360*-3])cylinder(1,1,1,center=true,$fn=13);


rotate([90,0,0])rotate([0,0,$t*360])
difference(){
cylinder(1,4,4,center=true,$fn=25);
cylinder(3,3.5,3.5,center=true,$fn=25);}


rotate([90,0,0])rotate([0,0,$t*360])
translate([3.85,0,0])cube([1,1,21],center=true);

rotate([90,0,0])rotate([0,0,$t*360])
translate([1.5,0,10])cube([5,1,1],center=true);
rotate([90,0,0])rotate([0,0,$t*360])
translate([1.5,0,-10])cube([5,1,1],center=true);