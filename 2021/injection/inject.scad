ir=10;
or=15;
a=min(50,sin($t*360)*60);

b=max(0,min(40,a));


mirror([1,0,0])mirror([0,1,0]) color("lightblue")tool();
color("yellow")tool();

mirror([1,0,0]) color("lightblue")klamp();
color("yellow")klamp();


module tool(){
    
rotate(90)
translate([0,b*.5,100+b])//
//rotate([max(0,30*+min(20,a)/60),0,0])
translate([0,15,-150]){
cube([100.,30,100],true);
   translate([35,0,-10])rotate([90,0,0]) cylinder(100,5,5);
//   translate([-35,0,10])rotate([90,0,0]) cylinder(100,5,5);
mirror([0,1,0])   translate([0,90,0])rotate([90,0,0]) cylinder(45,3,3);
    
    hull(){
     translate([35,-90,-10])rotate([90,0,0]) cylinder(10,5,5);
//   translate([-35,-80,10])rotate([90,0,0]) cylinder(20,5,5);
   translate([-0,-90,0])rotate([90,0,0]) cylinder(10,5,5);
    }

//translate([0,15,20])cube([10,10,190],true);

}
}

module klamp(){
fa=50;
ag=90;
ro=30;


translate([-ro-fa,30,-20])rotate([0,-ag+atan2(fa,b),0])cube([fa,10,10]);
translate([-ro-fa,-40,-20])rotate([0,-ag+atan2(fa,b),0])cube([fa,10,10]);
translate([-ro-fa,0,-80])rotate([0,-ag+atan2(fa,b),0])cube([fa,10,10]);
//translate([-ro-fa,-30,-80])rotate([0,-ag+atan2(fa,b),0])cube([fa,10,10]);
}

translate([0,0,a])
translate([0,0,80])color("grey")cylinder(180,ir,ir);

color("red")translate([0,0,max(0,a)])
 {
translate([0,0,155])
linear_extrude(80+min(0,a),twist=360*5,$fn=30)
{
  translate([or-(or-ir)*.5,0]) rotate(-4)scale([1,3]) circle(2,$fn=12);
    
    }



 translate([0,0,5])linear_extrude(60)
{
    
    difference()
    {
        circle(or);
        circle(ir);
        
        }
    }
    
   translate([0,0,5])
linear_extrude(160)
{
    
    difference()
    {
     square([or*3,ir],true);
        circle(or);
        
        }
    }

translate([0,0,120])
linear_extrude(30)
{
    difference()
    {
        circle(or);
        circle(ir);
        
        }
    }
    
linear_extrude(30,scale=.45)
{
    
  offset(2)
  offset(-2)  difference()
    {
     square([100,15],true);
        circle(or);
        
        }
    }    cylinder(5,3,10);
    }