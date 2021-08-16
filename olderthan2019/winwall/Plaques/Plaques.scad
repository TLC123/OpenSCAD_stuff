Seed=8321815916372415397;//
plate=[135,85];//
thickness=3;
fudge=0.05;//
/*[Hidden]*/
dir=[rnd(-0,-0.5,Seed),0.5,0]*10;

color("Goldenrod")difference(){
translate([0,plate[1]*fudge,-thickness]) linear_extrude(height = thickness +1,  convexity = 10, scale=0.97,$fn=20)offset(r=3, chamfer=true)offset(r=-3, chamfer=false) square(plate,center=true);
mirror([0,0,1])translate([0,plate[1]*fudge,-2]) linear_extrude(height = 2,  convexity = 10, scale=0.97,$fn=20)offset(delta=3, chamfer=true)offset(r=-5, chamfer=false) square(plate,center=true);
}


up=[0,0,-2];
{
// first run
color("DarkGoldenrod")for(t=[rnd(-40,-10,Seed+1):rnd(15,20,Seed+3):rnd(10,60,Seed+2)]){
spiral([-1,0,0],dir,t);
mirror([1,0,0])spiral([-1,0,0],dir,t);
}
//second run
dir2=[-0.5,-0.1-rnd(0.7,0,Seed+4),0]*10;
color("Goldenrod")for(t=[rnd(-40,-10):rnd(15,20,Seed+5):rnd(10,60,Seed+6)]){
spiral([-1,0,0],dir2,t);
mirror([1,0,0])spiral([-1,0,0],dir2,t);
}
}

// modules
module spiral(op,dir,t, i=0){
magfield=[0,0,cos(i*t)*3];
ndir=dir*0.85+cross(dir,magfield)*0.1;// blend dirction with force ( nonscientific)
np=op+ndir;
line(op,np);
if(i<25){spiral(np,ndir,t,i+1);}


}



module line(p1, p2) {
  hull() {
    translate(p1) rotate([0,0,-45]) scale([0.5,2,1])sphere(1);
    translate(p2) rotate([0,0,-45])scale([0.5,2,1])sphere(1);
  }
}
function rnd(a = 0, b = 1,S) = (rands(min(a, b), max(a, b), 1)[0]);
