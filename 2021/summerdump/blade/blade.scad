r=3;
$fn=25;
minkowski(){
    linear_extrude(1e-4)offset(r=-r)offset(r=-4)offset(r=2)blade_profile();
    
    hull(){
    mirror([0,0,1])cylinder(r*10,r,r);
        sphere(r);
     }
    }


module blade_profile(){
    //import your svg
    polygon([[0,0],[30,5],[70,-20],[130,-15],[200,10],[130,7],[100,40],[0,10]]);
    
    }