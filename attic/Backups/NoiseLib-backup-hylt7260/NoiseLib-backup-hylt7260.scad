//Use Noise(x,y,z,seed);
Seed=1955;
step=1;//[0.25:0.25:10]
iscale=1;//[0.1:0.1:10]
oscale=1;//[0.1:0.25:10]
for (z=[0:8: 0]){for (x=[-20:step: 20]){for (y=[-20:step: 20]){
p1=[x,y,z+Noise(x*iscale ,y*iscale ,z*iscale,Seed)*oscale];
p2=[x+step,y,z+Noise((x+step)*iscale ,y*iscale ,z*iscale,Seed)*oscale];
p3=[x+step,y+step,z+Noise((x+step)*iscale ,(y+step)*iscale ,z*iscale,Seed)*oscale];
p4=[x,y+step,z+Noise(x*iscale ,(y+step)*iscale ,z*iscale,Seed)*oscale];
color(un([
(Noise(x*iscale ,y*iscale ,z*iscale,Seed+1)),
(Noise(x*iscale ,y*iscale ,z*iscale,Seed/2)),
(Noise(x*iscale ,y*iscale ,z*iscale,Seed/3))+(20-z)/30
])*min(Noise(x*iscale ,y*iscale ,z*iscale,Seed),1))polyhedron ([p1,p2,p3,p4],[[3,2,1,0]]);
}}}
// end of demo code */

function Noise(x=1,y=1,z=1,seed=1)=let(SML=octavebalance())(Sweetnoise(x*1,y*1,z*1,seed)*SML[0]+Sweetnoise(x/2,y/2,z/2,seed)*SML[1]+Sweetnoise(x/4,y/4,z/4,seed)*SML[2]);
function lim31(l,v)=v/len3(v)*l;
function octavebalance()=lim31(1,[40,150,280]);
function len3(v)=sqrt(pow(v[0],2)+pow(v[1],2)+pow(v[2],2));

function Sweetnoise(ix,iy,iz,seed=69840)=
let(x=floor(ix),y=floor(iy),z=floor(iz))
tril(SC3(ix-floor(ix)),(SC3(iy-floor(iy))),(SC3(z-floor(iz))),
Coldnoise((x),(y),(z),seed),Coldnoise((x+1),(y),(z),seed),
Coldnoise((x),(y+1),(z),seed),Coldnoise((x),(y),(z+1),seed),
Coldnoise((x+1),(y),(z+1),seed),Coldnoise((x),(y+1),(z+1),seed),
Coldnoise((x+1),(y+1),(z),seed),Coldnoise((x+1),(y+1),(z+1),seed));


function tril(bias_x,bias_y,bias_z,V000,V100,V010,V001,V101,V011,V110,V111)=
lerp(
    lerp(
        lerp(V000,V001,bias_z),
        lerp(V010,V011,bias_z),
    bias_y
    ),
    lerp(
        lerp(V100,V101,bias_z),
        lerp(V110,V111,bias_z),
    bias_y
    )
    ,bias_x
);
function lerp(start, end, bias) = (end * bias + start * (1 - bias));


function SC3(a)=(a*a*(3-2*a));
function  Coldnoise(i1,i2,i3,seed=69940) =
 let (
v=[i1,i2,i3],
   xseed = round(rnd(1e8, -1e8, seed  + round(v.x * 1e3))),
   yseed = round(rnd(1e8, -1e8, xseed + round(v.y * 1e3))),
   zseed = round(rnd(1e8, -1e8, yseed + round(v.z * 1e3))),
   noise  =  (rnd(0, 1e8, zseed))%1)
  noise ;

 function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 

function un(v)=v/max(len3(v),0.000001)*1;
