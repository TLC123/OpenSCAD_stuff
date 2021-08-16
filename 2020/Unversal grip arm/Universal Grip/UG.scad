*translate([-60,-5,0])scale([0.02,0.02,0.001 ])import("universalgrip2.stl");
//sphere(10);

A=[
[-88,9,2],
[-83,13,3],
[-80,21,1],
[-78,21,.5],
[-65,30,1.2],
[-55,32,.4],

[-41,32,1.2],
[-27,29,.5],
[-25,29,1],
[-20,27,3],
];
linear_extrude(10)union(){
 polyline(A);
              polyline([[-21,12,.5],[-20,10,.5],]);
              polyline([[-18.5,11,.5],[-21,8,1.8],[-22.5,6,2],[-26,0,.5],]);
              polyline([ [-21,8,1.8],[-25,10,1.8], ]);
              polyline([ [-26,-10,.7],[-19,6.5,.7],[-12.8,19,.7], ]);

 body();
lowjaw(0);
 translate([2,-8,0])mirror([0,1])
ujaw(10);
}
    
    module outake(){
        
        translate([-40,-5,0])circle(13);
        translate([-64.5,-5,0])circle(8);
        translate([-82,0,0])circle(6);
      
      
      
        translate([-56,28,0])scale([1.0,0.9])circle(39);
        }
        
        
        
       module lowjaw(r)
        { 
            
            
            
            translate([-22,-16]) 
                 rotate(r)   translate(-[-22,-16]) 
            
          intersection  (){
            difference(){
        translate([-22,-16])    
                     union(){
        rotate(-9)         rotate(180)     translate([2,-7])  square([68,19]);
                  square([5,0.6],center=true);
                }
            
            outake();
        }
        
    translate([-57,-6,0])rotate(-16)  scale([1.05,0.45])circle(36);
        }
            
            }
            
            
               
       module ujaw(r)
        { 
            
            
            translate([-22,-16]) 
                 rotate(r)   translate(-[-22,-16]) {
            translate([-55,-20]) rotate(-10)scale([1.5,0.5]) circle(10);
          intersection  (){
            difference(){
        translate([-22,-16])    
                     union(){
        rotate(-9)         rotate(180)     translate([4,-7])  square([66,19]);
                 }
            
            outake();
        }
        
    translate([-57,-6,0])rotate(-16)  scale([1.05,0.45])circle(36);
        }}
            
            }
            
     module body(){
         difference(){
         translate([-12,6])square([22,46],center= true);
         
         polygon([[-24,14],[-24,-16], [-18.7,5],[-10,21],[-12,23],[-17.3,12.1],[-21,11],]);
         }
         }       
            

module polyline(a){
    
    for (i=[0:len(a)-2])
        
    hull() {
    translate([a[i].x,a[i].y]) circle (a[i].z  );
    translate([a[i+1 ].x ,a[i+1].y])circle(a[i+1].z );
    
    }
    }