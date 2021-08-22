 $fn=8;

v=[[3,0],[31,0],[31,9],[26.5,9]];

 


v3=[[17.5,-20],[12,-20],[12,-13],[0,-13 ]];
 


v2=[[17.5,0],[17.5,-20],[16.5,-35],[19,-57],[14,-53],[17.5,-49 ],[28,-4],[22,-6],[21.5,0]];


minkowski(){
    
    hull(){
 translate([0,0,0])  scale([1,1,0.0001])  sphere(1.5);
    translate([0,0,14-1.5])  sphere(1.75);
    translate([0,0,28-1.5])  sphere(1.25);
    }

linear_extrude(0.0001)mirrorcopy(){
 polyline(v);
 polyline(v2);
 polyline(v3);
}}
 module polyline(p) {for(i=[0:max(0,len(p)-2)])line(p[i],p[ (i+1   )]);
} // polyline plotter
module line(p1, p2 ,width=0.00001) 
{ // single line plotter
    hull() {
       $fn=4;
        translate(p1) circle(width);
        translate(p2) circle(width);
    }
}

module
mirrorcopy()
{
    children();
    mirror([1,0,0])children();
    
    }
