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
     
     rotate(-20.)    cube([B*0.25,B*0.5,B*1.3],center=true);
translate([0,0,EX*0.57])cylinder(B*1.1,B,B);
      mirror([0,0,1])
translate([0,0,EX*0.57])cylinder(B*1.1,B,B);
      
 linear_extrude(EX ,center=true,convexity=50)  lock2d();
 
       mirror([0,1])   
 
mirror([1,0])  linear_extrude(EX,center=true,convexity=50)      lock2d();
     
     
     
 linear_extrude(EX,center=true,convexity=50)  
 
 lh();

 
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
      
      
   tumbler();
      
        

      }
      
      module lh(){
         {
 //translate( [(M-T*1.0)/2*sin(-40), 0]) 
            rotate(-20.)  union() {
                
                square([lh*5,T*1],center=true); // live hinge
                translate([-lh*1.8,T*.5])  rotate(20.) square([lh*1.6,T*.75],center=true); // live hinge
                rotate(180)
                translate([-lh*1.8,T*.5])  rotate(20.) square([lh*1.6,T*.75],center=true); // live hinge
            
                
                }
          
                  translate([T*0.,-(M-T)/2+lh*0.25])    square([lh,T/2],center=true); // live hinge

     
  mirror([1,0])   
      mirror([0,1])translate([T*0.,-(M-T)/2+lh*0.25])    square([lh,T/2],center=true); // live hinge

          }

          }
      
  
  module tumbler(){
    
          O=T*0.06;
     offset(-O,$fn=30)offset(O*2,$fn=30)offset(-O,$fn=30)    
  translate([T*0.,-(M-T)/2+lh*0.25])   
      rotate(30.)  scale([1,0.5]) 
      
      polygon([
      [0,0],
      [T-.5,0],
      [T,1],
      [T*0.66,(M-T*.76)/2],
      [T*0.31,(M-T*.76 )/2]]);
    
      
      


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


//
//
//*union(){
//lock2d();
//mirror([0,1])lock2d();
//}
//
//module lock2d(){ 
//           tumbler= M/2-T*1.;
//
//    rot=50;
//    O=T*0.08;
//    translate ([-T*0.25,0])
//    offset(-O,$fn=10)offset(O*2,$fn=10)offset(-O,$fn=10)
//    {
//    square([T*2,T*0.65],center=true);
//
//    
//  translate([T*1.25,0]) square([T*0.75,T*2],center=true);
//        
//  translate([snappy*0.5,0])    
//  translate([-T*1.25,0]) square([T*0.65,T*2.8],center=true);
//     translate([snappy*0.5,0])     translate([0,-M*0.174])  
//   * translate([lh*0.26,M/4-T/8])   square([T,lh]);
//   intersection(){
//      difference(){
//      translate([T*4.25,0])circle(3*T,$fn=20);
//      translate([T*4.25,0])circle(2*T,$fn=20);}
//        translate([T*1.25,0]) square([T *3 ,T*3 ],center=true);
//
//    }
//    mirror([1,0])
//     intersection(){
//      difference(){
//      translate([T*4.25,0])circle(3*T,$fn=20);
//      translate([T*4.25,0])circle(2*T,$fn=20);}
//        translate([T*1.25,0]) square([T *3 ,T*3 ],center=true);
//
//    }
//    }
//     
//translate([snappy*0.5,0]) translate([T*0.25,M/4-T/8])  rotate(-rot)  
//    
//offset(-O,$fn=10)offset(O*2,$fn=10)offset(-O,$fn=10)  difference ()  {
//    
// 
// union(){
//      translate(-[-T*0.5  ,tumbler -lh]/2)  circle( lh*2);
//     translate([-T *0.5 ,tumbler-lh]/2)  circle( lh*2);
//    square([T ,tumbler],center=true);
//    square([T ,tumbler]*0.5,center=false);
//  rotate(180)  square([T ,tumbler]*0.5,center=false);
//    }
// 
//      
//      hull(){ translate([-T  ,tumbler-lh*4]/2) circle(lh*.35,$fn=12);
//  translate([-T+lh*3 ,tumbler-lh*4]/2) circle(lh*.5,$fn=12);
//      }
//     rotate(180)     hull(){ translate([-T  ,tumbler-lh*4]/2) circle(lh*.35,$fn=12);
//  translate([-T+lh*3 ,tumbler-lh*4]/2) circle(lh*.25,$fn=12);
//      }  
//      
//      
//      
//      translate([-T*1.2,0])circle(T,$fn= 23);
//      translate([T*1.2,0])circle(T,$fn= 23);
//      
//        }
//        
// 
//        
//        
//        
//tab(rot,tumbler);   
// 
// 
//    
//    }
//    module tab(rot,tumbler){
//        
//         {
//                hull(){
// translate([snappy*0.5,0]) translate([T*0.25,M/4-T/8])  rotate(-rot)    
//                    translate([-T+lh*1  ,tumbler-lh*1]/2) circle(lh*.5,$fn=12);
//
//    
//    
// translate([snappy,0])  translate([-T*.15,(M-T)/2-lh]) circle(lh*0.5 ,$fn=12);}
//    
//           hull(){
// 
//
//     translate([snappy,0])  translate([-T*.15,(M-T)/2 ]) circle(lh  ,$fn=12);   
//
//    
// translate([snappy,0])  translate([-T*.15,(M-T)/2-lh]) circle(lh*0.5 ,$fn=12);} }
// 
// 
// 
//        {
//                hull(){
// translate([snappy*0.5,0]) translate([T*0.25,M/4-T/8])  rotate(-rot+180)    
//                    translate([-T+lh *1 ,tumbler-lh*1]/2) circle(lh*.5,$fn=12);
//
//    
//   translate([T, T/2]) circle(lh*0.5);}
// }
// 
// 
// }

