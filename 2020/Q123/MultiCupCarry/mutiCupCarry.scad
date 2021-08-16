cupdia=60;
h=2;
cups=4;

linear_extrude(h)


difference(){
  
        
   offset(-5)offset(5)  

   union(){   offset(4)incup();
translate([0,cupdia*1.25 ])scale([1,.5])hamdle();
}
    
incup();
}

linear_extrude(h*2.5)


difference(){
  
        
   offset(-5)offset(5)  

   union(){   offset(1.75)incup();
 }
    
incup();
}
intersection(){
H();
r=7.5;
rotate([0,-90,0]) linear_extrude(30,center=true,convexity=100)
    offset(r)offset(-r)  union(){
     square([h*10,cupdia*1.6]);
     projection() rotate([0,90,0]){
     H();
     }
 }}
module H(){
hull(){
translate([0,cupdia*1.0125 ])scale([.24,1.051])linear_extrude(h*2+1)hamdle();
translate([0,cupdia*1.2 ])linear_extrude(h+3)scale([1,1])hamdle();
}

hull(){
translate([0,cupdia*1.3])linear_extrude(h+3)scale([1,.8])hamdle();
translate([0,cupdia*1.75,15])scale([1,0.5])linear_extrude(1)hamdle();
}
hull(){
translate([0,cupdia*1.75,15 ])scale([1,0.5])linear_extrude(1)hamdle();
translate([0,cupdia*2.,60 ])rotate([-10,0,0])scale([0.7,0.35])linear_extrude(5,center=true)hamdle();
     
}}
module incup()
{
for(a=[0:360/cups:360])
rotate(a+(180/cups))translate([cupdia*0.825,0,0])
circle(cupdia/2);
 }

 module hamdle(){
     
     scale(1)
 offset(9)  offset(-9)     square( [20,cupdia*0.75],center=true);
     }