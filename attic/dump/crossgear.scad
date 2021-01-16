$fn=36;
   translate ([6,-0,-0.0]) rotate([0,90,0])cylinder(12,1,1);

translate ([0,-0,-4.5]){
translate ([0,-10,-0.0])diff(true);
mirror([0,1,0])translate ([0,-10,-0])diff(true);
translate ([0,-5,-0])diff(true);
    rotate([-90,0,0])cylinder(38,1,1,center=true);
        translate ([0,.5,-0]){ 
           translate ([5,-7.5,-0]) color("green") cube([2,1.5,4],center=true);  
           translate ([5,7.5,-0]) color("green") cube([2,1.5,4],center=true);  
      translate ([0,-7.5,-0]) color("red")rotate([-90,0,0])cylinder(.2,5,5,center=true);
   translate ([0,7.5,-0]) color("red")rotate([-90,0,0])cylinder(.2,5,5,center=true);
        }

}


translate ([3,-0,-0.0])
{
translate ([0,2,-0.0])
diff(true);
    translate ([0,-2,-0.0]){
diff();
   color ("blue" )cube([6,1,6],center= true);}
    rotate([-90,0,0])cylinder(12,1,1,center=true);

}

 translate ([0,-0,4.5]){
 translate ([0,-10,0])ring( );
mirror([0,1,0])translate ([0,-10,0]) ring( );
     mirror([0,1,0])translate ([0,-5,0])diff(true);

rotate([-90,0,0])cylinder(18,1,1,center=true);
        translate ([0,-.5,-0]){ 
                  translate ([5,-7.5,-0]) color("green") cube([2,1.5,4],center=true);  
           translate ([5,7.5,-0]) color("green") cube([2,1.5,4],center=true);  
      translate ([0,-7.5,-0]) color("red")rotate([-90,0,0])cylinder(.2,5,5,center=true);
   translate ([0,7.5,-0]) color("red")rotate([-90,0,0])cylinder(.2,5,5,center=true);
        }
 }
module diff(ifs){
    rotate([90,0,0])gear(2,1);
rotate([-90,0,0])gear(2,1);
rotate([0,180,0])gear(2,1);
rotate([0,0,0])gear(2,1);
    
    
if(ifs)ring();
    }


module ring(){rotate([-90,0,0])   rotate_extrude()
    hull(){
    translate([3.5,0])     square([0.01,1] );
    translate([3.5,0])     square([1,0.01] );
    translate([3.5,-1])     square([1,1] );
    }}
module gear(r,h){
    translate([0,0,-r-h*0.1])
    hull(){
  linear_extrude(h*0.1)  circle (r);
    
   linear_extrude(h*0.9)    circle (r-h*0.8);
    }
    }