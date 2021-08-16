simplyfy() hull()union(){
rotate(rands(0,360,3))    cube(26,true);
rotate(rands(0,360,3))    cube(26,true);
rotate(rands(0,360,3))    cube(26,true);
};

module simplyfy(lim=100000)
scale(lim)
render()union(){
  color("blue")  sphere(.1/lim);
 scale(1/lim)render()children();
}