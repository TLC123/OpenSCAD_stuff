segment=[15,0,0,[1,1,1]];
downsegment=[-5,0,-5,[1,1,1]];
body = [
	[segment, [
		[segment, [lleg(), rleg()]], lleg(),
		rleg()
	]],
	[downsegment, [lleg(), rleg()]]
];
V3d =[[segment, [[segment,body]]]];
function lleg()=[[0,10,5,[1,1,1]],[[[0,10,-10,[1,1,1]]]]];
function rleg()=[[0,-10,5,[1,1,1]],[[[0,-10,-10,[1,1,1]]]]];

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
module bodypart(profile, List, root=[0,0,0]) {
for(i = [0: len(List) - 1]) {

line(t(root),t(root+List[i][0] )) ;
 echo(i,root,List[i][0]);
bodypart(profile,List[i][1] ,root+List[i][0]);

 }
}
module line(s,f,h=2){
  hull() {
    translate(t(s)) sphere(h);
    translate(t(f)) sphere(h / 2);
  }
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