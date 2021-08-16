$fn=6;
hull(){translate([1,1,7])sphere(2);
translate([0,0,1])scale(1.3)cylinder(1,2,2);}

hull(){translate([-1,4,1])scale([1,1,0.5])sphere(2);
translate([-1,4,0])cylinder(1,2,2);
translate([0,0,0])cylinder(2.5,2,2);}
hull(){
translate([1,1,7])sphere(2);

translate([2,-1,11])sphere(2);}
hull(){
translate([5,-1,7])sphere(2);

translate([4,-1,11])sphere(2);}

translate([6,-4,0])hull(){translate([1,5,1])scale([1,1,0.5])sphere(2);
translate([1,5,0])cylinder(1,2,2);
translate([0,0,0])cylinder(1,2,2);}

hull(){
translate([5,-1,7])sphere(2);
translate([6,-4,1])scale(1.3)cylinder(1,2,2);}

hull(){

translate([3,-1,9])scale([4,3,1])rotate(90)cylinder(1,1,1);
translate([3,0,12])scale([3,3,1])rotate(90)cylinder(1,1,1);

}
hull(){
translate([3,0,9])scale([1,1,1]) cylinder(1,1,1);

translate([3,0,12])scale([3,3,1])rotate(90)cylinder(1,1,1);
translate([3,1,15])scale([4,3,1])rotate(60)cylinder(1,1,1);
}
hull(){
translate([3,1,15])scale([4,3,1])rotate(60)cylinder(1,1,1);

translate([3,1,16])scale([2,2,1])rotate(90)cylinder(1,1,1);
}
translate([3,1,18.5])scale([0.7,0.8,1])rotate(45/2)sphere(3,$fn=8);