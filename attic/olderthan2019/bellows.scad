x = 25;
y = 50;
approx_z = 100;
steps = 10;
step = round(approx_z  / steps);
z=step*steps;
step2 = floor(step * 2);
ext = 1.5;
radi = 1;
verticalsegment = 0.2;
sleeve = 20;
sleeve_ext = 0;
sleeveext = sleeve*sleeve_ext;
sleeves();
body();
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
  translate([0, 0, z]) linear_extrude(0.01) offset(r = radi, $fn = 10) square([x + (z % step2) * ext, y + ((z + step) % step2) * ext], center = true);
}
module sleeve(x, y) {
  translate([0, 0, 0]) linear_extrude(0.01) offset(r = radi, $fn = 10) square([x + sleeveext * 2, y + sleeveext * 2], center = true);}

function rnd(a=0,b=1)=(rands(min(a,b),max(a,b),1)[0]);
