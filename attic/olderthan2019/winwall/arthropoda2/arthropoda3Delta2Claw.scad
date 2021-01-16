


Claw = [
  
    [0,-0,  0,[1,1,1]], //claw
  [12.5,-2.5,  -10,[1,1,1]],// Tarsomeres
  [10,-7.5, -10,[1,1,1]],// Tarsomeres
  [5,  -12.5,-10,[0.6,0.5,1]],// Tarsomeres
  [-5,  -17,-10,[0.1,0.1,1]] //claw


];
Leg = [
    [0,0,20,[4,4,1]],
    [16,0,-26,[3,4,1]],
	[55, 0, 0, [3,3,1]],
	[20, 0, 9, [4,3,1]],
	[5, 0, -5, [3,1,1]],
	[20, 0, 0, [3,3,1]],
	[55, 0, -100, [2,2,0.9]],
	[-105, 0, -50, [1,1,0.5] ,claw()],
	[-1, 0, -1, [1,1,0.5] ]
	
];

V3d = [
	[0, 0, 0, [1,2,0.5],claw()],
	[-25,0 , 45, [2,6,1],claw()  ],
	[-5, 0, 52, [5,8,1] ,claw() ],
	[40, 0, 18, [8,8,1] ,claw()],// cephalon
	[20, 0, 0, [10,10,1],claw()],// cephalon
	[20, 0, -5, [12,12,1],leg()],
    
   	[50, 0, -5, [10,12,1],leg()],// Thorax1
	[50, 0, -5, [12,15,1],leg()],// Thorax2
	[50, 0, -5, [12,15,1],leg()],// Thorax3
 
	[50, 0, -5, [7,12,0.5]],// Thorax4
	[50, 0, 0, [4,4,0.5] ],// Thorax5
//
	[100, 0, 70, [20,20,0.9]],//Abdomen
	[100, 0, 70, [20,20,0.9],claw() ],//Abdomen
	[150, 0, 30, [15,15,0.9],claw() ],//Abdomen
	[100, 0, 20, [1,1,1],claw()],//Abdomen	
[1, 0, 1, [0.1,0.1,0.1]]
];

profile = [
  [5, 5],
  [0,6],
[-5, 5],
[-7,2],
[-7,-2],
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
Locpos=sumv(List,i);
LocScale=lerp(List[i][3],List[i+1][3],0.5);
      
//
//ttranslate(lerp(List[i ],List[i + 1],0.5))rotate(getanglexz(v(i,List)))     translate([profile[6][0]*LocScale[0],profile[6][1]*LocScale[1],0])color("yellow")sphere(2);
//
//
 if (List[i][4]!=undef){
mirrorcopy()
 ttranslate(lerp(Locpos,Locpos+List[i+1],0.5))   
     translate([0,profile[3][1]*LocScale[1],profile[3][0]*LocScale[0]])rotate([0,0,0])color("yellow")rotate([0,0,90]){bodypart(profile, List[i][4] );
     sphere(5);
     }}
      
 grove1=List[i][3][2]  ;  
 grove2=List[i+1][3][2]  ;  
 # hull() {
      if(i == 0) {
        
color("blue")
ttranslate(Locpos)
         rotate(getanglexz( List[i+1] )) 
          
          scale(List[i][3]) 
         //scale(lerp(List[i][3],List[i+1][3],lrp0)) scale(grove1) 
          linear_extrude(height = sth) polygon(profile);
//ttranslate(lerp(Locpos,Locpos+List[i +1],lrp1))
//        rotate(getanglexz( List[i] )) 
//          //scale(lerp(Locpos[3],Locpos+List[i][3],lrp1)) 
//          linear_extrude(height = sth) polygon(profile);
//ttranslate(lerp(Locpos,Locpos+List[i+1],lrp2)) 
//          rotate(getanglexz( List[i+1] )) 
//          linear_extrude(height = sth) polygon(profile);
ttranslate(Locpos+List[i+1]) 
         //rotate((getanglexz( List[i] )+getanglexz( List[i+1] ))/2) 
        rotate((getanglexz( List[i+1]+List[i+2] ) ))
scale(List[i+1][3]) 
          //scale(lerp(List[i][3],List[i+1][3],lrp3))  scale(grove2) 
          linear_extrude(height = sth) polygon(profile);
      
} else if(i == len(List) - 2) {

color("red")
ttranslate(Locpos)    
   rotate((getanglexz( List[i]+List[i+1] ) ))
    scale(List[i][3]) 
//scale(lerp(List[i][3],List[i+1][3],lrp0)) scale(grove1) 
    linear_extrude(height = sth) polygon(profile);

//ttranslate(lerp(Locpos,Locpos+List[i + 1],lrp1)) 
//    rotate(getanglexz( List[i] ))   
////scale(lerp(List[i][3],List[i+1][3],lrp1))
//    linear_extrude(height = sth) polygon(profile);
//ttranslate(lerp(Locpos,Locpos+List[i + 1],lrp2)) 
//    rotate(getanglexz( List[i+i] ))  
////scale(lerp(List[i][3],List[i+1][3],lrp2)) 
//    linear_extrude(height = sth) polygon(profile);
ttranslate(Locpos+List[i+1]) 
          rotate((getanglexz( List[i+1] ) ))
    scale(List[i+1][3]) 
//scale(lerp(List[i][3],List[i+1][3],lrp3))  scale(grove2)  
    linear_extrude(height = sth) polygon(profile);

      } 
 else {
//echo(getanglexz(v(i,List)));
color("red")
ttranslate(Locpos) 
    rotate((getanglexz( List[i]+List[i+1] ) ))
  scale(List[i][3]) //scale(grove1)
     linear_extrude(height = sth) polygon(profile);
//
//
//ttranslate(lerp(Locpos,Locpos+List[i+1],lrp1))
//   rotate(getanglexz( List[i] )) 
// //scale(lerp(List[i][3],List[i+1][3],lrp1))
//     linear_extrude(height = sth) polygon(profile);
//ttranslate(lerp(Locpos,Locpos+List[i +1 ],lrp2)) 
//     rotate(getanglexz( List[i+1] )) 
// //scale(lerp(List[i][3],List[i+1][3],lrp2))
//     linear_extrude(height = sth) polygon(profile);
//
//color("green")
ttranslate(Locpos+List[i+1]) 
           rotate((getanglexz( List[i+1]+List[i+2] ) ))
scale(List[i+1][3]) //  scale(grove2) 
     linear_extrude(height = sth) polygon(profile);
 
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
function claw(extention)=Claw;
module ttranslate(v){
          for (j=[0:$children-1]) 
      translate(t(v))  children(j);
    }
function sumv(v,i)= i==0?v[0]:v[i]+sumv(v,i-1);    
function getanglexz(v) = geteulerxz(lim3(1, t(v)));    
function getangle(v) = (len(v) == 3||len(v) == 4) ? [0, 90, 0] + geteuler(lim3(1, v)): [90, 0, 0] + [0, 0, -atan2(v[0], v[1])];
function lerp(start,end,bias ) = (end * bias + start * (1 - bias));
function geteuler(v) = [0, -asin(v[2]), atan2(v2xy(v)[1], v2xy(v)[0])]; //Euler angles from Vec3
function geteulerxz(v) = [0, atan2(v[0], v[2]), 0]; //Euler angles from Vec3
function v2xy(v) = lim3(1, [v[0], v[1], 0]); // down projection xyz2xy
function lim3(l, v) = v / len3(v) * l; // normalize Vec37Vec4 to magnitude l
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2)); // find magnitude of Vec3
function v(i,v)=v[i+1]-v[i]; // vec3 from polyline segment
function t(v) = [v[0], v[1], v[2]];// purge vec4... down to vec3 (for translate to play nice)
function delta(v) = [
  for(i = [1:len(v) -1]) v[i]-v[i-1]
];