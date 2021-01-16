difference(){
    union(){
        hull(){
        cube([30,50,110+40]);
      translate([-50,0,0])  cube([70,50,20]);
        }
        
        
translate([0,15,0])cube([50,20,110+60]);
        
        
    }
    hull(){
translate([-30,-1,40])rotate([-90,0,0])cylinder(55,4.85,4.85);  
translate([-55,-1,180])  cube([50,50,20]);
    }
    translate([-30,-1,40])rotate([-90,0,0])cylinder(55,5.26,5.26);  

 translate([-75,-2,45])  cube([50,55,20]);

translate([5,0,180])rotate([-90,0,0])cylinder(50,31,31);
    
    
}

hull(){
    linear_extrude(10)    offset(20) translate([-50,0])  square([100,50]);
 linear_extrude(20)    offset(10) translate([-50,0])  square([100,50]);
}