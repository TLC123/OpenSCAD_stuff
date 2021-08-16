r=(1-$t*2) *-30+cos(       $t*360*2)*2;
r2=-max(0,-r*2);

color("black")square(1000,true);
translate([0,0,1])color("white")square(200,true);
for(a=[0:90:360])
rotate(a)
color("grey"){
 
translate([0,26,10]){
rotate([r2,0,0])translate([0,-6,200]){
 

translate([0,6,-15])rotate([-90,0,0]) back();
}
//rotate([0,90,0])cylinder(200,5,5,true);
}


}
color("lightyellow")translate([0,-0,max(0,.5+pow((.9-$t),2)*180-5)+1])
rotate([0*max(.5,(1-($t))),0*max(.5,(1-$t)),40+90*min(.5,$t)])
{
cylinder(220,18,18);
translate([0,0,205])cube([70,20,1],true);
translate([0,0,205])cube([20,70,1],true);
}

module gripbase(){
rotate(clamp(-80+$t*$t*110,-45,-15))translate([0, -11])difference()
{
    
intersection(){
translate([0,4])scale([1.2,1.6])circle(9);
 circle(14);
}

circle(9);
translate([0,-9])circle(4);
translate([0, 11])scale([1,2])circle(4);
translate([0,-10])square(40);

}}

module grip(){
      linear_extrude(5,center=true)
 difference(){
   offset(.5)gripbase();
  offset(-.5) gripbase();
    }
    }

module back ()
{
     linear_extrude(5,center=true)
    difference(){
     offset(3)base();
 
   offset(3)offset(-3)           union(){ 
    difference(){ 
         base();
    
    for(y=[-5:20:250]){
    translate([0,y])square([250,2],true);
    }
       
    }
 
    }

}
    }
    
    
    
    module base(){
difference(){        
      offset(3) hull(){
   translate([10,0,0]) square([20,10],true);
  translate([-125,180,0])  square([10,5],true);
    }
    
        hull(){
translate([10,10,0])  square([30,10],true);
        translate([50,210,0])  square([270,5],true);
    }
    
}}
  function un(v) = v / max(norm(v), 1e-64) * 1;
  function clamp(a,b=0,c=1) =  min(max(a,min(b,c)),max(b,c));
  function lerp(start,end,bias) = (end * bias + start * (1 - bias));
  function rnd(a,b)=a+(rands(0,1,1)[0])*(b-a);
  