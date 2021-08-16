difference(){
   translate([0,0,-3]) cylinder(50,22,32);
rotate([90,0,0])cylinder(50,12,12);
    hull(){
rotate([0,0,85])rotate([90,0,0])cylinder(25,12,12);
rotate([0,0,-85])rotate([90,0,0])cylinder(25,12,12);
}}