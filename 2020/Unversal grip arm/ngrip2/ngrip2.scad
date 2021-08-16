//$fn=30;
$fn=13;
L= 130;
M=L/150;
tab=8;
convexity =40;



scale (.5)intersection() {
   union() {
!translate([0,0, 11.9]) arm2();
*translate([0,0, 22])rotate( [0,180,0])halfbone();

//
translate([90,60,-00.1])bone();
translate([-90,60,-00.1])bone();
 
       
 translate([ 20,60,-00.1]) linear_extrude(20,convexity =40)   offset(0.5)   kross();
 translate([-20,60,-00.1]) linear_extrude(20,convexity =40)   offset(0.5)   kross();
       
}
 color("Red")translate([0,0,40]) cube([355,300,80],center=true);


}
echo(M);


module kross(){
    
     {
    translate ([0,5,0]) rotate(45)square([10,10],center=true);
   translate ([0,-5,0]) rotate(45)square([10,10],center=true);
    translate ([0,0,0]) rotate(0)square([7,7],center=true);

    }}

module arm() {
    hull(){c=2;
linear_extrude(24,center=true,convexity =40)offset(-c)grip(c);
linear_extrude(24-c*2,center=true,convexity =40)grip(c);
}



module grip(c){
hull(){
scale([2.5,1])circle(40);
square([L*2+33,35-c*2],center=true);
square([L*2+33-c*2,35],center=true);
}}
}
module block(){
    rotate(26) polygon([[2.125,4.95],[7,0],[16,0],
    [7.5,27.8],[16,29.3],[14,30.7],[6,30],[5,25],
    [-0.4,7],[-0,-5],[1.3,-4]])
    *square ([8,32]);
    }

module innard(){
   offset(-1,$fn=$fn)offset(2,$fn=$fn)offset(-1,$fn=$fn)
    difference(){
    
    union() {
    offset(-1,$fn=$fn)offset(2,$fn=$fn)offset(-1,$fn=$fn) union(){
union (){
     hull(){ square([L*2-65+tab,3],center=true);
  
scale([5.2*M,1.9])circle(17.5,$fn=$fn*2);
translate([-(L-35 ),0,0])circle(2,$fn=10);
translate([(L-35 ),0,0])circle(2,$fn=10);
}}






hull(){
translate([(L-20 ),0,0])circle(2);
translate([L,0,0])circle(8);
translate([(L+35*M),0,0])circle(5);}
hull(){
translate([-(L-20 ),0,0])circle(2);
translate([-L,0,0])circle(8);
translate([-(L+35*M),0,0])circle(5);}
}
}

//offset(.5,$fn=$fn) offset(-1.5,$fn=$fn)offset( 1,$fn=$fn) 
union(){
             translate([0,-33])block();
mirror([0,1])translate([0,-33])block();
 }

}
}
 




module arm2 (convexity =40){
 
 
 
 
 
difference(){
 arm();
 

 linear_extrude(100,center=true,convexity =40){ innard();} 

                  translate([-L,0,0])  shrinksphere();
 mirror([-1,0,0]) translate([-L,0,0])  shrinksphere();
 
} }

module  shrinksphere(){
    
    
  translate([-10,0,0])   cube([25,20.,26],center=true);
                  scale([1.3,0.95])    cones ();
 rotate([0,180,0])scale([1.3,0.95])  cones ();
scale([1.51,1])rotate([0,-90,0])cones ();
    
   intersection(){
translate([0,3,0]) rotate( [90, 0,0])  sphere(20);
translate([0,-3,0]) rotate( [90, 0,0]) sphere(20);
    }
    }
    
    module cones (){
        
         translate([0,3,0])   cylinder(12.5,0,12.5); 
 translate([0,-3,0])   cylinder(12.5,0,12.5);
        }

//

//translate([-L,0,0]) rotate( [0, -90,0]) cylinder(30 ,0,30);
// translate([-L,0,5]) rotate( [0, 0,0]) cylinder(30,0,30);
// translate([-L,0,-5]) rotate( [0, 180,0]) cylinder(30,0,30);
//intersection(){
//translate([L,5,0]) rotate( [90, 0,0]) sphere(20);
//
// //translate([ L,-4.1,0]) rotate( [0, 0,0])   phere(20);
//// translate([ L,4.1,0]) rotate( [0, 0,0])   phere(20);
//
//translate([L,-5,0]) rotate( [90, 0,0]) sphere(20);
//
//}
// translate([L,0,0]) rotate( [0, 90,0]) cylinder(30 ,0,30);
// translate([L,0,5]) rotate( [0, 0,0]) cylinder(30,0,30);
// translate([L,0,-5]) rotate( [0, 180,0]) cylinder(30,0,30);
// 
// 
//}

 
 
 
module phere(r)
{
j=2;
scale([1,1,1]) for(i=[0:5*j:180]){rotate( [0,i,0])  hull(){rotate_extrude(convexity =40)translate([r-j,0])circle(j,$fn=4);}}
 
}
module bone(){
    
    
    
    
    
    
    rotate([90,0,90])
    
 difference (){    
    {rotate_extrude(angle=180,convexity =40)
     intersection(){ 
translate([20,0,0])square([40,100],center=true);
 
offset(-20)offset(20)union(){translate([0,-30,0])circle(20);
square([10,30],center=true);
translate([0,30,0])circle(20);
}
}}

 translate([0,0,25])linear_extrude (30) offset(0.5)kross();
 mirror([0,0,1])translate([0,0,25])linear_extrude (30) offset(0.75)kross();
}



}

module halfbone(){rotate_extrude(convexity =40)intersection(){ 
translate([20,0,0])square([40,100],center=true);

offset(-19)offset(19)union(){translate([0,-30,0])circle(20);
square([10,40],center=true);
translate([0,20,0])square([50,5],center=true);
 }
}}

module CHcube(c,ch,cent)
{
    hull(){
        cube([c,c-ch,c-ch],center=true);
        cube([c-ch,c,c-ch],center=true);
        cube([c-ch,c-ch,c],center=true);
        
        }
    }