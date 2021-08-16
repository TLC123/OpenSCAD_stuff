w=180;
h=600;
sides=10;
$vpr=[70+cos($t*360)*5,0,-215+sin($t*360)*15];
 t=(($t*10)%1)*1/72;

 path=[[[w,0,0],0],[[w,0,h],-540],[[-w,0,h],-540],[[-w,0,0] ,-540*2],[[w,0,0],-540*2]];
  scale([1,1,.5]){
     
%translate( [ w,0,0 ])cylinder(750,20,20);
%translate( [-w,0,0 ])cylinder(750,20,20);
      grate();
translate([0,0,530])mirror([0,1,0])  scale([0.975,1,1])    grate();
      
      for(j=[40:10:90]){
translate( [ w,0,j ])spiralguide();
      mirror([1,0,,0])
translate( [ w,0,j ])spiralguide();
      }

  
  
 for(i=[t:1/72:1-1/72+t]){
    p=v2t(path,(4*w+2*h)*(i%1));
    translate(limz(t(p[0]))) rotate(p[1])  step();
 }
  step=1/72;
 halfstep=step*.5;
  for(i=[t+halfstep:step:1-step+t+halfstep]){
    p=v2t(path,(4*w+2*h)*(i%1));
    translate(limz(t(p[0]))) rotate(p[1]) connector();
 }}
        
 function limz(v)=[v.x,v.y,max(40,min(h-30,v.z))];
 
 module connector() {
     translate([0,80,20]){
     color("lightblue")    linear_extrude(7,center=true) offset(1)square([8,.1],true);
  color("orange") scale([1,1,2]) rotate([-90,0,0])cylinder(2,2,2,$fn=sides);}

 }
 
module step() {
   color("lightyellow",0.95)  rotate(90-11) rotate_extrude(angle=21,$fn=66){
     difference(){
         translate([25,0])square([55,40]);
             translate([25,39])text(" iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii  ",size=5);
     }
   }
    
    
    color("lightyellow")  rotate(10)translate([0,80,0])cylinder(40,1,1,$fn=sides);
    color("lightyellow")  rotate(-10)translate([0,80,0])cylinder(40,1,1,$fn=sides);
     color("orange") {
//    rotate(0)translate([0,80,20])scale([1,1,2])rotate([-90,0,0]) cylinder(2,2,2,$fn=sides);
    rotate(5)translate([0,80,33])scale([1,1,2])rotate([-90,0,0])cylinder(2,2,2,$fn=sides);
    rotate(-5)translate([0,80,5])scale([1,1,2])rotate([-90,0,0])cylinder(2,2,2,$fn=sides);
     rotate(-5)translate([0,80,33])scale([1,1,2])rotate([-90,0,0])cylinder(2,2,2,$fn=sides);
    rotate(5)translate([0,80,5])scale([1,1,2])rotate([-90,0,0])cylinder(2,2,2,$fn=sides);
}}
        
 module grate() {
    color("darkgray",0.95)for(j=[25:7:77])
  translate([0,j,80]) cube([min(408,355+j*.85),5,1],true);  
 color("lightgreen")   for(j=[6.5:13:28]) {
  translate([0,80,60+j]) cube([355 ,2,3],true);  
  translate([0,80,60-j]) cube([355 ,2,3],true);  
 }}

       module spiralguide(){
     color("gray"){
 linear_extrude(510,twist=460){
      rotate(-40)translate([0,81,0])square(1.5);
      rotate(-40)translate([0,23,0])square(1.5);
    }
 
  } }
  
  function t(p)=[p.x,p.y,p.z];
  
  // lenght along vetorlist to point 
  function v2t(v,stop,p=0)=

p>len(v)-2 || stop< norm(( v[p][0]-v[p+1][0]))?

(v[p])+((v[p+1]-v[p])/norm(v[p+1][0]-v[p][0]))*stop:  

v2t(v,stop-norm(v[p][0]-v[p+1][0]) ,p+1);

  
 