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
controlpoints=3;//[1:20]
thickest=15;//[5:50]
detail = 10; //[0.01:0.001:0.5]
fn = 10; //[8:30]
rad=5;//[1:0.5:12]
tang=2;//[1:10]
//some random 4D points
v1 = [
  for(i = [0: controlpoints])[floor(rands(0, 20, 1)[0]+ i*30),floor( rands(0, 200, 1)[0]),floor( rands(0, 200, 1)[0]), i==0||i==controlpoints?15:floor(rands(0, 40, 1)[0])]
];

  v2 = [
  for(i = [0: controlpoints])[0,i==0||i==controlpoints?1:1,rands(-360, 360, 1)[0], i==0||i==controlpoints?1:rands(5, 5, 1)[0]]
];
  
  
    v3 = [
  for(i = [0: controlpoints])[0,1,rands(-360, 360, 1)[0], rands(1, 2, 1)[0]]
];
  
function  subdv(v)=[
  let(last=(len(v)-1)*3)
  for (i=[0:last])
      let(j=floor((i+1)/3))
  
  i%3 == 0?
    v[j]
  :
    i%3  == 2?
       v[j]- un(un(pre(v,j))+un(post(v,j)))*(len3(pre(v,j))+len3(post(v,j)))*0.13
        :
       v[j] +un(un(pre(v,j)) +un(post(v,j)))*(len3(pre(v,j))+len3(post(v,j)))*0.13
 
  ]
  ;
  function pre(v,i)= i>0?         (v[i]-v[i-1]):[0,0,0,0];
  function post(v,i)=i<len(v)-1?  (v[i+1]-v[i]):[0,0,0,0] ;
  //((v[i+1]-v[1])/len3(v[i+1]-v[1])*0.3)
  //((v[i-1]-v[1])/len3(v[i-1]-v[1])*0.3)
echo(  subdv(v1));
  
v100=subdv(v1);
  v1000=subdv(v100);
 ShowControl(v1);
 %     ShowControl(v100);
      * ShowControl(v1000);
  for (i=[0:1/20:1]){
        //translate(t(v2t(v1,len3v(v1)*i)))
  *    translate( t(v2t(v1,len3v(v1)*i)))
sphere(10);
  }
//main call
  

color("darkred")*for(j=[1:8]){color("red")
  
 DistrubuteAlong2(v100,v2,20,0,1,[0,0,j*45,0]){
translate([0,0,1]) scale(0.3)rotate([0,90,0]) sphere(r=1,$fn=10,center=true);  
    
    }}
    
    
# color(rndc())  
extrudeT(v100,25){translate([0,0,0]) scale(1) rotate([0,90,0])sphere(r=1,$fn=10,center=true);  }
  for(j=[0:8]){color(rndc())  
 *DistrubuteAlong2(v100,v2,40,0.05,0.95,[0,0,j*45,0]){
translate([0,0,1]) scale(1) rotate([0,90,0])sphere(r=1,$fn=10,center=true);  

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
function un(v) = v / max(len3(v),0.000001) * 1;
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
