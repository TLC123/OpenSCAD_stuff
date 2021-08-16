boundary=[[10,10 ],[-10,10 ],[-5,-10 ],[10,-5 ]];
 
 cut(4,boundary,rndc());

 
function half(b,select=1,l1=0.5,l2=0.5)=let(np1=lerp(b[0],b[3],l1),np2=lerp(b[1],b[2],l2))select==1?[b[0],b[1],np2,np1]:[np1,np2,b[2],b[3]];
function flip(b)=[b[1],b[2],b[3],b[0]];
module cut(i,b,c)
{
if(i>0){
l1=rnd(0.3,0.7);
l2=rnd(0.3,0.7);
cut(i-1,half(half(flip(b),1,l1,l2),1),c*0.75+rndc()*0.25);
cut(i-1,half(half(flip(b),2,l1,l2),1),c*0.75+rndc()*0.25);
cut(i-1,half(half(flip(b),1,l1,l2),2),c*0.75+rndc()*0.25);
cut(i-1,half(half(flip(b),2,l1,l2),2),c*0.75+rndc()*0.25);
}
else
{color(c)linear_extrude(rnd(1)+2)offset(r=0.05)offset(r=-0.2)polygon(b,[[0,1,2,3]]);
color(c)linear_extrude(1)polygon(b,[[0,1,2,3]]);}
}

function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);

function rndc(seed) =seed==undef? [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]]:[rands(0, 1, 1,seed)[0], rands(0, 1, 1,seed+101)[0], rands(0, 1, 1,seed+201)[0]];
