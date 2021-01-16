x = round(rnd(25,150));
y = round(rnd(25,150));
approx_z = rnd(40,200);
steps =  round(rnd(approx_z /5,approx_z /20));
step = round(approx_z/steps);

z = step*steps;
step2 = floor(step * 2);
ext = rnd(1.5,1.7);
radi = rnd(0,3);
verticalsegment = rnd(0,1);
sleeve = round(rnd(35,35));
sleeve_ext = 0;
sleeveext = sleeve*sleeve_ext;
sleeveFN = rnd(3,20);

hx=x/2;
hy=y/2;
 rotate([45,90,rnd(360)]){
color("RoyalBlue" )sleeves();
color("RoyalBlue" )body();
  * translate([0, 0,  -z*0.25])color("Gray" )scale([x*0.5,y*0.5,1])cylinder(z*1.5+sleeve*2,0.9,0.9,  $fn=sleeveFN);
}
echo (ext);
module sleeves() {
  hull() {
    translate([0, 0, verticalsegment+  sleeve]) plane(x, y, 0);
    translate([0, 0,   sleeve]) plane(x, y, 0);
    translate([0, 0, sleeve- min(step,sleeve*0.5)]) sleeve(x, y);
  }
  hull() {
    translate([0, 0, sleeve- min(step,sleeve*0.5)]) sleeve(x, y);
    translate([0, 0, 0]) sleeve(x, y);
  }

  hull() {
    translate([0, 0, sleeve]) plane(x, y, z);
    translate([0, 0, z + sleeve + min(step,sleeve*0.5)]) sleeve(x, y);
  }
  hull() {
    translate([0, 0, z + sleeve + sleeve]) sleeve(x, y);
    translate([0, 0, z + sleeve + min(step,sleeve*0.5)]) sleeve(x, y);
  }
}
module body() {
  for (i = [0: step: z - step]) {
    hull() {
      translate([0, 0, verticalsegment + sleeve]) plane(x, y, i);
      translate([0, 0, sleeve]) plane(x, y, i);
    }
    hull() {
      translate([0, 0, verticalsegment + sleeve]) plane(x, y, i);
      translate([0, 0, sleeve]) plane(x, y, i + step);
    }
  }
}
module plane(x, y, z) {
  translate([0, 0, z]) linear_extrude(0.01) offset(r = radi, $fn = 10){
 square([x -hx * ext + ext*((z +step ) % step2) * ext, y + ((z  ) % step2) * ext], center = true);
 square([x + ((z ) % step2) * ext, y   -hy*ext+ ext*((z +step ) % step2) * ext ], center = true);
}
}
module sleeve(x, y) {
  translate([0, 0, 0]) linear_extrude(0.01) offset(r = radi, $fn = 10) scale([x + sleeveext * 2, y + sleeveext * 2])circle(0.5,$fn=sleeveFN);}

function rnd(a=0,b=1)=(rands(min(a,b),max(a,b),1)[0]);
