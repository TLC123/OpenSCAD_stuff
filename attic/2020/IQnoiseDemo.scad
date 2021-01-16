include<IQnoise.scad>

seed=rnd();
for(i=[0:30],j=[0:30]){
    rgb=[
    
    noise(  [i/rnd(2,15,seed+6),j/rnd(2,15,seed+9) +10]+ 
    [j/rnd(2,15,seed+6),-i/rnd(2,15,seed+9) +10]    ,
    rnd(.15,1,seed),  rnd(0.15,2,seed+5) ),
    
    noise(  [i/rnd(2,15,seed+7),j/rnd(2,15,seed+10)+11] +
    [j/rnd(2,15,seed+6),-i/rnd(2,15,seed+9) +10] 
    ,  rnd(.15,1,seed+1),  rnd(.15,2,seed+4) ),
    
    noise(  [i/rnd(2,15,seed+8),j/rnd(2,15,seed+11)+5]  +
    [j/rnd(2,15,seed+6),-i/rnd(2,15,seed+9) +10]  
    ,  rnd(.15,1,seed+2),  rnd(.15,2,seed+3) )
    ] ;
translate([i,j])color( max(rgb)>1?rgb/max(rgb):rgb)square(1);}
function rnd(a = 1, b = 0, s = []) = s == [] ? (rands(min(a, b), max(
 a, b), 1)[0]) : (rands(min(a, b), max(a, b), 1, s)[0]);