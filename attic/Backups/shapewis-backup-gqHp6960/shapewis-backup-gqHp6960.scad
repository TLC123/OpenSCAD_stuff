$fn=50;
cut(7,100,100,0,0)

offset(delta=6,chamfer=true) offset(delta=-4,chamfer=true)difference()       
{circle(50);
translate([0,0,0])circle(30);
translate([-0,21,0])scale([50,3,1])circle(1);
translate([-0,-21,0])scale([50,3,1])circle(1);
translate([-0,-0,0])scale([50,2,1])circle(1);}

module cut(i,xm,ym,x,y)
{
  offset(r=0.5) offset(r=-0.5)difference()       
{children();
offset(delta=-2,chamfer=true)children();
}

if (i>0){
cut(i-1 )
 
   offset(delta=-3,chamfer=true)children();  

 }
 
}