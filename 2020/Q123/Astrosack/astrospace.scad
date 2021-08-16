//Is the legs on a EVA suit really wort it?

ta=$t*3000;
vp=[0,2000-4000*$t,250];
$vpt=vp+[0,0,50] ;
$vpr=[50+sin(-100+ta)*20,0,0-ta*.25+150];
$vpd=(1500); 
translate (vp) 
 rotate([
 0 ,
-30 +sin($t*360*5)*5 +sin(40+$t*360*9)*4 +sin($t*360*5)*3   ,
0
])
 
translate([350,00,0]) 
 
rotate([
20+sin($t*360*5)*5 +sin(40+$t*360*13)*4 +sin($t*360*3)*3 ,
10 +(sin($t*360*5)*5 +sin(40+$t*360*9)*4 +sin($t*360*5)*3  )*4 ,
-45+$t*-90
+sin($t*360*5)*5 +sin(40+$t*360*15)*1 +sin($t*360*7)*2 
])translate([0,0,-30]) evaman();


station();
sky=[for(i=[0:1000])rands(-360,360,3,i)];
sky();

module sky(){
    for(i=[0:1000])
   color("white") rotate(sky[i])   translate([5000,0,0]) cube(5.5);
    
    }

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
     
     $fn=8;
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
     $fn=12;
    sphere(150);
    cylinder(300,105,105,center=true);
rotate([90,0,0])    cylinder(300,105,105,center=true);
  rotate([0,90,0])   cylinder(300,105,105,center=true);
    
    }


module evaman(){
 color ("gray") translate([0,10,0])import("astrobod1.stl");
aarm();
mirror([1,0,0])aarm();
    
roboarm(); 

mirror([1,0,0]) roboarm();
    
    }
    module roboarm(){
        color([0.7,0.6,0.5])
        
  translate([20,-50,85]) 
      translate(-[3,-44,0])  rotate([30+sin($t*360*2)*20,0,20+sin(150+$t*360*2)*20]) translate([3,-44,0])
        
        { 
           translate([0,-20,25]) rotate([30+sin($t*-360*2)*20,0,0])rotate([0,90,0])
            
            linear_extrude(10,center=true){
                
                polygon ([[-2,0],[0,2],[2,0],[5,-15],[2,-30],[1,-30],[2,-20],[0,-10],[-2,-20],[-1,-30],[-2,-30],[-5,-15],]);
                
                
                } 
            
            hull(){ 
        translate([0,42,0]) rotate([0,90,0])cylinder(5,5,5,center=true);  
       translate([0,-00,-10]) rotate([0,90,0]) cylinder(5,5,5,center=true);
        }
        
              hull(){ 
        translate([0,-20,25]) rotate([0,90,0])cylinder(4,4,4,center=true);  
       translate([0,-0,-10]) rotate([0,90,0]) cylinder(4,4,4,center=true);
               translate([0,-20,25]) rotate([0,90,0])cylinder(4,4,4,center=true);  
                  
 }}
        
        
        
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