$fn = 20;
//[[X,Y,Radius],[X,Y,Radius],[ [ X,Y,Radius ],[ X,Y,Radius ] ]] : Bracket holes togethter for slots
 
Plate1 = [
[-20+rnd(50),rnd(-50,50),3+rnd(10)],
[-10+rnd(150),rnd(-50,50),3+rnd(5)],
[-10+rnd(150),rnd(-50,50),3+rnd(5)],
   [
[-10+rnd(50),rnd(-50,50),3+rnd(5)],
[-10+rnd(50),rnd(-50,50),3+rnd(5)],
   ]
];
Plate2 = [
[20-rnd(50),rnd(-50,50),3+rnd(10)],
[10-rnd(150),rnd(-50,50),3+rnd(5)],
[-10-rnd(50),rnd(-50,50),3+rnd(5)],
   [
[10-rnd(50),rnd(-50,50),3],
[10-rnd(50),rnd(-50,50),3],
   ]
];
Thickness = 3;
Aroundhole = 5;
MaxX=300;
MaxY1=150;
MaxY2=90;
Plate1offset = [-30, 10, 0];
Plate2offset = [30, 0, 00];
Platerelativerotation = -45+rnd(180);
Plate1internalrotation =   -90+rnd(180);
Plate2internalrotation =  -90+rnd(180);
/*[hidden]*/
Plate2relativerotation = [0, Platerelativerotation,0];

 
union(){ 
translate([Plate1offset[0],0,0])

union(){

difference(){
intersection(){
hull(){intersection(){

profile(Thickness,Aroundhole,Plate2relativerotation);

union(){plates(Plate1,Plate2,Thickness,Aroundhole,Plate1offset,Plate2offset);
rotate(Plate2relativerotation)plates(Plate1,Plate2,Thickness,Aroundhole,Plate1offset,Plate2offset);}
}

}
profile(Thickness,Aroundhole,Plate2relativerotation);
}

union(){holes();
rotate(Plate2relativerotation)holes();}

}}}


module plates(Plate1,Plate2,Thickness,Aroundhole,Plate1offset,Plate2offset){
  linear_extrude(Thickness*2, center = true,convexity=10)  
difference(){

hull(){
translate(-Plate1offset)offset(r=Aroundhole) makeplate(Plate1,0);
translate(-Plate2offset)offset(r=Aroundhole) rotate([0,0,90]) makeplate(Plate2,0);
}
union(){
translate(-Plate1offset)offset(r=-1)offset(r=1) makeplate(Plate1,0);
translate(-Plate2offset)offset(r=-1)offset(r=1) rotate([0,0,90])makeplate(Plate2,0);
}
}

} 

 module holes(){
  linear_extrude(Thickness*2, center = true,convexity=10)  
difference(){

 
union(){
translate(-Plate1offset)offset(r=-1)offset(r=1) rotate([0,0,Plate1internalrotation])makeplate(Plate1,0);
translate(-Plate2offset)offset(r=-1)offset(r=1) rotate([0,0,Plate2internalrotation])makeplate(Plate2,0);
}
}

}  
module profile (Thickness,Aroundhole,Plate2relativerotation){rotate([90,0,0]){
linear_extrude(MaxX,center=true,convexity=10){
offset(r=-3)offset(r=Thickness+2)union(){hull(){
translate([MaxY1,0])square([Aroundhole,1],center=true);
circle(1*0.5);}
hull(){rotate([0,0,-Plate2relativerotation[1]])
translate([-MaxY2,0])square([Aroundhole,1],center=true);
circle(1*0.5);}}}

}}


module makeplate(P, A) {
   for (i = [0: len(P) - 1]) {
       if (len(P[i][0]) == undef) {
         translate([P[i][0], P[i][1], 0]) circle(P[i][2] + A);
      } else {
         hull() {
            for (j = [0: len(P[i]) - 1]) {
               translate([P[i][j][0], P[i][j][1], 0]) circle(P[i][j][2] + A);
            }
         }
      }
   }
}


function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);

function rndc(seed) =seed==undef? [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]]:[rands(0, 1, 1,seed)[0], rands(0, 1, 1,seed+101)[0], rands(0, 1, 1,seed+201)[0]];

