$fn=16;
main();
module main(){
color("lightgrey")
    {
        head();
        arm();
        foot();
    }
}


module head()
{
difference(){ 
union(){ 
    translate([150,-6,38+17])mirror([1,0,1])ocorner(3);//trim
    translate([150, 6,38+17])mirror([1,0,1])ocorner(3);//trim
    translate([147,-12,38+14+3])cube([7,18+6,27]);//trim
    translate([147,-6,38+11])cube([7,18-6,33]);//trim    
        difference(){ 
            translate([150,-16,38])cube([60,32,44]); 
            translate([150,0,38+44])mirror([0,0,0])mirror([0,-1,-1])
        otrim(34);//trim
        }

}

    translate([147,-12,38+11])cylinder(44,3,3);//trim
    translate([147,12,38+11])cylinder(44,3,3);//trim
    translate([147, 0,38+11]) rotate([90,0,0]) 
        cylinder(44,3,3,center=true);//trim 
    translate([147,-12,38+44])mirror([0,0,1]) 
        ocorner(3);//trim
    translate([147, 12,38+44])mirror([0,0,1]) 
        ocorner(3);//trim 
    translate([175, 0,38+22])rotate([90,0,0])
         cylinder(44,15,15,center=true,$fn=64);//trim
    translate([200, 0,38+22])rotate([0,0,0]) 
        cylinder(45,4.5,4.5,center=true,$fn=16);//trim
    translate([200, 0,38+22])rotate([0,0,0]) 
        cylinder(2,30,30,center=true,$fn=16);//trim

   }  
}
module arm()
{   
difference(){ 
        translate([70,-9,38+14])cube([80,18,30]);
//trim
 translate([110,-9,52])mirror([0,0,1])mirror([1,0,1])otrim(81);      
 translate([110,9,52])mirror([0,1,-1])mirror([1,0,1])otrim(81);  
 translate([110,-9,82])mirror([0,0,1])mirror([1,0,-1])otrim(81);      
 translate([110,9,82])mirror([0,1,1])mirror([1,0,-1])otrim(81);  
 

   }   
difference(){   
        translate([20,-9,10])cube([55,18,22]);  
//trim 
 translate([20,-9,15])mirror([0,0,0])otrim(36);      
 translate([20,9,15])mirror([0,1,0])otrim(36);  
 translate([75,-9,15])mirror([1,0,0])otrim(36);  
 translate([75,9,15])mirror([1,1,0])otrim(36);  

 }   

    intersection()
    {
        translate([20,-9,32])cube([75,18,50]);
        difference(){   translate([70,0,32]) rotate([90,0,0])
            cylinder(18,50,50,center=true,$fn=64);
                        translate([95,0,32]) rotate([90,0,0])
            cylinder(19,20,20,center=true,$fn=64);
//trim
mirror([0,0,0])translate([95,9,32]) rotate([90,0,0])ocorner32(20);
mirror([0,1,0])translate([95,9,32]) rotate([90,0,0])ocorner32(20);
mirror([0,1,0])translate([70,9,32]) rotate([90,0,0])ocorner32(-55+5);
mirror([0,0,0])translate([70,9,32]) rotate([90,0,0])ocorner32(-55+5);


 }
    }
}

module foot(){
    difference(){
        hull(){ for(i=[0:1/4:1]){
        y=cos(i*90)*3; x=-3+sin(i*90)*3;
        translate([0,0,0]) linear_extrude(7+y) offset( x)footP();
        } }
        translate([0,0,-0.005])linear_extrude(10.01){
        circle(4); 
        translate([75,-30])circle(4); 
        translate([75,30]) circle(4);} 
    }
//trim
 translate([20+3,-9+3,10])ocorner(3);
 translate([20+3,9-3,10])ocorner(3);
 translate([75-3,-9+3,10])ocorner(3);
 translate([75-3,9-3,10])ocorner(3);
 translate([20,0,10])mirror([1,0,0])mirror([0,-1,1])otrim(12);
 translate([75,0,10])               mirror([0,-1,1])otrim(12);
 translate([20+55/2,9,10])mirror([0,0,1])mirror([1,0,1])otrim(55-6);
 translate([20+55/2,-9,10])mirror([0,-1,1])mirror([1,0,1])otrim(55-6);}

 module footP(){
    hull()
    {
        circle(10);
        translate([75,-30])circle(10);
        translate([75,30])circle(10);
    }
}


module quarterround(){ 
difference()
{
    translate([-1,-1]) square([4,4]);
    translate([3,3])circle(3,$fn=16);
}}

module ocorner(r)
{
rotate_extrude ($fn=16,convexity=20)translate([r,0])quarterround();
}
module ocorner32(r)
{
rotate_extrude ($fn=64,convexity=20)translate([r,0])quarterround();
}
module otrim(l)
{
linear_extrude (l,center=true,convexity=20)translate([0,0])quarterround();
}