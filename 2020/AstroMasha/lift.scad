
mn=20;


lift(tan(rnd(mn*360))*20);



module lift(a){
   color("red")       
    
    rotate([0,a/5,0])
{ translate([0,0,100])rotate([-90,0,0])rotate([0,0,mn/2]) arc(100,mn );} 

   color("blue") 





{   rotate([0,a/5,0]) translate([0,0,97])rotate([0,mn,0])translate([0,0,-97])   rotate([0,-a,0])translate([0,0,97]) rotate([0,0,0])rotate([-90,0,0]){
    rotate([0,0,-mn/2])  arc(97,mn );
    rotate([0,0,-mn ])  translate([0,95,0])sphere(5);
    
    }} 
    
}
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
      
 