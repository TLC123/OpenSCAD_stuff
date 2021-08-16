   $fn=36;  
   

union(){
translate([0,0,0])cage();
translate([0,0,0]) rotate([0,0,90])cage();
}
//   minidiff();
//rotate([90,0,0])cuff();
//rotate([90,0,0])cage();

//translate([0,0,00])rotate([90,0,0])gear1();

module cage()
{$fn=36;
    
    
    intersection(){union(){
rotate([0,0,90])translate([0,-8.5,0])rotate([90,0,0])  cagebar();
rotate([0,0,-90])translate([0,-8.5,0])rotate([90,0,0])  cagebar();
    }
        o=5;
    linear_extrude(15,center=true)     offset(o)offset(-o) square(36,center=true);
    }
        
        
        
    }
    module cagebar(){
        
        
            o=.5;
  linear_extrude(10,convexity=100) offset(o)offset(-o) difference(){
    square([35,18],center=true);
    circle(1.5);
      hull(){
  translate([0,2,0])  circle(1.8);
  translate([0,16.5,0])  circle(1.8);
      }
        }}
 module minidiff(){
o=4.7;
rotate([-90,  0,0])translate([0,0,-o])gear2();
rotate([90,  0,0])translate([0,0,-o])gear2();
rotate([0, 90,0])translate([0,0,-o])gear2();
rotate([0,-90,0])translate([0,0,-o])gear2();
}

module gear2(){
    
    translate([0,0,-1.60])
    union(){
            $fn=36;
    difference(){
        
 
        mirror([0,0,1])cylinder(3.25,4.5,4.5,center=true );
 
 
        
         cylinder(8,1.6,1.6,center=true);
        }
   import("22.stl");}
 
}
module cuff(){
     
    $fn=36;
    difference(){
        
 union(){
        mirror([0,0,1])cylinder(3,4.5,4.5,center=true );
 
     rotate([0,90,0])cylinder(24,1.5,1.5,center=true);
     }
        
         cylinder(8,1.6,1.6,center=true);
        }
    
    
    }
    
    
    
    module gear1(){
        $convexity=100;
      difference()
    {   linear_extrude(5,center=true,convexity=100 )   projection() scale(1.25)import("1.stl");
                    o=.5;
     
     linear_extrude(26,center=true,convexity=100)     offset(o)offset(-o) square(17,center=true);
        gearinset();
    }
    
    }
        module gear3(){
        $convexity=100;
      linear_extrude(5,center=true,convexity=100 )  difference()
    {    projection() scale(1.25)import("1.stl");
    circle(1.7);
    }
    
    }
    
module    gearinset(){

   $fn=36;
            o=-.5;
  rotate([90,0,90])linear_extrude(25,center=true,convexity=100) offset(o, $fn=16)offset(-o, $fn=36) union(){
     circle(1.5);
  translate([0,2,0])  circle(1.8);
        
        }}