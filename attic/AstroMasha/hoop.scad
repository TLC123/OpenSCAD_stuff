 
basr=140; 
mn=25;
mnc=10;
$special=true;

 module hoop(f1,f2){
//     echo(f1,f2);
 
     

 
     med=lerp(f1,f2,0.5);
  translate(f1)color("blue")sphere(3);
 translate(f2)color("blue")sphere(3);
    translate(med)color("lightblue")sphere(3);
     mainhooprx= 180+atan2(med.y,med.z);
     
     tmed=invrotate(med,[mainhooprx,0,0]);
     tf1= invrotate(f1 ,[mainhooprx,0,0]);
     tf2= invrotate(f2 ,[mainhooprx,0,0]);
      


     mainhoopry= 90+ atan2(tmed.z,tmed.x);
     
     zmed =invrotate(tmed,[ 0,mainhoopry,0]);
     zf1  =invrotate(tf1,[0,mainhoopry,0]);
     
   
     
     n= ( [zf1.x,zf1.y,0]-[zmed.x,zmed.y,0]);
     
     mainhooprz= atan2(n.y,n.x);
     
 Ff1=un(f1)*basr;
 Ff2=un(f2)*basr;
 Fmed=un(med)*basr;
 Ff113=un(f1)*(basr-13);
 Ff213=un(f2)*(basr-13);
 translate(Ff113)color("blue")sphere(3);
 translate(Ff213)color("blue")sphere(3);
    translate(Fmed)color("lightblue")sphere(3);
    
ah=acos(.5*norm(f1-Ff113)/mn) *0.25;
bh=acos(.5*norm(f2-Ff213)/mn) *0.25;
      
     atest=  ((max(0.0001,un(Ff1)*un(Fmed))   ) );//fromTo
     btest=  ((max(0.0001,un(Ff2)*un(Fmed))   ));
     
 a=(180 ) - acos(is_num(atest)?atest:180)*2 ;
 b=(180 ) - acos(is_num(btest)?btest:180) *2  ;
     
     

rotate([-90-mainhooprx,0,0]){
    arc(basr,180);
    rotate([0,0,  -mainhoopry])
    rotate([0,-mainhooprz,0])
     {
        color("yellow")arc(basr-4,mnc );
     translate([0,basr-2,0])plug();



mirrorcopy() rotate(-(mnc  )/2) rotate([0,-a*0.5,0]) {
    rotate(-(mn )/2)arc(basr-5,mn+5);
    translate([0,basr-4,0])plug();
    
    rotate(-mn  ) rotate([0,a,0]) {
        translate([0,basr-7,0])plug();
         {rotate(-(mn  )/2)arc(basr-8,mn+5);
 rotate(-(mn  ))
             rotate([0,a*-.5+180 ,0]) 
             translate([0,basr-10,0]) if($special) lift(ah);
  }
    
    }
}    



mirrorcopy() rotate((mnc )/2) rotate([0,-b *0.5,0]) {
    rotate((mn )/2)arc(basr-5,mn+5);
      translate([0,basr-4,0])plug();
    
    rotate(mn ) rotate([0,b,0]){
        translate([0,basr-7,0])plug();
        {
            rotate((mn  )/2)arc(basr-8,mn+5);
       rotate((mn  ))
                         rotate([0, b *-0.5+180,0]) 

            translate([0,basr-10,0]) rotate([0,180,0])  if($special) lift(bh);}
    }
}
}}
}

module lift(a){
    h=2;  color("red")       
 
    rotate([0,0,a/h])
{rotate([ 90,0,0]) translate([0,0,basr-10])rotate([-90,0,0])rotate([0,0,mn/2]) arc(basr-10,mn );} 

   color("blue") 





{rotate([ 90,0,0])  rotate([0,a/h,0]) translate([0,0,basr-13])rotate([0,mn,0])translate([0,0,-(basr-13)])   rotate([0,-a,0])translate([0,0,basr-13]) rotate([0,0,0])rotate([-90,0,0]){
    rotate([0,0,-mn/2])  arc(basr-13,mn );
    rotate([0,0,-mn ])  translate([0,basr-15,0])sphere(5);
    
    }} 
    
}
    module mirrorcopy()
{
    children();
    union(){
     $special=false;
    mirror([0,0,1])children([0]);
    }
    }
    
module plug(){
   color("red") rotate( [90,0,0])cylinder(8,4,4,center=true);}

module arc(r,a){
  color("yellow")  rotate([0,0,(90-(a/2))])
    rotate_extrude (angle=a,$fa=5)   {translate([r,0,0]) square([2,10],center=true);}}
    
    
    function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function v3(p) = [p.x,p.y,p.z]; // vec3 formatter
function un(v)=assert (is_list(v)) v/max(norm(v),1e-64) ;
function rndc(a = 1,b = 0,s = [])=[rnd(a,b,s),rnd(a,b,s),rnd(a,b,s)];
function rnd(a = 1,b = 0,s = []) =
s == []?(rands(min(a,b),max(a,b),1)[0]) :(rands(min(a,b),max(a,b),1,s)[0]);

function bbox(v)=
let(x=[for(i=v)i.x],y=[for(i=v)i.y],z=[for(i=v)i.z])
[[min(x),min(y),min(z)],[max(x),max(y),max(z)]];


function roundlist(v,r = 0.01) = is_num(v) ? v - (v % r) : len(v) == 0 ? [] : [
  for (i = v) roundlist(i,r)];
      
 function invrotate(p,q)=
let(s=sin(q.z),c=cos(-q.z))let(p=[p.x * c - p.y * s, p.x * s + p.y * c, p.z])    
let(s=sin(q.y),c=cos(-q.y))let(p=[p.x * c + p.z * s, p.y, p.z * c - p.x * s]) 
let(s=sin(q.x),c=cos(-q.x))let(p=[p.x, p.y * c - p.z * s, p.y * s + p.z * c])

p;
  
//  function fromTo(/*vec3*/p,/*vec3*/q)= acos( un(p)*un(q) );
