$fn=30;
L= 150;
M=L/150;
tab=8;
intersection() {
   union() {
translate([0,0, 11.5]) arm();
//
translate([50,0,-00.1])bone();
translate([-50,0,-0.1])bone();
translate([0,0, 22])rotate( [0,180,0])halfbone();
}
 color("Red")translate([0,0,40]) cube([330,100,80],center=true);


}
echo(M);

module arm (){
//translate([ L,0,0]) 
intersection(){
scale([(300*M)+29,100,32])cube(1,center=true);
 
 difference(){
union(){
difference(){
 hull(){
translate([0,0,10])scale([4*M,1.5,0.])rotate( [0,90,0])sphere(30);
translate([0,0,-10])scale([4*M,1.5,0.])rotate( [0,90,0])sphere(30);

translate([0,0,13])scale([4*M,1.5,0.])rotate( [0,90,0])sphere(28.5);
translate([0,0,-13])scale([4*M,1.5,0.])rotate( [0,90,0])sphere(28.5);
     
     
 scale([1,1,0.9]) 
translate([-L,0,0]) rotate( [0,90,0])CHcube(26,5  );
 
 scale([1,1,0.9]) 
translate([L,0,0]) rotate( [0,90,0])CHcube(26,5 );
}

 linear_extrude(100,center=true){
offset(-1,$fn=$fn)offset(2,$fn=$fn)offset(-1,$fn=$fn) union(){
union (){
     hull(){ square([235+tab,3],center=true);
  
scale([5.2*M,1.9])circle(20,$fn=$fn*2);
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

}}}
intersection(){
translate([-L,5,0]) rotate( [90, 0,0])  sphere(20);
//translate([-L,-4.1,0]) rotate( [0, 0,0])   phere(20);
//translate([-L,4.1,0]) rotate( [0, 0,0])   phere(20);
translate([-L,-5,0]) rotate( [90, 0,0]) sphere(20);
} 
translate([-L,0,0]) rotate( [0, -90,0]) cylinder(30 ,0,30);
 translate([-L,0,5]) rotate( [0, 0,0]) cylinder(30,0,30);
 translate([-L,0,-5]) rotate( [0, 180,0]) cylinder(30,0,30);
intersection(){
translate([L,5,0]) rotate( [90, 0,0]) sphere(20);

 //translate([ L,-4.1,0]) rotate( [0, 0,0])   phere(20);
// translate([ L,4.1,0]) rotate( [0, 0,0])   phere(20);

translate([L,-5,0]) rotate( [90, 0,0]) sphere(20);

}
 translate([L,0,0]) rotate( [0, 90,0]) cylinder(30 ,0,30);
 translate([L,0,5]) rotate( [0, 0,0]) cylinder(30,0,30);
 translate([L,0,-5]) rotate( [0, 180,0]) cylinder(30,0,30);
 
 
}}
 
 }
module phere(r)
{
j=2;
scale([1,1,1]) for(i=[0:5*j:180]){rotate( [0,i,0])  hull(){rotate_extrude()translate([r-j,0])circle(j,$fn=4);}}
 
}
module bone(){
    rotate_extrude()
     intersection(){ 
translate([20,0,0])square([40,100],center=true);
      difference(){
translate([3,0,0])square([40,100],center=false);
translate([0,30,0])square([8,20],center=false);
      }
offset(-20)offset(20)union(){translate([0,-30,0])circle(20);
square([10,30],center=true);
translate([0,30,0])circle(20);
}
}}

module halfbone(){rotate_extrude()intersection(){ 
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