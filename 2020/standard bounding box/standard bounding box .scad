
obj();
 # bbox() obj();
 module obj(){
      rotate([40,30,0]) translate([15,1,0])    sphere(4);

 rotate([40,30,0]) difference(){
     
     sphere(10);
 translate([0,8,0])   rotate([40,30,0])  sphere(7);
 rotate([40,30,0]) translate([5,1,0])    sphere(8);
 }
 }


module bbox(s=1.08)
 
{$fn=8;
    minkowski(){
    
minkowski(){
hull(){  scale([0.000001,s,0.000001]) children();}
hull(){    scale([s,0.000001,0.000001])  children();}
}
hull(){ scale([0.000001,0.000001,s] )     children();}
}
}