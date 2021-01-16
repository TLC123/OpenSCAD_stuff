$fn=30;   


height=50;
spout_troat_from_top=.7;
spout_radious_by_diameter=0.1;
diameter=60;
divisions=3;
wall_thicknesss=1;
dividers_pillback=2;
 
 makecup(height,spout_troat_from_top,spout_radious_by_diameter,diameter,divisions,wall_thicknesss,dividers_pillback);
 {

}

module makecup(
h=50,
pip=.6,
pipr=.5,
dia=40,
div=5,
wall=1){

difference()
{

 connect(h,pip,pipr,dia,div,wall){
translate([0,0,h-wall])linear_extrude(wall)top( h,pip,pipr,dia,div,wall);
translate([0,0,h*(1-pip)-wall])linear_extrude(wall)bottom(h,pip,pipr,dia,div,wall);
linear_extrude(wall)bottom(h,pip,pipr,dia,div,wall);
 }
 
difference(){
 connect(h,pip,pipr,dia,div,wall){
translate([0,0,h-wall+0.01])linear_extrude(wall)offset(-wall)top(h,pip,pipr,dia,div,wall);
translate([0,0,h*(1-pip)-wall])linear_extrude(wall)offset(-wall)bottom(h,pip,pipr,dia,div,wall);
translate([0,0,wall]) linear_extrude(wall)offset(-wall)bottom(h,pip,pipr,dia,div,wall);
 }
  l=0.9;
linear_extrude(h-dividers_pillback,convexity=100) {

 for (x=[dia/(div
     )*(div%2):dia/(div/2
     ):dia/1.5]){
 hull()
 {
     translate([((-dia/2)),x*l,0]) 
  circle(wall/2);
 
translate([((dia/2)*1.5)-((dia/2)*pipr)*-.5,0,0])  circle(wall/2);
 }
  hull()
 {
     translate([((-dia/2)),-x*l,0]) 
  circle(wall/2);
 
translate([((dia/2)*1.5)-((dia/2)*pipr)*-.5,0,0])  circle(wall/2);
 }
 }}
}

} 
}
module connect(h,pip,pipr,dia,div,wall)
{
  hull(){
      children(0);
    children(1);
  }
  hull(){
    children(1);
    children(2);
  }
    }




module bottom(h,pip,pipr,dia,div,wall)
    {
        circle(dia/2);
        
        }

module top(h,pip,pipr,dia,div,wall){
    
 hull(){ 
    bottom(h,pip,pipr,dia,div,wall);
    translate([((dia/2)*1.5)-((dia/2)*pipr),0,0])circle((dia/2)*pipr);
   }
    }

  
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];
  function rndR()=rands(-360,360,3) ;
function rnd(a = 1,b = 0,s = []) =
s == []?(rands(min(a,b),max(a,b),1)[0]) :(rands(min(a,b),max(a,b),1,s)[0]);
