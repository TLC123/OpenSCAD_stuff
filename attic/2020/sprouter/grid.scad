part=2;
 sq=[128,80];
rotate([0,0,0]){
  union (){
     *  translate([0,0,-0.9]) cube([sq.x,sq.y,6]);

   union(){
 
      
    if (part==0)   union(){color("blue")rotate([-90,0,0])linear_extrude(sq.y,convexity=10)longrow();
color("blue")rotate([0,90,0])linear_extrude(sq.x,convexity=10)shortrow();
translate(sq*.5) 
linear_extrude(2,convexity=10)difference() {square(sq,center=true);
offset (-2.3)square(sq,center=true);
}
   union(){
           rotate([0,0,0])    translate([0,15,0])   jack();
       translate([sq.x,0] )   rotate([0,0,90]) translate([0,15,0])     jack();
           translate([sq.x,sq.y] )    rotate([0,0,180])  translate([0,15,0])    jack();
       translate([0,sq.y] )      rotate([0,0,270])   translate([0,15,0]    ) jack();
            
   } }
   
 
if(part==2)color ("red") translate([0,0, 2])
    linear_extrude(2,convexity=10)translate(sq*.5)rotate([0,0,0])
    offset (-2.3)square(sq,center=true);
 

 
}
}}

module jack(){
      hull()
            {
 translate([1.5,0,4.3]               )rotate([0,0,3]) cube([3,4,1]);  
color ("red") translate([0,0,3.2])cube([2,6,1]);  }
 translate([0,0,2])cube([2,6,2]);  
        }
     
        
        module longrow(){
            
            for(x=[0:sq.x/3]){
                
            translate([1+x*3,0,0])tand();
            
            }
            
            }
        
             module shortrow(){
            
            for(y=[0:sq.y/3]){
                
            translate([0,1+y*3,0])rotate(90)tand();
            
            }
            
            }
        
       module tand (){
           hull(){
          square([2,0000.1],center=true);
           translate([0,-0.9]) square([.3,0000.1],center=true);
           }
           
           }