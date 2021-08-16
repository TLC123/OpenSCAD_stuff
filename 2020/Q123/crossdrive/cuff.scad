   $fn=36;  
//  
// difference(){  
//  union(){
// gear3();
//    
//   translate([0,0,2.5+3])       import("22.stl",convexity=100);
// 
//     translate([0,0,-2.5])cylinder(8.1,7.4,7.4);
//
// 
// }
//   
//
//
//  translate([0,0,-10])cylinder(46,1.6,1.6);
//}
//
////union(){
////translate([40,0,0])cage();
////translate([40,0,0]) rotate([180,0,90])cage();
////}
////   minidiff();
union(){
rotate([00,0,0])cuff();
 }

////rotate([90,0,0])cage();
//
// translate([0,0,00])rotate([0,0,0])gear1();

module cage()
{$fn=36;
    
    
    intersection(){union(){
rotate([0,0,90])translate([0,-8.5,0])rotate([90,0,0])  cagebar();
rotate([0,0,-90])translate([0,-8.5,0])rotate([90,0,0])  cagebar();
    }
        o=.5;
    linear_extrude(6,center=true)     offset(o)offset(-o) square(21,center=true);
    }
        
        
        
    }
    module cagebar(){
        
        
            o=.5;
  linear_extrude(2,convexity=100) offset(o)offset(-o) difference(){
    square([35,5],center=true);
    circle(1.5);
  translate([0,2,0])  circle(1.8);
        
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
     
union(){    $fn=36;
    difference(){
        
 union(){
      translate([0,0,-1.5])cylinder(3,4.4,4.4  );
      translate([0,0,-1.5+3])cylinder(2.9,4.4,2.4  );
 
     rotate([0,90,0])cylinder(24,1.5,1.5,center=true);
     rotate([0,90,90])cylinder(24,1.5,1.5,center=true);
     }
        
         cylinder(12,1.6,1.6,center=true);
        }
    
            translate([6.2,6.2,0])   difference(){
        

      translate([0,0,-1.5])cylinder(2.9,4.4,2.4  );
 
     cylinder(12,1.6,1.6,center=true);
     }
        
       translate([6.2,6.2,-3]*.5)  cylinder(.15,.5,.5);
   
    
    }
         }
    
    
    module gear1(){
        $convexity=100;
      difference()
    {   linear_extrude(5,center=true,convexity=100 )   projection() scale(1.25)import("1.stl");
                    o=.5;
     
     linear_extrude(26,center=true,convexity=100)     offset(o)offset(-o) square(17,center=true);
        gearinset();
     rotate([0,0,090]) gearinset();
     
   
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