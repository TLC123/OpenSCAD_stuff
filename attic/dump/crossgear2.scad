$fn=36;



//mirror([0,0,0])translate([-12,0,-5.5])bev();
//mirror([1,0,0])translate([-12,0,-5.5])bev();
//mirror([0,0,1])translate([-12,0,-5.5])bev();
//mirror([1,0,0])mirror([0,0,1])translate([-12,0,-5.5])bev();


                 translate([12,0,0])cylinder(22,.5,.5,center=true);
                 translate([-12,0,0])cylinder(22,.5,.5,center=true);
                translate([12,0,0])rotate([-90,0,0])diff(true,true,2);
 mirror([1,0,0])translate([12,0,0])rotate([-90,0,0])diff(true,true,2);


rotate(      [0,90,0]){
                 translate([0,0,5.5])rotate([-0,0,-90])rotate([-90,0,0])cylinder(22,.5,.5,center=true);
                
                  translate([0,0,-5.5])rotate([-0,0,-90])rotate([-90,0,0])cylinder(22,.5,.5,center=true);
                   translate([0,00])rotate([-0,0,-90])rotate([-90,0,0])cylinder(22,.5,.5,center=true);
                   
                   
                                      translate([3,00])rotate([-0,0,-90])rotate([-90,0,0])cylinder(4,1,1 );
                 mirror([1,0,0])  translate([3,00])rotate([-0,0,-90])rotate([-90,0,0])cylinder(4,1,1 );

 

 
                 translate([-4.5,0,5.5])rotate([-0,0,-90])diff(true,false);
 mirror([1,0,0]) translate([-4.5,0,-5.5])rotate([-0,0,-90])diff(true,false);
 
                  translate([-2,0,0])rotate([-0,0,90])diff(true,true,-1);
   
    
    mirror([0,1,0])               {
                  translate([2,0,0])rotate([-90,0,-0])bev( );
                  translate([2,0,0])rotate([90,0,-180])bev( );
color("blue")translate([2,2,0])rotate([-0,-90,-90]) cylinder(3,.5,.5,center=false);
                  }
                  
           
   translate([2,0,5.5]) mirror([0,1,0])               {
                  translate([2,0,0])rotate([-90,0,-0])bev( );
                  translate([2,0,0])rotate([90,0,-180])bev( );
color("blue")translate([2,2,0])rotate([-0,-90,-90]) cylinder(3,.5,.5,center=false);
                  }           
       rotate([0,180,0])   translate([2,0,5.5]) mirror([0,1,0])               {
                  translate([2,0,0])rotate([-90,0,-0])bev( );
                  translate([2,0,0])rotate([90,0,-180])bev( );
color("blue")translate([2,2,0])rotate([-0,-90,-90]) cylinder(3,.5,.5,center=false);
                  }              
 color("red")   translate([9.5,0,5.5])rotate([-0,0,-90])rotate([-90,0,0])cylinder(.2,3,3,center=true);
 mirror([1,0,0])    color("red")   translate([9.5,0,5.5])rotate([-0,0,-90])rotate([-90,0,0])cylinder(.2,3,3,center=true);
  
 color("red")   translate([9.5,0,-5.5])rotate([-0,0,-90])rotate([-90,0,0])cylinder(.2,3,3,center=true);
 mirror([1,0,0])    color("red")   translate([9.5,0,-5.5])rotate([-0,0,-90])rotate([-90,0,0])cylinder(.2,3,3,center=true);
              }
module diff(ifs,ifs2,v=1){
    
     if(ifs2)  translate ([3.5,-0,-0.0]) rotate([0,90,0])cylinder(8,1,1);
    rotate([00,0,90])   translate ([1.5,-0,-0.0]) rotate([0,90,0])cylinder(v,1,1);
    rotate([00,0,-90])   translate ([1.5,-0,-0.0]) rotate([0,90,0])cylinder(v+1,1,1);

    rotate([90,0,0])gear(2,1);
rotate([-90,0,0])gear(2,1);
rotate([0,180,0])gear(2,1);
rotate([0,0,0])gear(2,1);
    
    
if(ifs)translate([0,-1,0])ring();
    }
module bev( ){
    
 
    rotate([0,-90,0])gear(2,1);
 rotate([0,180,0])gear(2,1);
 
    
    
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