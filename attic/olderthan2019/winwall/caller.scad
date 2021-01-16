module select(tr,sc,ro){
    union(){
       scale(1.001) difference(){
    children(0);
     children(1);
        }
        
       translate(tr)scale(sc)rotate(ro)   intersection(){
    children(0);
    children(1);
        }
    }
    
    }
 

   rotate ([rands(0,360,1)[0],rands(0,360,1)[0],rands(0,360,1)[0]])select([0,0,0],[1,1,1],[0,0,rands(0,360,1)[0]]) {
       rotate ([rands(0,360,1)[0],rands(0,360,1)[0],rands(0,360,1)[0]])select([0,0,0],[1,1,1],[0,0,rands(0,360,1)[0]]) {
       rotate ([rands(0,360,1)[0],rands(0,360,1)[0],rands(0,360,1)[0]])select([0,0,0],[1,1,1],[0,0,rands(0,360,1)[0]]) {
       rotate ([rands(0,360,1)[0],rands(0,360,1)[0],rands(0,360,1)[0]])select([0,0,0],[1,1,1],[0,0,rands(0,360,1)[0]]) {
       rotate ([rands(0,360,1)[0],rands(0,360,1)[0],rands(0,360,1)[0]])select([0,0,0],[1,1,1],[0,0,rands(0,360,1)[0]]) {
       rotate ([rands(0,360,1)[0],rands(0,360,1)[0],rands(0,360,1)[0]])select([0,0,0],[1,1,1],[0,0,rands(0,360,1)[0]]) {
       rotate ([rands(0,360,1)[0],rands(0,360,1)[0],rands(0,360,1)[0]])select([0,0,0],[1,1,1],[0,0,rands(0,360,1)[0]]) {
       rotate ([rands(0,360,1)[0],rands(0,360,1)[0],rands(0,360,1)[0]])select([0.1,0,0],[1,1,1],[0,0,rands(0,360,1)[0]]) {
       sphere(d=5,center=true,$fn=30);    
              translate([0,0,-2.5]) cube([16,16,5],center=true);};    
              translate([0,0,-2.5]) cube([16,16,5],center=true);};    
              translate([0,0,-2.5]) cube([16,16,5],center=true);};    
              translate([0,0,-2.5]) cube([16,16,5],center=true);};    
              translate([0,0,-2.5]) cube([16,16,5],center=true);};    
              translate([0,0,-2.5]) cube([16,16,5],center=true);};    
              translate([0,0,-2.5]) cube([16,16,5],center=true);};    
              translate([0,0,-2.5]) cube([16,16,5],center=true);}

    
 
