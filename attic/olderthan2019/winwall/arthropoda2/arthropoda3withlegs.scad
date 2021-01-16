

Leg = [
  [-20, 0, 00,[5,2,1]],
  [35,0, 0,[7,3,1]],// Coxa
  [55,  0,9,[4,3,1]],//Trochanter
  [160,0, 100, [3,,1]],//Femur  
  [180, 0,100,[3,3,1] ],//Patella
  [235,0,00,[2,2,0.9]],//Tibia  
  [250,0,-150,[1,1,0.5]],//Tibia
  //[300,0,-60,  [2,1,1]],//Tarsus
 // [350, 0, -55,[2,1,1]],// Tarsomeres
 // [375, 0, -55,[2,1,1]],// Tarsomeres
  //[400,0,  -50,[3,1,1]],// Tarsomeres
 //[450,  0,-70,[1,1,1]], //claw
];
Claw = [
    [290,  -120,0,[0.1,0.1,0-1]], //claw
  [275,  -100,0,[1,1,1]],// Tarsomeres
  [270,  -85,0,[1,1,1]],// Tarsomeres
  [265,  -70,0,[1,1,1]],// Tarsomeres

  [270,-40, 0, [2,2,2]],//Tarsus
  //[290,  -60,0,[1,1,1]],// Tarsomeres
  //[305,  -85,0,[1,1,1]],// Tarsomeres
  //[305,  -100,0,[1,1,1]],// Tarsomeres
 [300,  -120,0,[0.1,0.1,0-1]], //claw
];
V3d = [
  [-100, 0,-105,[1,2,0.5]],// cephalon
  [-125, 0,-60,[2,6,1]],// cephalon
  [-130, 0,-8,[5,8,1]],// cephalon
  [-90, 0, 10,[8,8,1]],// cephalon
  [-70, 0, 10,[10,10,1]],// cephalon
  [-50, 0,5, [12,12,1],leg()],// cephalon

  [0, 0, 0,[10,12,1],leg()],// Thorax1
  [50, 0, 0,[12,15,1],leg()],// Thorax2
  [100, 0, 0,[12,15,1],leg()],// Thorax3
  [150, 0, 0,[7,12,0.5]],// Thorax4
 // [200, 0, 0,[4,4,0.5]],// Thorax5

  [250, 0, 70,[20,20,0.9]],//Abdomen
  [400, 0, 100,[15,15,0.9]],//Abdomen
  [500, 0, 120,[1,1,1]]//Abdomen
];

profile = [
  [5, 5],
  [0,6],
[-5, 5],
[-7,0],
[-5, -5],
[0,-6],
[5, -5],
[7,0]

];

bodypart(profile, V3d );
module bodypart(profile, List, grove=0.7,lrp1=0.3,lrp2=0.8) {
    lrp0=0;
    lrp3=1;
   sth = 0.001;
  for(i = [0: len(List) - 2]) {
LocScale=lerp(List[i][3],List[i+1][3],0.5);

ttranslate(lerp(List[i ],List[i + 1],0.5))rotate(getanglexz(v(i,List)))     translate([profile[6][0]*LocScale[0],profile[6][1]*LocScale[1],0])color("yellow")sphere(2);


 if (List[i][4]!=undef){
   mirrorcopy()
ttranslate(lerp(List[i ],List[i + 1],0.5))    translate([profile[6][0]*LocScale[0],profile[6][1]*LocScale[1],0])rotate([0,0,0])color("yellow")rotate([0,0,i*20+140])bodypart(profile, List[i][4] );}
      
 grove1=List[i][3][2]  ;  
 grove2=List[i+1][3][2]  ;  
 #  hull() {
      if(i == 0) {
        
color("red")
ttranslate(List[i]) rotate(getanglexz(v(i,List)))  scale(lerp(List[i][3],List[i+1][3],lrp0)) scale(grove1)  linear_extrude(height = sth) polygon(profile);
ttranslate(lerp(List[i ],List[i + 1],lrp1)) rotate(getanglexz(v(i,List) ) )    scale(lerp(List[i][3],List[i+1][3],lrp1)) linear_extrude(height = sth) polygon(profile);
ttranslate(lerp(List[i ],List[i + 1],lrp2)) rotate(getanglexz(v(i,List) ) )    scale(lerp(List[i][3],List[i+1][3],lrp2)) linear_extrude(height = sth) polygon(profile);

color("green")
ttranslate(List[i + 1]) rotate((getanglexz(v(i,List)) + getanglexz(v(i+1,List))) / 2) scale(lerp(List[i][3],List[i+1][3],lrp3))  scale(grove2)  linear_extrude(height = sth) polygon(profile);
      
} else if(i == len(List) - 2) {

color("red")
ttranslate(List[i ])  rotate((getanglexz(v(i-1,List)) + getanglexz(v(i,List))) / 2)   scale(lerp(List[i][3],List[i+1][3],lrp0)) scale(grove1)  linear_extrude(height = sth) polygon(profile);


ttranslate(lerp(List[i ],List[i + 1],lrp1)) rotate(getanglexz(v(i,List) ) )    scale(lerp(List[i][3],List[i+1][3],lrp1)) linear_extrude(height = sth) polygon(profile);
ttranslate(lerp(List[i ],List[i + 1],lrp2)) rotate(getanglexz(v(i,List) ) )    scale(lerp(List[i][3],List[i+1][3],lrp2)) linear_extrude(height = sth) polygon(profile);

color("green")
ttranslate(List[i+1]) rotate(getanglexz(v(i,List))) scale(lerp(List[i][3],List[i+1][3],lrp3))  scale(grove2)  linear_extrude(height = sth) polygon(profile);

      } 
 else {
//echo(getanglexz(v(i,List)));
color("red")
ttranslate(List[i ])  rotate((getanglexz(v(i-1,List)) + getanglexz(v(i,List))) / 2)   scale(lerp(List[i][3],List[i+1][3],lrp0)) scale(grove1)  linear_extrude(height = sth) polygon(profile);


ttranslate(lerp(List[i ],List[i + 1],lrp1)) rotate(getanglexz(v(i,List) ) )    scale(lerp(List[i][3],List[i+1][3],lrp1)) linear_extrude(height = sth) polygon(profile);
ttranslate(lerp(List[i ],List[i + 1],lrp2)) rotate(getanglexz(v(i,List) ) )    scale(lerp(List[i][3],List[i+1][3],lrp2))  linear_extrude(height = sth) polygon(profile);

color("green")
ttranslate(List[i + 1]) rotate((getanglexz(v(i,List)) + getanglexz(v(i+1,List))) / 2)scale(lerp(List[i][3],List[i+1][3],lrp3))   scale(grove2)  linear_extrude(height = sth) polygon(profile);
 
     }
    }
  }
}
module mirrorcopy(vec=[0,1,0]) 
{ union(){
children(); 
mirror(vec) children(); }
}
function leg(extention)=Leg;
function claw(extention)=concat(Claw,extention);
module ttranslate(v){
          for (j=[0:$children-1]) 
      translate(t(v))  children(j);
    }
function getanglexz(v) = (len(v) == 3||len(v) == 4) ? [0, 0, 0] + geteulerxz(lim3(1, v)): [90, 0, 0] + [0, 0, -atan2(v[0], v[1])];    
function getangle(v) = (len(v) == 3||len(v) == 4) ? [0, 90, 0] + geteuler(lim3(1, v)): [90, 0, 0] + [0, 0, -atan2(v[0], v[1])];
function lerp(start,end,bias ) = (end * bias + start * (1 - bias));
function geteuler(v) = [0, -asin(v[2]), atan2(v2xy(v)[1], v2xy(v)[0])]; //Euler angles from Vec3
function geteulerxz(v) = [0, atan2(v[0], v[2]), 0]; //Euler angles from Vec3
function v2xy(v) = lim3(1, [v[0], v[1], 0]); // down projection xyz2xy
function lim3(l, v) = v / len3(v) * l; // normalize Vec37Vec4 to magnitude l
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2)); // find magnitude of Vec3
function v(i,v)=v[i+1]-v[i]; // vec3 from polyline segment
function t(v) = [v[0], v[1], v[2]];// purge vec4... down to vec3 (for translate to play nice)