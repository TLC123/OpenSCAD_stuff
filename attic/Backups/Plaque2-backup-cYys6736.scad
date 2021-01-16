Seed=83533115397;//
Calligraphic=1.9;//
CalligraphicSlant=45;//
Oscale=[1.1,1];//
plate=[85,45];//
thickness=3;
fudge=0.35;//
/*[Hidden]*/
v2=rnd(2,4);
v3=rnd(0.9,1.1);
v4=rnd(0.9,1.1);
v5=rnd(0.9,1.1);
v6=rnd(0.9,1.1);
v7=rnd(0,360);
v8=rnd(0,360);
dir=([sin(v7),cos(v7),0])*8*v6;

golds=["DarkGoldenrod","Goldenrod"];
*difference(){
color("DarkGoldenrod")translate([0,plate[1]*fudge,-thickness]) linear_extrude(height = thickness +1,  convexity = 10, scale=0.97,$fn=20)offset(r=3, chamfer=true)offset(r=-3, chamfer=false) square(plate,center=true);
color("Goldenrod")mirror([0,0,1])translate([0,plate[1]*fudge,-1.99]) linear_extrude(height = 2,  convexity = 10, scale=0.97,$fn=20)offset(delta=3, chamfer=true)offset(r=-5, chamfer=false) square(plate,center=true);
}

up=[0,0,-2];
intersection(){
*color("DarkGoldenrod")translate([0,plate[1]*fudge,-thickness]) linear_extrude(height = thickness +1,  convexity = 10, scale=0.97,$fn=20)offset(r=3, chamfer=true)offset(r=-3, chamfer=false) square(plate,center=true);
scale([Oscale[0],Oscale[1],1]){
// first run
 for(t=[rnd(-40,-10,Seed+421):90:rnd(10,60,Seed+432)]){
translate([0,0,-rnd(0.2,0.0,Seed+123+t)])color(golds[round(rnd(1,0,Seed-t))]) spiral([-1,0,0],dir,t);
translate([0,0,-rnd(0.2,0.0,Seed+123+t)])color(golds[round(rnd(1,0,Seed-t))])mirror([1,0,0])spiral([-1,0,0],dir,t);
}
//second run
dir2=([sin(v8),cos(v8),0])*8*v6;
 { for(t=[rnd(-40,-10,Seed):90:rnd(10,60,Seed+556)]){
translate([0,0,-rnd(0.1,0.0,Seed+123+t)])color(golds[round(rnd(1,0,Seed+t))])spiral([-1,0,0],dir2,t,CalligraphicSlant);
translate([0,0,-rnd(0.1,0.0,Seed+123+t)])color(golds[round(rnd(1,0,Seed+t))])mirror([1,0,0])spiral([-1,0,0],dir2,t,CalligraphicSlant);
}}

}}
// modules
module spiral(op,dir,t,cs, i=0){
magfield=[0,0,cos(i +t )*v2];
ndir=dir*0.85*v3+cross(dir,magfield)*0.1*v4;// blend dirction with force ( nonscientific)
np=op+ndir;
line(op,np,cs);
if(i<25){spiral(np,ndir,t,cs,i+1);
if(i<15)if(i%5==2){spiral(np,[ndir[1],-ndir[0],ndir[2]],-t+90,cs+45,i+1);}
}


}



module line(p1, p2,cs=CalligraphicSlant) {
  hull() {
    translate(p1) rotate([-5,5,-cs]) scale([1/Calligraphic,Calligraphic,1])sphere(1,$fn=6);
    translate(p2) rotate([-5,5,-cs])scale([1/Calligraphic,Calligraphic,1])sphere(1,$fn=6);
  }
}
function rnd(a = 0, b = 1,S) = (rands(min(a, b), max(a, b), 1)[0]);
