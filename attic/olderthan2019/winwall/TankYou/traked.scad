track();
mirror([0,1,0])track();


module track(){
xlist=[
[0, 30],
[1, 0],
[2, -15],
[3, 20],
[4, 60], 
[5, 40],
[6, 0],// allway the same as nr1
[7,-15]// allway the same as nr2
];

ylist=[
[1, 0],
[2, 10],
[3, 8],
[4, 12], 
[5, 0],
[6, 0],// allway the same as nr1
[7,10]// allway the same as nr2
];
function x(p)= lookup(p, xlist);
function y(p)= lookup(p, ylist);
//trackmagic
translate([0,-8,0])rotate([90,0,0])
union(){
intersection(){
    union(){
for (i = [1:0.1:6]) {
 ah=0.42;
 	
    ro=atan2(y(i+ah)-y(i-ah),x(i+ah)-x(i-ah));

 	//translate([(x(i-0.2)+x(i+0.2))/2, (y(i-0.2)+y(i+0.2))/2,0])
    translate([x(i), y(i),0]) 
    rotate([0,0,ro])
    translate([0,5,0])
    rotate([0,0,-ro])
    cylinder(r=4,15.001,center=true,$fn=7);
}
}
difference(){
union(){
 for (i = [1:0.1:6]) {
 ah=0.42;
 	 	    ro=atan2(y(i+ah)-y(i-ah),x(i+ah)-x(i-ah));

    color("Red")
    translate([x(i), y(i),0]) 
    rotate([0,0,ro])translate([0,0,0])cylinder(r=5,h=15,center=true);
    }
}
union(){
 for (i = [1:0.1:6]) {
 ah=0.42;
 	 	    ro=atan2(y(i+ah)-y(i-ah),x(i+ah)-x(i-ah));

    color("Blue")
    translate([x(i), y(i),0]) 
    rotate([0,0,ro])translate([0,0,0])cylinder(r=4,h=16,center=true);
    }
}
}

}


// wheels

wsp=1;// wheel spacing
//large wheels
 for (i = [1:wsp:6]) {
 ah=0.42;
 	    ro=atan2(y(i+ah)-y(i-ah),x(i+ah)-x(i-ah));

    color("Gray")
    translate([x(i), y(i),0]) 
    rotate([0,0,ro])translate([0,0,2])resize([9,9,3])wheel();
    }
    
 //small wheels
   
     for (i = [1+wsp*0.43:wsp/4:6]) {
 ah=0.42;
    ro=atan2(y(i+ah)-y(i-ah),x(i+ah)-x(i-ah));
    color("Gray")
    translate([x(i), y(i),0]) 
    rotate([0,0,ro+10])translate([0,1.5,-1])resize([6,6,3])wheel();
    }
//skirt
    
intersection(){
     hull(){
     for (i=[2:1:4]) {
 
    color("Red")
    translate([x(i), y(i),0]) 
    translate([0,4,0])cube([18,8,16],center=true);
    }}
    
    difference(){
        hull(){
     for (i=[2:1:4]) {
 
    color("Red")
    translate([x(i), y(i),0]) 
    translate([0,0,-8])cylinder(r=7,h=16,$fn=8);
    }}
        hull(){
     for (i=[2:1:4]) {
 
    color("Red")
    translate([x(i), y(i),0]) 
    translate([0,0,-4])cylinder(r=6,h=14,$fn=8);
    }}
    
    }
}

//filler
hull(){
     for (i=[1:1:6]) {
 
    color("Blue")
    translate([x(i), y(i),0]) 
    translate([0,0,-7.501])cylinder(r=4.5,h=6.2,$fn=8);
    }}

}
}    
    module wheel(){
        translate([0,0,-2])
        difference(){
        cylinder(r=4,h=3);    
        translate([0,0,2])cylinder(r=3,h=2);
        }
        cylinder(r=1,h=1);
        
        }