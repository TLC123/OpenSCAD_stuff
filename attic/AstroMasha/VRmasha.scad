 include <polyround2019.scad>;
// 60fps 3000steps
  vMinLimit=vMinLimit();
  vMaxLimit=vMaxLimit();
  posecount=199;

 vv=[for(j=[0:posecount]) [for(i=[0:15])rands(-25,25,3,i+10001+j)] ];
iv=[ for(i=[0:posecount]) round(rands(0,1,1,10000+i)[0]) ];
   
T=$t*posecount;
m= (smooth(T-floor(T)));
im=1-m;
randompose= lerp(vv[floor(T)]  ,vv[ceil(T)],m) ;
 
 
pose1= [
[90,0,0],  [-20,0,0],  [-30,10,-10],  [-0,10,-10], 
[-10,-25,0], [10,0,0],  [0,0,0],  
[-10,-25,0],  [10,0,0],  [0,0,0],
[-10,-40,-10],  [-40,0,0], [0,0,0],
[-10,-40,-10],[-40,0,0], [-00,10,50]];  
pose2= [
[-90,0,0],  [5,0,0],  [10,10,-30],  [-0,10,-10], 
[-10,12,0], [50,0,0],  [0,-5,10],  
[-10,12,0],  [40,0,0],  [0,-5,10],
[10,-10,30],  [-10,40,-40], [30,-50,30],
[10,-30,20],[-10,40,-40], [30,-30,30]];  

pose3= [
[0,90,0],  [0,0,0],  [-0,-30,-20],  [-0,10,-10], 
[10,0,0], [40,0,0],  [10,0,0],  
[-30,10,0],  [90,0,0],  [0,30,0],
[-10,-0,-0],  [-40,0,0], [0,0,0],
[-0,40,-0],[-40,40,0], [-20,0,0]];  
pose4= [
[0,-90,0],  [0,0,0],  [-0,30,20],  [-0,10,-10], 
[-30,10,0],  [70,0,0],  [0,0,0],
[10,0,0], [40,0,0],  [30,0,0],
[-0,40,-0],[-40,40,0], [-30,0,0],  
[-10,-0,-0],  [-40,0,0], [0,0,0]];  
 pose5= [
[0,0,0],  [10,0,0],  [-0,-0,-0],  [-0,10,-10], 
[-10,7,10], [30,0,0],  [0,0,0],  
[-10,7,10], [60,0,0],  [0,0,0],
[30,10,20],[-40,40,0], [20,0,0],
[30,10,20],[-40,40,0], [20,0,0]];  
 pose6= [
[180,0,0],  [-20,0,0],  [-20,-0,-0],  [-0,10,-10], 
[-20,-17,10], [90,0,0],  [0,0,0],  
[-20,-17,10], [90,0,0],  [0,0,0],
[-140,-30,20],[-60,0,0], [ 40,-20,-70],
[-140,-30,20],[-60,0,0], [ 40,-20,-70]]; 

//$vpt=[0,0,0];
//$vpr=[60+sin(90+$t*360*2)*10,0,90+$t*360*3];
//$vpd=700+sin($t*360)*50;

v= un(

[sin(-360+($t*3)*720),cos(-360+($t*5)*720)*2,sin(45-($t*3)*90)]+
[sin(-360+(80+$t*5)*720)*0.5,cos(-360+(130+$t*6)*720)*0.5,sin(45-(200+$t*4)*90)*0.5]


);
 
b= [max(0,v.y),max(0,-v.y),max(0,v.x),max(0,-v.x),max(0,v.z),max(0,-v.z)];
a=[for(i=b)gauss(i)];
mix=a/(a[0]+a[1]+a[2]+a[3]+a[4]+a[5]);
 pose= ((
 pose1*mix[0]+
 pose2*mix[1]+
 pose3*mix[2]+
 pose4*mix[3]+
 pose5*mix[4]+
 pose6*mix[5])*1.25  +randompose*1.25)
 
;
// echo( mix ,pose);
xrtamix=[for(i=[0:15])rands(-90,90,3  )];

 
 dancer(clampAngleVector(pose,vMinLimit,vMaxLimit));
 //dancer(clampAngleVector(xrtamix,vMinLimit,vMaxLimit));

 
 
 
 module dancer(pose){
  
tx=pose[0]; 
ab=pose[1]; 
hd=pose[2]*0.5 ; 
nc=pose[2]*0.5 ;
ll=pose[4]; 
lc=pose[5]; 
lf=pose[6]; 

rl=pose[7]; 
rc=pose[8]; 
rf=pose[6]; 

la=pose[10]; 
lu=pose[11]; 
lh=pose[12]; 

ra=pose[13]; 
ru=pose[14];
rh=pose[15];
 
      
  //color("red")  rotate_extrude( ){    translate([2000,0,0])  square(5,center=true); }
  rotate([0,89,0]){
 
 
    rotate([0,0,0])    color("yellow")translate([ 145,0,0]) rotate([0,-90,0])   {
        cylinder(20,20,20,center=true); 
      cylinder(23,18,18,center=true); }
 
  rotate([0,0,90])     color("yellow")translate([ 145,0,0]) rotate([0,-90,0])cylinder(20,6,6,center=true); 

   color("blue")  rotate_extrude(angle=90,$fn=80){
     
  color("red")   translate([145,0,0]) offset(r=3,chamfer=true,$fn=1)square(5,center=true);
     
     }}
 
     
     rotate([0,tx.y,0]){
 
 
    rotate([0,0,0])    color("yellow")translate([ 135,0,0]) rotate([0,-90,0])cylinder(20,5,5 ); 
 rotate([0,0,180])   color("yellow")translate([ 135,0,0]) rotate([0,-90,0])cylinder(20,5,5 ); 
  rotate([0,0,90])     color("yellow")translate([ 135,0,0]) rotate([0,-90,0])cylinder(12,7,7 ); 

   color("red")  rotate_extrude(angle=180,$fn=100){
     
  color("red")   translate([130,0,0]) offset(r=2,chamfer=true,$fn=1)square(5,center=true);
     
     }
     
          


     }
     

     
    rotate(   [tx.x,tx.y,0] ) translate([0,0,10])  {
        
              //footfloor
        
        {
 //"floor"hoop
al=(rl+ll)/2;
 
ac=(rc+lc)/2;
            
solvey=sin( 0+ ab.x   )*0   +sin( 0+ al.x   )*44   +  sin( 0+ ac.x   )*44           ;
solvex=  cos( 0+ab.x   )* 0   +cos(0+al.x) *44  +cos(0+ac.x) *44 ;
            bias=0.58;
ysolvey= lerp( sin( ab.y   ), sin(ab.y+  al.y   ),bias)  ;
ysolvex= lerp( cos( ab.y   ), cos( ab.y+ al.y)   ,bias) ; 
  
xsolution= ab.x+atan2(solvey,solvex) ;
ysolution=   atan2(ysolvey,ysolvex) ;
            
   color("darkgreen")translate([ -0,0, -10])  rotate([   xsolution ,0,0])  
    { 
        rotate([  -90  ,0,0])rotate_extrude(angle=180,$fn=100){
            translate([115,0,0])  square([1,8],center=true); }
//    rotate([0,ysolution,0]) { translate([0,0,-110])cylinder(1,25,25) ;} 
    
    }
    
    }
        
        
        
           
        
 
        
        
        
        
        
        
        
        
        
        
         
  color("lightblue") import ("torax.stl");
      color("red")    import ("toraxvest.stl");
 color("red")translate([0,12,22]) sphere(4);
 color("red")translate([5,10,10]) sphere(4);
 color("red")translate([-5,10,10]) sphere(4);
 
  color("yellow")polyline(   polyRound([[0,15,-5,0],[0,15,15,3] ,[0,0,15,3]   ],8),2); 
 color("yellow")polyline(
polyRound([[0,12,20,0],[0,15,15,0],[0,15,25,0] ]),3); 
color("yellow")polyline(
polyRound([[-5,12,10,0],[0,15,15,10],[-20,50,50,40], [-105,70,0,60],[-120,0,-10,0]],fn=16),3); 
color("yellow")polyline(
polyRound([[5,12,10,0],[0,15,15,10],[20,50,50,40], [105,70,0,60],[ 120,0,-10,0]],fn=16),3);
color("yellow")translate([ 120,0,-10]) rotate([0,90,0])cylinder(10,6,6,center=true); 
color("yellow")translate([ -120,0,-10]) rotate([0,90,0])cylinder(10,6,6,center=true);
       
      
      

        
 translate( [0, 3, 27] )rotate(nc) {
 color(skin()) import ("collum.stl");

translate([0, -1, 7]  ) rotate(hd){
 color(skin()) import ("head.stl");
  color("lightblue")  hull(){
    translate([0,-8,10])scale([2.5,1,0.5])rotate(67)rotate_extrude(angle=45)
        {translate([7,0,0])offset(1)square([2,2]);       
            }
    
 translate([0,-2,6])rotate(-135)rotate_extrude(angle=90)
        {translate([8,0,0])offset(1)square([4,6]);       
            }

}}
}



//left arm
 translate([10, 4.5, 22]) 

 rotate(la)
{
 color(skin()) import ("Uarm.stl");

translate(   [33, 1, -0] ) 
 rotate(lu) {
 color(skin()) import ("ulna.stl");

translate(  [22, -.4, -0] ) 
 rotate(lh) {
 color(skin()) import ("hand2.stl");


}
}
}

//right arm
mirror([-1,0,0])   translate([10, 4.5, 22])
 rotate(ra){
 color(skin()) import ("Uarm.stl");

translate(   [33, 1, -0] ) 
 rotate(ru){
 color(skin()) import ("ulna.stl");

translate(  [22, -.4, -0] ) 
 rotate(rh){
color(skin()) import ("hand2.stl");


}
}
}
  
     
 color("blue")  for(i=[0:2])  hull(){
  translate([0,15,-5])sphere(1);
        translate(-[0, -3, 25])  
translate([0,-2,-2]) translate([0, -3, 25])rotate(ab) translate(-[0, -3, 25]) translate([0,2,2]){
    
    if(i==0) color("red")translate([0,10,12]) sphere(1);
 if(i==1) color("red")translate([5,6,18]) sphere(1);
  if(i==2)color("red")translate([-5,6,18]) sphere(1);
    }}
 
    translate(-[0, -3, 25])  
translate([0,-2,-2]) translate([0, -3, 25])rotate(ab) translate(-[0, -3, 25]) translate([0,2,2]){
    
    
  color("lightblue") import ("abdomen.stl");
 color("red")translate([0,8,12]) sphere(3);
 color("red")translate([5,6,18]) sphere(3);
 color("red")translate([-5,6,18]) sphere(3);
    color("red")translate([9,-8,11]) sphere(4);
 color("red")translate([-9,-8,11]) sphere(4);
     color("red")
    polyline(polyRound(
    [ [ -2,-4,-5,0],
     [ -13.5,-4,3,4], 
    [-16,1,8,6], 
    [-5,6,18,5],
    [0,5,18,1],
    [ 5,6,18,5],
    [ 16,1,8,6],  
    [ 13.5,-4,3,4],
    [ 2,-4,-5,0],

   
    ]
    ),.5 );
    
   color("blue")polyline(polyRound(
    [
   [-9,-10,11,0],
    [-13,-6,16,3],
    [-13,1,16,5],
    [-8,6,19,7],
    [-1,11,10,1],
    [-1,20,3,7],
    [-1,12,-8,7],
    [-2,3,-10,7],
    [-2,-5,-6,7],
    [-5,-8,2,3],
    [0,-8,4,0],
    ]
    ),1 );
   {
   color("red")polyline(polyRound(
    [
   [-8,-10,11,0],
    [-12,-6,8,5],
    [-15,0,5,6],
    [-15,6,1,5],
    [-12,9,-3,0],
   
    ]
    ),.5 );}
    mirror([-1,0,0]){
   color("blue")polyline(polyRound(
    [
   [-9,-10,11,0],
    [-13,-6,16,3],
    [-13,1,16,5],
    [-8,6,19,7],
    [-1,11,10,1],
    [-1,20,3,7],
    [-1,12,-8,7],
    [-2,3,-10,7],
    [-2,-5,-6,7],
    [-5,-8,2,3],
    [0,-8,4,0],
    ]
    ),1 );}

   mirror([-1,0,0]){
   color("red")polyline(polyRound(
    [
   [-8,-10,11,0],
    [-12,-6,8,5],
    [-15,0,5,6],
    [-15,6,1,5],
    [-12,9,-3,0],
   
    ]
    ),.5 );}
//left leg
 
translate([9.9, 1.7, 2])
 rotate(ll)
{
 color(skin()) import ("Thigh.stl");
      color("red")import ("Thighsleve.stl");

translate( [-0.40, 2.8, -42]) 
 rotate(lc)
{
 color(skin()) import ("crus.stl");

translate( [0.65, 2.5, -43.5]) 
 rotate(lf)
{
 color(skin()) import ("foot2.stl");
      translate([1,-6,-17])
             rotate([rf.x,0,0]){
  hull(){
                    translate([0,0,-0])cylinder(1, 5, 5,center=true);
                    translate([0,15,-0])cylinder(1,4,4,center=true);
                    }
translate([0,0,-2])sphere(3); 
                    mirror([0,0,-1])cylinder(8,2,2);}

}
}
}

//right leg
 
mirror([-1,0,0])
translate([9.9, 1.7, 2])
 rotate(rl)
{
  color(skin()) import ("Thigh.stl");
  color("red")import ("Thighsleve.stl");

    
translate( [-0.40, 2.8, -42]) 
    rotate(rc){
 color(skin()) import ("crus.stl");

translate( [0.65, 2.5, -43.5]) 
         rotate(rf){
color(skin()) import ("foot2.stl");
             
             translate([1,-6,-17])
             rotate([rf.x,0,0]){
  hull(){
                    translate([0,-2,-0])cylinder(1, 6, 6,center=true);
                    translate([0,12,-0])cylinder(1,5,5,center=true);
                    }
translate([0,0,-2])sphere(3);
                    mirror([0,0,-1])cylinder(8,2,2);}
}
}
}

////skateboard  
//rotate([   xsolution ,0,0]) translate([0,0,-10]) rotate([-ab.x,0,0])translate([0,0,-88])sphere(4);

color("violet")hull(){
mirror([-1,0,0])
translate([9.9, 1.7, 2])
 rotate(rl){
translate( [-0.40, 2.8, -42]) 
    rotate(rc){ 
translate( [0.65, 2.5, -43.5]) 
         rotate(rf){
translate([1,-6,-17])
rotate([rf.x,0,0])
translate([0,-0,-7])sphere(2);
             }}}
 
             
             translate(-[0,-2,-2])translate([0, -3, 25]) translate(-[0, -3, 25])  rotate(-ab)rotate([   xsolution ,0,0])  translate(-[0,2,2]) translate([0,40,-80])sphere(2);
}

color("violet")hull(){
//mirror([-1,0,0])
translate([9.9, 1.7, 2])
 rotate(ll){
translate( [-0.40, 2.8, -42]) 
    rotate(lc){ 
translate( [0.65, 2.5, -43.5]) 
         rotate(lf){
translate([1,-6,-17])
rotate([lf.x,0,0])
translate([0,-0,-7])sphere(2);
             }}}
translate(-[0,-2,-2])translate([0, -3, 25]) translate(-[0, -3, 25])  rotate(-ab)rotate([   xsolution ,0,0])  translate(-[0,2,2]) translate([0,40,-80])sphere(2);
 
}

 color("violet")hull(){
 translate(-[0,-2,-2])translate([0, -3, 25]) translate(-[0, -3, 25])  rotate(-ab)rotate([   xsolution ,0,0])  translate(-[0,2,2]) translate([0,0,-100])sphere(3);
     
translate(-[0,-2,-2])translate([0, -3, 25]) translate(-[0, -3, 25])  rotate(-ab)rotate([   xsolution ,0,0])  translate(-[0,2,2]) translate([0,40,-80])sphere(2);
 
}
} 

}

}
     
     
     
   function skin()
=let (sho=(rands(0,1,3)),mix=sho/(sho.x+sho.y+sho.z))(
mix[0]*[	255,224,189]/255+
mix[1]*[	255,205,148]/255+
mix[2]*[	234,192,134]/255)*0.9
 

;
module sky(){
    for(i=[0:1000])
   color("white") rotate(sky[i])   translate([5000,0,0]) cube(5.5);
    
    }
    
function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function smooth (a) =
let (b = clamp(a))(b * b * (3 - 2 * b));
function smooths(v,steps) =smooth( smooth(mods(v,steps) ))/steps+mstep(v,steps);

 

function clamp(a, b = 0, c = 1) = min(max(a, b), c);

function gauss(x) =  
     x + (x - smooth(x));
    
 function vMinLimit()=  [
[-360,-360,-360],[-120,-50,-70],[-60,-30,-45],[-60,-30,-45],
//[-360,-0,-0],[-0,-50,-0],[-60,-30,-45],[-60,-30,-45],
// [-90,-70,-5],[00,00,-20],[-40,-20,-45],
[-90,-70,-5],[00,00,-20],[-40,-20,-45],
[-90,-70,-5],[00,00,-20],[-40,-20,-45],
[-90,-20,-120],[-150,0,-160],[-70,-45,-30],
[-90,-20,-120],[-150,0,-160],[-70,-45,-30]];
 function vMaxLimit()=  [
[360,360,360],[40,50,70],[30,30,45],[30,30,45],
//[360,0,0],[0,50,0],[30,30,45],[30,30,45],
// [30,5,10],[160,0,30],[40,30,45],
[30,5,10],[160,0,30],[40,30,45],
[30,5,10],[160,0,30],[40,30,45],
[90,80,50],[80,0,00],[55,80,30],
[90,80,50],[80,0,00],[55,80,30]
];

 
    function clamp(a, b = 0, c = 1) = min(max(a, b), c);

    function clamp3(a,b,c)=[clamp(a.x,b.x,c.x),clamp(a.y,b.y,c.y),clamp(a.z,b.z,c.z)];

 function  clampAngleVector(v,vmin,vmax)=[for(i=[0:len(v)-1]) clamp3(v[i],vmin[i],vmax[i])];
