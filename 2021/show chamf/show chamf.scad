R=rands(-360,360,3);

W();
K();
T();
union(){
 color("lightblue" )A();
 color("lightgreen" )B();
}

module W(){

color("red")
difference(){
minkowski()  
{   intersection(){
A();
B();        }

 sphere(.2,        $fn=12);
}
A();
B();
}
}

module K(){

color("blue")
difference(){
minkowski()  
{   intersection(){
off()A();
B();        }

 sphere(.2,        $fn=12);
}
off()A();
B();
}
}

module T(){

color("green")
difference(){
minkowski()  
{   intersection(){
A();
off()B();        }

 sphere(.2,        $fn=12);
}
A();
off()B();
}
}

module off(){
    
    minkowski()  
    {
        children();
//        cube(1.93,center=true,        $fn=12);
        sphere(1.93,        $fn=12);
        
        }
    
    }


module A()difference(){
    mirror([0,0,1])linear_extrude(13 ,convexity=100)square(13 );
    translate([13,13,-13]*.5)cylinder(14,5,5,center=true);}
    
module B()rotate(R)linear_extrude(13,center=true,convexity=100)square(13,center=true);