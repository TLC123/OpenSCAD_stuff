color("yellow")  translate([-190-100,-85,0])import("sherp.stl");
 

 r=[90,0,90];
 for(a=[0:16])
rotate(2*a)translate([a*150,0,0])rotate(2*a)scale(.5)trailer(r+[0,0,-2*a],a);



module trailer(r,n){
    rd=200 ;
    h=150  ;
    l=200 ;
    w=70;
color("darkgray")    {
translate([-150,0,55])cube ([l/2,5,5],center=true);
//translate([-130-l,0,50])cube ([l,5,5],center=true);
}

color("darkgray")hull(){
translate([-10,0,50])cube ([l+40,5,5],center=true);
translate([0,w,25])cube ([80,5,5],center=true);
translate([0,-w,25])cube ([80,5,5],center=true);
}

color("darkgray")hull(){
translate([50,0,50])cube ([10,15,5],center=true);
translate([0,0,h])cube ([10,5,5],center=true);
}
color("darkgray")
hull(){
translate([-50,0,50])cube ([10,15,5],center=true);
translate([0,0,h])cube ([10,5,5],center=true);
    
}
color("gray")translate([0,0,h+10]) rotate(r)scale([.4,1])hull(){
cylinder(2,rd+4,rd+4,$fn=6,center=true);
 cylinder(5,rd,rd,$fn=6,center=true);
}

color("black")
{translate([35,-w-10,25])rotate([90,0,0]) wh();
 translate([-35,-w-10,25])rotate([90,0,0]) wh();
translate([35,w+10,25])rotate([90,0,0]) wh();
 translate([-35,w+10,25])rotate([90,0,0]) wh();
}
}
module wh(){hull(){
 cylinder(13,30,30,$fn=36,center=true);
 cylinder(18,25,25,$fn=36,center=true);
}}