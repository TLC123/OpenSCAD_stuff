//masha();

part=8;

if (part==1) translate(-[19,8,17])
intersection (){
     masha();
    hull(){
    translate([19,8,17]) sphere(3,$fn=16);
    translate([18,13,13]) sphere(5);
 translate([21,0,0])    sphere(5);
    
}}
    

if (part==2)  
    translate(-[13.01,5.5,60])
intersection (convexity=30){
     masha();
    hull(){
    translate([13,5.5,60.01]) sphere(4.5);
    translate([13,5.5,55]) sphere(6.5);
    translate([16.01,12,45]) sphere(7.01);
      translate([19,8.01,23]) sphere(5.01);
    translate([19,8.01,17]) sphere(4.01);

   } 
}
   
if (part==2.5)  
  
intersection (convexity=30){
     masha();
    hull(){
translate([0,-40,0])cube([80,80,80]);
 
   } 
}
   
 if (part==3)  translate(-[9.9,2.7,102]) 
intersection (){
     masha();
     hull(){
    
    translate([13,5.5,60]) sphere(5.5);
    translate([13,5.5,65]) sphere(6.5);
   
         translate([9.5,2.8,80]) sphere(9.6);
         
         
     translate([9.9,2.7,102]) sphere(6.8);  
     translate([9.9,2.7,97]) sphere(7.8);  

   } 


}


 if (part==4) translate(-[0,1,100]) 
 intersection (){
      masha();
   # union(){
        hull(){
    
     translate([0,1,100]) sphere(6.2);  
     translate([8,10,101.7]) sphere(6.9);  
     translate([-8,10,101.7]) sphere(6.9);  
 translate([9.9,2.7,102]) sphere(7.8);  
     translate([-9.9,2.7,102]) sphere(7.8); 
     
       translate([8,-3,112]) sphere(5);  
       translate([-8,-3,112]) sphere(5);  

    translate([0,-1.5,113])scale([1.2,1,1]) sphere(9.5);  

   } 
   hull(){
          translate([8,-3,112]) sphere(5);  
       translate([-8,-3,112]) sphere(5);  

  translate([0,-3.8,123]) scale([1,0.8,1])sphere(9);  
     translate([0,-1.5,113])scale([1.2,1,1]) sphere(9.5);  
       }}
 }
 


 if (part==5)     translate(-[0,-2,125])  
 intersection (){
      masha();
     union(){
 hull(){
    
  
     translate([0,-2.8,125]) scale([1,0.9,1])sphere(9.1);  
     translate([4,-4,138]) sphere(11);  
     translate([-4,-4,138]) sphere(11); 

     translate([0,2,145]) sphere(10);  
     translate([10,2.5,147]) sphere(5.5);  
     translate([7.,4.5,145]) sphere(8.5);      
     translate([-10,2.5,147]) sphere(5.5);  
     translate([-7.,4.5,145]) sphere(8.5);  

   } hull(){
       translate([0,1,154]) sphere(4,$fn=16);  
        translate([0,2,145]) sphere(9);  

       }
}
 }
 
if (part==6)    translate(-[10,2.5,147])  
 intersection (){
      masha();
 hull(){
    
  
 
     translate([13,4.5,149]) sphere(5);  
     translate([15,5.5,146.5]) sphere(5);  
     translate([16,2.5,149]) sphere(5);  
     translate([36.5,1.5,129 ]) sphere(4 );  
      
 
 
   } 
 }
 
 
 
 if (part==7)    translate(-[36.5,1.5,129 ])  
 intersection (){
      masha();
 hull(){
   a=[36.5,1.5,129 ];
   b=[54,-5,117 ];
 
   translate(a) sphere(2.3,$fn=16 ); 
     
     translate(a*.9+b*.1) sphere(4 );  
     translate(a*.2+b*.8) sphere(3.2 );  
      
   translate(b) sphere(1.8 ,$fn=16);  
 
   } 
 }
if (part==8)    translate(-[54,-5,116 ])  
 intersection (){
      masha();
  hull(){
    
  
 
 
      translate([54,-5,116 ]) rotate([0,-30,-30])scale([.8,1.5,.6])sphere(1.6,$fn=16 );  
     translate([65,-8,105 ]) translate([-1,-2,1])rotate([25,45,0])scale([1,1,0.4]) sphere(12 );  
      
 
 
   } 
 }


   if (part==9)   translate(-[0,1,154])  
 intersection (){
      masha();
 hull(){
    
  
 

 
   translate([0,1,154]) sphere(4,$fn=16);  
   translate([0,0.5,158]) sphere(5.4,$fn=16);  
   translate([0,0,162]) sphere(4,$fn=16); 
       
 
 
   } 
 }



 if (part==10)     translate(-[0,0,162])  
 intersection (){
      masha();
     union(){
 hull(){
    
  
 

 
     translate([0,2,172]) sphere(9);  
    translate([0,-4,172]) sphere(11);  
    translate([1,-11,161]) sphere(2);  
    translate([-1,-11,161]) sphere(2);  
 
 
   }
hull(){  
   translate([0,0,162]) sphere(4,$fn=16); 
   translate([0,-2,170])scale([2,1.5,1]) sphere(5); 
   
   
}
   }
 }

 
    module masha(){
       import("masha.stl");
 }