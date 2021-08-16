fg=10;
lg=22;
h=2;
t=18;
tw=1;
module gear(i)
{
for(i=[(360/t)*fg:360/t:360+(360/t)*fg])
{
   union(){
//rotate(i) translate([10,0,0]) scale([0.9,0.6])rotate(45)
//circle(1.4,$fn=12,center=true);
hull(){
rotate(i ) translate([8,0,0])  rotate( )square([0.1,3],$fn=12,center=true); 


rotate(i ) translate([10,0,0])  rotate( )square([2.4,1.2],$fn=12,center=true);

  }
}
circle(10,$fn=18);

}


}
module tooth(i)
{
  union(){
//rotate(i) translate([10,0,0]) scale([0.9,0.6])rotate(45)
//circle(1.4,$fn=12,center=true);
hull(){
rotate(i ) translate([8,0,0])  rotate( )square([0.1,3],$fn=12,center=true); 


rotate(i ) translate([10,0,0])  rotate( )square([2.4,0.66],$fn=12,center=true);

  }
}


}
 difference()
{
 rotate([0,90,0])drop();

for(i=[(360/t)*fg:360/t:(360/t)*lg]){
mstep=1/32;
for(m=[0:mstep:1]){
hull(){
rotate([m*360,0,0]) translate ([0,5+8,0])rotate(m*(360/t))
linear_extrude(h,center=true ,convexity=20,twist=-tw) tooth(i);

rotate([m*360,0,0]) translate ([0,5+8+10,0])rotate(m*(360/t))
linear_extrude(h,center=true ,convexity=20,twist=-tw) tooth(i);


rotate([(m+mstep)*360,0,0])translate ([0,5+8+10,0])rotate((m+mstep)*(360/t))
linear_extrude(h,center=true ,convexity=20,twist=-tw) tooth(i);

rotate([(m+mstep)*360,0,0])translate ([0,5+8,0])rotate((m+mstep)*(360/t))
linear_extrude(h,center=true ,convexity=20,twist=-tw) tooth(i);

//rotate([(m )*360,0,0])translate ([0,5+8,0])cylinder(2,1,1);
//rotate([(m+mstep)*360,0,0])translate ([0,5+8,0])cylinder(2,1,1);

}
 }}
}


 module drop(){
rotate_extrude($fn=32) 

difference(){
union(){
translate([1.5,0])square([2,30],center=true);

hull(){
translate([2,0])square([4,20],center=true);
translate([3,0])square([6,10],center=true);
}}
translate ([5+8,0,0])circle( 10,$fn=49); 
}
}

 translate ([0,5+8,0])linear_extrude(h,center=true ,convexity=20,twist=-tw)gear();