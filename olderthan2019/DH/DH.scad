//dwarf head
*translate([-0.9,0,0]) %import("dwarfhead.stl");

$fn=16;
 hull(){
translate([0,-5,23])scale([0.9,1,0.7])sphere(21);
translate([0,-11,26])scale([0.8,1,0.7])sphere(18);

*translate([0,-16,-3])scale([3.8,1,0.9])sphere(4);
translate([0,-6,6])scale([4.8,1,0.9])sphere(4);
translate([0,-3,10])scale([0.9,1,1])sphere(18);
//cheekbone
translate([0,-15,15])scale([4.8,2,2])sphere(4);
translate([0,-24,25])scale([2.2,1,1])sphere(4);
}
//jawline
 hull(){
translate([0,-26,-5])scale([1.8,1,0.9])sphere(4);
translate([0,-18,-2])scale([3.8,1,0.9])sphere(4);
translate([0,-6,6])scale([4.8,1,0.9])sphere(4);
translate([0,-3,10])scale([0.9,1,1])sphere(18);
//cheekbone
translate([0,-15,15])scale([4.8,2,2])sphere(4);
translate([0,-25,8])scale([1.8,1,0.9])sphere(4);
translate([0,-27,-0])scale([1.4,1,0.9])sphere(4);


}
//nose
hull(){
translate([0,-22,16])scale([0.5,1,1])sphere(8);

translate([0,-32,6])scale([1.5,1,1])sphere(5);
translate([0,-28,7])scale([0.5,1,1])sphere(4);
translate([0,-27,7])scale([3,2,1])sphere(3);
translate([0,-29,16])scale([1,1,1])sphere(2);
}