
LOA=rnd(500,1600);
Stern=LOA*rnd(0.0,0.3);
Bow=LOA*rnd(0.0,0.3);
Beam=LOA*rnd(0.1,0.3);
SternHeight=LOA*rnd(0.1,0.3);
BowHeight=LOA*rnd(0.1,0.5);
BeamHeight=LOA*rnd(0.1,0.3);
KeelBase=LOA-Stern-Beam;
KeelLine=[
[0,0,0], 
[KeelBase*0.25,0,-0.0*KeelBase], 
[KeelBase/2,0,-0.0*KeelBase],
[KeelBase*0.75,0,-0.0*KeelBase],
[KeelBase-1,0,0],
[KeelBase-1,0,0]];
BottomLine=[
[0,0,0],
[KeelBase*0.25,Beam*0.5,1],
[KeelBase*0.5,Beam*0.5,1],
[KeelBase*0.75,Beam*0.25,1],
[KeelBase,0,1],
[KeelBase,0,1]];
WaterLine=[
[-Stern*0.3,0,SternHeight/2],
[-Stern*0.3,Beam*2,SternHeight/2],
[KeelBase*0.5,Beam*2,BeamHeight/2],
[KeelBase+Bow/2,0,BowHeight/2],
[KeelBase+Bow/2,0,BowHeight/2]];
BeamLine=[
[-Stern*0.6,0,SternHeight],
[-Stern*0.6,Beam,(BeamHeight+SternHeight)/2],
[KeelBase*0.25,Beam*1.5,BeamHeight],
[KeelBase*0.75,Beam,BeamHeight],
[KeelBase+Bow,0,BowHeight],
[KeelBase+Bow,0,BowHeight]];
KeelBow=concat(
[KeelLine[len(KeelLine)-3],KeelLine[len(KeelLine)-2]],
[BottomLine[len(BottomLine)-1],
BottomLine[len(BottomLine)-1],
WaterLine[len(WaterLine)-1],
BeamLine[len(BeamLine)-1]]);

SternLine=[BeamLine[0],WaterLine[0],BottomLine[0],KeelLine[0],KeelLine[0],KeelLine[1]
];


difference(){
union(){ 
    BoatHull();

extrudeT(BeamLine,16,0.05,0.99){
    translate([0,0,0]) scale(1) cube(5,center=true);
    }
mirror([0,-1,0])extrudeT(BeamLine,16,0.05,0.99){
    translate([0,0,0]) scale(1) cube(5,center=true);
    }

extrudeT(KeelBow,16,-0.02,1.02){
    translate([0,0,-5]) scale(1) cube([5,5,15],center=true);
    }
extrudeT(KeelLine,16,0.25,0.91){
    translate([0,0,-5]) scale(1) cube([5,5,15],center=true);
    }
extrudeT(SternLine,16,0,1.1){
    translate([0,0,-5]) scale(1) cube([5,5,15],center=true);
    }
    }
   

    union(){
    Middeck();
    BoatHull(20,-10);
    }
    }
    difference(){
     BoatHull(20,10);
          BoatHull(21,20);
    }                             
%color("RED"){mirror([0,-1,0]){

{ShowControl((BottomLine));
ShowControl((WaterLine));
ShowControl((BeamLine));}
}
{ShowControl((KeelLine));
ShowControl((BottomLine));
ShowControl((WaterLine));
ShowControl((BeamLine));}}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module Middeck()
{    hull(){
translate([bez2(0.7, BeamLine)[0],0,bez2(0.7, BeamLine)[2]])rotate([90,0,0])cylinder(Beam*3,BeamHeight*0.5,BeamHeight*0.5,center=true);
translate([bez2(0.5, BeamLine)[0],0,bez2(0.5, BeamLine)[2]])rotate([90,0,0])cylinder(Beam*3,BeamHeight*0.5,BeamHeight*0.5,center=true);
translate([bez2(0.6, BeamLine)[0],0,bez2(0.6, BeamLine)[2]])rotate([90,0,0])cylinder(Beam*3,BeamHeight*0.5,BeamHeight*0.5,center=true);}
    
    }
module BoatHull(offset=0,offset2=0,){
hstep=1/8;
vstep=1/8;
    HLOA=LOA*0.5;
    offsetscale= (LOA-offset)/LOA;
    
   
    color("lightgreen")for (t=[-0:hstep:1-hstep]){
spar1=[ bez2(t, BeamLine)+[0,0,-offset2],bez2(t, WaterLine),bez2(t, BottomLine),bez2(t, KeelLine)+[0,0,offset]];
spar2=[ bez2(t+hstep, BeamLine)+[0,0,-offset2],bez2(t+hstep, WaterLine),bez2(t+hstep, BottomLine),bez2(t+hstep, KeelLine)+[0,0,offset]];
  
for (v=[0:vstep:1-vstep]){
 
      
    p1=[((bez2(v, spar1)[0]-HLOA)*offsetscale)+HLOA,max(0,bez2(v, spar1)[1] ),bez2(v, spar1)[2]];
    p2=[((bez2(v+vstep, spar1)[0]-HLOA)*offsetscale)+HLOA,max(0,bez2(v+vstep, spar1)[1] ),bez2(v+vstep, spar1)[2]];
    p3=[((bez2(v, spar2)[0]-HLOA)*offsetscale)+HLOA,max(0,bez2(v, spar2)[1] ),bez2(v, spar2)[2]];
    p4=[((bez2(v+vstep, spar2)[0]-HLOA)*offsetscale)+HLOA,max(0,bez2(v+vstep, spar2)[1] ),bez2(v+vstep, spar2)[2]];
intersection(){
hull(){   
translate([0,-offset,0])polyhedron([p1,p2,p3,p4],[[0,2,1],[1,2,3,]]);
translate([0,-5000,0])polyhedron([p1,p2,p3,p4],[[0,2,1],[1,2,3,]]);
}
mirror([0,-1,0])hull(){
    {translate([0,-offset,0])polyhedron([p1,p2,p3,p4],[[0,2,1],[1,2,3,]]);
translate([0,-5000,0])polyhedron([p1,p2,p3,p4],[[0,2,1],[1,2,3,]]);
        }}}

}
}
    }
module extrudeT(v,d=8,start=0,stop=1) {
         detail=1/d;
    for(i = [start+detail: detail: stop]) {
       for (j=[0:$children-1]) 
      hull() {
        translate(t(bez2(i,v))) rotate(bez2euler(i, v))scale(bez2(i  , v)[3]) children(j);
        translate(t(bez2(i - detail, v))) rotate(bez2euler(i - detail, v))scale(bez2(i- detail  , v)[3]) children(j);
      }
    }
  }


function  subdv(v)=[
  let(last=(len(v)-1)*3)
  for (i=[0:last])
      let(j=floor((i+1)/3))
  
  i%3 == 0?
    v[j]
  :
    i%3  == 2?
       v[j]- un(un(pre(v,j))+un(post(v,j)))*(len3(pre(v,j))+len3(post(v,j)))*0.1
        :
       v[j] +un(un(pre(v,j)) +un(post(v,j)))*(len3(pre(v,j))+len3(post(v,j)))*0.1
 
  ]
  ;
  module ShowControl(v)  
  {  // translate(t(v[0])) sphere(v[0][3]);
      for(i=[1:len(v)-1]){
       // vg  translate(t(v[i])) sphere(v[i][3]);
          hull(){
              translate(t(v[i])) sphere(0.5);
              translate(t(v[i-1])) sphere(0.5);
              }          }
      } 
      
      
      
      
      
 function bz2t(v,stop,precision=0.01,t=0,acc=0)=
    acc>=stop||t>1?
    t:
    bz2t(v,stop,precision,t+precision,acc+len3(bez2(t,v)-bez2(t+precision,v)));

function len3bz(v,precision=0.01,t=0,acc=0)=t>1?acc:len3bz(v,precision,t+precision,acc+len3(bez2(t,v)-bez2(t+precision,v)));

function bez2(t, v) = (len(v) > 2) ? bez2(t, [
  for(i = [0: len(v) - 2]) v[i] * t + v[i + 1] * (1 - t)
]): v[0] * t + v[1] * (1 - t);
function lim31(l, v) = v / len3(v) * l;
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
function bez2euler(i, v) = [0, -asin(bez2v(i, v)[2]), atan2(bez2xy(bez2v(i, v))[1], bez2xy(bez2v(i, v))[0])];
  
function bez2xy(v) = lim31(1, [v[0], v[1], 0]); // down xy projection
function bez2v(i, v) = lim31(1, bez2(i - 0.0001, v) - bez2(i, v)); // unit vector at i
function t(v) = [v[0], v[1], v[2]];
function rndR()=[rands(0,360,1)[0],rands(0,360,1)[1],rands(0,360,1)[0]];
function rndV()=[rands(-1,1,1)[0],rands(-1,1,1)[0],rands(-1,1,1)[0]];
function midpoint(start,end) = start + (end  - start )/2;
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];     
      
      function rnd(a,b)=rands(a,b,1)[0];     

  function t(v) = [v[0], v[1], v[2]];

  
    function un(v) = v / max(len3(v),0.000001) * 1;
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
  function pre(v,i)= i>0?         (v[i]-v[i-1]):[0,0,0,0];
  function post(v,i)=i<len(v)-1?  (v[i+1]-v[i]):[0,0,0,0] ;