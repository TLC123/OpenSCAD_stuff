/*[Profile]*/
//[Modify ----------------------------------------> Done] v >
 view1 = 0; //[0:1]
// Basic width
A = 50;
// Basic depth
B = 15;
// Lip width
C = 6;
//Lip slope
D = 10;
//lip Sholder
E = 5;
//Material thickness
M = 5;
// Clerance
O = 1;
// Inner Radius
IR = 0.25;
// Outer Radius
OR = 1;
// core hollow
CH=0;//[1,0]
/*[Taper]*/

//[Modify ----------------------------------------> Done] v >
 view2 = 0; //[0:1]
// Extrusion Height
H = 100;
// Taper A, 0=A
AT =0;

// Taper B ,0=B
BT = 0;

// Taper Baseline Offset
TBO=0;
B2O =B+E+D+TBO;

/*[Hole pattern]*/
//[Modify ----------------------------------------> Done] v >
 view3 = 0; //[0:1]
// (Red) List of holes work like this - A slot is holes grouped inside a extra bracket - [  [ [ X,Y,R ] , [ X,Y,R ] ]  , [ X,Y,R ] , [ X,Y,R ] ]                     Here the vertical centerline is x=0
Plate1 = [  [    [0, 80, 3],    [0, 20, 3]  ],  [15, 20, 4],  [-15, 20, 4],  [15, 80, 4],  [-15, 80, 4],  [10, 50, 3],  [-10, 50, 3]];
// (Blue) A B C D E H, all defined values can be used for advanced expressions,  for example [[0,H/2,2.5]] is a single hole at half height.  And [[0,0,0]] is no hole at all.  try [  [    [-A*0.3, H*0.8, 3],    [A*0.3, H*0.2, 3]  ],[    [A*0.3, H*0.8, 3],    [-A*0.3, H*0.2, 3]  ]] 
Plate2 = [  [    [0, 80, 3],    [0, 20, 3]  ],  [10, 50, 3],  [-10, 50, 3]];
// Here are some User defined constants in addition
U1=0;
//User defined constants
U2=0;
//User defined constants
U3=0;
/*[Stops]*/
//[Modify ----------------------------------------> Done] v >
 view4 = 0; //[0:1]

//inner bottom [L,H,W]
S11=[50,10,0];
//inner top  [L,H,W]
S12=[50,20,3];
//outer bottom [L,H,W]
S21=[55,20,3];
//outer top [L,H,W]
S22=[50,2,0];

/*[Parts]*/
//parts 0=both ,1=inner, 2=outer
make = 0; //[1,2,0]
// Detail
$fn = 30;
/*[hidden]*/
B2 = BT == 0 ? B : BT;
A2 = AT == 0 ? A : AT;
//******************************************************
//******************************************************
//******************************************************
//******************************************************
Go();

//******************************************************
module Go() {
  // menu1
  if (view1 == 0) {
    rr() corepack();
    rr() encore();
    translate([0, 0, 0.1]) {
      hdim(-A * 0.5, B + D + E, A, "A");
      hdim(-A * 0.5, B + D + E, C, "C");
      vdim(-A * 0.5, D + E, B, "B");
      vdim(-A * 0.5, E, D, "D");
      vdim(-A * 0.5, 0, E, "E");
    }
  }
  // menu2
  else if (view2 == 0) {
    translate([0, 0, H]) {
      hdim(-A2 * 0.5, (-B2O + B + D + E) * (B2 / B), A2, "AT");
      vdim(-A2 * 0.5, (-B2O + D + E) * (B2 / B), B2, "BT");
      color("White") translate([-A, 0]) square([A * 4, 0.5]);
    }
    linear_extrude( H, convexity = 20,scale = ([A2 / A, B2/B]), slices = 1) translate([0, -B2O, 0]) {
      rr() difference() {
        corepack();
        if (CH==1) offset(r = -M) core(B+E+D);
      }
    }
    translate([max(A2 * 1.5, A * 1.5) + M * 2, 0])
    linear_extrude(H,convexity = 20,  scale = ([A2 / A,  B2/B]), slices = 1) translate([0, -B2O, 0]) {
      rr() encore();
    }
  }
  // menu3
  else if (view3 == 0) {   difference() {
union(){
  color("Red")    translate  ([-(A+M*2+O*2)*0.5,0,0])  cube([A+M*2+O*2,M,H]);
   color("Blue")     translate([max(A2 * 1.5, A * 1.5) + M * 2, 0])
     translate  ([-A*0.5,0,0])   cube([A ,M,H]);
}
   hol(); 
  }}
  else if (view4 == 0) {  
rotate([90,0,0]) difference() {
union(){
    translate  ([-(A+M*2+O*2)*0.5,0,0])  cube([A+M*2+O*2,M,H]);
    translate([max(A2 * 1.5, A * 1.5) + M * 2, 0])
     translate  ([-A*0.5,0,0])   cube([A ,M,H]);

translate ([-S11[0]/2,0,0])cube(S11+[0,M,0]);

translate([max(A2 * 1.5, A * 1.5) + M * 2, 0])
translate ([-S21[0]/2,0,0])cube(S21+[0,M,0]);

translate([0,0,H-S12[2]])
translate ([-S12[0]/2,0,0])cube(S12+[0,M,0]);

translate([0,0,H-S12[2]])
translate([max(A2 * 1.5, A * 1.5) + M * 2, 0])
translate ([-S22[0]/2,0,0])cube(S22+[0,M,0]);

}
  hol();
    }
  }
  //final output menu
  else {
  render(convexity = 20)  difference() {
    union(){  extr();
 if (make == 0 || make == 1) {
translate ([-S11[0]/2,-(B+E+D),0])cube(S11+[0,M,0]);
translate([0,0,H-S12[2]])
translate ([-S12[0]/2,-(B+E+D),0])cube(S12+[0,M,0]);
}
 if (make == 0 || make == 2) {

translate([max(A2 * 1.5, A * 1.5) + M * 2, 0])
translate ([-S21[0]/2,M,0])mirror([0,1,0])cube(S21+[0,M,0]);
translate([0,0,H-S12[2]])
translate([max(A2 * 1.5, A * 1.5) + M * 2, 0])
translate ([-S22[0]/2,M,0])mirror([0,1,0])cube(S22+[0,M,0]);
}
}

      hol();
    }
  }
}

//hole selector
module hol() {
  if (make == 0 || make == 2) {
    translate([max(A2 * 1.5, A * 1.5) + M * 2, 0])
    translate([0, -(B + D + E + M) * 0.5])
    rotate([90, 0, 0])
    linear_extrude( (B + D + E + M) * 2,convexity = 20, center = true)
    makeplate(Plate1, 0);
  }
  if (make == 0 || make == 1) {
    translate([0, -(B + D + E + M) * 0.5])
    rotate([90, 0, 0])
    linear_extrude( (B + D + E + M) * 2,convexity = 20, center = true)
    makeplate(Plate2, 0);
  }
}
//extrusions selector
module extr() {
  if (make == 0 || make == 1) {
    linear_extrude( H,convexity = 20, scale = ([A2 / A,  B2/B]), slices = 1) translate([0, -B2O, 0]) {
      intersection() {
        rr() difference() {
          corepack();
         if (CH==1)   offset(r = -M) core();
        }
* translate([0, B2O]) rotate([0, 0, F]) translate([-(A + M * 2) * 0.5, 0]) square([A + M * 2, B * 2 + M]);;
      }
    }
  }
  if (make == 0 || make == 2) {
    translate([max(A2 * 1.5, A * 1.5) + M * 2, 0])
    linear_extrude( H,convexity = 20, scale = ([A2 / A,  B2/B]), slices = 1) translate([0, -B2O, 0]) {
      intersection() {
        rr() encore();* translate([0, B2O]) rotate([0, 0, F]) translate([-(A + M * 2) * 0.5, 0]) square([A + M * 2, B * 2 + M]);
      }
    }
  }
}
//
module rr( ) {
  offset(r = IR) offset(r = -(IR + OR)) offset(r = OR) children();
}

// core with hollowout
module corepack() {
  difference() {
    core();
  if (CH==1)  offset(r = -M) core(B + E + D);
  }
}
// outer hull
module encore() {
  difference() {
    intersection() {
      translate([-(A + M * 2) * 0.5, 0]) square([A + M * 2, B + D + E + M]);
      offset(r = O + M) core();
    }
    offset(r = O) core();
  }
}
// center core
module core(x = 0) {
  hull() {
    translate([-A * 0.5, D + E]) square([A, B + x]);
    translate([-(A - C * 2) * 0.5, E]) square([A - C * 2, D]);
  }
  translate([-(A - C * 2) * 0.5, 0]) square([A - C * 2, E]);
}
// dim lines 
module hdim(x, y, d, label, lw = 0.5) {
  size = max(2, d / 10);
  d3 = min((d - size) / 2, d * 0.3);
  linel = max(20, d * 0.381) + d * 0.2;
  tline = y + max(20 * 0.95, (d * 0.381 * 0.95)) + d * 0.2;
  color("Black") translate([x, y]) square([lw, linel]);
  color("Black") translate([x + d, y]) square([lw, linel]);
  color("Black") translate([x, tline]) square([d3, lw]);
  color("Black") translate([x + d - d3, tline]) square([d3, lw]);
  color("Blue") translate([x + d * 0.5, tline]) text(str(label), size, valign = "center", halign = "center");
}
module vdim(x, y, d, label, lw = 0.5) {
  size = max(2, d / 10);
  d3 = min((d - size) / 2, d * 0.3);
  linel = max(20, d * 0.381) + d * 0.2;
  tline = max(20 * 0.95, (d * 0.381 * 0.95)) + d * 0.2;
  color("Black") translate([x - linel, y]) square([linel, lw]);
  color("Black") translate([x - linel, y + d]) square([linel, lw]);
  color("Black") translate([x - tline, y]) square([lw, d3]);
  color("Black") translate([x - tline, y + d - d3]) square([lw, d3]);
  color("Red") translate([x - tline, y + d * 0.5, ]) text(str(label), size, valign = "center", halign = "center");
}

function rnd(a = 0, b = 1) = (rands(min(a, b), max(a, b), 1)[0]);
//recursive plate parser
module makeplate(P, a) {
  for (i = [0: len(P) - 1]) {
    if (len(P[i][0]) == undef) {
      translate([P[i][0], P[i][1], 0]) circle(P[i][2] + a);
    } else {
      hull() {
        for (j = [0: len(P[i]) - 1]) {
          translate([P[i][j][0], P[i][j][1], 0]) circle(P[i][j][2] + a);
        }
      }
    }
  }
}