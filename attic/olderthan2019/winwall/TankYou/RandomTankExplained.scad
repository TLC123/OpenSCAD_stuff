////////////////////
//Tank generator by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike

////////////////////

Generate_Random=0.15;//[0:0.0001:1]
size=1;//[0.5;2]
part=1;//[1,2,3,4]

style=floor(rnd(1,6.99));
bubble=rnd(0,2);
//GUN!
gunl=rnd(30,45);//[20:60]
gund=rnd(2,3.5);//[1:10]
gunelev=rnd(-5,25);//[-10:60]
guns=floor(rnd(1,3.99));
gunstyle1=rnd(0,2);
gunstyle2=rnd(0,2);
gunstyle3=rnd(0,2);
//Tracks
skirtstyle1=rnd(0,2);
skirtstyle2=rnd(0,2);
skirtstyle3=floor(rnd(0,1.999));
skirtstyle4=rnd(1,2);
  wi= rnd(1,7);
  bi=rnd(14,16);
  skirtstylero=rnd(-20,15);
theight=rnd(0.8,0.9);//[0:2];
tlengdth=rnd(0.9,1);//[0.8:1.1];
twidth=rnd(0.5,1.2);//[0:3];
tslopeupper=rnd(0.95,1.15);//[0:03];
tslope1=rnd(0.65,0.75);//[0.5;1];
tslope2=rnd(0.1,0.15);//[0:0.5];

B1Xsize=rnd(40,50);//[10:200]
B1Ysize=rnd(B1Xsize*0.5,B1Xsize*.55);//[10:100]
B1Zsize=rnd(B1Ysize*0.4,B1Ysize*.45);//[10:50]
B1Xplace=rnd(0,B1Xsize*0.0);//[-3:0.1:3]
B1Yplace=rnd(0,0);//[-3:0.1:3]
B1Zplace=rnd(0,0.3);//[-3:0.1:3]
TRsc=26/B1Xsize;


B1r1=rnd(30,45);//[0:90]//Front panel: slope&offset
B1o1=rnd(0.1,0.2);//[-1:0.1:1]
B1r2=rnd(55,60);//[0:90]//Rear panel: slope&offset
B1o2=rnd(0.4,0.5);//[-1:0.1:1]
B1r3=rnd(60,75);//[0:90]//Bottom Rear panel: slope&offset
B1o3=rnd(0.3,0.45);//[-1:0.1:1]
B1r4=rnd(45,65);//[0:90]//Bottom Front panel: slope&offset
B1o4=rnd(0.2,0.4);//[-1:0.1:1]
B1r5=rnd(0,40);//[0:90]//left Side Rear panel: slope&offset
B1o5=rnd(0.3,0.5);//[-1:0.1:1]
B1r6=rnd(10,45);//[0:90] //Left Side Front panel: slope&offset
B1o6=rnd(0.4,0.5);//[-1:0.1:1]
B1r7=B1r6;//[0:90]//Right Side Front panel: slope&offset
B1o7=B1o6;//[-1:0.1:1]
B1r8=B1r5;//[0:90] //Right Side Rear panel: slope&offset
B1o8=B1o5;//[-1:0.1:1]
//And so on

B2Xsize=rnd(B1Xsize*0.6,B1Xsize*0.8);//[10:100]
B2Ysize=rnd(B2Xsize*0.2,B2Xsize*0.5);//[10:50]
B2Zsize=rnd(B2Ysize*0.3,B2Ysize*.3);//[10:50]
B2Xplace=B1Xplace+ rnd(-B1Xsize*0.1,B1Xsize*0.1);//[-30:0.1:30]
B2Yplace=B1Yplace;//[-30:0.1:30]
B2Zplace=B1Zplace+rnd(B1Zsize*0.3,B1Zsize*0.3);//[-30:0.1:30]

B2r1=rnd(40,80);//[0:90]//Front panel: slope&offset
B2o1=rnd(0,0.3);//[-1:0.1:1]
B2r2=rnd(0,80);//[0:90]//Rear panel: slope&offset
B2o2=rnd(0,0.5);//[-1:0.1:1]
B2r3=rnd(0,40);//[0:90]//Bottom Rear panel: slope&offset
B2o3=rnd(00.4,0.5);//[-1:0.1:1]
B2r4=rnd(0,80);//[0:90]//Bottom Front panel: slope&offset
B2o4=rnd(0,0.5);//[-1:0.1:1]
B2r5=rnd(30,80);//[0:90]//left Side Rear panel: slope&offset
B2o5=rnd(0,0.4);//[-1:0.1:1]
B2r6=rnd(30,80);//[0:90] //Left Side Front panel: slope&offset
B2o6=rnd(0,0.4);//[-1:0.1:1]
B2r7=B2r6;//[0:90]//Right Side Front panel: slope&offset
B2o7=B2o6;//[-1:0.1:1]
B2r8=B2r5;//[0:90]//Right Side Rear panel: slope&offset
B2o8=B2o5;//[-1:0.1:1]


B3Xsize=rnd(B2Xsize*0.7,B2Xsize*0.9);//[10:100]
B3Ysize=rnd(B3Xsize*0.2,B3Xsize*0.7);//[10:50]
B3Zsize=rnd(B3Ysize*0.4,B3Ysize*0.5);//[10:50]
B3Xplace=-B1Xplace- rnd(0,B1Xsize*0.1);//[-3:0.1:3]
B3Yplace=B1Yplace;//[-3:0.1:3]
B3Zplace=B1Zplace+rnd(B1Zsize*0.3,B1Zsize*0.3+B2Zsize*0.3);//[-3:0.1:3]

B3r1=rnd(0,80);//[0:90]//Front panel: slope&offset
B3o1=rnd(0,0.5);//[-1:0.1:1]
B3r2=rnd(0,80);//[0:90]//Rear panel: slope&offset
B3o2=rnd(0,0.5);//[-1:0.1:1]
B3r3=rnd(0,80);//[0:90]//Bottom Rear panel: slope&offset
B3o3=rnd(0,0.5);//[-1:0.1:1]
B3r4=rnd(0,80);//[0:90]//Bottom Front panel: slope&offset
B3o4=rnd(0,0.5);//[-1:0.1:1]
B3r5=rnd(0,80);//[0:90]//left Side Rear panel: slope&offset
B3o5=rnd(0,0.5);//[-1:0.1:1]
B3r6=rnd(0,80);//[0:90] //Left Side Front panel: slope&offset
B3o6=rnd(0,0.5);//[-1:0.1:1]
B3r7=B3r6;//[0:90]//Right Side Front panel: slope&offset
B3o7=B3o6;//[-1:0.1:1]
B3r8=B3r5;//[0:90]//Right Side Rear panel: slope&offset
B3o8=B3o5;//[-1:0.1:1]



Rotate=rnd(-40,40);//[-360:360]

T1Xsize=B1Xsize*rnd(0.6,0.7);//[10:200]
T1Ysize=B1Ysize*rnd(0.8,0.9);//[10:100]
T1Zsize=B1Zsize*rnd(0.4,0.6);//[10:50]

T1Xplace=B3Xplace- rnd(-B1Xsize*0.2,B1Xsize*0.2);//[-3:0.1:3]
T1Yplace=B3Yplace;//[-3:0.1:3]
T1Zplace=B3Zplace+B3Zsize*0.5+T1Zsize*0.5;//[-3:0.1:3]
// Turret Front panel: slope&offset
T1r1=rnd(40,50);//  [0:90]
T1o1=rnd(0,0.2);//  [-1:0.1:1]
// Turret Rear panel: slope&offset
T1r2=rnd(30,40);//  [0:90]
T1o2=rnd(0.3,0.5);//  [-1:0.1:1]
// Turret Bottom Rear panel: slope&offset
T1r3=rnd(0,10);//  [0:90]
T1o3=rnd(0,0.5);//  [-1:0.1:1]
 // Turret Bottom Front panel: slope&offset
T1r4=rnd(40,60);//  [0:90]
T1o4=rnd(0.3,0.5);//  [-1:0.1:1]
 // Turret left Side Rear panel: slope&offset
T1r5=rnd(0,40);//  [0:90]
T1o5=rnd(0,0.2);//  [-1:0.1:1]
 // Turret Left Side Front panel: slope&offset
T1r6=rnd(0,40);//  [0:90]
T1o6=rnd(0,0.4);//  [-1:0.1:1]
 // Turret Right Side Front panel: slope&offset
T1r7=T1r6;//  [0:90]
T1o7=T1o6;//  [-1:0.1:1]
 // Turret Right Side Rear panel: slope&offset
T1r8=T1r5;//  [0:90]
T1o8=T1o5;//  [-1:0.1:1]
// Turret And so on


T2Xsize=rnd(T1Xsize*rnd(0.4,0.6),T1Xsize*0.75);//  [10:100]
T2Ysize=rnd(T2Xsize*rnd(0.4,0.6),T2Xsize*0.9);//  [10:50]
T2Zsize=rnd(T1Zsize*rnd(0.4,0.6),T1Zsize*0.9);//  [10:50]
T2Xplace=T1Xplace +rnd(-T1Xsize*0.1,T1Xsize*0.1);//  [-30:0.1:30]
T2Yplace=T1Yplace;//  [-30:0.1:30]
T2Zplace=T1Zplace+rnd(T1Zsize*0.4,T1Zsize*0.4+T2Zsize*0.2);//  [-30:0.1:30]

T2r1=rnd(0,80);//  [0:90]// Turret Front panel: slope&offset
T2o1=rnd(0,0.5);//  [-1:0.1:1]
T2r2=rnd(0,80);//  [0:90]// Turret Rear panel: slope&offset
T2o2=rnd(0,0.5);//  [-1:0.1:1]
T2r3=rnd(0,30);//  [0:90]// Turret Bottom Rear panel: slope&offset
T2o3=rnd(0.4,0.6);//  [-1:0.1:1]
T2r4=rnd(60,80);//  [0:90]// Turret Bottom Front panel: slope&offset
T2o4=rnd(0.3,0.5);//  [-1:0.1:1]
T2r5=rnd(0,80);//  [0:90]// Turret left Side Rear panel: slope&offset
T2o5=rnd(0,0.5);//  [-1:0.1:1]
T2r6=rnd(0,80);//  [0:90] // Turret Left Side Front panel: slope&offset
T2o6=rnd(0,0.5);//  [-1:0.1:1]
T2r7=T2r6;//  [0:90]// Turret Right Side Front panel: slope&offset
T2o7=T2o6;//  [-1:0.1:1]
T2r8=T2r5;//  [0:90]// Turret Right Side Rear panel: slope&offset
T2o8=T2o5;//  [-1:0.1:1]


T3Xsize=rnd(T2Xsize*0.8,T2Xsize*0.9);//  [10:100]
T3Ysize=rnd(T3Xsize*0.7,T3Xsize*0.9);//  [10:50]
T3Zsize=rnd(gund*1.5,gund*1.5);//  [10:50]
T3Xplace=T2Xplace+rnd(-T1Xsize*0.1,T1Xsize*0.1);//  [-3:0.1:3]
T3Yplace=T2Yplace;//  [-3:0.1:3]
T3Zplace=T2Zplace+rnd(T2Zsize*0.3,T2Zsize*0.2-T3Zsize*0.2);//  [-3:0.1:3]

T3r1=rnd(30,80);//  [0:90]// Turret Front panel: slope&offset
T3o1=rnd(0,0.3);//  [-1:0.1:1]
T3r2=rnd(0,80);//  [0:90]// Turret Rear panel: slope&offset
T3o2=rnd(0,0.5);//  [-1:0.1:1]
T3r3=rnd(0,30);//  [0:90]// Turret Bottom Rear panel: slope&offset
T3o3=rnd(0.4,0.5);//  [-1:0.1:1]
T3r4=rnd(0,80);//  [0:90]// Turret Bottom Front panel: slope&offset
T3o4=rnd(0,0.5);//  [-1:0.1:1]
T3r5=rnd(0,80);//  [0:90]// Turret left Side Rear panel: slope&offset
T3o5=rnd(0,0.5);//  [-1:0.1:1]
T3r6=rnd(0,80);//  [0:90] // Turret Left Side Front panel: slope&offset
T3o6=rnd(0,0.5);//  [-1:0.1:1]
T3r7=T3r6;//  [0:90]// Turret Right Side Front panel: slope&offset
T3o7=T3o6;//  [-1:0.1:1]
T3r8=T3r5;//  [0:90]// Turret Right Side Rear panel: slope&offset
T3o8=T3o5;//  [-1:0.1:1]

////////////////////////////////////////



/////////////////Main/////////////////////

scale(size) union(){
color("Olive") translate([-B1Xsize/2,-B1Ysize/2,-B1Zsize/1.3])//resize([B1Xsize, B1Ysize/3*twidth, B1Zsize*theight])
    scale(TRsc)scale([1.1,twidth,1.1])track();
color("Olive") translate([-B1Xsize/2,B1Ysize/2,-B1Zsize/1.3])mirror([0,1,0])
    //resize([B1Xsize, B1Ysize/3*twidth, B1Zsize*theight])
    scale(TRsc)scale([1.1,twidth,1.1])track();


!rotate([0,0,0]){
color("Red")translate([B1Xplace, B1Yplace, B1Zplace])resize([B1Xsize, B1Ysize, B1Zsize])	
body(B1r1, B1o1, B1r2, B1o2, B1r3, B1o3, B1r4, B1o4, B1r5, B1o5, B1r6, B1o6, B1r7, B1o7, B1r8, B1o8);

color("Green")translate([B2Xplace, B2Yplace,B2Zplace])resize([B2Xsize, B2Ysize, B2Zsize])
body(B2r1, B2o1, B2r2, B2o2, B2r3, B2o3, B2r4, B2o4, B2r5, B2o5, B2r6, B2o6, B2r7, B2o7, B2r8, B2o8);

color("Blue")translate([B3Xplace,B3Yplace,B3Zplace])resize([B3Xsize, B3Ysize, B3Zsize])
body(B3r1, B3o1, B3r2, B3o2, B3r3, B3o3, B3r4, B3o4, B3r5, B3o5, B3r6, B3o6, B3r7, B3o7, B3r8, B3o8);
   
}

translate([T1Xplace,0,0])rotate([0,0,0]){   

 color("DarkOliveGreen") translate([0,T1Yplace,B3Zplace-B2Zsize])  cylinder(d=max(B2Ysize,B3Ysize),h=B2Zsize*2.5);
color("Olive")translate([0, T1Yplace, T1Zplace])resize([T1Xsize, T1Ysize, T1Zsize])	
body(T1r1, T1o1, T1r2, T1o2, T1r3, T1o3, T1r4, T1o4, T1r5, T1o5, T1r6, T1o6, T1r7, T1o7, T1r8, T1o8);

color("Olive")translate([T2Xplace-T1Xplace, T2Yplace,T2Zplace])resize([T2Xsize, T2Ysize, T2Zsize])
body(T2r1, T2o1, T2r2, T2o2, T2r3, T2o3, T2r4, T2o4, T2r5, T2o5, T2r6, T2o6, T2r7, T2o7, T2r8, T2o8);

color("Olive")translate([T3Xplace-T1Xplace,T3Yplace,T3Zplace])resize([T3Xsize, T3Ysize, T3Zsize])
body(T3r1, T3o1, T3r2, T3o2, T3r3, T3o3, T3r4, T3o4, T3r5, T3o5, T3r6, T3o6, T3r7, T3o7, T3r8, T3o8);
   
    
  translate([0,T2Yplace,T3Zplace]) rotate ([0,-gunelev,0]){
    if(guns==1){
    gun(gunl,gund);
    }
    if(guns==2){
    translate([0,gund,0])gun(gunl,gund);    
    translate([0,-gund,0])gun(gunl,gund);
    }
    if(guns==3){
    translate([0,gund*1.5,0])gun(gunl,gund);    
    translate([0,0,0])gun(gunl,gund);    
    translate([0,-gund*1.5,0])gun(gunl,gund);    
    }}
   
    }
}

//////////////////////MODULES/////////////////

module body(r1,o1,r2,o2,r3,o3,r4,o4,r5,o5,r6,o6,r7,o7,r8,o8){
fudge=0.0001;
difference(){ 
   if (bubble>1){
       
       if (bubble>2){
       translate([0,0,0]) 
       intersection(){
           cube([1,1,1],center=true);
          hull(){ 
         translate([0,-0.2,0])resize([1,1,1.4])sphere(10,center=true,$fn=12);
         translate([0,0.2,0])resize([1,1,1.4])sphere(10,center=true,$fn=12);}}
       
   }
       else{
       translate([0,0,0]) 
       intersection(){
           cube([1,1,1],center=true);
       resize([1,1.3,1.4])sphere(10,center=true,$fn=10);}}
       
       
   }else{translate([0,0,0]) resize([1,1,1])tcube();}

//Front_slope
color("LightGreen",0.5)
    translate([o1,0,0.5])rotate ([0,r1,0])translate([0,0,0.5])tcube();
//back_slope
color("Green",0.5) 
    translate([-o2,0,0.5])rotate ([0,-r2,0])translate([0,0,0.5])tcube();
//Front_under_slope
color("DarkGreen",0.5)
    translate([-o3,0,-0.5])rotate ([0,r3,0])translate([0,0,-0.5])tcube();
//back_under_slope
color("DarkGreen",0.5) 
    translate([o4,0,-0.5])rotate ([0,-r4,0])translate([0,0,-0.5])tcube();

//Front_right_slope
color("Pink",0.5)
    translate([-o5,0.5,0])rotate ([0,0,r5])translate([0,0.5,0])tcube();
//back_right_slope
color("Pink",0.5) 
    translate([o6,0.5,0])rotate ([0,0,-r6])translate([0,0.5,0])tcube();
//Front_left_slope
color("Red",0.5) 
    translate([o7,-0.5,0])rotate([0,0,r7])translate([0,-0.5,0])tcube();
//back_left_slope
color("red",0.5)
    translate([-o8,-0.5,0])rotate([0,0,-r8])translate([0,-0.5,0])tcube();
    
}  }









//////////////////////////////////
function rnd(n,m)=rands(n,m,9)[part];

module gun(l,d){
   color("Olive") rotate ([0,90,0]){
       translate([0,0,3])resize([d*1.2,d*1.4
      ,d*3])cube(1,center=true);
      
        difference() {   
            
            
            
           union(){ 
               if (gunstyle1>1){for(i=[0:6]){    translate([0,0,d*2.9 + i])cylinder(d=d*1.55,l*0.01,$fn=8);     }}
            
            if (gunstyle2>1){for(i=[0:3]){    rotate([0,0,i*60])translate([0,0,l*0.5])cube([d*1.15,d*0.25,l],center=true);     }}
            if (gunstyle3>1){for(i=[0:2:5]){    translate([0,0,l*1.01- i*1.7])cylinder(d=d*1.55,l*0.08,$fn=8);     }}
            
               translate([0,0,0])cylinder(d=d,l,$fn=20);}
        cylinder(d=d*0.7,l*1.3+1.001,$fn=20);
            }
        difference(){
        translate([0,0,gunl])cylinder(d=d*1.25,l*0.1,$fn=20);
        translate([0,0,gunl*0.9+0.001])cylinder(d=d*.7,l*0.2,$fn=20);
        }
    }
    
    }


module track(){
xlist=[
[0, 60*tslope1*tlengdth],
[1, 60*tslope2*tlengdth],
[2, 0],
[3, 30*tlengdth],
[4, 60*tlengdth], 
[5, 60*tslope1*tlengdth],
[6, 60*tslope2*tlengdth],// allway the same as nr1
[7,0]// allway the same as nr2
];

ylist=[
[1, 0],
[2, 10*theight],
[3, 8*theight],
[4, 12*tslopeupper*theight], 
[5, 0],
[6, 0],// allway the same as nr1
[7,10*theight]// allway the same as nr2
];
function x(p)= lookup(p, xlist);
function y(p)= lookup(p, ylist);

color("DarkGray")translate([0,-8,0])rotate([90,0,0])
{

//skirt
    
color("DarkOliveGreen") intersection(){
     hull(){
     for (i=[2:1:4]) {
 
    color("Red")
    translate([x(i), y(i),0]) 
    translate([0,4,0])resize([18,8,18])cube(1,center=true);
    }}
    
    difference(){
       union(){
     if(skirtstyle1>1){  
      
         
         for (i=[2.1:0.3:4.0]) { translate([x(i), y(i),0]) 
    translate([0,0,0])rotate([0,0,skirtstylero])cube ([wi,35,bi],center=true);}}
           
    hull(){for (i=[2:1:4]){color("Red")
    translate([x(i), y(i),0]) 
    translate([0,0,-8])cylinder(r=7,h=16,$fn=8);}}
    if(skirtstyle2>1){  
    hull(){for (i=[2:1:4]){color("Red")
    translate([x(i), y(i),0]) 
    translate([0,0,-7])cylinder(r=8,h=1,$fn=8);}}
     hull(){for (i=[2:1:4]){color("Red")
    translate([x(i), y(i),0]) 
    translate([0,0,-2.5])cylinder(r=8,h=1,$fn=8);}}
     hull(){for (i=[2:1:4]){color("Red")
    translate([x(i), y(i),0]) 
    translate([0,0,2])cylinder(r=8,h=1,$fn=8);}}
    
    if(skirtstyle4>1){  
      
         
         for (i=[2.1:0.3:4.0]) { translate([x(i), y(i),0]) 
    translate([0,0,8])rotate([0,0,skirtstylero]) translate([0,15,0])cube ([wi,25,4],center=true);}}
}
    }
          
   
    hull(){
     for (i=[2:1:4]) {
 
    color("Red")
    translate([x(i), y(i),0]) 
    translate([0,0,-4-skirtstyle3*3])cylinder(r=6,h=12.1,$fn=8);
    }}
    
    }
}

// wheels

wsp=1;// wheel spacing
//large wheels
 for (i = [1:wsp:6]) {
 ah=0.42;
 	    ro=atan2(y(i+ah)-y(i-ah),x(i+ah)-x(i-ah));

    color("Gray")
    translate([x(i), y(i),0]) 
    rotate([0,0,ro])translate([0,0,2])resize([9,9,3])wheel();
    }
    
 //small wheels
   
     for (i = [1+wsp*0.43:wsp/4:6]) {
 ah=0.42;
    ro=atan2(y(i+ah)-y(i-ah),x(i+ah)-x(i-ah));
    color("Gray")
    translate([x(i), y(i),0]) 
    rotate([0,0,ro+10])translate([0,1.5,-1])resize([6,6,3])wheel();
    }

//filler
hull(){
     for (i=[1:1:6]) {
 
    color("Blue")
    translate([x(i), y(i),0]) 
    translate([0,0,-7.501])cylinder(r=4.5,h=6.2,$fn=8);
    }}

//trackmagic
intersection(){
    union(){
for (i = [1:0.25:6]) {
 ah=0.42;
 	
    ro=atan2(y(i+ah)-y(i-ah),x(i+ah)-x(i-ah));

 	//translate([(x(i-0.2)+x(i+0.2))/2, (y(i-0.2)+y(i+0.2))/2,0])
    translate([x(i), y(i),0]) 
    rotate([0,0,ro])
    translate([0,5,0])
    rotate([0,0,-ro])
    cylinder(r=8,15.001,center=true,$fn=6);
}
}
difference(){
union(){
 for (i = [1:0.1:6]) {
 ah=0.42;
 	 	    ro=atan2(y(i+ah)-y(i-ah),x(i+ah)-x(i-ah));

    color("Red")
    translate([x(i), y(i),0]) 
    rotate([0,0,ro])translate([0,0,0])cylinder(r=5,h=15,center=true,$fn=14);
     
    }
}
union(){
 for (i = [1:0.1:6]) {
 ah=0.42;
 	 	    ro=atan2(y(i+ah)-y(i-ah),x(i+ah)-x(i-ah));

    color("Blue")
    translate([x(i), y(i),0]) 
    rotate([0,0,ro])translate([0,0,0])cylinder(r=4,h=16,center=true,$fn=12);
    }
}
}

}

}
}    
    module wheel(){
        translate([0,0,-2])
        difference(){
        cylinder(r=4,h=3);    
        translate([0,0,2])cylinder(r=3,h=2);
        }
        cylinder(r=1,h=1);
        
        }
        
        /////// T Cube //////////
        module tcube(){resize([2,1.1,1.1])
            if(part<3){cube(1,center=true);}
            else{
            intersection(){intersection(){
                
                intersection(){
                color("Blue" ,0.5)
                    rotate ([0,0,0])
                translate([rnd(-3,3),0,-0.05]) resize([8.01,1.5,1])strip();
             color("Blue",0.5)
                    rotate ([90,0,0])
                translate([rnd(-3,3),0,-0.05]) resize([8.01,1.5,1])strip();
            }
            intersection(){
                color("Red",0.5)rotate ([180,0,0])
                translate([rnd(-3,3),0,-0.05]) resize([8.01,1.5,1])strip();
                color("Red",0.5)rotate ([270,0,0])
                translate([rnd(-3,3),0,-0.05]) resize([8.01,1.5,1])strip();
            }
            }
            union(){
               color("Green",0.5)rotate ([0,90,0])
                translate([rnd(-3,3),0,0.45]) resize([8.01,1.5,1])strip();
                color("Green",0.5)rotate ([0,270,0])
                translate([rnd(-3,3),0,0.45]) resize([8.01,1.5,1])strip();}
                
            }}}
            
         module strip(scale) {
if (style==1){ difference(){
    cube([8,2,1],center=true);
for(i=[0:0.2:0.9])
    {
   translate([-3.9+i,0,1-0.0251]) cube([0.1,0.99,1.01],center=true);
   translate([2.3,0.40-i,1-0.0251]) cube([0.99,0.1,1.01],center=true);
     
    }
 for(i=[0:0.25:0.9])
    {
   translate([0.8+i,0,1-0.0251]) cube([0.2,0.9,1.01],center=true);
   translate([-2.65,0.40-i,1-0.0251]) cube([0.449,0.2,1.01],center=true);
     translate([-2.15,0.40-i,1-0.0251]) cube([0.449,0.2,1.01],center=true);
    }
    
    translate([3.4,0,0.5-0.05] ) cylinder(d=0.7,d2=0.9,h=0.06,$fn=18);
    
    translate([0,0,0.48])difference(){
         cylinder(d=0.999,h=0.054,$fn=18);
        cylinder(d=0.8,h=0.01,$fn=18);

        }
            translate([-1,0.25,0.48])difference(){
        cylinder(d2=0.5,d=0.4,h=0.054,$fn=10);
        cylinder(d2=0.2,d=0.3,h=0.01,$fn=10);

        }
             translate([-1,-0.25,0.48])difference(){
        cylinder(d2=0.5,d=0.4,h=0.054,$fn=10);
        cylinder(d2=0.2,d=0.3,h=0.01,$fn=10);

        }
        
              translate([-1.5,0.25,0.48])difference(){
        cylinder(d2=0.5,d=0.4,h=0.054,$fn=10);
        cylinder(d2=0.2,d=0.3,h=0.01,$fn=10);

        }
             translate([-1.5,-0.25,0.48])difference(){
        cylinder(d2=0.5,d=0.4,h=0.054,$fn=10);
        cylinder(d2=0.2,d=0.3,h=0.01,$fn=10);

        }
        
    }}
if (style==2){ union(){
    cube([8,2,1],center=true);
for(i=[0:0.2:0.9])
    {
   translate([-3.9+i,0,0.51]) cube([0.1,0.99,0.05],center=true);
   translate([2.3,0.40-i,0.51]) cube([0.99,0.1,0.05],center=true);
     
    }
 for(i=[0:0.25:0.9])
    {
   translate([0.8+i,0,0.51]) cube([0.2,0.9,0.051],center=true);
   translate([-2.65,0.40-i,0.51]) cube([0.449,0.2,0.05],center=true);
     translate([-2.15,0.40-i,0.51]) cube([0.449,0.2,0.05],center=true);
    }
    
    translate([3.4,0,0.4999] ) cylinder(d=0.9,d2=0.7,h=0.06,$fn=18);
    
    translate([0,0,0.4999])difference(){
         cylinder(d2=0.95,d=1,h=0.054,$fn=18);
        cylinder(d2=0.8,d=0.75,h=0.055,$fn=18);

        }
            translate([-1,0.25,0.48])difference(){
        cylinder(d2=0.4,d=0.5,h=0.054,$fn=10);
        cylinder(d2=0.3,d=0.2,h=0.01,$fn=10);

        }
             translate([-1,-0.25,0.48])difference(){
        cylinder(d2=0.4,d=0.5,h=0.054,$fn=10);
        cylinder(d2=0.3,d=0.2,h=0.01,$fn=10);

        }
        
              translate([-1.5,0.25,0.48])difference(){
        cylinder(d2=0.4,d=0.5,h=0.054,$fn=10);
        cylinder(d2=0.3,d=0.2,h=0.01,$fn=10);

        }
             translate([-1.5,-0.25,0.48])difference(){
        cylinder(d2=0.4,d=0.5,h=0.054,$fn=10);
        cylinder(d2=0.3,d=0.2,h=0.01,$fn=10);

        }
        
    }}
     
    if (style==3){ union(){
    cube([8,2,1],center=true);
for(i=[0:0.2:0.9])
    {
   translate([-3.9+i,0,0.51]) cube([0.1,0.99,0.1],center=true);
   translate([2.3,0.40-i,0.51]) cube([0.99,0.1,0.1],center=true);
     
    }
 for(i=[0:0.25:0.9])
    {
   translate([0.8+i,0,0.51]) cube([0.2,0.9,0.1],center=true);
   translate([-2.65,0.40-i,0.51]) cube([0.449,0.2,0.1],center=true);
     translate([-2.15,0.40-i,0.51]) cube([0.449,0.2,0.1],center=true);
    }
    
    translate([3.4,0,0.4999] ) cylinder(d=0.9,d2=0.7,h=0.06,$fn=18);
    
    translate([0,0,0.4999])difference(){
         cylinder(d2=0.95,d=1,h=0.054,$fn=18);
        cylinder(d2=0.8,d=0.75,h=0.055,$fn=18);

        }
            translate([-1,0.25,0.48])difference(){
        cylinder(d2=0.4,d=0.5,h=0.054,$fn=10);
        cylinder(d2=0.3,d=0.2,h=0.01,$fn=10);

        }
             translate([-1,-0.25,0.48])difference(){
        cylinder(d2=0.4,d=0.5,h=0.054,$fn=10);
        cylinder(d2=0.3,d=0.2,h=0.01,$fn=10);

        }
        
              translate([-1.5,0.25,0.48])difference(){
        cylinder(d2=0.4,d=0.5,h=0.054,$fn=10);
        cylinder(d2=0.3,d=0.2,h=0.01,$fn=10);

        }
             translate([-1.5,-0.25,0.48])difference(){
        cylinder(d2=0.4,d=0.5,h=0.054,$fn=10);
        cylinder(d2=0.3,d=0.2,h=0.01,$fn=10);

        }
        
    }}
    if (style==4){ union(){
    cube([8,2,1],center=true);
for(i=[0:0.2:0.9])
    {
   translate([-3.9+i,0,0.5])rotate([0,45,0]) cube([0.1,0.99,0.1],center=true);
   translate([2.3,0.40-i,0.5]) rotate([45,0,0]) cube([0.99,0.1,0.1],center=true);
     
    }
 for(i=[0:0.25:0.9])
    {
   translate([0.8+i,0,0.51]) cube([0.2,0.9,0.1],center=true);
   translate([-2.65,0.40-i,0.51]) cube([0.449,0.2,0.1],center=true);
     translate([-2.15,0.40-i,0.51]) cube([0.449,0.2,0.1],center=true);
    }
    
    translate([3.4,0,0.4999] ) cylinder(d=0.9,d2=0.7,h=0.06,$fn=4);
    
    translate([0,0,0.4999])scale([1,0.8,1])difference(){
         cylinder(d2=0.95,d=1,h=0.054,$fn=6);
        cylinder(d2=0.6,d=0.55,h=0.055,$fn=6);

        }
            translate([-1,0.25,0.48])scale([1,0.5,1])difference(){
        cylinder(d2=0.4,d=0.5,h=0.054,$fn=4);
        cylinder(d2=0.3,d=0.2,h=0.016,$fn=4);

        }
             translate([-1,-0.25,0.48])scale([1,0.5,1])difference(){
        cylinder(d2=0.4,d=0.5,h=0.054,$fn=4);
        cylinder(d2=0.3,d=0.2,h=0.016,$fn=4);

        }
        
              translate([-1.5,0.25,0.48])scale([1,0.5,1])difference(){
        cylinder(d2=0.4,d=0.5,h=0.054,$fn=4);
        cylinder(d2=0.3,d=0.2,h=0.016,$fn=4);

        }
             translate([-1.5,-0.25,0.48])scale([1,0.5,1])difference(){
        cylinder(d2=0.4,d=0.5,h=0.054,$fn=4);
        cylinder(d2=0.3,d=0.2,h=0.01,$fn=4);
        }
        
        
 translate([-1,0,0.48])scale([1,0.5,1])difference(){
        cylinder(d2=0.4,d=0.5,h=0.054,$fn=4);
        cylinder(d2=0.3,d=0.2,h=0.016,$fn=4);

        }
             translate([-1.5,0,0.48])scale([1,0.5,1])difference(){
        cylinder(d2=0.4,d=0.5,h=0.054,$fn=4);
        cylinder(d2=0.3,d=0.2,h=0.01,$fn=4);
        }
        
    }}
    
     if (style==5){ union(){
    cube([8,2,1],center=true);
for(i=[0:0.2:0.9])
    {
   translate([-3.9+i,0,0.5])rotate([0,45,0]) cube([0.1,0.99,0.1],center=true);
   translate([2.3,0.40-i,0.5]) rotate([45,0,0]) cube([0.99,0.1,0.1],center=true);
     
    }
 for(i=[0:0.25:0.9])
    {
   translate([0.8+i,0,0.51]) cube([0.2,0.9,0.1],center=true);
   translate([-2.65,0.40-i,0.51]) cube([0.449,0.2,0.1],center=true);
     translate([-2.15,0.40-i,0.51]) cube([0.449,0.2,0.1],center=true);
    }
    
    translate([3.4,0,0.4999] ) cylinder(d=0.9,d2=0.7,h=0.06,$fn=5);
    
    translate([0,0,0.4999])scale([1,1,1])difference(){
         cylinder(d2=0.95,d=1,h=0.054,$fn=5);
        cylinder(d2=0.6,d=0.55,h=0.055,$fn=5);

        }
            translate([-1,0.25,0.48])scale([1,1,1])difference(){
        cylinder(d2=0.4,d=0.5,h=0.054,$fn=5);
        cylinder(d2=0.3,d=0.2,h=0.016,$fn=5);

        }
             translate([-1,-0.25,0.48])scale([1,1,1])difference(){
        cylinder(d2=0.4,d=0.5,h=0.054,$fn=5);
        cylinder(d2=0.3,d=0.2,h=0.016,$fn=5);

        }
        
              translate([-1.5,0.25,0.48])scale([1,1,1])difference(){
        cylinder(d2=0.4,d=0.5,h=0.054,$fn=5);
        cylinder(d2=0.3,d=0.2,h=0.016,$fn=5);

        }
             translate([-1.5,-0.25,0.48])scale([1,1,1])difference(){
        cylinder(d2=0.4,d=0.5,h=0.054,$fn=5);
        cylinder(d2=0.3,d=0.2,h=0.01,$fn=5);
        }
        
        

        
    }}
      if (style==6){ difference(){union(){
    cube([8,2,1],center=true);
for(i=[0:0.2:0.9])
    {
   translate([-3.9+i,0,0.45])rotate([0,45,0]) cube([0.1,0.99,0.1],center=true);
   translate([2.3,0.40-i,0.47]) rotate([0,-5,0]) resize([0.99,0.1,0.1])cylinder(1,center=true,$fn=10);
     
    }
 for(i=[0:0.25:0.9])
    {
   translate([0.8+i,0,0.47]) rotate([0,-7,0])resize([0.5,1.3,0.1])rotate([90,0,0])sphere(10,center=true,$fn=15);
   translate([-2.65,0.40-i,0.50-0.01]) resize([0.6,0.3,0.1])rotate([90,0,0])sphere(10,center=true,$fn=10);
     translate([-2.15,0.40-i,0.50-0.01]) resize([0.6,0.3,0.1])rotate([90,0,0])sphere(10,center=true,$fn=10);
    }
    
    
    translate([0,0,0.4999])scale([1,1,1])difference(){
         resize([1.2,1.2,0.054])sphere(10,center=true);
        translate([0,0,0.03])resize([0.65,0.65,0.054])sphere(10,center=true ,$fn=16);

        }
           
        
        

        
    }
    
     translate([3.4,0,0.4999] ) resize([1.2,1.3,0.2])rotate([90,0,0])sphere(10,center=true,$fn=18);
   
     translate([-1,0.25,0.51])scale([1,1,1])difference(){
        resize(  [0.51,0.5,0.054]) rotate([90,0,0])sphere(10,center=true,$fn=10);

        }
             translate([-1,-0.25,0.51])scale([1,1,1])difference(){
        resize(  [0.51,0.5,0.054]) rotate([90,0,0])sphere(10,center=true,$fn=10);

        }
        
              translate([-1.5,0.25,0.51])scale([1,1,1])difference(){
        resize(  [0.51,0.5,0.054]) rotate([90,0,0])sphere(10,center=true,$fn=10);

        }
             translate([-1.5,-0.25,0.51])scale([1,1,1])difference(){
        resize(  [0.51,0.5,0.054]) rotate([90,0,0])sphere(10,center=true,$fn=10);
        }
    }}
    //////
    }
