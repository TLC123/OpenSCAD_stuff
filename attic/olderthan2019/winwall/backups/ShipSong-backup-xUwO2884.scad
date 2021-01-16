
// No Preview. Just hit Create.   Always leave Part at 1"
part=1;//[1,2,3,4,5,6]
/* [Hidden] */
LOA=rnd(900,2000);
Stern=LOA*rnd(-0.1,0.3);
Bow=LOA*rnd(-0.1,0.3);
Beam=LOA*rnd(0.05,0.3);
BeamHeight=min(Beam*rnd(0.4,1),LOA*0.1);
SternHeight=BeamHeight*rnd(0.9,3);
BowHeight=max(SternHeight*rnd(0.9,2),BeamHeight*rnd(0.9,3));;

KeelBase=LOA-Stern-Beam;
KeelLine=[
[0,0,0], 
[KeelBase*rnd(0.0,0.3),0,-KeelBase*rnd(-0.1,0.1)], 
[KeelBase*rnd(0.3,0.6),0,-KeelBase*rnd(-0.1,0.1)],
[KeelBase*rnd(0.6,0.9),0,-KeelBase*rnd(-0.1,0.1)],
[KeelBase-1,0,0],
[KeelBase-1,0,0]];
BottomLine=[
[0,0,0],
[KeelBase*rnd(0,0.3),Beam*rnd(0.1,1.5),1],
[KeelBase*rnd(0.3,0.6),Beam*rnd(0.1,2),1],
[KeelBase*rnd(0.6,0.9),Beam*rnd(0.1,3),1],
[KeelBase,0,1],
[KeelBase,0,1]];
bowbend=rnd(-1,3);
WaterLine=[
[-Stern*rnd(0.1,0.9),0,SternHeight/2],
[-Stern*rnd(0.1,0.9),Beam*rnd(0.5,2),SternHeight/2],
[KeelBase*rnd(0,2),Beam*rnd(0.5,3),BeamHeight/2],
[KeelBase+Bow*bowbend,0,BowHeight/2],
[KeelBase+Bow*bowbend,0,BowHeight/2]];
beamstern=[-Stern*rnd(-0.1,1),0,SternHeight];
BeamLine=[
beamstern,
[beamstern[0]+Beam*rnd(0,1),Beam*rnd(0.15,1.5),(BeamHeight+SternHeight)/2],
[KeelBase*rnd(0.0,0.5),Beam*rnd(0.15,2),BeamHeight],
[(KeelBase+Bow)*rnd(0.5,1),Beam*rnd(0.15,2),(BeamHeight+BowHeight)/2],
[KeelBase+Bow,0,BowHeight],
[KeelBase+Bow,0,BowHeight]];
KeelBow=concat(
[
BottomLine[len(BottomLine)-1],
WaterLine[len(WaterLine)-1],
BeamLine[len(BeamLine)-1]]);

SternLine=[BeamLine[0],WaterLine[0],BottomLine[0],KeelLine[0]];
RudderLine=[WaterLine[0]+[0,0,LOA*0.03],WaterLine[0]-[LOA*rnd(0.03,0.2),0,0],BottomLine[0]-[LOA*rnd(0.03,0.2),0,0],KeelLine[0]];
tiny=[0.0001,0.0001,0.0001];
Clinked=rnd(0,1);
openhull=sign(rnd(-1,1));
nummasts= floor(rnd(0,4));
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



  union(){
 masts(nummasts);
   * BoatHull(0,0,16,Clinked);
    }
//*render()
difference(){
    
    union(){
    if(floor(rnd(0,5))!=0 ||openhull>0){ Railings();}
    BoatHull(0,0,16,Clinked);
    }

    union(){
   if(floor(rnd(0,2))!=0){ Middeck();}
   
    translate(tiny)BoatHull(LOA/50,LOA/50*openhull,16);
    }
 

    }       
if (nummasts>0){
intersection(){    

    mirrorextrudeT(WaterLine,16,0.05,0.99){
    translate([0,-LOA/50,0]) scale(3) cube([LOA/1000,LOA/1000,LOA/200],center=true);
    }    
    
    BoatHull(LOA/400,0,10);
    }}
ctrl();

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module Railings(){
    

mirrorcopy([0,-1,0]){
    extrudeT(BeamLine,16,0,1){
    translate([0,0,0]) scale(2.5) cylinder(LOA/100,LOA/300,LOA/300,center=true,$fn =6);
    }  }
    


extrudeT(KeelBow,16,-0.07,1){
    translate([0,0,-5]) scale(3) cube([LOA/200,LOA/150,LOA/150],center=true);
    }
/*extrudeT(KeelLine,16,0.25,0.91){
    translate([0,0,-5]) scale(3) cube([LOA/1000,LOA/150,LOA/300],center=true);
    }*/

extrudeT(SternLine,16,0,1.2){
    translate([0,0,-5]) scale(3) cube([LOA/200,LOA/200,LOA/150],center=true);
    }
  ! color("RED")hull(){ extrudeT(RudderLine,8,0,1.1){
    translate([0,0,-5]) scale(3) sphere(LOA/400,center=true,$fn=6);
    }}
    
    intersection(){
    cube([LOA*2,LOA/50,LOA*2],center=true);
    BoatHull(-30,10,6);}
}
module masts(n=2){
       m=0.8/(n+0.5);
    i=len(WaterLine)-1 ;
    MastLine=[[max(WaterLine[0][0],BeamLine[0][0]),0,WaterLine[0][2]],[bez2(0.5, WaterLine)[0],0,bez2(0.5, WaterLine)[2]],[min(WaterLine[i][0],BeamLine[i][0]),0,WaterLine[i][2]]];
    
       for (s=[0.05+m:m:0.89]){
      p= bez2(s, MastLine);
       echo(p);
           MH=LOA*rnd(0.5,0.6)+Beam*rnd(0.2,0.2);th=MH*0.03;
   translate(p){   
       if (Beam<LOA*0.1){   cylinder(MH,th*0.5,th*0.2);
           translate([-th*0.25,0,bez2(s, BeamLine)[2]]) rotate([0,rnd(-5,5),-95]){ rotate([90,0,0])cylinder(KeelBase*m,th*0.5,th*0.3);   }}
           else{cylinder(MH,th*0.8,th*0.3);
   translate([th*0.5,0,MH*rnd(0.5,0.70)]) rotate([rnd(0,25),0,0])mirrorcopy([0,-1,0]){ rotate([90,0,0])cylinder(MH*0.5,th*0.5,th*0.3);   }}     
       }}}
    
module Middeck()
{   s=rnd(0.4,0.5);
   e=rnd(0.52,0.63); 
    bh=BeamHeight*rnd(0.3,0.5);
    hull(){
translate([bez2(s, BeamLine)[0],0,bez2(s, BeamLine)[2]])rotate([90,0,0])cylinder(Beam*4,bh,bh,center=true);
translate([bez2(midpoint(s,e), BeamLine)[0],0,bez2(midpoint(s,e), BeamLine)[2]])rotate([90,0,0])cylinder(Beam*4,bh,bh,center=true);
translate([bez2(e, BeamLine)[0],0,bez2(e, BeamLine)[2]])rotate([90,0,0])cylinder(Beam*4,bh,bh,center=true);}
    
    }
module BoatHull(offset=0,offset2=0,D=6,Clinker=0){
hstep=1/D;
vstep=1/(D*0.5);
    HLOA=LOA*0.5;
    offsetscale= (LOA-offset)/LOA;
    
   
for (t=[-0:hstep:1-hstep]){
spar1=[ bez2(t, BeamLine)+[0,0,-offset2],bez2(t, WaterLine),bez2(t, BottomLine),bez2(t, KeelLine)+[0,0,offset]];
spar2=[ bez2(t+hstep, BeamLine)+[0,0,-offset2],bez2(t+hstep, WaterLine),bez2(t+hstep, BottomLine),bez2(t+hstep, KeelLine)+[0,0,offset]];
  
for (v=[0:vstep:1-vstep]){
 
      
    p1=[((bez2(v, spar1)[0]-HLOA)*offsetscale)+HLOA,max(0,bez2(v, spar1)[1] ),bez2(v, spar1)[2]];
    p2=[((bez2(v+vstep, spar1)[0]-HLOA)*offsetscale)+HLOA,max(0,bez2(v+vstep, spar1)[1] ),bez2(v+vstep, spar1)[2]];
    p3=[((bez2(v, spar2)[0]-HLOA)*offsetscale)+HLOA,max(0,bez2(v, spar2)[1] ),bez2(v, spar2)[2]];
    p4=[((bez2(v+vstep, spar2)[0]-HLOA)*offsetscale)+HLOA,max(0,bez2(v+vstep, spar2)[1] ),bez2(v+vstep, spar2)[2]];
    
 p5=p2-[0,LOA/150,0]*SC3(v);
 p6=p4-[0,LOA/150,0]*SC3(v);
if (Clinker >0.5){
intersection(){
hull(){   
translate([0,-offset,0])polyhedron([p1,p5,p3,p6],[[0,2,1],[1,2,3,]]);
translate([0,-2000,0])polyhedron([p1,p5,p3,p6],[[0,2,1],[1,2,3,]]);
}
mirror([0,-1,0])hull(){
    {translate([0,-offset,0])polyhedron([p1,p5,p3,p6],[[0,2,1],[1,2,3,]]);
translate([0,-2000,0])polyhedron([p1,p5,p3,p6],[[0,2,1],[1,2,3,]]);
        }}}
    }
    else{
        
        intersection(){
hull(){   
translate([0,-offset,0])polyhedron([p1,p2,p3,p4],[[0,2,1],[1,2,3,]]);
translate([0,-2000,0])polyhedron([p1,p2,p3,p4],[[0,2,1],[1,2,3,]]);
}
mirror([0,-1,0])hull(){
    {translate([0,-offset,0])polyhedron([p1,p2,p3,p4],[[0,2,1],[1,2,3,]]);
translate([0,-2000,0])polyhedron([p1,p2,p3,p4],[[0,2,1],[1,2,3,]]);
        }}}
        
        
        
        }
    
}
}
    }
    
    module ctrl(){
        
        %color("RED"){mirror([0,-1,0]){

{ShowControl((BottomLine));
ShowControl((WaterLine));
ShowControl((BeamLine));}
}
{ShowControl((KeelLine));
ShowControl((BottomLine));
ShowControl((WaterLine));
ShowControl((BeamLine));}}}


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

module mirrorextrudeT(v,d=8,start=0,stop=1) {
         detail=1/d;
    for(i = [start+detail: detail: stop]) {
       for (j=[0:$children-1]) 
      hull() {mirrorcopy([0,-1,0]){
        translate(t(bez2(i,v))) rotate(bez2euler(i, v))scale(bez2(i  , v)[3]) children(j);
        translate(t(bez2(i - detail, v))) rotate(bez2euler(i - detail, v))scale(bez2(i- detail  , v)[3]) children(j);
      }}
    }
  }

  module ShowControl(v)  
  {  // translate(t(v[0])) sphere(v[0][3]);
      for(i=[1:len(v)-1]){
       // vg  translate(t(v[i])) sphere(v[i][3]);
          hull(){
              translate(t(v[i])) sphere(0.5);
              translate(t(v[i-1])) sphere(0.5);
              }          }
      } 
      
      
      
module mirrorcopy(vec=[0,1,0]) 
{ 
    children(); 
    mirror(vec) children(); 
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
      
      function rnd(a,b)=a+gauss(rands(0,1,1)[0])*(b-a);     

  function t(v) = [v[0], v[1], v[2]];

  
    function un(v) = v / max(len3(v),0.000001) * 1;
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
  function pre(v,i)= i>0?         (v[i]-v[i-1]):[0,0,0,0];
  function post(v,i)=i<len(v)-1?  (v[i+1]-v[i]):[0,0,0,0] ;
  function SC3 (a)= let( b=clamp(a))(b * b * (3 - 2 * b));
  function clamp (a,b=0,c=10)=min(max(a,b),c);
function gauss(x)=x+(x-SC3(x))*2;;