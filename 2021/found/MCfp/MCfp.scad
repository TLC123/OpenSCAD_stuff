 {translate([-170,0,0]){
 *color("blue" ) hull()
{ color("Red")translate ([50,50,50]) sphere(0.1); 
color("Red") translate ([50,50,-50]) sphere(0.1);
color("Red")translate ([-50, 50,-50]) sphere(0.1);
color("Red")translate ([50,-50,-50]) sphere(0.1);
MC();
}
cell();}

translate([0,0,0])
{
MC();
cell();
color("Yellow")translate ([-30,-30,30]) sphere(5);
 pseudofeature();
}

translate([ 170,0,0]){
 EMC();
cell();

}

}

module pseudofeature (){
 *color("blue" ) hull(){
 color("Red")translate ([50,50,50]) sphere(0.1); 
color("Red") translate ([50,50,-50]) sphere(0.1);
color("Red")translate ([-50, 50,-50]) sphere(0.1);
color("Red")translate ([50,-50,-50]) sphere(0.1);

hull(){ 
translate ([-30,-30,30]) sphere(0.1);
  translate ([0,-50,-50]) sphere(0.1);}
 hull(){ translate ([-30,-30,30]) sphere(1);translate ([-50,0,-50]) sphere(0.1);}
 hull(){ translate ([-30,-30,30]) sphere(1);translate ([50,0,50]) sphere(0.1);}
hull(){ translate ([-30,-30,30]) sphere(1); translate ([50,-50,0]) sphere(0.1);}
hull(){ translate ([-30,-30,30]) sphere(1); translate ([-50,50,0]) sphere(0.1);}
hull(){ translate ([-30,-30,30]) sphere(1); translate ([0,50,50]) sphere(0.1);}}
}

module EMC(){





 
 
color("Red")translate ([0,-50,-50]) sphere(3);


color("Red")translate ([-50,0,-50]) sphere(3);

 
 color("Red")translate ([50,0,50]) sphere(3);

 
color("Red")translate ([50,-50,0]) sphere(3);
 
 color("Red")translate ([-50,50,0]) sphere(3);

color("Red")translate ([0,50,50]) sphere(3);

color("Yellow")translate ([-30,-30,30]) sphere(5);

color("Yellow")translate ([20,-50,-20]) sphere(3);
color("Yellow")translate ([-40,50,40]) sphere(3);


color("Yellow")translate ([50,-40,40]) sphere(3);
color("Yellow")translate ([-50,20,-20]) sphere(3);


color("Yellow")translate ([-40,-40,-50]) sphere(3);
 color("Yellow")translate ([ 20,20,50]) sphere(3);

 
 *color("blue" ) hull(){
 color("Red")translate ([50,50,50]) sphere(0.1); 
color("Red") translate ([50,50,-50]) sphere(0.1);
color("Red")translate ([-50, 50,-50]) sphere(0.1);
color("Red")translate ([50,-50,-50]) sphere(0.1);


color("Red")translate ([0,-50,-50]) sphere(0.1);


color("Red")translate ([-50,0,-50]) sphere(0.1);

 
 color("Red")translate ([50,0,50]) sphere(0.1);

 
color("Red")translate ([50,-50,0]) sphere(0.1);
 
 color("Red")translate ([-50,50,0]) sphere(0.1);

color("Red")translate ([0,50,50]) sphere(0.1);

color("Yellow")translate ([-30,-30,30]) sphere(0.1);

color("Yellow")translate ([20,-50,-20]) sphere(0.1);
color("Yellow")translate ([-40,50,40]) sphere(0.1);


color("Yellow")translate ([50,-40,40]) sphere(0.1);
color("Yellow")translate ([-50,20,-20]) sphere(0.1);


color("Yellow")translate ([-40,-40,-50]) sphere(0.1);
 color("Yellow")translate ([ 20,20,50]) sphere(0.1);

 }
}




module MC(){

 {color("Red")translate ([0,-50,-50]) sphere(3);
color("Red")translate ([-50,0,-50]) sphere(3);

}
 {color("Red")translate ([50,0,50]) sphere(3);
color("Red")translate ([50,-50,0]) sphere(3);

}
 {color("Red")translate ([-50,50,0]) sphere(3);
color("Red")translate ([0,50,50]) sphere(3);

}
hull(){color("Red")translate ([0,-50,-50]) sphere(1);
color("Red")translate ([-50,0,-50]) sphere(1);

}
hull(){color("Red")translate ([50,0,50]) sphere(1);
color("Red")translate ([50,-50,0]) sphere(1);

}
hull(){color("Red")translate ([-50,50,0]) sphere(1);
color("Red")translate ([0,50,50]) sphere(1);

}



hull(){color("Red")translate ([50,-50,0]) sphere(1);

color("Red")translate ([0,-50,-50]) sphere(1);


}
hull(){


color("Red")translate ([0,50,50]) sphere(1);
color("Red")translate ([50,0,50]) sphere(1);


}
hull(){
color("Red")translate ([-50,0,-50]) sphere(1);

color("Red")translate ([-50,50,0]) sphere(1);


}
}



module cell(){
color("Red")translate ([50,50,50]) sphere(5);
translate ([-50, 50,50]) sphere(5);

translate ([-50,-50,50]) sphere(5);
translate ([50,-50,50]) sphere(5);

color("Red") translate ([50,50,-50]) sphere(5);

color("Red")translate ([-50, 50,-50]) sphere(5);
translate ([-50,-50,-50]) sphere(5);

color("Red")translate ([50,-50,-50]) sphere(5);

hull(){
translate ([50,50,50]) sphere(1);
translate ([-50, 50,50]) sphere(1);
}
hull(){
translate ([50,50,50]) sphere(1);
translate ([50, -50,50]) sphere(1);
}
hull(){
translate ([50,50,50]) sphere(1);
translate ([50, 50,-50]) sphere(1);
}
 
hull(){
translate ([-50,-50,50]) sphere(1);
translate ([-50, 50,50]) sphere(1);
}
hull(){
translate ([-50,-50,50]) sphere(1);
translate ([50, -50,50]) sphere(1);
}
hull(){
translate ([-50,-50,50]) sphere(1);
translate ([-50, -50,-50]) sphere(1);
}


hull(){
translate ([-50, 50,-50]) sphere(1);
translate ([-50, 50,50]) sphere(1);
}
hull(){
translate ([-50, 50,-50]) sphere(1);
translate ([50,  50,-50]) sphere(1);
}
hull(){
translate ([-50, 50,-50]) sphere(1);
translate ([-50, -50,-50]) sphere(1);
}

hull(){
translate ([ 50, -50,-50]) sphere(1);
translate ([50, -50,50]) sphere(1);
}
hull(){
translate ([ 50, -50,-50]) sphere(1);
translate ([50,  50,-50]) sphere(1);
}
hull(){
translate ([ 50, -50,-50]) sphere(1);
translate ([-50, -50,-50]) sphere(1);
}
}