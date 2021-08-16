v=[[0,0],[rnd(25,60),0],[rnd(5,60),rnd(5,60)],[rnd(1,60),rnd(5,60)],[rnd(1,60),rnd(1,60)],[rnd(1,40),60]];

o1=[[rnd(180),0.1],[rnd(180),rnd(0.5)],[rnd(180),rnd(0.5)],[rnd(180),rnd(0.5)],[rnd(180),rnd(0.5)],[rnd(180),rnd(0.5)]];
o2=[o1[5],[rnd(180),rnd(0.95,0.5)],[rnd(180),rnd(0.95,0.5)],[rnd(180),rnd(0.95,0.5)],[rnd(180),rnd(0.95,0.5)],[rnd(180),rnd(0.95,0.5)]];
o3=[o1[5],[rnd(180),rnd(0.95,0.5)],[rnd(180),rnd(0.95,0.5)],[rnd(180),rnd(0.95,0.5)],[rnd(180),rnd(0.95,0.5)],[rnd(180),0.95]];
intersection(){
#cylinder(h=60,r=60);



rotate_extrude($fn=40){
intersection(){
square([50,100]);
union(){
offset(r=0.5) difference(){
polygon( concat(bzplot(v,50),[[0,60]]));
offset(r=-1)polygon( concat(bzplot(v,30),[[-2,65],[-2,0]]));
translate([0,1,0])offset(r=-1)polygon( concat(bzplot(v,30),[[-2,65],[-2,0]]));
}hull(){translate([7.5,1,0]) scale([2,1,1])circle(1);
 scale([2,1,1])circle(1);}}


}

 }
steps=8;
for(r=[0:360/steps:359]){
rotate([0,0,r]){
ornamet(v,o1) ;
ornamet(v,o2) ;
ornamet(v,o3) ;
}}}
module ornamet(v,o) {
ostep=0.01;
for(i=[0:ostep:1])
{
hull(){
rotate([0,0,bez2(i,o)[0]])translate(concat(0,bez2(bez2(i,o)[1],v)))rotate([0,90,0])brush();
rotate([0,0,bez2(i+ostep,o)[0]])translate(concat(0,bez2(bez2(i+ostep,o)[1],v)))rotate([0,90,0])brush();
}}}
module brush(){
rotate([0,45,0])scale([2,1,0.5])sphere(1,$fn=10);
}
//ShowControl( concat(bzplot(v,20),[[0,30]]));

  module ShowControl(v)  
  {  // translate(t(v[0])) sphere(v[0][3]);
      for(i=[1:len(v)-1]){
       // vg  translate(t(v[i])) sphere(v[i][3]);
          hull(){
              translate(t(v[i])) sphere(1);
              translate(t(v[i-1])) sphere(1);
              }          }
      } 

function bez2(t, v) = (len(v) > 2) ? bez2(t, [
for(i = [0: len(v) - 2]) v[i] * t + v[i + 1] * (1 - t)
]): v[0] * t + v[1] * (1 - t);


function rnd( a=1,b=0)= (rands(min(a,b),max(a,b),1)[0]);



function bzplot(v,res)=[for(i=[1:-1/res:0])bez2(i,v)];
function lim31(l, v) = v / len3(v) * l;
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));

function bez2xy(v) = lim31(1, [v[0], v[1], 0]); // down xy projection
function bez2v(i, v) = lim31(1, bez2(i - 0.0001, v) - bez2(i, v)); // unit vector at i
function t(v) = [v[0], v[1], v[2]];
function rndR()=[rands(0,360,1)[0],rands(0,360,1)[1],rands(0,360,1)[0]];
function rndV()=[rands(-1,1,1)[0],rands(-1,1,1)[0],rands(-1,1,1)[0]];
function midpoint(start,end) = start + (end  - start )/2;
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];     
function srnd(a,b)=rands(a,b,1)[0];     
function t(v) = [v[0], v[1], v[2]];
function y(v) = [v[0], 0, v[2]];
function vsharp(v) = [  for(i = [0: 0.5: len(v) - 1]) v[floor(i)]];
function un(v) = v / max(len3(v),0.000001) * 1;
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
function pre(v,i)= i>0?         (v[i]-v[i-1]):[0,0,0,0];
function post(v,i)=i<len(v)-1?  (v[i+1]-v[i]):[0,0,0,0] ;
function SC3 (a)= let( b=clamp(a))(b * b * (3 - 2 * b));
function clamp (a,b=0,c=10)=min(max(a,b),c);
function gauss(x)=x+(x-SC3(x));
function  subdv(v)=[let(last=(len(v)-1)*3)for (i=[0:last])  let(j=floor((i+1)/3))i%3 == 0?v[j]:i%3  == 2? v[j]- un(un(pre(v,j))+un(post(v,j)))*(len3(pre(v,j))+len3(post(v,j)))*0.1: v[j] +un(un(pre(v,j)) +un(post(v,j)))*(len3(pre(v,j))+len3(post(v,j)))*0.1];     
function bz2t(v,stop,precision=0.01,t=0,acc=0)=acc>=stop||t>1?t:bz2t(v,stop,precision,t+precision,acc+len3(bez2(t,v)-bez2(t+precision,v)));
function len3bz(v,precision=0.01,t=0,acc=0)=t>1?acc:len3bz(v,precision,t+precision,acc+len3(bez2(t,v)-bez2(t+precision,v)));
function bez2euler(i, v) = [0, -asin(bez2v(i, v)[2]), atan2(bez2xy(bez2v(i, v))[1], bez2xy(bez2v(i, v))[0])];