fastminski(chunk= 10){
model();
sphere(1,$fn=18);
}



module fastminski(chunk=2.5){
range=[-20:chunk:20+chunk];
for( z=range)
{
color(rands(0,1,3))
    
    intersection(){
        minkowski(convexity=10){
            intersection(){
                children(0); 
                translate([0,0,z])cube([20,20,chunk],center=true);
                }
             children(1);
        }

        translate([0,0,z])cube([20,20,chunk],center=true);
        }
}
}
module model(){
    translate([0,0,-10])cube(9,center=true);
    translate([0,0,10])sphere(6);
    cylinder(20,2,5,center =true);
    }
