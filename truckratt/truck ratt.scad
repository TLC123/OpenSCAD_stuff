color([0.4,0.4,0.4])rotate([90,0,0])rotate_extrude($fn=36)
hull(){
translate([3,0])offset(r=.5,$fn=12)square([1,3],true);
translate([1,0])offset(r=.25,$fn=6)square([1,8],true);
}
color([0.3,0.3,0.4])rotate_extrude($fn=36)translate([11.,0])offset(r=.5,$fn=12)rotate(10)square([8,3],true);

color([0.3,0.3,0.4]*2)rotate_extrude($fn=36)translate([18.,0])offset(r=.5,$fn=12)rotate(-10)square([4,1],true);

color("darkred")rotate_extrude($fn=36)translate([5.5,0])offset(r=.5,$fn=12)rotate(10)square([1,3],true);

color([0.4,0.4,0.4])translate([10.5,0,1])rotate([0,-10,0])rotate_extrude($fn=36)translate([3.,0])offset(r=.5,$fn=12)rotate(20)square([2,2],true);
