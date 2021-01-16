                

copytransform(
[rnd(-0.25,0.25),rnd(-0.25,0.25),rnd(0.15,0.5)],
[rnd(-15,15),rnd(-15,15),rnd(-15,15)],
let(ms=rnd(0.9,1.001))[ms,ms,ms],43) 
translate([0,0,0])
intersection(){

sphere(1,1,1,$fn=8,center=false);
//cylinder(1,1,1,$fn=8,center=false);
}
module copytransform(T=[],R=[],S=[],n=0,c=1)
{

s=[pow(S.x,c),pow(S.y,c),pow(S.z,c)];
scale(s) children();
 if(c<n)translate(T)rotate(R)copytransform( [T.x*S.x,T.y*S.y,T.z*S.z],R,S,n,c+1){
children();}
}

function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 