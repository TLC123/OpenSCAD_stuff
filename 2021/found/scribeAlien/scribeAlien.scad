color("black")for (rows=[0:11])
{My_poly_line=make_points(120- round(rnd(10)));
translate([rnd(20),rows*27])polyline(My_poly_line);
}
module sline(p1, p2 ,width=0.9,s=18) {
if(abs(p1.x-p2.x)>abs(p1.y-p2.y)){
for(i=[0:1/s:1]) 
line(xlerp(p1,p2,i),xlerp(p1,p2,i+1/s),width);}
else{for(i=[0:1/s:1-1/s]) 
line(ylerp(p1,p2,i),ylerp(p1,p2,i+1/s),width);}}

module line(p1, p2 ,width=0.3) {
 hull() {        
translate(p1) rotate(0)scale([1,1]) circle(width,$fn=4);
translate(p2) rotate(0)scale([1,1]) circle(width,$fn=4);    }}


module polyline(p) {for(i=[0:max(0,len(p)-2)])
    if(round(rnd(0.56))==0)sline(p[i],p[i+1]);}

function smooth_curve(i,c=1) =let(a=c>0?smooth_curve(i,c-1) :i)let (b = clamp(a))(b * b * (3 - 2 * b));

function clamp(a, b = 0, c = 1) = min(max(a, b), c);
function lerp(start, end, bias) = (end * bias + start * (1 - bias));

function xlerp(start, end, i) =
     [lerp(start.x,end.x,arcs1(i,2)),lerp(start.y,end.y,i)];
function ylerp(start, end, i) =
     [lerp(start.x,end.x,i),lerp(start.y,end.y,arc1(i,3))];
 
function mstep(v,steps) = (floor(v*steps)/steps );
function mods(v,steps) = ( (v*steps)%1);
function arcs1(v,steps=1) = arc1(mods(v,steps),2)/steps+mstep(v,steps);
function arcs2(v,steps=1) = arc2(mods(v,steps),1)/steps+mstep(v,steps);
function arc1 (x,n=0) = let(a= n>0? arc1(x,(n-1)):x) clamp(sqrt(1-(1-a)*(1-a)));
function arc2 (x,n=0) =let(a= n>0? arc2(x,(n-1)):x) clamp( 1-sqrt(1-(a)*(a)));


function make_points(j=10,l1=[-25,-1],l2=[30,20])= 
     ([for(i=[1:j])
[roundlist(rnd(l1.x,l2.x)/4+i*4,6),
roundlist(rnd(l1.y,l2.y),6)]]);
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 

function roundlist(v, r = 1) = len(v) == undef ? v - (v % r) : len(v) == 0 ? [] : [
  for (i = [0: len(v) - 1]) roundlist(v[i], r)];