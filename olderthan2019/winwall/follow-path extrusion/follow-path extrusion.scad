function getangle(v) = (len(v) == 3||len(v) == 4) ? [0, 90, 0] + geteuler(lim3(1, v)): [90, 0, 0] + [0, 0, -atan2(v[0], v[1])];
function lerp(start,end,bias ) = (end * bias + start * (1 - bias));
function geteuler(v) = [0, -asin(v[2]), atan2(v2xy(v)[1], v2xy(v)[0])]; //Euler angles from Vec3
function v2xy(v) = lim3(1, [v[0], v[1], 0]); // down projection xyz2xy
function lim3(l, v) = v / len3(v) * l; // normalize Vec37Vec4 to magnitude l
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2)); // find magnitude of Vec3
function v(i,v)=v[i+1]-v[i]; // vec3 from polyline segment
function t(v) = [v[0], v[1], v[2]];// purge vec4... down to vec3 (for translate to play nice)
function rnd(a,b)=a+(rands(0,1,1)[0])*(b-a);     

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// FollowPath Extrusion
// (c) 2013 Wouter Robers
path3d = [
  [rnd, 23.3115, 77.6378,1],
  [-41.9771, -26.9999, 44.4277,3],
  [-60.9717, -35.7994, -74.2041,1],
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

FollowPath(profile, path3d );
module FollowPath(shape, path, grove=0.8,lrp1=0.2,lrp2=0.8) {
    lrp0=0;
    lrp3=1;
   shapethickness = 0.001;
  for(i = [0: len(path) - 2]) {
    hull() {
      if(i == 0) {
          
color("red")
ttranslate(path[i]) rotate(getangle(v(i,path)))  scale(lerp(path[i][3],path[i+1][3],lrp0)) scale(grove)  linear_extrude(height = shapethickness) polygon(shape);
ttranslate(lerp(path[i ],path[i + 1],lrp1)) rotate(getangle(v(i,path) ) )    scale(lerp(path[i][3],path[i+1][3],lrp1)) linear_extrude(height = shapethickness) polygon(shape);
ttranslate(lerp(path[i ],path[i + 1],lrp2)) rotate(getangle(v(i,path) ) )    scale(lerp(path[i][3],path[i+1][3],lrp2)) linear_extrude(height = shapethickness) polygon(shape);

color("green")
ttranslate(path[i + 1]) rotate((getangle(v(i,path)) + getangle(v(i+1,path))) / 2) scale(lerp(path[i][3],path[i+1][3],lrp3))  scale(grove)  linear_extrude(height = shapethickness) polygon(shape);
      
} else if(i == len(path) - 2) {

color("red")
ttranslate(path[i ])  rotate((getangle(v(i-1,path)) + getangle(v(i,path))) / 2)   scale(lerp(path[i][3],path[i+1][3],lrp0)) scale(grove)  linear_extrude(height = shapethickness) polygon(shape);


ttranslate(lerp(path[i ],path[i + 1],lrp1)) rotate(getangle(v(i,path) ) )    scale(lerp(path[i][3],path[i+1][3],lrp1)) linear_extrude(height = shapethickness) polygon(shape);
ttranslate(lerp(path[i ],path[i + 1],lrp2)) rotate(getangle(v(i,path) ) )    scale(lerp(path[i][3],path[i+1][3],lrp2)) linear_extrude(height = shapethickness) polygon(shape);

color("green")
ttranslate(path[i+1]) rotate(getangle(v(i,path))) scale(lerp(path[i][3],path[i+1][3],lrp3))  scale(grove)  linear_extrude(height = shapethickness) polygon(shape);

      } 
 else {
echo(getangle(v(i,path)));
color("red")
ttranslate(path[i ])  rotate((getangle(v(i-1,path)) + getangle(v(i,path))) / 2)   scale(lerp(path[i][3],path[i+1][3],lrp0)) scale(grove)  linear_extrude(height = shapethickness) polygon(shape);


ttranslate(lerp(path[i ],path[i + 1],lrp1)) rotate(getangle(v(i,path) ) )    scale(lerp(path[i][3],path[i+1][3],lrp1)) linear_extrude(height = shapethickness) polygon(shape);
ttranslate(lerp(path[i ],path[i + 1],lrp2)) rotate(getangle(v(i,path) ) )    scale(lerp(path[i][3],path[i+1][3],lrp2))  linear_extrude(height = shapethickness) polygon(shape);

color("green")
ttranslate(path[i + 1]) rotate((getangle(v(i,path)) + getangle(v(i+1,path))) / 2)scale(lerp(path[i][3],path[i+1][3],lrp3))   scale(grove)  linear_extrude(height = shapethickness) polygon(shape);
 
     }
    }
  }
}
module ttranslate(v){
          for (j=[0:$children-1]) 
      translate(t(v))  children(j);
    }