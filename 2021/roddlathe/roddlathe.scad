rotate(-90+360*$t){
    offset(40)offset(-20)union(){
            intersection(){
            circle(100);
            translate([90,0])square(200,true);}
            circle(80);
        }
        
       difference(){
        
        offset(140)offset(-20)union(){
            intersection(){
            circle(100);
            translate([110,0])square(200,true);}
            circle(80);
        }
        
        
        
        
        offset(120)offset(-20)union(){
            intersection(){
            circle(100);
            translate([110,0])square(200,true);}
            circle(80);
        }
    }}
    
translate([150,0,0]) rotate(abs($t*100-50)*10)   circle(30,$fn=12);
    
    translate([150,30,0])rotate(-45)square([10,300-abs(-($t*100-50))*4]);