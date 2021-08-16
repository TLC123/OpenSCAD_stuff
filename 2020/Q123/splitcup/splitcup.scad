$fn=160;
h=140;
pip=.975;
pipr=.09;
dia=120;
div=3;
wall=0.75;

  l=0.87;
difference()
{

 connect(){
translate([0,0,h-wall])linear_extrude(wall)top();
translate([0,0,h*(1-pip)-wall])linear_extrude(wall)bottom();
linear_extrude(wall)bottom();
 }
 
difference(){
 connect(){
translate([0,0,h])linear_extrude(wall)offset(-wall)top();
translate([0,0,h*(1-pip)-wall])linear_extrude(wall)offset(-wall)bottom();
translate([0,0,wall]) linear_extrude(wall)offset(-wall)bottom();
 }
linear_extrude(h-wall*3,convexity=100) {

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

module connect()
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




module bottom()
    {
        circle(dia/2);
        
        }

module top(){
    
 hull(){ 
    bottom();
    translate([((dia/2)*1.5)-((dia/2)*pipr),0,0])circle((dia/2)*pipr);
   }
    }
