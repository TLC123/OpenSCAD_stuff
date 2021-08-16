//
//   scale([1,1,.7]) mirrorcopy()
//translate([30,0,0])rotate([0,-10,-20]){
// scale([1,1.5,1])sphere(6);   
//translate([-56,0,0]) sphere(5);   
//    rotate([-20,0,0])
//rotate(20)translate([-30,0,0])
//
//rotate_extrude(angle =140)translate([30,0,0])circle(4);
//}    
// translate([30,0,0])for(i=[-20:20:20]) rotate(i)   rotate([-90,60,0])translate([-30,0,0])rotate_extrude(angle =-60)translate([30,0,0])circle(3);
$fn=30;
r=reflect([[-30*.7,30*.7,-1,4],[30*.7,55,-25,0],[40,2,10,4]]*1.7+listthis([-50,0,0,0],[0:2]));
g=reflect([ bez(.25,r),[80,10,10,4],[10,-00,160,8]]);
h=reflect([ bez(.4,g) , bez(.49,g) , [-10,10,280,6] ,[180,80,180,2],[180,80,180,2] , [10,2,50,9]]); 

b=4;
rotate([0,-10,0])intersection(){
rotate(b)b2();
rotate(-b)b2();
}

module b2(){

         translate([40,0,0]) difference(){
 
rotate([-90,0,0]) linear_extrude(height=80,center=true,convexity=20) offset(-1.5)projection()rotate([90,0,0])winehook();  
     
     
linear_extrude(height=400,center=true,convexity=20)
     
     {
   offset(-4)offset(4){
         translate([-40,0,0])circle( 50*.5 );
 translate([-80,0,0])circle( 15 );
 translate([-100,0,0])circle( 20 );
   }
     }

 
 
 
 }}
 
 
 
 module winehook(){
 bez(r);
 bez(g);
  bez(h);
 }
 function listthis(i,c)=[for(j=c)i];

module mirrorcopy(m=[0,1,0])
{children();
    mirror(m)children();
    
    }


module bez(v,steps=20)
 {
     
     step=1/steps;
     for(i=[0:step:1-step]){
     hull()    for(ii=[i:step:i+step*1.1]){
         b=bez(ii,v);
              translate([b.x,b.y,b.z]) scale(b[3])sphere(1);
         }
     }}
 
 
 
 
function bez(t,v)=
     len(v)<3?
     lerp(v[0],v[1],t):
     bez(t,[for(i=[0:max(1,len(v)-2)])lerp(v[i],v[i+1],t)]);
 
 function reflect(v)=[each v,each rev(v)];
function rev(v)=[for(i=[len(v)-1:-1:0])[v[i].x,-v[i].y,v[i].z,v[i][3]]];
 function un(v) = v / max(norm(v), 1e-64) * 1;
 function clamp(a,b=0,c=1) =  min(max(a,min(b,c)),max(b,c));
 function lerp(start,end,bias) =  (end * bias + start * (1 - bias));
 function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);
 function smooth(a) = let (b = clamp(a))(b * b * (3 - 2 * b));
 function gauss(x) = x + (x - smooth(x));
 