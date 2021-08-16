$fn=15;
style= rands(0.01,0.99,100);

rotate_extrude(){intersection(){
square([13,10+10+10+10]);offset(r=1)offset(r=-2)offset(r=1)union() {
base(10,12);}}}
translate([0, 0, 10])knighthead();
module knighthead(){ 
%  translate([0, -3, 0])
    scale(0.7)rotate([0,0,0])
    import(file = "horse3.stl", convexity=30);
neck = [[-10, -0,0,[20,15,15]],[10, -15,0,[1,8,19]],[22, 22,0,[1,1,6]],[40, 8,0,[12,12,1]],[32, 0,0,[8,12,10]],[21, -6,0,[9,-3,1 ]],[21, -13,0,[3,6,6]] ,[19, -13,0,[3,3,5]] ];
neck2 = [[-10, -0,0,[20,15,25]],[10, -15,0,[1,8,9]],[22, 22,0,[1,0,3]],[35, 8,0,[1,3,8]],[28, 0,0,[8,20,35]],[21, -6,0,[9,-3,8 ]],[22, -13,0,[3,6,-4]] ,[16, -16,0,[2,3,15]] ];
neck3 = [[-10, -6,0,[1,1,1]],[25, -28,0,[1,10,10]],[-5, 42,0,[1,0,0]],[65, -5,0,[1,1,32]],[28, -6,0,[8,10,12]],[20, -7,0,[9,-3,1 ]],[19, -12,0,[3,2,-4]] ,[22, -16,0,[2,6,22]] ];
l1=[[32,4,3,3],[34.5, 5.45, 4.2, 1.5],[37,6.9,6.2,0.3]];
l2=[[31,0,0,2],[30,-3,3,2.8]];
l3=[[30,-0.8,5.8,0.8],[31,-1,5.6,0.95],[31.8,-2,5.15,1],[32,-4.5,4.5,0.7],[31,-6,4,0.5],[28,-7,2,1]];
l4=[[30,-0.8,5.8,0.8],[29,-1,5.6,0.9],[28,-2,5,1],[28,-4.5,4.5,0.7],[29,-6,4,0.5],[28,-7,2,1]];
l5=[[20,-11,2,1],[20,-11,4,1],[24.4,-11.9,3,0.9],[24.6,-13.6,2.6,0.8],[24,-14.5,3,0.7],[21.5,-14.5,1.4,0.5],[21.5,-14.5,1,0.5]];

rstep=3;  
 
 
rotate([0,-90,90]){
 
extrudeT(neck,30,0.15,0.60,0,0.5){//mane
scale([1,1.5,1])hull(){
translate( [0,0.1,0.1])rotate([0,90,0])sphere(0.1);
translate( [0,-1,0.1])rotate([0,90,0])sphere(0.1);
translate( [0,-1,-0.1])rotate([0,90,0])sphere(0.1);
translate( [0,0.1,-0.1])rotate([0,90,0])sphere(0.1);
}}
extrudeT(neck,30,0.15,0.60,0,1){//mane
scale([0.8,1.4,0.8])hull(){
translate( [0,0.1,0.1])rotate([0,90,0])sphere(0.1);
translate( [0,-1,0.1])rotate([0,90,0])sphere(0.1);
translate( [0,-1,-0.1])rotate([0,90,0])sphere(0.1);
translate( [0,0.1,-0.1])rotate([0,90,0])sphere(0.1);
}} 

 }}
module semi(v,d=20,l=0.99){
detail=1/d;  

for (i=[detail:detail:1+detail]){
        //translate(t(v2t(v1,len3v(v1)*i)))

p1=t(bez2(i, v) );
p2=t(bez2(i-detail, v));
 

hull(){    
translate( p1)rotate(bez2euler (i,v))          scale(bez2(i  , v)[3])rotate([0,-90,0])minkowski(){
linear_extrude(height = 0.01)offset(r=1)translate([0,5,0]) circle(5,center=true,$fn=8);
sphere(1);
}
translate( p2)rotate(bez2euler (i-detail,v))          scale(bez2(i-detail  , v)[3])rotate([0,-90,0])minkowski(){
linear_extrude(height = 0.01)offset(r=1)translate([0,5,0]) circle(5,center=true,$fn=8);
sphere(1);
}
 
  }}}



function t(v) = [v[0], v[1], v[2]];
function rnd( a=1,b=0)= (rands(min(a,b),max(a,b),1,s)[0]);
    function len3v(v,acc=0,p=0)=p+1>len(v)-1?acc:len3v(v,acc+len3(v[p]-v[p+1]),p+1)  ;
function bzplot(v,res)=[for(i=[0:1/res:1.001])bez2(i,v)];
function bez2euler(i, v) = [0, -asin(bez2v(i, v)[2]), atan2(bez2xy(bez2v(i, v))[1], bez2xy(bez2v(i, v))[0])];

function bez2(t, v) = (len(v) > 2) ? bez2(t, [
for(i = [0: len(v) - 2]) v[i] * (1 - t) + v[i + 1] * ( t)]): v[0] * (1 - t) + v[1] * ( t);
function bez2xy(v) = lim31(1, [v[0], v[1], 0]); // down xy projection
function bez2v(i, v) = lim31(1, bez2(i - 0.0001, v) - bez2(i, v)); // unit vector at i
function lim31(l, v) = v / len3(v) * l;

function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
  // lenght along vetorlist to point 
  function v2t(v,stop,p=0)=p+1>len(v)-1|| stop<len3(v[p]-v[p+1])?   v[p]+un(v[p+1]-v[p])*stop:  v2t(v,stop-len3(v[p]-v[p+1]),p+1);

function un(v) = v / len3(v) * 1;
function lerp(start, end, bias) = (end * bias + start * (1 - bias));

function rnd(a = 0, b = 1) = (rands(min(a, b), max(a, b), 1)[0]);

function bz2t(v,stop,precision=0.01,t=0,acc=0)=
    acc>=stop||t>1?
    t:
    bz2t(v,stop,precision,t+precision,acc+len3(bez2(t,v)-bez2(t+precision,v)));
function len3bz(v,precision=0.01,t=0,acc=0)=t>1?acc:len3bz(v,precision,t+precision,acc+len3(bez2(t,v)-bez2(t+precision,v)));



// Bline module
module extrudeT(v,d=8,start=0,stop=1,twist=0,gap=1) {
         detail=1/d;

    for(i = [start+detail: detail: stop]) {
if($children>0){
       for (j=[0:$children-1]) 
      hull() {
        translate(t(bez2(i,v))) rotate(bez2euler(i, v))scale(bez2(i  , v)[3]) rotate([twist*i,0,0])children(j);
        translate(t(bez2(i - detail*gap, v))) rotate(bez2euler(i - detail*gap, v))scale(bez2(i- detail*gap  , v)[3]) rotate([twist*(i- detail),0,0])children(j);
      }
    }else{
      hull() {
        translate(t(bez2(i,v))) rotate(bez2euler(i, v))scale(bez2(i  , v)[3]) rotate([twist*i,0,0])rotate([0,-90,0])sphere(1);
        translate(t(bez2(i - detail*gap, v))) rotate(bez2euler(i - detail*gap, v))scale(bez2(i- detail*gap  , v)[3]) rotate([twist*(i- detail),0,0])rotate([0,-90,0])sphere(1);
      }}
}


  }

  
  
// Bline module

module DistrubuteAlong(v,d=8,start=0,stop=1) {
         detail=1/d;
     if($children>0)for(i3 = [start: detail: stop+detail]) {
         i2=i3>stop?stop:i3;
         i=bz2t(v,len3bz(v)*i2,0.01);
        translate([bez2(i  , v)[0],bez2(i  , v)[1],bez2(i  , v)[2]])rotate(bez2euler (i,v))           scale(bez2(i  , v)[3])children();
           
        
      
    }
  }
module ShowControl(v)  
  {  // translate(t(v[0])) sphere(v[0][3]);
      for(i=[1:len(v)-1]){
       // vg  translate(t(v[i])) sphere(v[i][3]);
          hull(){
              translate(t(v[i])) sphere(v[i][3]);
              translate(t(v[i-1])) sphere(v[i-1][3]);
              }          }
      }
module base(h=1,w=1)
{

r1=w*0.1;
r2=w*0.25*style[4];
r3=w*0.2*style[5];
r4=w*1*lerp(0.3,1,style[6]);
difference(){
union(){

basecore(h+r3,w);

hull(){
translate([w-r1,r1])circle(r=r1);
basecore(h/2,w);}
hull(){
translate([lerp(w-r2, w/2+r2,style[0]),lerp(h-r2,r2,style[1])])circle(r=r2);
basecore(h,w);}
hull(){
translate([w*0.618-r3,h ])circle(r=r3);
translate([0,r3])basecore(h+r3,w);}


}
translate([lerp(w*0.65+r4,w*0.45+r4,style[7]),lerp(h,r4+r1*0.5,style[8])])circle(r=r4);

}

}
module basecore(h,w){
square([w*0.1,h]);
}