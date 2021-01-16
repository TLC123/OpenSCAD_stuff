import("D:/g/OpenSCAD/bod/astrobod1.stl");
aarm();
mirror()aarm();

module aarm(){
translate([13,0,140])sphere(15);
translate([18,-1,135])sphere(12);
translate([25,0,126])sphere(12);
translate([33,2,115])sphere(10);
translate([38,-1,106])sphere(10);
translate([40,-2,100])sphere(10);}