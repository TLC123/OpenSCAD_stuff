Detail=6;//
$fn=Detail;
//Do you want veins
doVeins=1;// [0:No, 1:Yes]
//Do you want base surface
doBase=1;// [0:No, 1:Yes]
//Diameter of starting stem
D=15; // [5:.1:50]
//Length of starting stem
L=150; // [50:1:200]
//Angle of Center stem
Ac=5; // [-90:90]
//Position of the Left stem up the initial stem
Pl=.5; // [0:.01:1.0]
//Angle of the Left branch
Al=30; // [-90:90]
//Position of the Right stem up the initial stem
Pr=.5; // [0:.01:1.0]
//Angle of the Right branch
Ar=30; // [-90:90]
//Ratio of size in next level
Rn=.75;// [.5:.01:.8]
//Smallest diameter to render
smallest=4; // [4.0:.1:10.0]

module veins(D,L,Ac,Pl,Al,Pr,Ar,Rn,smallest=2) {
  if (D>smallest) {
    rod(D,L);
    translate([0,L,0])
     rotate([0,0,Ac])
       veins(D*Rn,L*Rn,Ac,Pl,Al,Pr,Ar,Rn,smallest);
    translate([0,L*Pl,0])
     rotate([0,0,Al])
       veins(D*Rn,L*Rn,Ac,Pl,Al,Pr,Ar,Rn,smallest);
    translate([0,L*Pr,0])
     rotate([0,0,-Ar])
       veins(D*Rn,L*Rn,Ac,Pl,Al,Pr,Ar,Rn,smallest);
  }
}
module veins2D(D,L,Ac,Pl,Al,Pr,Ar,Rn,smallest=2) {
  if (D>smallest) {
    rod2D(D,L);
    translate([0,L,0])
     rotate([0,0,Ac])
       veins2D(D*Rn,L*Rn,Ac,Pl,Al,Pr,Ar,Rn,smallest);
    translate([0,L*Pl,0])
     rotate([0,0,Al])
       veins2D(D*Rn,L*Rn,Ac,Pl,Al,Pr,Ar,Rn,smallest);
    translate([0,L*Pr,0])
     rotate([0,0,-Ar])
       veins2D(D*Rn,L*Rn,Ac,Pl,Al,Pr,Ar,Rn,smallest);
  }
}

module base(D,L,Ac,Pl,Al,Pr,Ar,Rn,smallest=2)
 {
  linear_extrude(height=D*.2)
   // projection(cut=true)

offset(r=20)
  offset(r=-40)
 
  offset(r=20)
    offset(r=30)

offset(delta=20)
  offset(r=-40)
 
  offset(delta=20)
//hull()
{    
        veins2D(D,L,Ac,Pl,Al,Pr,Ar,Rn,smallest);}
 }

module petal(doVeins,doBase,D,L,Ac,Pl,Al,Pr,Ar,Rn,smallest=2) {
   if (doBase==1) 
       base(D,L,Ac,Pl,Al,Pr,Ar,Rn,smallest);
   if (doVeins==1)
     translate([0,0,D*.2])
       veins(D,L,Ac,Pl,Al,Pr,Ar,Rn,smallest);
}

petal(doVeins,doBase,D,L,Ac,Pl,Al,Pr,Ar,Rn,smallest);

module rod(D,L) {
translate([0,L,D/2])
  hull() {
    rotate([90,0,0])
      hull() {
        cylinder(r=D/2,h=L);
        translate([-D/2,-D/2,0])
          cube([D,D/2,L]);
      }
    sphere(r=D/2);
    translate([0,0,-D/2])
    cylinder(r=D/2,h=D/2);
  }
}
module rod2D(D,L) {
//translate([0,L,D/2])
  hull() {
       
        translate([-D/2,  0])
          square([D,L]);
       
     //translate([0,0])   { circle(r=D/2,h=D/2,$fn=20);}
  translate([0,L])   { circle(r=D/2,h=D/2,$fn=20);}
  }
}
