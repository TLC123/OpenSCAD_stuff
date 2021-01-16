
//====================
// OpenSCAD version of the openCscad tool here:
// - https://github.com/smcameron/opencscad

// User editable parameters
// None yet

//---------------------------------
// Random seed control is critical.
// The seed defines all the variation. Using the same seed will give the same ship.
//
$seed = floor(rands(0,1000000,1)[0]);
// $seed = 970439;
max_random_values = 300;
echo("Seed=",$seed);
function randn(n,idx=0) = floor(rands(0,n,max_random_values, $seed)[idx]);
function randf(n,idx=0) = rands(0,n*1000,max_random_values, $seed)[idx] / 1000.0;

// echo(randn(10,0), randn(10,1));
// echo(randf(12.5,0), randf(12.5,1));

cyl_res = 40;
sph_res = 80;
Gseed = false;
verbose = false;

//---------------------------------
// from opencscad
module cyl(h,r1,r2,ctr=false) {
//if (verbose) {echo("cyl", h, r1, r2, ctr);}
cylinder(h=h, r1=r1, r2=r2, center=ctr, $fn=cyl_res);
}

//---------------------------------
// cylinder_rings
//
module cylinder_rings(length, r1, r2, nrings, rand_idx) {
if (verbose) {echo("cyl_rings", nrings, rand_idx);}
ringspacing = length / (nrings + 1.0);
ringheight = ringspacing / 3.0;
z = -(ringspacing *nrings) / 2.0;
dstart = ringspacing;
rstart = r1 *1.3;
dr = ((r2* 1.3) - rstart) / nrings;
//
for (i = [0:nrings]) {
z = (i+1) *ringspacing + dstart;
r = (i+1) * dr + rstart;
translate([0, 0, z])
cyl(ringheight, r, r, true);
}
}

// cylinder_ribs
module cylinder_ribs(length, r1, r2, nribs, rand_idx) {
if (verbose) {echo("cyl_ribs", rand_idx);}
dangle = 360.0 / nribs/4;
extra_factor = randf(1, rand_idx)+1;
//
for (i=[0:nribs]) {
angle = dangle*i;
rotate([0, 0, angle])
intersection() {
union() {
translate([max(r1, r2)* 1.05, 0, 0]);
cube(size=[max(r1, r2)* 2, max(r1, r2)* 2, length + 2], center=true);
translate([max(r1, r2)* -1.05, 0, 0]);
cube(size=[max(r1, r2)* 2, max(r1, r2)* 2, length + 2], center=true);
translate([0, max(r1, r2), 0]);
cube(size=[max(r1, r2)* 2.1, max(r1, r2)* 2.1, length + 2], center=true);
}
cyl(length, r1*extra_factor, r2*(extra_factor*0.8), true);
}
}
}

// cylindrical_thing
module cylindrical_thing(length, r1, r2, rand_idx) {
if (verbose) {echo("cyl_thing", rand_idx);}
cyl(length, r1, r2, true);
cylinder_rings(length, r1, r2, randn(3, rand_idx) + 5);
}

// cylinder_protrusions
module cylinder_protrusions(length, r1, r2, nprotrusions, rand_idx, excess=1.5) {
if (verbose) {echo("cylinder_protusions", rand_idx);}
intersection() {
// cyl(length, r1 excess, r2 excess, true);
cylindrical_thing(length, r1* excess, r2 *excess, rand_idx);
//
union() {
rand_local = rand_idx+1;
for (i = [0:nprotrusions]) {
h = ((randn(80, rand_local) + 20) / 100.0)* length;
z = -((length - h) / 2.0)* (randn(100, rand_local+1) / 100.0);
x = min(r1, r2)* randf(0.2, rand_local+2);
angle = randf(360.0, rand_local+3);
translate([0, 0, z])
rotate([0, 0, angle])
cube(size=[x, max(r1, r2)* 3, h], center=true);
rand_local = rand_local + 1;
}
}
}
}

// random_cylinder_protrusions
module random_cylinder_protrusions(length, r1, r2, nelaborations, rand_idx) {
if (verbose) {echo("rand_cyl_protrusions", rand_idx);}
nprots = randn(5, rand_idx) + 5;
pheight = randf(0.1, rand_idx+1);
l = (1.0 - randf(0.7, rand_idx+2))* length / nelaborations;
offset = randf((length / 2.0) - (l / 2.0), rand_idx+3);
if (randn(100, rand_idx+4) < 50) {
offset = -offset; }
translate([0, 0, offset])
cylinder_protrusions(l, ((r1 + r2) / 2.0)* (1 + pheight), ((r1 + r2) / 2.0) * (1 + pheight), nprots, rand_idx+5);
}

// random_cylinder_ribs
module random_cylinder_ribs(length, r1, r2, nelaborations, rand_idx) {
if (verbose) {echo("rand_cyl_ribs", rand_idx); }
nribs = randn(5, rand_idx) + 5;
ribheight = randf(0.3, rand_idx+1);
l = (1.0 - randf(0.7, rand_idx+2))* length / nelaborations;
offset = randf((length / 2.0) - (l / 2.0), rand_idx+3);
if (randn(100, rand_idx+4) < 50) {
offset = -offset; }
translate([0, 0, offset])
cylinder_ribs(l, ((r1 + r2) / 2.0) *(1 + ribheight), ((r1 + r2) / 2.0) * (1 + ribheight), nribs, rand_idx+5);
}

// random_cylinder_rings
module random_cylinder_rings(length, r1, r2, nelaborations, rand_idx) {
if (verbose) {echo("rand_cyl_rings", rand_idx);}
nrings = randn(4, rand_idx) + 1;
ringheight = randf(0.05, rand_idx+1);
l = (1.0 - randf(0.7, rand_idx+2)) *length / nelaborations;
offset = randf((length / 2.0) - (l / 2.0), rand_idx+3);
if (randn(100, rand_idx+4) < 50) {
offset = -offset;}
translate([0, 0, offset])
cylinder_rings(l, r1 *(1 + ringheight), r2 * (1 + ringheight), nrings, rand_idx+5);
}

// block_pile
module block_pile(length, r1, r2, rand_idx) {
if (verbose) {echo("block_pile", rand_idx);}
w = max(r1, r2);
pod_module(length *0.9, w* 0.7);
block_count = randn(40, rand_idx) + 20;
rand_local = rand_idx;
for (i =[0:block_count]) {
x = 0.8 *(randf(w, rand_local+1) - (w / 2.0));
y = 0.8 *(randf(w, rand_local+2) - (w / 2.0));
z = 0.8 * (randf(length - (length / 2.0),rand_local+3));
sx = randf(w / 2.0, rand_local+4) + w / 2.0;
sy = randf(w / 2.0, rand_local+5) + w / 2.0;
sz = randf(w / 2.0, rand_local+6) + w / 2.0;
translate([x, y, z])
cube(size=[sx, sy, sz], center=true);
rand_local = rand_local + 1;
}
}

// elaborate_cylinder
module elaborate_cylinder(length, r1, r2, nelaborations, with_spheres=false, rand_idx) {
if (verbose) {echo("elaborate_cylinder",length, r1, r2, nelaborations, with_spheres, rand_idx);}
cyl(length, r1, r2, true);
for (i = [0:nelaborations]) {
e = randn(3, rand_idx);
if (e==0) {
random_cylinder_protrusions(length, r1, r2, nelaborations, rand_idx+1+i);
} else if (e==1) {
random_cylinder_ribs(length, r1, r2, nelaborations, rand_idx+1+i);
} else if (e==2) {
random_cylinder_rings(length, r1, r2, nelaborations, rand_idx+1+i);
}
}
//
if (with_spheres) {
translate([0, 0, -length / 2.0])
if (randn(100, rand_idx+2) < 30) {
if (verbose) {echo(" elab=sph-cyl");}
difference() {
sphere(r1, $fn=sph_res);
//
translate([0, 0, -r1/2.0])
cyl(r1* 1.2, r1* 0.9, r1* 0.7, true);
}
} else if (randn(100, rand_idx+3) < 30) {
if (verbose) {echo(" elab=thrustcluster");}
rotate(180, 0, 1, 0)
thruster_cluster(r1, rand_idx+4);
} else {
if (verbose) {echo(" elab=sphonly");}
sphere(r1, $fn=sph_res);
}
//
translate([0, 0, length / 2.0])
if (randn(100, rand_idx+5) < 50) {
if (verbose) {echo(" sph-r2");}
sphere(r2, $fn=sph_res);
} else {
difference() {
if (verbose) {echo(" sph2-cyl");}
sphere(r2, $fn=sph_res);
//
translate([0, 0, r2 / 2.0])
cyl(r1* 1.2, r2* 0.9, r2 *0.7, true);
}
}
}
//
}

// thruster_module
module thruster_module(length, r1, r2, rand_idx) {
if (verbose) {echo("thruster_module", length, r1, r2, rand_idx);}
nelaborations = randn(2, rand_idx)+1;
difference() {
elaborate_cylinder(length, r1, r2, nelaborations, false, rand_idx+1);
//
translate([0, 0, length* 0.05])
cyl(length, r1* 0.95, r2 * 0.95, true);
}
}

// thruster
module thruster_variant(length, r1, r2, rand_idx) {
if (verbose) {echo("thruster_variant", length, r1, r2, rand_idx);}
v = randf(0.3, rand_idx) - 0.15 + 1.0;
v2 = randf(0.3, rand_idx+1) - 0.15 + 1.0;
thruster_module(length, r1 *v, r2* v2, rand_idx+2);
}

// thruster_cluster
module thruster_cluster(r, rand_idx) {
if (verbose) {echo("thruster_cluster", rand_idx);}
ttype = randn(3, rand_idx);
cyl(r* 0.2, r, r, true);
v1 = randf(0.3, rand_idx+1) - 0.15 + 1.0;
v2 = randf(0.3, rand_idx+2) - 0.15 + 1.0;
v3 = randf(0.3, rand_idx+3) - 0.15 + 1.0;
translate([0, 0, r *0.1]) {
if (ttype==0) {
if (verbose) {echo("thrust");}
thruster_variant(r* v1 * 1.5, r* v2* 0.4, r *v3, rand_idx+4);
} else {
if (verbose) {echo("thrust xN");}
n = randn(7, rand_idx+4) + 2;
r1 = r* 0.5* v1;
r2 = r *0.2* v2;
r3 = r *0.7;
thruster_variant(r1 *v3 *1.5, r1* v2* 0.4, r1* v3, rand_idx+5);
angle = 360.0 / n;
for (i=[0:n]) {
a = i*angle;
rotate([0,0,a])
translate([r3,0,0])
thruster_module(r2 *v3* 1.5, r2* v2* 0.4, r2 * v3, rand_idx+6+i);
}
}
}
}

// fuselage_module
module fuselage_module(length, r1, r2, rand_idx) {
if (verbose) {echo("fuselage_module", rand_idx);}
nelabs = randn(3, rand_idx) + 2;
squashx = 1.0;
squashy = randf(0.5, rand_idx+1) + 0.5;
if (randn(100, rand_idx+2) < 50) {
squashx = randf(0.5, rand_idx+3) + 0.5;
squashy = 1.0;
}
scale([squashx, squashy, 1.0]) {
if (randn(100, rand_idx+4) < 50)
elaborate_cylinder(length, r1, r2, nelabs, true, rand_idx+5);
else
block_pile(length, r1, r2, rand_idx+5);
}
}

// spar_module
module spar_module(length, angle, rand_idx) {
if (verbose) {echo("spar_module", rand_idx);}
squash = 0.3 + randf(0.7, rand_idx);
r = length / (10.0 + randf(10.0, rand_idx+1));
rotate([0,angle,0])
scale([1.0, squash, 1.0])
cyl(length, r, r * randf(0.4, rand_idx+2) + 0.4, false);
}

// pod_module
module pod_module(length, r, rand_idx) {
if (verbose) {echo("pod_module", rand_idx);}
scale([r / 10.0, r / 10.0, length / 20.0])
sphere(r=10.0, $fn=sph_res);
}

// ring
module ring(length, rand_idx) {
if (verbose) {echo("ring", rand_idx);}
r = length* randf(0.5, rand_idx) + 0.5;
h = (r *0.4) - randf(0.2, rand_idx+1);
difference() {
cyl(h, r, r, true);
cyl(h + 1, r* 0.95, r *0.95, true);
}
}

// outrigger_module
module outrigger_module(length, rand_idx) {
if (verbose) {echo("outrigger_module", rand_idx);}
dualpod = (randn(100, rand_idx) < 50);
angle = randn(60, rand_idx+1) + 90;
//
spar_length = length;//(1+randn(2));
spar_module(spar_length, angle, rand_idx+2);
translate([sin(angle) *spar_length, 0, cos(angle)* spar_length])
//translate([0,0,spar_length/3/(2+randn(4))])
if (randn(100, rand_idx+2) < 50)
pod_module(length / 3.0, length / 10.0, rand_idx+3);
else
fuselage_module(length / 3.0, length / 10.0, length / 12.0, rand_idx+3);
//
if (dualpod) {
if (verbose) {echo(" dualpod"); }
dprad = randf(spar_length* 0.8, rand_idx+3) + spar_length* 0.1;
translate([sin(angle)* dprad, 0, cos(angle)* dprad])
//translate([0,0,-spar_length/3/(1+randn(4))])
if (randn(100, rand_idx+4) < 50)
pod_module(length / 3.0, length / 10.0, rand_idx+5);
else
fuselage_module(length / 3.0, length / 10.0, length / 12.0, rand_idx+5);
}
//
if (randn(100, rand_idx+5) < 10) {
if (verbose) {echo(" ring");}
dprad = randf(length *0.8, rand_idx+6) + length* 0.1;
translate([0, 0, cos(angle) * dprad])
ring(length, rand_idx+7);
}
}

// outrigger_set_module
module outrigger_set_module(maxlength, minlength, rand_idx) {
if (verbose) {echo("outrigger_set_module", rand_idx);}
length = randf(maxlength - minlength, rand_idx) + minlength;
if (randn(100, rand_idx+1) < 20) {
n = randn(8, rand_idx+2) + 1;
angle = 360.0 / n;
for (i=[0:n]) {
rotate([0,0,angle*i])
outrigger_module(length, rand_idx+2+i);
}
} else {
angle = randn(360, rand_idx+3);
if (randn(100, rand_idx+4) < 30) {
angle = randn(4, rand_idx+5)* 90;
}
rotate([0, 0, angle])
outrigger_module(length, rand_idx+6);
}
}

// cut_in_half
module cut_in_half(size) {
if (verbose) {echo("cut in half");}
intersection() {
translate([0, -size/2.0, -size/2.0])
cube(size=size, center=false);
//
children(0);
}
}

// bilaterally_symmetricalize
module bilaterally_symmetricalize(size) {
if (verbose) {echo("Symmetry");}
cut_in_half(size) children(0);
mirror([1,0,0])
cut_in_half(size) children(0);
}

// ship_module
module ship_module(rand_idx=0) {
if (verbose) {echo("Ship module");}
fuselage_module(30 + randn(60), randn(10) + 8, randn(10) + 8, rand_idx);
outrigger_count = randn(2, rand_idx+1)+1;
for (i=[0:outrigger_count]) {
outrigger_set_module(60, 5, rand_idx+2+i);
}
}

// Main
module ship() {
if (randn(100) < 20) {
echo("ship",$seed);
bilaterally_symmetricalize(10000) ship_module();
} else {
ship_module();
}
}

rotate([90,0,0])
ship();