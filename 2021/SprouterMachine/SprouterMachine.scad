include<polyround.scad>
 
 
 bunk=[[0,14,0],[30,15,4],[38,24,4],[44,25,4],[55,1,4],[130,0,4],[150,100,4] ,[160,100,4],[162,90,0] ];
 top1=[[0,180,0],[20,180,4],[30,101,2],[34,100,2],[35,90,2],[147,91,4],[148,102,3] ,[163,102,3],[164,90,0] ];
 top2=[[0,180,0],[20,180,4],[30,101,2],[34,100,2],[35,90,2],[145,91,4],[147,98,0]   ];
 top4=[[31,145,0],[35,143,4],[41,116,4],[135,115,4],[144,130,4],[149,105,4] ,[164,104,4],[166,90,0] ];
 
 
 lathe(bunk);
 difference(){
 translate([0,0,2]) color("lightyellow",.7)lathe(top4 );
 angl1=40;
     linear_extrude(200,convexity=30)offset(-5,$fa=6) offset(10,$fa=6)offset(-5,$fa=6)
     intersection(){
     difference(){
     
     polygon([[0,0],[sin(angl1),cos(angl1)]*50, [sin(angl1),cos(angl1)]*250 ,[sin(-angl1),cos(-angl1)]*250]);
     circle(50,$fa=6);
         }
     circle(152,$fa=6);
     
     }
     }
 
 color("yellow")difference(){
 lathe(top1);
   linear_extrude(150,convexity=30){
     offset(5) offset(-5) difference(){
      circle(135,$fa=6);
//          circle(45,$fa=6);
//         for(i=[0:360/10:360])rotate(i) square([400,10],true);
          
     }}}
 
  color("red")translate([0,0,2])difference(){
 lathe(top2);
   linear_extrude(150,convexity=30){
     offset(5) offset(-5) difference(){
      circle(135,$fa=6);
          circle(45,$fa=6);
         for(i=[0:360/10:360])rotate(i) square([400,10],true);
          
     }}}
 
 module lathe(r,angle=360){
rotate_extrude(angle=angle,$fa=6,convexity=30)   trimToZeroX() offset(.7) polygon(polyRound( concat( r,revList(r)) ));
 }
module  trimToZeroX( )
{
    
    intersection(){
        
        children();
        union(){
            square(10e16);
            mirror([0,1])
            square(10e16);}
        }
    
    
    
    
    
    }