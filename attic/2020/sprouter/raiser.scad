$fn=24;
linear_extrude(1.5)difference() {
    union() {
offset(6)offset(-6)square ([75,120],center=true);
         
    }
offset(2)offset(-6)square ([75,120],center=true);
}

knob();
mirror([1,0])knob();
mirror([0,1])knob();
mirror([0,1])mirror([1,0])knob();
 
module knob() {
    translate([35.5,52])cylinder(4,2,.75);
    translate([35.5,0])cylinder(4,2,.75);
    translate([35.5,26])cylinder(4,2,.75);
translate([29.5,58])cylinder(4,2,.75);
translate([0,58])cylinder(4,2,.75);
}