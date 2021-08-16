//color("Red",0.2)cube(20);
orl=[
 [10,0, 0],[0,10,0],[20,0,10],[0,10,10],[20,10,20],[10,20,20]
];
pl= [
[[10, 0, 0], [0.390098, 0.895578, 0.213923]], 
[[0, 10, 0], [0.860071, 0.451819, -0.236932]],
[[20, 0, 20], [0, 0, -1]],
[[0, 10, 10], [ 0 , 0, 0]],
[[20, 10, 20], [0,0, 0]], 
[[10, 20, 20], [0.523576, 0.0468883, -0.850688]]] ;//
echo(pl);
p=([10,10,10]);
color("Blue")translate( p ) sphere(1); 
q4= findp2p(p,pl,15);
 

color("Red")translate( q4 ) sphere(2);
// 
  findp2p(p,pl);
 


 

for(i=[0:len(pl)-1]){
color("lightGreen",0.99)hull(){
point(pl[i][0]+pl[i][1]*10);
 point(pl[i][0]+pl[i][1]*1);} 
 if(len3(pl[i][1])>0)translate(pl[i][0])orientate(pl[i][1]) color("lightGreen",0.2)circle(25); 
}
 
module  findp2p(p,pl,f=75)
{
if(f>0&&len(pl)>0){

//for(i=[0:len(pl)-1]){
//mi=point2plane( p, pl[i][0] , pl[i][1] );
//color("Yellow")hull(){
// translate( p ) sphere(1);
// translate( mi ) sphere(1);
//}
//}
echo(p);
 
qi= clamp3([0,0,0],[20,20,20],avrg([for(i=[0:len(pl)-1])point2plane( p, pl[i][0] , pl[i][1] ) ]));
q=qi[0]==undef?p:qi;
df=q-p;
color("Purple")translate( clamp3([0,0,0],[20,20,20],p+df*1.9 ) ) sphere(1);
findp2p(clamp3([0,0,0],[20,20,20],p+df*1 ) ,pl,f-1);

}
}



 function cross(u,v) = [
  u[1]*v[2] - v[1]*u[2],
  -(u[0]*v[2] - v[0]*u[2]) ,
  u[0]*v[1] - v[0]*u[1]];

 function dot(u,v) = u[0]*v[0]+u[1]*v[1]+u[2]*v[2];
//

//
function anglev(u,v) = acos( dot(u,v) / (len3(u)*len3(v)) );
module orientate(v,vref=[0,0,1], roll=0)
{
  //-- Calculate the rotation axis
  raxis = cross(vref,v);
  
  //-- Calculate the angle between the vectors
  ang = anglev(vref,v);

  //-- Rotate the child!
  rotate(a=roll, v=v)
    rotate(a=ang, v=raxis)
      children();
}
function cross(u,v) = [
  u[1]*v[2] - v[1]*u[2],
  -(u[0]*v[2] - v[0]*u[2]) ,
  u[0]*v[1] - v[0]*u[1]];

module point(p)
{
  translate(p)
    sphere(r=0.5,$fn=20);
}
//

function  findp2p(p,pl,f= 4)=
f>0&&len(pl)>0?let(qi=clamp3([0,0,0],[20,20,20],avrg([for(i=[0:len(pl)-1])if(len3(pl[i][1])>0)point2plane( p, pl[i][0] , pl[i][1] ) ])),q=qi[0]==undef?p:qi,df=q-p)findp2p(clamp3([0,0,0],[20,20,20],p+df*1.9),pl,f-1):clamp3([0,0,0],[20,20,20],p);
function point2plane(p,o,n)=let(v=o-p)p+(n*(v.x*n.x + v.y*n.y + v.z*n.z)) ;
function clamp3(v1,v2,v3)=[min(v2.x,max(v3.x,v1.x)),min(v2.y,max(v3.y,v1.y)),min(v2.z,max(v3.z,v1.z))];

function addl(l,c=0)=c<len(l)-1?l[c]+addl(l,c+1):l[c];
function avrg(l)=len(l)>1?addl(l)/(len(l)):l;
 function un(v) = v/len3(v);
function len3(v) =len(v)>1?sqrt(addl([for(i=[0:len(v)-1])pow(v[i], 2)])):len(v)==1?v[0]:v; 
function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);
function rndc(a = 1, b = 0)=[rnd(a,b),rnd(a,b),rnd(a,b)];
