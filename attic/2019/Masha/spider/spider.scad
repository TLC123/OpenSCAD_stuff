// shameless plug for my other project
//   https://www.youtube.com/channel/UCILubmqRg9xmgLys698sVWg/


 $legSize=rands(0,0.6,1)[0];
 i=[
 [6,5,-43,5]
,[7,13,-44,7]
,[6,18,-38,9]
,[9,22,-20,15]
,[0,27,-28,14]
,[9,24, -4,18]
,[6,22,10,20]


,[0,20,37,22]
,[10,22,60,26]
,[10,20,80,28]
,[6,16,100,20]
,[3,10,116,10]

,[15,15,-30,3]
,[16,14,-35,3]
,[18,13,-40,3]
,[20,12,-45,3]
,[20,10,-50,4]
,[19,10,-55,5]
,[18,10,-60,5]

,[80,0,-180,5]
,[130,0,-130,5]
,[115,0,135,5]
,[65,0, 180,5]

, [62.5, 56, -102.5, 6.5]
, [87.5, 56, -71, 6.5]
, [80, 56, 70.5, 6.5]
, [65, 56, 100, 6.5]

,[25,12,-25,8]
,[28,14,-12,8]
,[28,14,6,8]
,[25,10,20,8]


];

body();
mirror ([1,0,0])body();

     
*# import("D:/g/OpenSCAD/spider/Black_House_Spider_Print.stl");


module body(){
scale(0.1){ 
    for(o=[27:30]){
     p=o-4;
     r=o-8;
        m=0.6+$legSize;
        
          horrorline(i[o], i[o]*0.4-[0,-8,0,-2] );
        horrorline(i[o]*m,i[p]*m);
        horrorline(i[r]*m,i[p]*m);
        
 
     
     }

for (o=[0:11])
{
    
translate([i[o].x,i[o].z,i[o].y])scale(i[o][3])rotate([90,0,0])horror(1,$fn=20);
    toothpick(i[o],i[ max(0,o-1)]);
 }
 
 for (o=[12:18])
{
    
translate([i[o].x,i[o].z,i[o].y])scale(i[o][3])rotate([90,0,0])horror(1,$fn=20);
    toothpick(i[o],i[ max(12,o-1)]);
 }
}}
 module toothpick(p1,p2) {
      hull(){
          
                  p1_3=[p1.x,p1.z,p1.y];
    translate(p1_3 )scale(p1[3]*.7)rotate([90,0,0])sphere(1,$fn=4);
                   p2_3=[p2.x,p2.z,p2.y];
    translate(p2_3 )scale(p2[3]*.7)rotate([90,0,0])sphere(1,$fn=4);
 
          }
      }
 module horrorline(p1,p2)
  {
    
      
    toothpick(p1,p2);
          
          
      l=norm(p1-p2);
      m=min(p1[3],p2[3]);
      for ( i=[0:m/l:1]) {   
       p=lerp(p1,p2,i);
          p_3=[p.x,p.z,p.y];
    translate(p_3+rands(-m/2,m/2,3))scale(p[3]*1.2)rotate([90,0,0])horror(1.3,$fn=20);
 
     } 
      
      }
 module horror(s,q)
 {
     $fm=q;
     
          hull()
     {
         
         rotate(rands(0,360,3))cube(s,center=true);
         rotate(rands(0,360,3))cube(s,center=true);
         
         rotate(rands(0,360,3))cube(s,center=true);
         }
     hull()
     {
         
         rotate(rands(0,360,3))cube(s,center=true);
         rotate(rands(0,360,3))cube(s,center=true);
         
         rotate(rands(0,360,3))cube(s,center=true);
         }
     
     
     }
     
     
     function lerp(a,b,bias)=a*bias+b*(1-bias);