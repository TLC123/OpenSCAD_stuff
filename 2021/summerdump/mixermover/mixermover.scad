color("gray",.15)rotate([-135+sin($t*360)*30,0,0])
rotate([0,0,$t*360*3])

render()union(){
    
    
    
 rotate_extrude(){
    intersection(){        
        square(100);        
union(){
                difference() {            
                hull (){
                    circle(15);
                    translate([0,20])circle(20);            
                    }                 
                   offset(-1) hull (){
                    circle(15);
                    translate([0,20])circle(20);            
                    }              
                 }
                           
}
}    
}
        

    
  
    
intersection(){
bell();  
union(){
for(r=[0:120:360])
{
rotate([-0,0,r])  translate([-8.5,0,22]) rotate([-15,0,0]) rotate([-0,0,-5]) rotate_extrude(angle=120,convexity=30){
 translate([10,0])  square([.5,25]);
}
}

translate([0,0,-30])rotate_extrude(convexity=30){
intersection(){
square(100);
translate([5,0])  square([.5,60]);
}
}

translate([0,0,40])mirror([0,0,1])cylinder(15,8,0);


}
}
    
    
    
    
    

 union(){  for(t=[-1.06125:.025:.95])   {
t2=t+.025;
hull(){
rotate([0,0,t*360*3])translate([0,4 ,0.5+t*30])rotate([0,20.5,0])cube([.11,1.51,.51],true);    
rotate([0,0,t2*360*3])translate([0,4 ,0.5+t2*30])rotate([0,20.5,0])cube([.11,1.51,.51],true);
}}


}  
   
 } 
    
module bell()
    
    {
    rotate_extrude(){
    intersection(){
        union(){
        square(100);
        mirror([0,1])square(100);
        }
         
       offset(-1)    union(){
       
        
         hull (){
            circle(15);
            translate([0,20])circle(20);
            
            }     
            
         hull (){
             translate([0,0])circle(15);
             translate([0,-50])circle(15);
            
            }   
        }
        
        
     
         
         
         
        
    }
    
    }
    
}

