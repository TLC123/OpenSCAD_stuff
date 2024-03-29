

Leg = [
    [290,  -120,0,[0.1,0.1,0-1]], //claw
  [275,  -100,0,[1,1,1]],// Tarsomeres
  [270,  -85,0,[1,1,1]],// Tarsomeres
  [265,  -70,0,[1,1,1]],// Tarsomeres

  [270,-40, 0, [2,2,2]],//Tarsus
  [290,  -60,0,[1,1,1]],// Tarsomeres
  [305,  -85,0,[1,1,1]],// Tarsomeres
  [305,  -100,0,[1,1,1]],// Tarsomeres
 [300,  -120,0,[0.1,0.1,0-1]], //claw
];


profile = [
  [5, 5],
  [0,6],
[-5, 5],
[-6,0],
[-5, -5],
[0,-6],
[5, -5],
[6,0]
];


bodypart ( profile, Leg );
    

module bodypart(profile, List, grove=1,lrp1=0.3,lrp2=0.7) {
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
echo(getangle(v(i,List)));
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