$fn=50;
 

cut(4   )

 
difference()       
{

union(){circle(50);
 }
union(){
translate([58,0,0])circle(40);

translate([-58,0,0])circle(40);

 
 } }

module cut(i,b)
{
 difference()       
{ children();
 offset(r=-2 )children();
}

if (i>0){
 

cut(i-1  )
union(){ 
 
 offset(r=-3 )children();  
children();} 
 }
 else
{   children();

}
}

module bottoms()
{
difference(){
 children();
translate([0,1]) children();
}
}

function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);

function rndc(seed) =seed==undef? [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]]:[rands(0, 1, 1,seed)[0], rands(0, 1, 1,seed+101)[0], rands(0, 1, 1,seed+201)[0]];
function half(b,select=1,l1=0.68,l2=0.5)=let(np1=lerp(b[0],b[3],l1),np2=lerp(b[1],b[2],l2))select==1?[b[0],b[1],np2,np1]:[np1,np2,b[2],b[3]];
function flip(b)=[b[1],b[2],b[3],b[0]];