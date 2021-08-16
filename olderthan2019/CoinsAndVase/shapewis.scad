$fn=50;
boundary=[[50,50 ],[-50,50 ],[-50,-50 ],[50,-50 ]];

cut(4,boundary )

offset(r=4) offset(r=-4)
difference()       
{

union(){circle(50);translate([rnd(-50,50),rnd(-50,50),0])circle(5);
translate([rnd(-50,50),rnd(-50,50),0])circle(5);
 
translate([rnd(-50,50),rnd(-50,50),0])circle(5);
translate([rnd(-50,50),rnd(-50,50),0])circle(5);
 
translate([rnd(-50,50),rnd(-50,50),0])circle(5);
translate([rnd(-50,50),rnd(-50,50),0])circle(5);}
union(){
translate([58,0,0])circle(40);

translate([-58,0,0])circle(40);

 
 }}

module cut(i,b)
{
 difference()       
{ children();
 offset(r=-2 )children();
}

if (i>0){
l1=rnd(0.68,0.68);
l2=rnd(0.68,    0.68);
b1=half(half(flip(b),2),2);
b2=half(half(flip(b),2),1);
b3=half(half(flip(b),1),1);
b4=half(half(flip(b),1),2);

cut(i-1,b1 )
intersection(){ 
 offset(r=-0.5 )polygon(b1);
 offset(r=-3 )children();  }
cut(i-1,b2 )
intersection(){ 
 offset(r=-0.5 )polygon(b2);
 offset(r=-3 )children();  }
cut(i-1,b3 )
intersection(){ 
 offset(r=-0.5 )polygon(b3);
 offset(r=-3 )children();  }
cut(i-1,b4 )
intersection(){ 
 offset(r=-0.5 )polygon(b4);
  offset(r=-3 )children();  }

 }
 else
{   children();}
}


function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);

function rndc(seed) =seed==undef? [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]]:[rands(0, 1, 1,seed)[0], rands(0, 1, 1,seed+101)[0], rands(0, 1, 1,seed+201)[0]];
function half(b,select=1,l1=0.68,l2=0.5)=let(np1=lerp(b[0],b[3],l1),np2=lerp(b[1],b[2],l2))select==1?[b[0],b[1],np2,np1]:[np1,np2,b[2],b[3]];
function flip(b)=[b[1],b[2],b[3],b[0]];