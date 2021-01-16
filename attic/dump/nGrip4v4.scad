$fn=40;

B=10;// ball radius
L=130; //ball CC
M=max(L/4,B*2);// handle width
T=M*.2;// Shank width
lh=0.6;// living hinge does not scale
snappy=-0;

EX=B*2*.50;
//EX=B*2*.52;
//#square([L,M],center=true);
//#translate([L/2,0,0])sphere (B);
//#translate([-L/2,0,0])sphere (B);

intersection (){
union(){ 
   k=21;
    for(j=[ 95])
    for(i=[0:30:360]){
   translate  ([L*0.5 ,0.5])rotate(j)rotate([i,0,0])rotate([0,k,0]) translate([-B,0])rotate([90,0,0]) sphere(lh*1.5,$fn=7); 
    
   translate  ([L*0.5 ,-0.5])rotate(-j)rotate([i,0,0])rotate([0,k,0]) translate([-B,0])rotate(90)  sphere(lh*1.5,$fn=7);
   translate  ([-L*0.5 ,-0.5])rotate(j)rotate([i,0,0])rotate([0,k,0]) translate([ B,0])rotate(90)  sphere(lh*1.5,$fn=7);
   translate  ([-L*0.5 ,0.5])rotate(-j)rotate([i,0,0])rotate([0,k,0]) translate([B,0])rotate(90)  sphere(lh*1.5,$fn=7);
    }
    
    difference(){ 
        
        union()  {
                difference(){ 
                arm3d(); 
             O=T*0.06;
                linear_extrude(EX*2,center=true,convexity=50)   
                offset(-O,$fn=10)offset(O*2,$fn=10)offset(-O,$fn=30) 
                innard2d(); 
                    
                
                    
                  // translate([L/2,0,-B*0.42])scale([1.1,1])cylinder(B*2,0,B*2); 
                } 
        translate([L/2,0,0])jaws();
        mirror([1,0,0])  translate([L/2,0,0])jaws();

}
 
 
 }  






 linear_extrude(EX,center=true,convexity=50) union(){ 
translate([L/2-B*1.13,0,0]) square([lh,T/2],center=true); // live hinge
translate([-(L/2-B*1.13),0,0]) square([lh,T/2],center=true); // live hinge

translate([L/2-B*1.27,0,0]) square([lh,T/2],center=true); // live hinge
translate([-(L/2-B*1.27),0,0]) square([lh,T/2],center=true); // live hinge
 

  }  

 //lock
// translate([0,0,-3.75])
//  rotate([0,90,0]) 

  {
     
//     rotate(-20.)    cube([B*0.25,B*0.5,B*1.3],center=true);
//translate([0,0,EX*0.57])cylinder(B*1.1,B,B);
//      mirror([0,0,1])
//translate([0,0,EX*0.57])cylinder(B*1.1,B,B);
    
   lock2d();
 
    
//       mirror([0,1])   
// 
//mirror([1,0])  linear_extrude(EX,center=true,convexity=50)      lock2d();
     
     
     
 linear_extrude(EX,center=true,convexity=50)  {
 
 lh();
 rotate(180)lh();
 }
 
  }

  }
  
  // intersection 
arm3d();  
  
  
  {
  O=T*0.36;
 rotate([90,0,0]) linear_extrude(M,center=true,convexity=50)
      offset( O,$fn=1)offset(-O ,$fn=1)square([L+B*1.34,EX],center=true);
  }
       

  
  }
  
  

  
  module arm3d(){
       O=T*0.06;
       ch=T*0.1;
         hull(){
         linear_extrude(EX-   ch*2,center=true,convexity=50)        
      offset(-O,$fn=20)offset(O*2,$fn=20)offset(-O,$fn=20) arm2d();
      
      linear_extrude(EX,center=true,convexity=50) offset(-ch,$fn=30)       
      offset(-O,$fn=20)offset(O*2,$fn=20)offset(-O,$fn=20) arm2d();
  }
      }
  
  module lock2d(){
      
      rotate(60)    union(){
          
          
   tumbler();
 
      }
        

      }
      
      module lh(){
 
          a=[[-T*0.5,lh*6,lh*2],[T*-0.3,lh*9,lh*1. ],
          [T*0.2,lh*14,lh*1. ],
          
          [T*1.2,(M-T*1.4)/2,lh*1.2],[T,M/2,lh*2],];
 polyline(a) ;

          }
        module tumbler(){
        
            hull(){
            ch=0.4;
            linear_extrude(EX-ch  ,center=true,convexity=50)  tumbler2();
            linear_extrude(EX  ,center=true,convexity=50) offset(-ch)  tumbler2();
            }
            }
  module tumbler2(){
    
          O=T*0.15;
    offset(-O,$fn=30)offset(O*2,$fn=30)offset(-O,$fn=30)    
      rotate(0.)   
     
      
      polygon([[3,0],[1,27/2],[-1,27/2],[-3,0],,[-1,-27/2],[1,-27/2],])
   ;
    
      


    } 
module innard2d(){
    difference(){
    union(){
    hull(){   
     scale([3.15,1])   circle((M-T)/2);
circle(B/2 ) ;
 translate([-(L/2-B*1.65) ,0,0])circle(B/4 ) ;
 translate([(L/2-B*1.65) ,0,0])circle(B/4 ) ;
}


 translate([L/2,0,0])gripcircle (B); // sphere pocket
 translate([-L/2,0,0])gripcircle (B);

 translate([L/2+B,0,0])gripcircle (B); // sphere pocket
 translate([-L/2-B,0,0])gripcircle (B);
square([L,T/3],center=true);
 }
 
 
 translate([0,-B*0.05,0]) translate([L/2,0,0])rotate([0,0,-5])  rotate([0,0,-30])  translate([0,B,0]) rotate([0,0, 20]) circle(lh*2,$fn=6);
 mirror([0,1,0])translate([0,-B*0.05,0]) translate([L/2,0,0])rotate([0,0,-5])  rotate([0,0,-30])  translate([0,B,0])  rotate([0,0, 20]) circle(lh*2,$fn=6);
 
 mirror([1,0,0]) translate([0,-B*0.05,0]) translate([L/2,0,0])rotate([0,0,-5])  rotate([0,0,-30])  translate([0,B,0])  rotate([0,0, 20]) circle(lh*2,$fn=6);
  mirror([0,1,0]) mirror([1,0,0])translate([0,-B*0.05,0]) translate([L/2,0,0])rotate([0,0,-5])  rotate([0,0,-30])  translate([0,B,0])  rotate([0,0, 20]) circle(lh*2,$fn=6);
 
 
 
}
}
module gripcircle(r)      {
    intersection(){
  translate([r*2,0])  rotate(3)translate([-r*2,0])circle(r);
  translate([r*2,0])  rotate(-3)translate([-r*2,0])circle(r);
    }
    }
module arm2d(){
hull(){   
    scale([2,.5])circle(M);
    
 translate([L/2,0,0])square([B*0.9,B*1.75+T*0.75],center=true) ;
 translate([-L/2,0,0])square([B*.9,B*1.75+T*0.75],center=true) ;
    
 translate([L/2,0,0])square([B*1.4,B*1.4+T*0.5],center=true) ;
 translate([-L/2,0,0])square([B*1.4,B*1.4+T*0.5],center=true) ;
//translate([0,-B*0.05,0]) translate([L/2,0,0])rotate([0,0,-5])  rotate([0,0,-30])  translate([0,B,0])   circle(lh*2);
    
    
}

}
module jaws(){
    
    
     jaw();
     mirror( [0,1,0])jaw();
    }

module jaw(){
    translate([0,-B*0.05,0]) rotate([0,0,-5]){
    
    
  rotate([0,000,0])  dent();
  
hull(){  
    rotate([0,120,0])  dent(); 
  translate([0,0,-T])rotate([0,120,0])  dent();
}
        
hull(){  
    rotate([0,-120,0])  dent(); 
  translate([0,0,T])rotate([0,-120,0])  dent();
}    }
     
    }
module dent(){
      rotate([0,0,-30])
  translate([0,B,0]) 
   hull(){ rotate([0,0, -15])cylinder(T*1.6,lh*1,lh*1.3,center=true,$fn=12);
   translate([-lh*3,lh*1.5,0])cube([lh*5,lh*2,T*2],center=true);
       }
       }

module bone(){}










///////////////////////////////


module polyline(a){
    
    for (i=[0:len(a)-2])
        
    hull() {
    translate([a[i].x,a[i].y]) circle (a[i].z  );
    translate([a[i+1 ].x ,a[i+1].y])circle(a[i+1].z );
    
    }
    }