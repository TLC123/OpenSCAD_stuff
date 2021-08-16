vp=[0,1700-4000*$t,0])rotate([45-40*$t,0,45])translate([0,550-200*$t,0];


 $vpt=vp;


$vpr=[70+sin(ta)*10,0,-ta*.25+150];
$vpd=(500); 

translate(vp) 

rotate([
sin($t*360*3),
0,0

])evaman();


station();

module station(){
translate ([150,0,0])cap(700);
rotate([0,0,180])translate ([150,0,0])cap(900);
rotate([0,0,90])translate ([150,0,0])cap(1150-300);
rotate([0,0,-90])translate ([150,0,0])cap(700);
rotate([0,0,90])translate ([150+1150,0,0])cap(500);
rotate([0,90,0])translate ([150,0,0])cap(400);
node();
     
translate ([0,1150+00,0])node();
    
 translate([0,50,300])   for(i= [-2000:300:2000]){
     
     
hull(){
    translate([150,i,150])sphere(10);
    translate([150,i,-150])sphere(10);
    }
hull(){
    translate([-150,i,150])sphere(10);
    translate([-150,i,-150])sphere(10);
    }
hull(){
    translate([150,i,150])sphere(10);
    translate([-150,i,150])sphere(10);
    }
hull(){
    translate([150,i,-150])sphere(10);
    translate([-150,i,-150])sphere(10);
    
    }
hull(){
    translate([150,i,150])sphere(10);
    translate([150,min(1900,i+300),150])sphere(10);
    }    
    
hull(){
    translate([-150,i,150])sphere(10);
    translate([-150,min(1900,i+300),150])sphere(10);
    }     
    
hull(){
    translate([-150,i,-150])sphere(10);
    translate([-150,min(1900,i+300),-150])sphere(10);
    }   
    
    hull(){
    translate([150,i,-150])sphere(10);
    translate([150,min(1900,i+300),-150])sphere(10);
    }   
}}




module node(){
    sphere(150);
    cylinder(300,105,105,center=true);
rotate([90,0,0])    cylinder(300,105,105,center=true);
  rotate([0,90,0])   cylinder(300,105,105,center=true);
    
    }


module evaman(){
 color ("gray") translate([0,10,0])import("astrobod1.stl");
aarm();
mirror([1,0,0])aarm();
    }

module cap(n=1150){
    rotate([0,90,0])
    translate([0,0,n/2])
    hull(){
    
    cylinder(n-150,200,200,center= true);
    cylinder(n,100,100,center= true);
    }
    }





module aarm(){ color ("white"){
translate([13,0,140])sphere(15);
translate([18,-1,135])sphere(12);
translate([25,0,126])sphere(12);
translate([33,2,115])sphere(10);
translate([38,-1,106])sphere(10);
translate([40,-2,100])sphere(10);}}