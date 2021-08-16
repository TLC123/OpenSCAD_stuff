// 60fps 3000steps
include <polyround2019.scad>;
include <hoop.scad>;
include <treepick.scad>
include <Mashalimits.scad>
//seed=rands(1,1,1,4377891);
  arcbaser=150;
pose1 =
clampAngleVector
([[rnd(-0,0),rnd(-0,00),0],  [rnd(90,-90),rnd(-50,50),rnd(-90,90)],
[-0,-30,-20],  [rnd(-60,60),rnd(-60,60),rnd(-60,360)], 
[rnd(30,-120),rnd(-100,50),rnd(-50,50)], [rnd(-0,190),0,0],  [rnd(-50,50),0,0],  
[rnd(30,-120),rnd(-100,50),rnd(-50,50)],  [rnd(-0,190),0,0],  [rnd(-50,50),30,0],
[rnd(-50,50),rnd(-50,50),rnd(-50,50)],  [rnd(-150,150),0,rnd(-150,150)],
[rnd(-50,50),rnd(-50,50),rnd(-50,50)],
[rnd(-50,50),rnd(-50,50),rnd(-50,50)],[rnd(-150,150),0,rnd(-150,150)],
[rnd(-50,50),rnd(-50,50),rnd(-50,50)]] *0.5 ); 
 

pose2 =
clampAngleVector
([[rnd(-0,-0),rnd(-10,20),0],  [rnd(90,-90),0,rnd(-90,90)],
[-0,-30,-20],  [rnd(-60,60),rnd(-60,60),rnd(-60,360)], 
[rnd(30,-120),rnd(-100,50),rnd(-50,50)], [rnd(-0,190),0,0],  [rnd(-50,50),0,0],  
[rnd(30,-120),rnd(-100,50),rnd(-50,50)],  [rnd(-0,190),0,0],  [rnd(-50,50),30,0],
[rnd(-50,50),rnd(-50,50),rnd(-50,50)],  [rnd(-150,150),0,rnd(-150,150)],
[rnd(-50,50),rnd(-50,50),rnd(-50,50)],
[rnd(-50,50),rnd(-50,50),rnd(-50,50)],[rnd(-150,150),0,rnd(-150,150)],
[rnd(-50,50),rnd(-50,50),rnd(-50,50)]]  *0.5); 

//pose=clampAngleVector(lerp(pose1,pose2,smooth( abs(($t-.5)*2))));
pose=lerp(pose1,pose2,smooth( rnd()));

//pose =
//clampAngleVector
//( [[0,0,0],[0,0,0],[0,0,0],[0,0,0],
//    [-25,10,-15],[60,0,0],[0,0,0],
//    [-25,10,-15],[60,0,0],[0,0,0],
//    [0,0,0],[0,0,0],[0,0,0],
//    [0,0,0],[0,0,0],[0,0,0],]); 
//    
//  # Ldancer( pose);
//    
// difference(){
// hull(){ 
//     Ldancer( pose,9);
//  Ldancer( pose,0);     
//  
// 
//     
//     }
// 
// 
// 
//
//
//
//for(a=[3,6 ])
//    {
// hull()
//for(i=[-72:20:60],j=[-52:20:70] )
//{ 
//pose =
//clampAngleVector
//( [[0,0,0],[0,0,0],[0,0,0],[0,0,0],
//    [i,j,0],[-i,0,i],[0,0,0],
//    [i,j,0],[-i,0,i],[0,0,0],
//    [i,j,0],[-i,0,i],[0,0,0],
//    [i,j,0],[-i,0,i],[0,0,0]]); 
//
//  Ldancer( pose,a);
////  Ldancer( pose);
//}
//
// }
//
//
//}// 
Ldancer( pose);

//
//posl=selector(mashatree(pose),[3,1,0,0,0],[0,-0,-0])[1];
//posr=selector(mashatree(pose),[3,0,0,0,0],[0,-0,-0])[1];
// 
// 
//
////
////hposl=selector(mashatree(pose),[1,0],[0,2,-1])[1];
////hposr=selector(mashatree(pose),[2,0],[-0,2,-1])[1];
////hposl2=selector(mashatree(pose),[1,0],[-19,2,-1])[1];
////hposr2=selector(mashatree(pose),[2,0],[19,2,-1])[1];
////
////hposl3=selector(mashatree(pose),[1,0],[12,5,-1])[1];
////hposr3=selector(mashatree(pose),[2,0],[-12,5,-1])[1];
////
////hposlcl=selector(mashatree(pose),[],[-20,40,20])[1];
////hposlcr=selector(mashatree(pose),[],[20,40,20])[1];
////hposlcl2=selector(mashatree(pose),[],[-40,50,20])[1];
////hposlcr2=selector(mashatree(pose),[],[40,50,20])[1];
//// 
////hull(){
////translate(hposr3)sphere(3);
////translate(hposr2)sphere(2);
////}
////hull(){translate(hposl3)sphere(3);
////translate(hposl2)sphere(2);
////}
////
////
////
////hull()
////{
////translate(hposl)sphere(1);
////translate(hposlcl2)sphere(2);
////}
////hull()
////{
////translate(hposr)sphere(1);
////translate(hposlcr2)sphere(2);
////}
////
////hull()
////{
////translate(hposl3)sphere(1);
////translate(hposlcl)sphere(2);
////}
////hull()
////{
////translate(hposr3)sphere(1);
////translate(hposlcr)sphere(2);
////}
//
//
//
//// floorbeam
//  rotate([0,89,0]){
//     rotate([0,0,0])    color("yellow")translate([ arcbaser+15,0,0]) rotate([0,-90,0])   {
//        cylinder(20,20,20,center=true); 
//      cylinder(23,18,18,center=true); }
// 
//  rotate([0,0,90])     color("yellow")translate([ arcbaser+15,0,0]) rotate([0,-90,0])cylinder(20,6,6,center=true); 
//
//   color("blue")  rotate_extrude(angle=90,$fn=80){
//     
//  color("red")   translate([arcbaser+15,0,0]) offset(r=3,chamfer=true,$fn=1)square(5,center=true);
//     
//     }}
//     
//     
//   //Hbeam   
//         rotate([0,pose[0].y,0])
//     {
// 
//
//    rotate([0,0,0])    color("yellow")translate([ arcbaser+5,0,0]) rotate([0,-90,0])cylinder(20,5,5 ); 
// rotate([0,0,180])   color("yellow")translate([  arcbaser+5,0,0]) rotate([0,-90,0])cylinder(20,5,5 ); 
//  rotate([0,0,90])     color("yellow")translate([  arcbaser+5,0,0]) rotate([0,-90,0])cylinder(12,7,7 ); 
//
//   color("red")  rotate_extrude(angle=180,$fn=100){
//     
//  color("red")   translate([ arcbaser,0,0]) offset(r=2,chamfer=true,$fn=1)square(5,center=true);
//     
//     }   }
//     
//     
//     //foot hoop
//  rotate([0,pose[0].y,0]) hoop(v3(posr),v3(posl));
//    
//   // back brace
//   rotate([pose[0].x,pose[0].y,0])  { 
////color("yellow")polyline(   polyRound([[0,15,-5,0],[0,15,15,3] ,[0,0,15,3]   ],8),2); 
// color("yellow")polyline(
//polyRound([[0,12,17,0],[0,17,25,0],[0,13 ,35,0] ]),3); 
//color("yellow")polyline(
//polyRound([[-5,12,20,0],[0,17,25,10],[-20,50,50,40], [-105,70,0,60],[-(arcbaser-10),0,-0,0]],fn=16),3); 
//color("yellow")polyline(
//polyRound([[5,12,20,0],[0,17,25,10],[20,50,50,40], [105,70,0,60],[ arcbaser-10,0,-0,0]],fn=16),3);
//color("yellow")translate([ arcbaser-10,0,-0]) rotate([0,90,0])cylinder(10,6,6,center=true); 
//color("yellow")translate([ -(arcbaser-10),0,-0]) rotate([0,90,0])cylinder(10,6,6,center=true);}
//    
module Ldancer(pose,globalselect) {
 
mtree=mashatree(pose);
selectors=[
    [],
    [0],
    [0,0],
    [1],
    [1,0],
    [1,0,0],
    [2],
    [2,0],
    [2,0,0],
    [3],
    [3,0],[3,0,0],[3,0,0,0],
    [3,1],[3,1,0],[3,1,0,0],
    ];
    on=true ; off=false;
    mirrors=[
    off,off,off,
    on,on,on,
    off,off,off,
    off,
      on,on,on, 
      off,off,off, ];
    
    
    file=[
    "torax.stl","collum.stl","head.stl",
    "Uarm.stl","ulna.stl","hand2.stl",
    "Uarm.stl","ulna.stl","hand2.stl",
    "abdomen2.stl",
    "Thigh.stl","crus.stl","foot2.stl",
    "Thigh.stl","crus.stl","foot2.stl"
   ];
    
       for(i=[0:len(selectors)-1])
    {
        S=selectors[i];
        T=selector(mtree,S )[1];
        R=rotationSelector(mtree,( S) );  
        
      if ( is_undef(globalselect) || i==globalselect) 
         
      if(mirrors[i])  
           
        
      mirror([1,0,0]) translate([T.x,T.y,T.z])  
      multmatrix (R )
//       mirror([1,0,0])
                import(file[i]); 
            else 
            translate([T.x,T.y,T.z])  
           
             multmatrix (R )              
                import(file[i]); 
        }
 


 
 
}    
    



function skin() =
let (sho = (rands(0, 1, 3)), mix = sho / (sho.x + sho.y + sho.z))(
    mix[0] * [255, 224, 189] / 255 +
    mix[1] * [255, 205, 148] / 255 +
    mix[2] * [244, 152, 80] / 255) * 0.9
;
 module skinner()
{
    for(i=[0:$children-1]){
        color(skin())children(i);
    }
    }

function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function smooth(a) =let (b = clamp(a))(b * b * (3 - 2 * b));
function smooths(v, steps) = smooth(smooth(mods(v, steps))) / steps + mstep(v, steps);
function clamp(a, b = 0, c = 1) = min(max(a, b), c);
function gauss(x) =x + (x - smooth(x));
function clamp3(a, b, c) = [clamp(a.x, b.x, c.x), clamp(a.y, b.y, c.y), clamp(a.z, b.z, c.z)];
 