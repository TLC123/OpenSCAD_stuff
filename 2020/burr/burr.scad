$fn=58;
f=sqrt(300) ;
v=atan2(sqrt(2),1);
echo(v);
burr();
rotate(60)burr();

module burr()
scale([1,1,.5])difference()  {
    
    hull()             {
rotate(.1)rotate([v,0,0])rotate(45)   cube(10);
rotate(-.1)rotate([v,0,0])rotate(45)   cube(10);
    }
  
translate([0,0,f*.5])torus(f*.5-1,2.85);
 translate([0,0,f*.85])scale(.75)torus(f*.5-3,2.85);
 translate([0,0,f*.15])scale(.75)torus(f*.5-3,2.85);
}
module torus(a,b)                  {
    
    rotate_extrude(convexity=100)translate([a,0,0])circle(b);
    }