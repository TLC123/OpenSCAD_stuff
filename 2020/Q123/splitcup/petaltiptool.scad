$fn=8;   


height=30;
spout_troat_from_top=.4;
spout_radious_by_diameter=0.01;
diameter=15;
divisions=1;
wall_thicknesss=.8;
dividers_pullback=2;
 spout_push_out=8;
 
 
 
 mirror([0,0,1])union(){
for(xr=[0:14.4:360])
   color((rndc()+[1,1,1])*.5)   rotate(xr)
 translate([-spout_push_out*diameter/2-1,0,0]) makecup(height,spout_troat_from_top,spout_radious_by_diameter,diameter,divisions,wall_thicknesss,dividers_pullback,spout_push_out);
 {

}
translate([0,0,height])linear_extrude(wall_thicknesss)offset(-5)offset(6)projection()

for(xr=[0:14.4:360])
   color((rndc()+[1,1,1])*.5)   rotate(xr)
 translate([-spout_push_out*diameter/2-1,0,0]) makecup(height,spout_troat_from_top,spout_radious_by_diameter,diameter,divisions,wall_thicknesss,dividers_pullback,spout_push_out);
 {

}}
module makecup(
h=50,
pip=.6,
pipr=.5,
dia=40,
div=5,
wall=1,dividers_pullback,spout_push_out){
 union()
*translate([0,0,h])mirror([0,0,1])   linear_extrude(h*0.15) union(){
rotate(60) translate([-diameter*0.5-wall*2.71,0,0]) 
  offset(-wall*.2)  union(){
    difference(){ union(){
    circle(wall*2);  
    
       rotate(-45) {
          hull(){ square([wall*2,wall*2]); 
        rotate(-15) translate([wall*2,wall*2])   circle(wall*1. );  
        rotate(15) translate([wall*2,wall*2])   circle(wall*1. );  
       }
           }  }
           
    circle(wall*.5);  

    }     }
    ;
   
rotate(-60)  translate([-diameter*0.5-wall*2.71,0,0]){  
   offset( wall*.2)    offset(-wall*.1)    offset(-wall*.1)   difference(){ circle(wall*3);
 circle(wall*2);  
   rotate(60)   square([wall*3,wall*3]); 
   }}}
difference()
{

 connect(h,pip,pipr,dia,div,wall){
translate([0,0,h-0.01])linear_extrude(0.01)top( h,pip,pipr,dia,div,wall,spout_push_out);
translate([0,0,h*(1-pip)-wall])linear_extrude(wall)bottom(h,pip,pipr,dia,div,wall,spout_push_out);
linear_extrude(wall)bottom(h,pip,pipr,dia,div,wall,spout_push_out);
 }
 
*difference(){
 connect(h,pip,pipr,dia,div,wall){
translate([0,0,h-wall+0.01])linear_extrude(wall)offset(-wall)top(h,pip,pipr,dia,div,wall,spout_push_out);
translate([0,0,h*(1-pip)-wall])linear_extrude(wall)offset(-wall)bottom(h,pip,pipr,dia,div,wall,spout_push_out);
translate([0,0,wall]) linear_extrude(wall)offset(-wall)bottom(h,pip,pipr,dia,div,wall,spout_push_out);
 }
  l=0.9;
linear_extrude(h-dividers_pullback,convexity=100) {

 for (x=[dia/(div
     )*(div%2):dia/(div/2
     ):dia/1.5]){
 hull()
 {
     translate([((-dia/2)),x*l,0]) 
  circle(wall/2);
 
translate([((dia/2)*spout_push_out)-((dia/2)*pipr)*-.5,0,0])  circle(wall/2);
 }
  hull()
 {
     translate([((-dia/2)),-x*l,0]) 
  circle(wall/2);
 
translate([((dia/2)*spout_push_out)-((dia/2)*pipr)*-.5,0,0])  circle(wall/2);
 }
 }}
}

} 
}
module connect(h,pip,pipr,dia,div,wall,spout_push_out)
{
  hull(){
      children(0);
    scale(0.9)  children(1);
  }
  hull(){
   scale(0.9)   children(1);
  scale(0.6)  children(2);
  }
    }




module bottom(h,pip,pipr,dia,div,wall,spout_push_out)
    {
        circle(dia/2);
     translate([((dia/2)*spout_push_out*.5)-((dia/2)*pipr),0,0])   circle((dia/2)*.5);
        
        }

module top(h,pip,pipr,dia,div,wall,spout_push_out){
    
 hull(){ 
    bottom(h,pip,pipr,dia,div,wall,spout_push_out);
    translate([((dia/2)*spout_push_out)-((dia/2)*pipr),0,0])circle((dia/2)*pipr);
   }
    }

  
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];
  function rndR()=rands(-360,360,3) ;
function rnd(a = 1,b = 0,s = []) =
s == []?(rands(min(a,b),max(a,b),1)[0]) :(rands(min(a,b),max(a,b),1,s)[0]);
