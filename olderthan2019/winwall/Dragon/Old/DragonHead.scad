*translate([5,-1,-6])rotate([80,0,3.5])import("headcase.stl", convexity=5);
circle(3);
cube([50,1,1],center=true);
color("red"){sphere(5);
translate([3,0,1])sphere(5);
translate([6,0,0.2])sphere(3.6);
translate([9,0,-0.50])sphere(3.3);
translate([12,0,-1])sphere(3.1);
translate([13,0,-2.7])sphere(2.7);
translate([14.9,0,-4.5])sphere(1.5);}
color("red"){
    translate([-0.5,0,2])sphere(4.5);
translate([4.1,0,2])sphere(4.3);
translate([8,0,2])sphere(2);
translate([11,0,1.1])sphere(2);
translate([12.5,0,0])sphere(2);
translate([13.5,0,-1.5])sphere(2);
translate([14.5,0,-3.5])sphere(1.5);}

color("red"){
    translate([-1.7,2.2,4.2])sphere(2);
translate([1.5,3.3,3.7])sphere(2);
translate([4.9,3.7,4.3])sphere(1);
translate([7.3,0.9,3.8])sphere(1);
translate([8,2.2,1.1])sphere(1);
translate([10.5,2.4,0])sphere(1);
translate([12.5,2.7,1])sphere(1);
translate([13.5,2.3,-1.5])sphere(1);}

color("red"){
    translate([-1.7,-2.2,4.2])sphere(2);
translate([1.5,-3.3,3.7])sphere(2);
translate([4.9,-3.7,4.3])sphere(1);
translate([7.3,-0.9,3.8])sphere(1);
translate([8,-2.2,1.1])sphere(1);
translate([10.5,-2.4,0])sphere(1);
translate([12.5,-2.7,1])sphere(1);
translate([13.5,-2.3,-1.5])sphere(1);}

color("blue"){
translate([0,2.0,0.5])   sphere(4);
translate([3,2.5,-0.2])sphere(3.5);
translate([6,2,0.2])sphere(2.6);
translate([5,2,-2.55])sphere(2.2);
translate([8,2,-3.5])sphere(1.6);
translate([10,2,-4.6])sphere(1.4);
translate([11.9,1,-5.5])sphere(1.0);}
color("blue"){
translate([0,-2.0,0.5])   sphere(4);
translate([3,-2.5,-0.2])sphere(3.5);
translate([6,-2,0.2])sphere(2.6);
translate([5,-2,-2.55])sphere(2.2);
translate([8,-2,-3.5])sphere(1.6);
translate([10,-2,-4.6])sphere(1.4);
translate([11.9,-1,-5.5])sphere(1.0);}

color("blue"){
translate([0,0.0,0.5])   sphere(4);
translate([3,0,-0.2])sphere(3.5);
translate([6,-0,0.2])sphere(2.6);
translate([5,-0,-2.55])sphere(2.2);
translate([8,-0,-3.5])sphere(1.6);
translate([10,-0,-4.6])sphere(1.4);
translate([11.9,-0,-5.5])sphere(1.0);}