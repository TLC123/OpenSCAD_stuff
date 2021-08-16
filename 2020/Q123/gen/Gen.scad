function getm()=
[

[ rands(.5,.75,1)[0],rands(-.25,.25,1)[0],0.1*round(rands(-10,.19,1)[0]),rands(-.25,.25,1)[0]],
[ 0.0*round(rands(-10,.19,1)[0]),rands(.5,.75,1)[0],rands(-.25,.25,1)[0],rands(-.25,.25,1)[0]],
[ rands(-.25,.25,1)[0],0.0*round(rands(-10,.19,1)[0]),rands(.5,.75,1)[0],rands(0.5,1,1)[0]],

[0,0,0,1]] 
;
d=5; 
 for(i=[0:d],j=[0:d])
     translate([i,j])
process(1+rands(0,1,1)[0]*4) obj();
 
 module process(s=4){
     if (s>0) 
         { nuops=4;
             select=round(rands(0,100,1)[0])%nuops;
             
           if      ( select==0)   process(s-1)shift()children();
          else if ( select==1)   process(s-1)reflect() rotate(90)children();  
           
           
         else if ( select==2)   process(s-1)stack(getm(),round(rands(0,1,1)[0]))children();
          else if ( select==3)   process(s-1)reflect() children();  
           
           else  process(s-1) rotsym([2,2,4,6,4][round(rands(0,4,1)[0])])children();
  
       }
             
           
     
     else 
         
  children();             
     
     
     
     }
 
     module reflect(){
         
         union(){
             children();
mirror([1,0,0])             children();
             
             }
         }
 
 
 module shift()
{
    translate([rands(-1,1,1)[0],0])children();
    } 

module obj()
{
    chamf(){
  linear_extrude(0.97) {
     square(1,center=true);
     
 
     
}
}}

module rotsym(s=2){
    
     for(r=[0:360/s:360]){
      rotate(r)  children();
        }
    }
    
    
module stack(M,s=5){
     
    if (s>0){
          union()        {
               children();
         stack(M,s-1)  Mop (M)children();}
        }
        else
           {    children();}
    }


 module Mop(M){
     
  translate([M[3][0],M[3][1],M[3][2]+1])
  rotate([M[1][0],M[2][1],M[0][2]]*360)
  
     scale([M[0][0],M[1][1],M[2][2]])
     children();
     }
 module trim()
    {
        intersection(){
       linear_extrude(3) projection()children();
        children();
            
            }
        }
 module ground()
    {
        hull(){
       linear_extrude(0.001) projection()children();
        children();
            
            }
        }
 
module chamf()
        {
            hull(){
         rotate(round(rands(0,3,1)[0])*15)   scale(rands(0.2,1,3))children();
            
            scale(rands(0.2,1,3)+[0,0,.8])children();
            }
            }