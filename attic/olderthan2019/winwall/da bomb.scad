for(r=[40:-10:0]){
    start=10;
for (i=[rands(0,10,1)[0]:160/r*PI:360]){
    
     select                  ([0,r,0],[1,1,1],[-90+(60-r*2),-0,i]) 
    
    color("red",0.5)rotate([0,0,i])translate([0,r-5,15]) cube([10,10,30],center=true);
   // sphere(d=80);
    }}
    
    module select(tr,sc,ro){
    union(){
       scale(1.001) difference(){
    children(1);
     children(0);
        }
        
       translate(tr)scale(sc)rotate(ro)   intersection(){
    children(1);
    children(0);
        }
    }
    
    }