include<DC19/DCmath.scad>
 t=$t;
//t=0.45;
optisteps=5000;
optiwsteps=30;
optspacing=1/3050;
opti0= 

[18.515, [596.305, 407.18, [-85.301, -400, -520], [136.177, -400, -520], [-310.851, -400, 9.4448], [-65.8506, -400, 0]]]


;
 
 tell(opti0);

 opti=seekw(optiwsteps,opti0[0],opti0[1]);
 
 tell(opti);

module tell(opti)
{echo(tell(opti));}
function tell(opti)=

 (str(
chr(10),"<pre>error: ",opti[0]," :n ",berror(opti[1]),
chr(10),opti[1][2][0],",",opti[1][3][0],
chr(10),opti[1][4][0],",",opti[1][5][0],
chr(10),
"bars: 2x - ",opti[1][0]/2,   "  2x - ",opti[1][1]/2,
chr(10),"top - ",norm(opti[1][2]-opti[1][3]),
 "  mid - ", midi(opti[1]),
 "  base - ",norm(opti[1][4]-opti[1][5]),
chr(10),
chr(10),opti,
chr(10),chr(10)
)) ;    
     

 


for(t=[0:.2:1.0]){
    
S=t;//(max(-1,min(1,sin( t*360)))*.5)+.5;
R=lerp(-0,50,S);
  translate([0,0,t*1400*5])
{
  translate([0,0,750])rotate([0,R])
{
translate([0,0,-50])cube([1200,800,800],center=true);


}
%translate([0,0,100])cube([1200,800,400],center=true);
%translate([0,400,750])rotate(90,[1,0,0])cylinder(19,730,730,$fn=39);  
    
    
    





L1=opti[1][0];
L2=opti[1][1];
piv1=rotate(opti[1][2],-R)+([0,0,750]);
piv2=rotate(opti[1][3],-R)+([0,0,750]);
piv3=opti[1][4];
piv4=opti[1][5];

//L1=400;
//L2=440;
//piv1=rotate([300,-400,-530],-R)+([0,0,750]);
//piv2=rotate([-50,-400,-500],-R)+([0,0,750]);
//piv3=[70,-400,-30];
//piv4=[-350,-400,50];


piv5=lerp(piv1,piv3,0.5);
piv6=lerp(piv2,piv4,0.5);
n1=let(n=un(piv1-piv3))[-n.z,0,n.x];
n2=let(n=un(piv2-piv4))[-n.z,0,n.x];

l1=sqrt(pow(L1/2,2)-pow(norm(piv1-piv3)/2,2));
l2=sqrt(pow(L2/2,2)-pow(norm(piv2-piv4)/2,2));;


piv7=piv5+n1*l1;
piv8=piv6+n2*l2;



//
// echo(berror());
//, L1=400,L2=440,p1=[300,-400,-530],
//p2=[-50,-400,-500],piv3=[70,-400,-30],piv4=[-350,-400,50]




$fn=6;
color([S,1,0.5])linkop(){
color("Red")translate(piv8) sphere(30 );
color("Red")translate(piv7) sphere(30);
 
 }
color([S,1,0.5])linkop(){
color("Red")translate(piv1) sphere(30 );
color("Red")translate(piv7) sphere(30);
color("Red")translate(piv3) sphere(30);
 }

translate([0,8,0])color([0.5,0,S])linkop(){
color("Red")translate(piv2) sphere(30);
color("Red")translate(piv8) sphere(30);
color("Red")translate(piv4) sphere(30);
}
}}


function seekw(steps,mini,v)=steps>0?
let( 
$steps=steps,
opti=seek(optisteps,mini,v)
)
seekw(steps-1,opti[0],opti[1]):[mini,v ]
;

function seek( c=optisteps, lowerror=1e9,
V ) 
= (c>0)? 
 let(
out1=c/500==round(c/500)?echo(str("responsive at:",$steps,":",c," ",lowerror)):0,
v=([
rnd(300,700),rnd(300,700),//l1,l2

[rnd(-500,500),-400, ( -520)],//p1
[rnd(-500,500),-400, ( -520)],//p2
[rnd(-500,500),-400,rnd(- 0, 20)],//p3
[rnd(-500,500),-400,rnd(- 0, 0)]//p4
//[rnd(100,-500),-400,rnd(-500,-500)],//p1
//[rnd(-500,100),-400,rnd(-500,-500)],//p2
//[rnd(-200,-400),-400,rnd(-0,0)],//p3
//[rnd(-400,200),-400,rnd(-0,0)]//p4

]+V+V+V+V +V+V+V+V)/9,

ve= (min( norm(v[2]-v[3]),norm(v[4]-v[5]) )),

newerror=berror(v)+ 1/(ve*optspacing),

isbetter=newerror<lowerror,

out=isbetter? 
echo(
tell([newerror,v])
//str(chr(10)," <pre> best so far: ",newerror," ve ",ve,chr(10)," as: "
//,chr(10),
//"[",newerror," [ ",v[0],",",v[1],chr(10),
//v[2],",",v[3],",",
//v[4],",",v[5],"]] 
//",chr(10), 
// 
//chr(10),
//"bars: 2x - ",v[0]/2,   "  2x - ",v[1]/2,
//chr(10),"top - ",norm(v[2]-v[3]),
// "  mid - ", midi(v),
// "  base - ",norm(v[4]-v[5]),
//chr(10)
//)

)
:0,
lowerror=isbetter?newerror:lowerror,
V=isbetter?v:V
)
seek(c-1, lowerror,V ):[lowerror,V ];





function berror(v )= 
let(L1=v[0],L2=v[1],p1=v[2],p2=v[3],piv3=v[4], piv4=v[5]  ,
  l= [ for(i=[0:0.01:1])bendist(i,L1,L2,p1,p2,piv3, piv4 ) ]  ) max(l)-min(l);
      
function midi (v)=let(L1=v[0],L2=v[1],p1=v[2],p2=v[3],piv3=v[4], piv4=v[5] )
bendist (0.5,L1,L2,p1,p2,piv3, piv4 );  
  
function bendist (S,L1,L2,p1,p2,piv3, piv4 ) =
let(
R=lerp(0,50,S),
piv1=rotate(p1,-R)+([0,0,750]),
piv2=rotate(p2,-R)+([0,0,750]),
piv5=lerp(piv1,piv3,0.5),
piv6=lerp(piv2,piv4,0.5),
n1=let(n=un(piv1-piv3))[-n.z,0,n.x],
n2=let(n=un(piv2-piv4))[-n.z,0,n.x],
l1=sqrt(pow(L1/2,2)-pow(norm(piv1-piv3)/2,2)),
l2=sqrt(pow(L2/2,2)-pow(norm(piv2-piv4)/2,2)),
  
klerror=(L1<norm(piv1-piv3)?1e10:0 ) +(L2<norm(piv2-piv4)?1e10:0)    ,
   
piv7=piv5+n1*l1,
piv8=piv6+n2*l2,
  res=norm(piv7-piv8)
)klerror>0?lerp(-klerror, klerror,S): res;


function rotate(p,r)= [p.x*cos(r)-p.z*sin(r),p.y,p.x*sin(r)+p.z*cos(r)]  ;

module linkop()
{
    
     for ( i= [0:1:$children-2])
    
   hull(){
      children(i);
     children(i+1);
   }  
    }