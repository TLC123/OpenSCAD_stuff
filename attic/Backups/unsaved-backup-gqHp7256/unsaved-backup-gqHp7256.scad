for(x=[0:0.5:50],y=[0:50]){
translate([x,y,0]) sphere(vertex_hash([x,y,0]));echo( vertex_hash([x,y,0]));}





function Coldnoise(x,y,z,seed=69940)=((3754853343/((abs((floor(x+40))))+1))%1+(3628273133/((abs((floor(y+44))))+1))%1+(3500450271/((abs((floor(z+46))))+1))%1+(3367900313/(abs(seed)+1))/1)%1;

 function  vertex_hash(v) =
 let (
   xseed = round(rnd(1e8, -1e8, round(v.x * 1e6))),
   yseed = round(rnd(1e8, -1e8, xseed + round(v.y * 1e6))),
   zseed = round(rnd(1e8, -1e8, yseed + round(v.z * 1e6))),
   hash  =  (rnd(0, 1e8, zseed))%1)
 hash;

 function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 
