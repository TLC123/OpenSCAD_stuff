$fn=100;
g=rnd(5,15);
g2=rnd(5,15);
intersection(){
linear_extrude(10)outline();
halfdome ();

}

intersection(){
 linear_extrude(10, convexity = 10)difference(){ outline(); offset(r=-1.5,$fn=20)outline();}
  halfdome (1);

}
intersection(){
 translate([0,0,7]) linear_extrude(6,scale=0.2, convexity = 10)difference(){offset(r=-3,$fn=20) outline();  }
  halfdome (0.5);

}

intersection(){
 translate([0,0,7]) linear_extrude(6,scale=0.2, convexity = 10)
offset(r=-6,$fn=20) outline(); 
  halfdome (1);

}


module outline(){

offset(1)offset(-1)
difference(){
intersection(){
translate([-g,0,0])circle(20);
translate([g,0,0])circle(20);
translate([0,-g2,0])circle(20);}
union(){
translate([-5,-g2+21,0])circle(3);
translate([5,-g2+21,0])circle(3);
translate([-12,0,0])circle(2);
translate([12,0,0])circle(2);

}
}
}
module halfdome (i=0 ){
translate([0,-5,0])scale([1.1,2.5,1])

rotate_extrude( convexity = 10) {

intersection(){square(20+i);

difference(){
 

hull(){

translate([0,i,0])circle(10);
translate([0,0,0])circle(10);}
translate([0,-0,0])circle(8);
}}}}
 

function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);