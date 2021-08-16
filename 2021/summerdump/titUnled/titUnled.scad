bord=400;
l=(sin(90+$t*360*17)/2+.5)*90;
r=(sin($t*360*7)/2+.5)*-45;
translate([bord+sin(-90+l)*bord,cos(-90+l)*bord])rotate(r)
{
    mirror([1,0,0])square([800,190]);
   translate([-0,190])   mirror([1,0,0])square([800,190]);
    translate([-0,190*2])  mirror([1,0,0])square([800,190]);
   translate([-0,190*3])   mirror([1,0,0])square([800,190]);
    
     translate([-50,-150])   mirror([1,0,0])square([800,40]);

   mirror([0,1])square([50,90]);
}


translate([180+50,0]) square ([1000,100]);


for(t=[0:1/50 :1]){
l=(sin(90+t*360*17)/2+.5)*90;
r=(sin(t*360*7)/2+.5)*-45;
translate([bord+sin(-90+l)*bord,cos(-90+l)*bord])rotate(r)
{
  *  mirror([1,0,0])square([800,190]);
  * translate([-0,190])   mirror([1,0,0])square([800,190]);
  *  translate([-0,190*2])  mirror([1,0,0])square([800,190]);
  * translate([-0,190*3])   mirror([1,0,0])square([800,190]);
    
   *  translate([-50,-150])   mirror([1,0,0])square([800,40]);

  color("red") translate([50,90])  mirror([0,1])translate([50,90]) square(14);
}
}