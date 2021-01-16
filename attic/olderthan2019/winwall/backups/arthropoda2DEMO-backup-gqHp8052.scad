////////////////////
//Easy Bez-curve generator by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike
////////////////////
// preview[view:south west, tilt:top diagonal]
//RandomSeed
//$vpd =650;
//$vpr =[ 90.00, 0.00, 0.00 ];
//View translation
//Vtr= [ 89.16, 66.01, 72.67 ];


seed = 1789; //[1111:9999]
part = 0; //[1,2,3,4,5]
controlpoints=rands(3, 6, 1)[0];
thickest=15;//[5:50]
detail = 5; //[0.01:0.001:0.5]
fn = 10; //[8:30]
rad=5;//[1:0.5:12]
tang=2;//[1:10]
//some random 4D points
v1 = vsmooth([  for(i =       [0: controlpoints])[rands(0, 2000, 1)[0]+ i*3000, rands(0, 5000*sign(i), 1)[0], rands(0,10000, 1)[0], i==0||i==controlpoints?15:rands(100, 800, 1)[0]]
]);

  v2 = [[0,0,0,1],[0,0,0,1],[0,0,0,1]]
;
  
  
    v3 = [
  for(i = [0: controlpoints])[0,1,rands(-360, 360, 1)[0], rands(1, 2, 1)[0]]
];
  
  
  
Leg = [
  [-20, 30, 0,[10,5,5]],
  [35, 10,0,[7,3,4]],// Coxa
  [55,  35,0,[4,6,4]],//Trochanter
  [200, 200,0, [3,6,3]],//Femur  
  [220, 200,0,[3,3,2] ],//Patella
  [250,-50,0,[2,2,2]],//Tibia
  [300,-60, 0, [2,1,1]],//Tarsus
  [350,  -55,0,[2,1,1]],// Tarsomeres
  [375,  -55,0,[2,1,1]],// Tarsomeres
  [400,  -50,0,[3,1,1]],// Tarsomeres
 [450,  -70,0,[1,1,1]], //claw
];


profile = vsmooth([
[0,-6],
[5, -5], 
[3,0],
 [7, 6],
 [0,6],
[-7, 6],
[-3,0],
[-5, -5],
[0,-6],


]);





   * ShowControl(v1);
  
*  for (i=[0:1/3:1]){
  //echo(t(v2t(v1,len3v(v1)*i)));
        //translate(t(v2t(v1,len3v(v1)*i)))
      translate( t(v2t(v1,len3v(v1)*i)))
scale (0.1)bodypart ( profile, Leg );
  }
//main call
  
resize(40,40,20){
color("darkred")
  for(j=[0:0]){color("red")
  
  DistrubuteAlong2(v1,v2,rands(3, 10, 1)[0],0.1,0.9,[0,0,j*45,0]){
translate([0,0,0]) 
     rotate([90,00,0]) rotate([0,90,0]) union(){
    translate([7,-5,0]) scale (0.1)bodypart ( profile, Leg );
mirror ([1,0,0])
    translate([7,-5,0]) scale (0.1)bodypart ( profile, Leg );}
     // sphere(r=1,$fn=10,center=true);  
    
    }}
 color("brown")   bodypart ( profile, v1 );}
    
 color(rndc())  
*extrudeT(v1,25){translate([0,0,0]) scale(1) rotate([0,90,0])sphere(r=1,$fn=10,center=true);  }
  for(j=[0:0]){color(rndc()) 
      
  *DistrubuteAlong2(v1,v2,7,0.05,0.95,[0,0,j*45,0]){
//translate([0,0,1]) scale(1) rotate([0,90,0])sphere(r=1,$fn=10,center=true);  
rotate([90,00,0]) rotate([0,90,0]) union(){
    translate([7,0,17]) scale (0.11)bodypart ( profile, Leg );
mirror ([1,0,0])
    translate([7,0,17]) scale (0.1)bodypart ( profile, Leg );}
      
  }}
  
// Bline module
module extrudeT(v,d=8,start=0,stop=1) {
    
         detail=1/d;
    if($children>0) for(i2 = [start+detail: detail: stop+detail]) {
        i=i2>stop?stop:i2;
       for (j=[0:$children-1]) 
      hull() {
        translate(t(bez2(i,v))) rotate(bez2euler(i, v))scale(bez2(i  , v)[3]) children(j);
        translate(t(bez2(i - detail, v))) rotate(bez2euler(i - detail, v))scale(bez2(i- detail  , v)[3]) children(j);
      }
    }
  }
module ShowControl(v)  
  {  // translate(t(v[0])) sphere(v[0][3]);
      for(i=[1:len(v)-1]){
       // vg  translate(t(v[i])) sphere(v[i][3]);
          hull(){
              translate(t(v[i])) sphere(5);
              translate(t(v[i-1])) sphere(5);
              }          }
      }  
 module extrudeT2(v,v2,d=8,start=0,stop=1,modify=[0,0,0,0]) {
         detail=1/d;
    if($children>0) for(i2 = [start+detail: detail: stop+detail]) {
        i=i2>stop?stop:i2;
       for (j=[0:$children-1]) 
      hull() {
translate(t(bez2(i,v))) rotate(bez2euler(i, v))
         
          rotate([bez2(i  , v2)[2]+modify[2],0,0])
          translate([0,0,bez2(i  , v2)[1]*bez2(i  , v)[3]+modify[1]])
          scale(bez2(i  , v2)[3]+bez2(i  , v)[3]*0.5+modify[3]) children(j);
          
translate(t(bez2(i - detail, v))) rotate(bez2euler(i - detail, v))
          
        rotate([bez2(i-detail  , v2)[2]+modify[2],0,0])
         translate([0,0,bez2(i- detail  , v2)[1]*bez2(i-detail  , v)[3]+modify[1]])scale(bez2(i- detail  , v2)[3]+bez2(i-detail  , v)[3]*0.5+modify[3]) children(j);
      }
    }
  } 
   module DistrubuteAlong2(v,v2,d=8,start=0,stop=1,modify=[0,0,0,0]) {
         detail=1/d;
    if($children>0)for(i3 = [start: detail: stop+detail]) {
        i2=i3>stop?stop:i3;
                i=bz2t(v,len3bz(v)*i2,0.005);

        for (j=[0:$children-1]) 
      
translate(t(bez2(i,v))) rotate(bez2euler(i, v))
         
          rotate([bez2(i  , v2)[2]+modify[2],0,0])
          translate([0,0,bez2(i  , v2)[1]*bez2(i  , v)[3]+modify[1]])
          scale(bez2(i  , v2)[3]+bez2(i-detail  , v)[3]*0.5+modify[3]) children(j);
      
      
    }
  }
  
    

module bodypart(profile, List, grove=0.7,lrp1=0.3,lrp2=0.7) {
    lrp0=0;
    lrp3=1;
   sth = 0.001;
  for(i = [0: len(List) - 2]) {
    hull() {
      if(i == 0) {
          
color("red")
ttranslate(List[i]) rotate(getangle(v(i,List)))  scale(lerp(List[i][3],List[i+1][3],lrp0)) scale(grove)  linear_extrude(height = sth) polygon(profile);
ttranslate(lerp(List[i ],List[i + 1],lrp1)) rotate(getangle(v(i,List) ) )    scale(lerp(List[i][3],List[i+1][3],lrp1)) linear_extrude(height = sth) polygon(profile);
ttranslate(lerp(List[i ],List[i + 1],lrp2)) rotate(getangle(v(i,List) ) )    scale(lerp(List[i][3],List[i+1][3],lrp2)) linear_extrude(height = sth) polygon(profile);

color("green")
ttranslate(List[i + 1]) rotate((getangle(v(i,List)) + getangle(v(i+1,List))) / 2) scale(lerp(List[i][3],List[i+1][3],lrp3))  scale(grove)  linear_extrude(height = sth) polygon(profile);
      
} else if(i == len(List) - 2) {

color("red")
ttranslate(List[i ])  rotate((getangle(v(i-1,List)) + getangle(v(i,List))) / 2)   scale(lerp(List[i][3],List[i+1][3],lrp0)) scale(grove)  linear_extrude(height = sth) polygon(profile);


ttranslate(lerp(List[i ],List[i + 1],lrp1)) rotate(getangle(v(i,List) ) )    scale(lerp(List[i][3],List[i+1][3],lrp1)) linear_extrude(height = sth) polygon(profile);
ttranslate(lerp(List[i ],List[i + 1],lrp2)) rotate(getangle(v(i,List) ) )    scale(lerp(List[i][3],List[i+1][3],lrp2)) linear_extrude(height = sth) polygon(profile);

color("green")
ttranslate(List[i+1]) rotate(getangle(v(i,List))) scale(lerp(List[i][3],List[i+1][3],lrp3))  scale(grove)  linear_extrude(height = sth) polygon(profile);

      } 
 else {
//echo(getangle(v(i,List)));
color("red")
ttranslate(List[i ])  rotate((getangle(v(i-1,List)) + getangle(v(i,List))) / 2)   scale(lerp(List[i][3],List[i+1][3],lrp0)) scale(grove)  linear_extrude(height = sth) polygon(profile);


ttranslate(lerp(List[i ],List[i + 1],lrp1)) rotate(getangle(v(i,List) ) )    scale(lerp(List[i][3],List[i+1][3],lrp1)) linear_extrude(height = sth) polygon(profile);
ttranslate(lerp(List[i ],List[i + 1],lrp2)) rotate(getangle(v(i,List) ) )    scale(lerp(List[i][3],List[i+1][3],lrp2))  linear_extrude(height = sth) polygon(profile);

color("green")
ttranslate(List[i + 1]) rotate((getangle(v(i,List)) + getangle(v(i+1,List))) / 2)scale(lerp(List[i][3],List[i+1][3],lrp3))   scale(grove)  linear_extrude(height = sth) polygon(profile);
 
     }
    }
  }
}
module ttranslate(v){
          for (j=[0:$children-1]) 
      translate(t(v))  children(j);
    }
    
function getangle(v) = (len(v) == 3||len(v) == 4) ? [0, 90, 0] + geteuler(lim3(1, v)): [90, 0, 0] + [0, 0, -atan2(v[0], v[1])];
function lerp(start,end,bias ) = (end * bias + start * (1 - bias));
function geteuler(v) = [0, -asin(v[2]), atan2(v2xy(v)[1], v2xy(v)[0])]; //Euler angles from Vec3
function v2xy(v) = lim3(1, [v[0], v[1], 0]); // down projection xyz2xy
function lim3(l, v) = v / len3(v) * l; // normalize Vec37Vec4 to magnitude l
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2)); // find magnitude of Vec3
function v(i,v)=v[i+1]-v[i]; // vec3 from polyline segment
function t(v) = [v[0], v[1], v[2]];// purge vec4... down to vec3 (for translate to play nice)  
  
// Bline module
module DistrubuteAlong(v,d=8,start=0,stop=1) {
         detail=1/d;
     if($children>0)for(i3 = [start: detail: stop+detail]) {
         i2=i3>stop?stop:i3;
         i=bz2t(v,len3bz(v)*i2,0.01);
        translate([bez2(i  , v)[0],bez2(i  , v)[1],bez2(i  , v)[2]])rotate(bez2euler (i,v))           scale(bez2(i  , v)[3])children();
           
        
      
    }
  }
  //The recusive
  
  
module knuckel(){
    rotate(rndR())translate([0,0,1])rotate([90,0,0])sphere(4,$fn=5);rotate(rndR())translate([0,0,1])rotate([90,0,0])sphere(3,$fn=5)    ;rotate(rndR())translate([0,0,3])rotate([90,0,0])sphere(3,$fn=5);}

function bz2t(v,stop,precision=0.01,t=0,acc=0)=
    acc>=stop||t>1?
    t:
    bz2t(v,stop,precision,t+precision,acc+len3(bez2(t,v)-bez2(t+precision,v)));

function len3bz(v,precision=0.01,t=0,acc=0)=t>1?acc:len3bz(v,precision,t+precision,acc+len3(bez2(t,v)-bez2(t+precision,v)));

function bez2(t, v) = (len(v) > 2) ? bez2(t, [
  for(i = [0: len(v) - 2]) v[i] * t + v[i + 1] * (1 - t)
]): v[0] * t + v[1] * (1 - t);
function lim31(l, v) = v / len3(v) * l;
function un(v) = v / len3(v) * 1;
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
function bez2euler(i, v) = [0, -asin(bez2v(i, v)[2]), atan2(bez2xy(bez2v(i, v))[1], bez2xy(bez2v(i, v))[0])];
function bez2xy(v) = lim31(1, [v[0], v[1], 0]); // down xy projection
function bez2v(i, v) = lim31(1, bez2(i - 0.0001, v) - bez2(i, v)); // unit vector at i
function t(v) = [v[0], v[1], v[2]];
function rndR()=[rands(0,360,1)[0],rands(0,360,1)[1],rands(0,360,1)[0]];
function rndV()=[rands(-1,1,1)[0],rands(-1,1,1)[0],rands(-1,1,1)[0]];
function midpoint(start,end) = start + (end  - start )/2;
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];

  // the total lenght op multisegment vektor
    function len3v(v,acc=0,p=0)=p+1>len(v)-1?acc:len3v(v,acc+len3(v[p]-v[p+1]),p+1)  ;
 // floor for four
  function floor3(v)=[floor(v[0]),floor(v[1]),floor(v[2]),floor(v[3])];

  // lenght along vetorlist to point 
  function v2t(v,stop,p=0)=p+1>len(v)-1|| stop<len3(v[p]-v[p+1])?   v[p]+un(v[p+1]-v[p])*stop:  v2t(v,stop-len3(v[p]-v[p+1]),p+1);
function vsmooth(v) = [  for(i = [0: 1 / len(v)*0.5: 1]) bez2(i,v)];