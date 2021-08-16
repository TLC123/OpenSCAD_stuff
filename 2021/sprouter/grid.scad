$fn=40;
part=2;
rimh=4;
lidh=-.5;
lidth=1.5;
 sq=[155,300/4];
 
 lid_inset=[3,4];
 
 stepover=3.5;
if(part==1)difference(){
 union(){//dark lid
 translate([0,0,lidth]) mirror([0,0,1])   linear_extrude(lidth)offset(2) offset(-2)square([sq.x-32,sq.y-5]-lid_inset ,true); 
 
      translate([0,0,lidth])rotate_extrude($fn=64) 
    offset(.15)
     offset(-.5) offset(.35)
     polygon([[0,0],
     [sq.y*.43 ,-1],
     [sq.y*.43-1,1],
     [sq.y*.43 ,6],[sq.y*.43-1,6.4],[sq.y*.43-5,2],[0,4]]);
   }
 translate([0,0.0,lidh])mirror([0,0,1])color("blue")rotate([0,90,0])linear_extrude(sq.x,convexity=10,center=true)shortrow(); 
 translate([0,0,0])mirror([0,0,1]) linear_extrude(10)offset(1) offset(-1)square([sq.x,sq.y]-[32,5]  ,true); 
} 







if (part==2)difference(){
    union(){
 translate([0,sq.y*.5-2.3*.5 ])linear_extrude(12,scale=.8)square([sq.x*.33,2.2],true );
//  translate(-[sq.x*.5-5,0])linear_extrude(18)square([3,sq.y*.33],true );
  
  scale([1,1,1.5]){
      
   intersection(){
        
linear_extrude(20,convexity=10,center=true)    shape();
 

union(){      
 color("blue")rotate([-90,0,0])linear_extrude(sq.y,convexity=10,center=true)longrow();
           
color("blue")rotate([0,90,0])linear_extrude(sq.x-0.001,convexity=20,center=true)shortrow(); 
}   
   }
   }
   

        
        
 
translate ([0,0,rimh ])mirror([0,0,1])linear_extrude(10,convexity=10 )

difference() {
    shape();
inshape();
}
 
   

 
 
 }
translate ([0,0,-.5])mirror([0,0,1]) linear_extrude(15)offset(1)  square(sq ,true); 

   
   }
module inshape(){
    intersection(){
    square([sq.x-32,sq.y] ,true);    
    offset (-2.3) shape();
    }
        }
 
module shape(){
        offset(20)offset(-20)square(sq,center=true);
    }
        
        module longrow(){
            
               for(x=[stepover*.5:stepover:sq.x]){
                
            translate([x,0,0])tand();
            translate([-x,0,0])tand();
            
            }
            
            }
        
             module shortrow(){
            
              for(y=[0:stepover:sq.y]){
                
            translate([0,
                  y,0])rotate(90)tand();
             translate([0,
                  -y,0])rotate(90)tand();
            
            }
            
            }
        
      module tand (){
      
           hull(){
//           offset(.1,$fn=16)
//               offset(-.1)
               {
                  translate([0,-0.2]) square([2,0.4],center=true);
               }
           translate([0,-0.9]) square([.3,0000.1],center=true);
           translate([0,0.6]) square([.3,0000.1],center=true);
           }
           
           }