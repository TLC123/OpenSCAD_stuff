
$fn=60;


D=27.9;
d=D/2;
o=1.0125;
ping=[o,1/o];
pomg=[ping.y,ping.x];


  

  

 translate([d+4,0,-1.5])difference()
{
    
    
    union(){
     hull()  {translate([0,0,-4]) scale(ping)intersection(){
       translate([0,0,-6])     scale([1,1,.8])   sphere(d+7);
   mirror([0,0,1])cylinder(d+7,d+7,d+7);
    }
   
   
//        scale(ping)cylinder(1,d+6,d+6);
    scale(ping)cylinder(3,d,d);
    
    }    
        
        hull() {
   translate([0,0,27]) scale(1)cylinder(1,d+10,d+10,center=true);
   translate([0,0,30]) scale(1)cylinder(20,d,d,center=true);
}
  hull(){

scale(ping)cylinder(.1,d+2,d+2);
translate([0,0,41])scale(pomg)cylinder(.1,d+2,d+2);
}  
    }
    

union(){
hull(){

scale(ping)cylinder(.1,d,d);
translate([0,0,40])scale(pomg)cylinder(.1,d,d);
}
hull(){

translate([0,0,35])scale(pomg)cylinder(.1,d,d);
translate([0,0,45])scale(pomg)cylinder(.1,d+2,d+2);
}}}