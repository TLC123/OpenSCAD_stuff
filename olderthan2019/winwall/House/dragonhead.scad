union(){cube([2,5,10],center=true) ;
translate([0,0,5])rotate([20,0,0]){
cube([2,7,7],center=true) ;
    translate([0,0,5])rotate([20,0,0]){
        cube([2,7,7],center=true) ;
            translate([0,0,5])rotate([20,0,0]){
            
            cube([2,6,8],center=true) ;
                translate([0,-5])rotate([20,0,0]){
                cube([2,4,8],center=true) ;
                    translate([0,-1,5])rotate([ 20,0,0]){
                    cube([2,4,6],center=true) ;
                        translate([0,0,2])rotate([ 20,0,0]){
                        cube([2,4,6],center=true) ;
                        translate([0,0,2])rotate([ 20,0,0])cube([2,4,5],center=true) ;}
    
    }}
            cube([2,4,7],center=true) ;
                translate([0,0,5])rotate([20,0,0]){
                cube([2,5,5],center=true) ;
                    translate([0,1,5])rotate([-20,0,0]){
                    cube([2,5,6],center=true) ;
                        translate([0,1,2])rotate([-20,0,0]){
                        cube([2,4,6],center=true) ;
                        translate([0,0,2])rotate([-20,0,0])cube([2,3,6],center=true) ;}
    
    }}}}
}
}