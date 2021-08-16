include<MarchingCubes.scad>
include<DCmath.scad>
include<IQlib.scad>

sdDemo= false; 
$boundingBoxPadding=.05;
$cubicBound=false;
$fastBailout= .87*2;
//s= function(p)sdRoundBox( p-[10,0,0], [1,1,4], 1.3 );
// s=function(p)  Transf(p, [[-1,-1,-1],[-20, 0, 0],[1,1,1]], function(p) Transf(p, [[1,1,1],[0,0, p.z*0],[1,1,1]],function(p)sdRoundBox( p, [1,1,4], 0.3 )));
s=function(p) smin(sdSphere(   [p.x+1,p.y,p.z -2],   2 ) ,sdSphere(   [p.x,p.y ,p.z],   2 ) ,.1);
 c=autoBound(s,cubic = $cubicBound,pad=$boundingBoxPadding);
 echo(c);
//  #translate(c[0])cube(c[1]-c[0]); 
sdMarchingCubes( s ,cell=[], sub = 4)   ; 

