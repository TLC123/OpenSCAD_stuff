module grow(i)
{ 
    if(i>=1){
    rotate([1,10,0]) {
    sphere(d=i,$fn=20);
    cylinder(d=i,d2=i-1,h=i,$fn=20);
    translate([0,0,i])grow(i-1);
    }}
    }
    
    grow(10);