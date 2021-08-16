g=160/(17);
r=.7;
linear_extrude(2)
offset(.5)offset(-.25)union()
{
    difference(){
union(){difference(){
square(160,center=true);
offset(-2)
square(160,center=true);
}
for(r=[0:90:360])rotate(r)translate([80,80]) circle(6);
}
for(r=[0:90:360])rotate(r)translate([80,80]) circle(3);
}



johnny();    
mirror([1,0,0])johnny();    

mirror([0,1]){johnny();    
mirror([1,0,0])johnny();    }

}

module johnny() {
    
intersection(){
square(160*.5);
   union() {
for(x=[-0:g*1.4:160],y=[-0:g*1.4*2:80 ])translate([x,y])translate([-g*.7,-g])
{ pin();
translate([-g*.7,g*1.4])pin();
}}
}

}
module pin()
{

hull()
{circle(r);
    translate([0,g*2])circle(r);
    
    }
    hull()
{translate([g*.7,g*1.3])circle(r);
    translate([0,g*2])circle(r);
    
    }
    
        hull()
{translate([g*.7,g*1.3])circle(r);
    translate([g*1.4,g*2])circle(r);
    
    }
    
    
}