sq=37;
height=sq*1.5;
stemh=sq*1.5;
v1=[[sq*0.5,0],[sq*0.5,8],[sq*0.4,8],[-10,5]];
v2=[[sq*0.4,0],[sq*0.45,15],[sq*0.45,8],[-10,10]];
v3=[[rnd(sq*0.5),0],[rnd(sq*0.5),stemh*0.25],[rnd(sq*0.6),stemh*0.95],[sq*0.5,stemh],[-10,stemh]];
v4=[[rnd(sq*0.75),0],[rnd(sq*0.5),stemh*0.25],[rnd(sq*0.6),stemh*0.95],[rnd(sq),stemh],[-10,stemh]];
v = concat([[5,0,rnd(0,6),3]],
[[25,0,rnd(0,10),rnd(3,min(2,sq/10))]],
[  for(i = [0: 1])[height/4+rnd(height/4)+i*height/4,rnd(-sq,sq)*0.35,rnd(0,sq)*0.5,rnd(3,min(2,sq/10)-i)]
],[[height,0,5,1]]);
base();
stem();
rstep=4;
for(r=[0:360/rstep:360]){
rotate([0,0,r])rotate([0,-90,0]){
semi(v);
 
}

}
  //extrudeT(v,50,-0.005,1.005){ scale(0.2) sphere(1);    translate([0,2,0]) scale(0.2) rotate([0,90,0])cylinder(r=7,h=2);    };
  
  
   // DistrubuteAlong(v,20,-0.005,1.005){ scale(0.2) sphere(2);     translate([0,2,0]) scale(0.2) rotate([90,0,0])cylinder(r=7,h=20,center=true);    };
module semi(v,d=20,l=0.95){
detail=1/d;  
for (i=[detail:detail:1]){
        //translate(t(v2t(v1,len3v(v1)*i)))

p1=t(v2t(v,len3v(v)*i));
p2=[bez2(1-i  , v)[0],bez2(1-i  , v)[1],bez2(1-i  , v)[2]];
p3=t(v2t(v,len3v(v)*(i-detail)));
p4=[bez2(1-(i-detail)  , v)[0],bez2(1-(i-detail)  , v)[1],bez2(1-(i-detail)  , v)[2]];
if(i==detail) {
 hull(){    translate( lerp(p1,p2,l))rotate(bez2euler (i,v))          scale(bez2((1-i)  , v)[3])rotate([0,-90,0])linear_extrude(height = 1)offset(r=1,$fn=15)rotate([0,0,45])square(1.5);
translate( lerp(p3,p4,l))  scale(bez2((1-i)+ detail  , v)[3])rotate([0,-90,0])linear_extrude(height = 1)offset(r=1,$fn=15)rotate([0,0,45])square(2);
}}
else
{
 hull(){    translate( lerp(p1,p2,l))rotate(bez2euler (i,v))          scale(bez2((1-i)  , v)[3])rotate([0,-90,0])linear_extrude(height = 1)offset(r=1,$fn=15)rotate([0,0,45])square(1.5);
translate( lerp(p3,p4,l)) rotate(bez2euler(i - detail, v))scale(bez2((1-i)+ detail  , v)[3])rotate([0,-90,0])linear_extrude(height = 1)offset(r=1,$fn=15)rotate([0,0,45])square(1.5);
}

}
  }}

// ShowControl(v);
module base(){
rotate_extrude($fn=100,convexity = 20){
intersection(){
square([sq,sq*3]);
union(){
offset(-0.5)offset(1)offset(-0.5){
polygon(convexity =20,concat(bzplot(v1,20),[[-10,0]]));
polygon(convexity =20,concat(bzplot(v2,20),[[-10,0]]));
//polygon([[0,0],[0,10],[10,0]]);
//polygon([[0,0],[0,1],[sq/2,0]]);
}
//polygon([[0,0],[0,10],[10,0]]);
}}

 }
}module stem(){
rotate_extrude($fn=100,convexity = 20){
intersection(){
square([sq,sq*stemh]);
union(){
offset(-0.5)offset(1)offset(-0.5){
polygon(convexity =20,concat(bzplot(v3,20),[[-10,0]]));
polygon(convexity =20,concat(bzplot(v4,20),[[-10,0]]));
//polygon([[0,0],[0,10],[10,0]]);
//polygon([[0,0],[0,1],[sq/2,0]]);
}
//polygon([[0,0],[0,10],[10,0]]);
}}

 }
}

function bez2euler(i, v) = [0, -asin(bez2v(i, v)[2]), atan2(bez2xy(bez2v(i, v))[1], bez2xy(bez2v(i, v))[0])];
function t(v) = [v[0], v[1], v[2]];
function rnd( a=1,b=0)= (rands(min(a,b),max(a,b),1,s)[0]);
    function len3v(v,acc=0,p=0)=p+1>len(v)-1?acc:len3v(v,acc+len3(v[p]-v[p+1]),p+1)  ;

function bzplot(v,res)=[for(i=[0:1/res:1.001])bez2(i,v)];
function bez2(t, v) = (len(v) > 2) ? bez2(t, [for(i = [0: len(v) - 2]) v[i] * t + v[i + 1] * (1 - t)]): v[0] * t + v[1] * (1 - t);
function bez2xy(v) = lim31(1, [v[0], v[1], 0]); // down xy projection
function bez2v(i, v) = lim31(1, bez2(i - 0.0001, v) - bez2(i, v)); // unit vector at i
function lim31(l, v) = v / len3(v) * l;

function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
  // lenght along vetorlist to point 
  function v2t(v,stop,p=0)=p+1>len(v)-1|| stop<len3(v[p]-v[p+1])?   v[p]+un(v[p+1]-v[p])*stop:  v2t(v,stop-len3(v[p]-v[p+1]),p+1);

function un(v) = v / len3(v) * 1;
function lerp(start, end, bias) = (end * bias + start * (1 - bias));

function rnd(a = 0, b = 1) = (rands(min(a, b), max(a, b), 1)[0]);
// Bline module
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

  
  
// Bline module
module DistrubuteAlong(v,d=8,start=0,stop=1) {
         detail=1/d;
    for(i = [start: detail: stop-detail]) {
      
        translate([bez2(i  , v)[0],bez2(i  , v)[1],bez2(i  , v)[2]])rotate(bez2euler (i,v))           scale(bez2(i  , v)[3])children();
           
        
      
    }
  }
module ShowControl(v)  
  {  // translate(t(v[0])) sphere(v[0][3]);
      for(i=[1:len(v)-1]){
       // vg  translate(t(v[i])) sphere(v[i][3]);
          hull(){
              translate(t(v[i])) sphere(2);
              translate(t(v[i-1])) sphere(2);
              }          }
      }