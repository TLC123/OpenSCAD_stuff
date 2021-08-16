//  $t=.65;
ta=$t*3000;
//cx=sin(ta)*5;
//cy=cos(ta)*5;
//cz=sin(ta*0.1)*2+2;
cd=20+cos(10-ta*0.7)*5;
        $fn = 360*0.05;

translate([0,0,-3.5])cylinder(0.01,30,30);
color("gray") translate([0,0,-3.5])cylinder(2,4,3);
color("gray") translate([-1,12 ,-3.5])cylinder(.35,2,1.5);
$vpt=[0,0,2];
$vpr=[70+sin(ta)*10,0,-ta*0.25+150];
$vpd=(cd);     
difference(){

rotate([0,-90,0]){


    //
   
 for (i = [-1: 0.05:  min( 5, 0+($t*3000*0.005))]) { 
      color(lerp([0.5,0.5,0.5],[1,1,1],clamp(i*.2,0,1)))  hull() {
            
            
            translate([jsin(  i+(($t*3000*0.005)%0.05)  ) * 0.1, 0, 0])
            translate([(i+(($t*3000*0.005)%0.05)) * 2, min(i+(($t*3000*0.005)%0.05), 0) * -12, 0]) rotate([max(i+(($t*3000*0.005)%0.05), 0) * 360, 0, 0]) translate([0, 0, 2]) cube([2 - 0.05 , 0.01, 0.05], center = true);
            j = i + 0.05;
            
            translate([jsin( j+(($t*3000*0.005)%0.05)  ) * 0.1, 0, 0])
            translate([(j+(($t*3000*0.005)%0.05))* 2, min(j+(($t*3000*0.005)%0.05), 0) * -12, 0]) rotate([max(j+(($t*3000*0.005)%0.05), 0) * 360, 0, 0]) translate([0, 0, 2]) cube([2 - .05 , 0.01, 0.05], center = true);
        }}
        
       for (i = [-1 : 0.05:  min( 5, 0+($t*3000*0.005))]) {   
           if (i>-0.05) color(lerp([1,0.5,0],[0.6,0.6,0.7],clamp(i*.6,0,1))) hull() {
            
            
            translate([jsin(  i +(($t*3000*0.005)%0.05) ) * 0.1, 0, 0])
            translate([(i+(($t*3000*0.005)%0.05)) * 2, min(i+(($t*3000*0.005)%0.05), 0) * -12, 0]) rotate([max(i+(($t*3000*0.005)%0.05), 0) * 360, 0, 0]) translate([1, 0, 2]) cube( [0.05 , 0.06, 0.05], center = true);
            j = i + 0.05;
            
            translate([jsin(  j +(($t*3000*0.005)%0.05) ) * 0.1, 0, 0])
            translate([(j+(($t*3000*0.005)%0.05)) * 2, min(j+(($t*3000*0.005)%0.05), 0) * -12, 0]) rotate([max(j+(($t*3000*0.005)%0.05), 0) * 360, 0, 0]) translate([1, 0, 2]) cube([ .05 , 0.06, 0.05], center = true);
        }
    }

    // uncut stainless
    color("gray") translate([-0.17, 1, 0] * 0.22)
    translate([0, 0, 2])
    linear_extrude(0.05,center=true)
    polygon([
        [-3, 12],
        [-1, 12],
        [0, 6],
        [-2, 6]
    ]);




    // roller support
    color("white")translate([-1.5, 0, 0]) color([0.6, 0.6, 0.6]) rotate([0, 90, 0]) linear_extrude(.3 ) difference() {
        $fn = 30;
        circle(2 + 0.3);
        circle(2 - 0.4);
    }
     // roller support
    color("white")translate([2, 0, 0]) color([0.6, 0.6, 0.6]) rotate([0, 90, 0]) linear_extrude(.3 ) difference() {
        $fn = 30;
        circle(2 + 0.3);
        circle(2 + 0.1);
    }
       // roller support
    color("white")translate([2.2, 0, 0]) color([0.6, 0.6, 0.6]) rotate([0, 90, 0]) linear_extrude(.3 ) difference() {
        $fn = 30;
        circle(2 - 0.15);
        circle(2 - 0.3);
    }
     // final rocket weld
//    color("orange") translate([1, 0, 0]) color([0.6, 0.6, 0.6]) rotate([0, 90, 0]) linear_extrude(2) difference() {
//        $fn = 60;
//        circle(2 + 0.01);
//        circle(2 - 0.002);
//    }
     
    
// color("gold") translate([1, 0, 0]) color([0.6, 0.6, 0.6]) rotate([0, 90, 0]) linear_extrude(1) difference() {
//        $fn = 120;
//        circle(2 + 0.01);
//        circle(2 - 0.002);
//    }
    {
  
    // laser cutter profile edges
    color([0.4, 0.5, 0.7]) translate([-1.8, 12] * 0.5) translate([0, 0, 2]) cube([2.4, 0.5, 1], center = true);

    // coil
   difference(){ color([0.6, 0.6, 0.6]) translate([-2, 12] * 1.025) translate([0, 0, 1]) rotate([0, 0, 7]) rotate([0, 90, 0]) cylinder(2, 1, 1, center = true);  color([0.6, 0.6, 0.6]) translate([-2, 12] * 1.025) translate([0, 0, 1]) rotate([0, 0, 7]) rotate([0, 90, 0]) cylinder(2.1,.3, .3, center = true);}


    // xray and heat treat
    color("red") rotate([30, 0, 0]) translate([1.1, 0, 2]) cube([.5, 0.25, 1], center = true);
    color("orange") rotate([50, 0, 0]) translate([1.2, 0, 2]) cube([.5, 0.25, 1], center = true);
    color("gold") rotate([60, 0, 0]) translate([1.23, 0, 2]) cube([.5, 0.25, 1], center = true);
    color("blue") rotate([90, 0, 0]) translate([1.4, 0, 2]) cube([.5, 0.25, 1], center = true);


    //welder
    color("yellow") rotate([1, 0, 0]) translate([1, 0, 2]) cube([.125, 0.125, 1.5], center = true);
    color([1, .8, .3]) rotate([1, 0, 0]) translate([1, 0, 2]) cube([.4, 0.4, .25], center = true);
   {    $fn = 20;

    // rollers
        color("white") rotate([-30, 0, 0]) 
     {   translate([0.5,0, 1.8]) rotate([0, 90, 0])cylinder(3.5,.11,.11, center = true); 
        translate([.5,0, 2.43]) rotate([0, 90, 0])cylinder(3.5,.11,.11, center = true);
     }
    color("white") rotate([-10, 0, 0]) 
     {   translate([0.5,0, 1.8]) rotate([0, 90, 0])cylinder(3.5,.11,.11, center = true); 
        translate([.5,0, 2.15]) rotate([0, 90, 0])cylinder(3.5,.11,.11, center = true);
     }
   color("white") rotate([20, 0, 0]) 
     {   translate([0.5,0, 1.8]) rotate([0, 90, 0])cylinder(3.5,.11,.11, center = true); 
        translate([.5,0, 2.1]) rotate([0, 90, 0])cylinder(3.5,.11,.11, center = true);
     }
    color("white") rotate([40,0, 0]) 
     {   translate([0.5,0, 1.8]) rotate([0, 90, 0])cylinder(3.5,.11,.11, center = true); 
        translate([.5,0, 2.1]) rotate([0, 90, 0])cylinder(3.5,.11,.11, center = true);
     }
  color("white") rotate([120,0, 0]) 
     {   translate([0.5,0, 1.8]) rotate([0, 90, 0])cylinder(3.5,.11,.11, center = true); 
        translate([.5,0, 2.1]) rotate([0, 90, 0])cylinder(3.5,.11,.11, center = true);
     } 
     color("white") rotate([240,0, 0]) 
     {   translate([0.5,0, 1.8]) rotate([0, 90, 0])cylinder(3.5,.11,.11, center = true); 
        translate([.5,0, 2.1]) rotate([0, 90, 0])cylinder(3.5,.11,.11, center = true);
     }
     
      color("white") rotate([230,0, 0]) 
     {    
        translate([.2,0., 2.]) rotate([0, 0, 0])cylinder(.5,.11,.11, center = true);
     }  
     color("white") rotate([110,0, 0]) 
     {    
        translate([-.459,0., 2.]) rotate([0, 0, 0])cylinder(.5,.11,.11, center = true);
     }
 color("white") rotate([30,0, 0]) 
     {    
        translate([-.9,0., 2.]) rotate([0, 0, 0])cylinder(.5,.11,.11, center = true);
     }
 }
     }}
 
     if ($t>.66)
     { 
                 $fn = 360*0.05;
translate([0,0,2.5+(max(0,$t-0.66)*3000*0.005)])cylinder (40,5,5);
         
        
         
         }     
     }
     
     
  
    
    
       if ($t >.66&&($t-.66)*100<10 )
     { color("white" ) translate([ 0,-($t-.66)*100,  2.6 +min(1,0.2*($t-.66)*100)]) color([0.6, 0.6, 0.6])   linear_extrude(16) difference() {
        $fn = 360*0.05;
        circle(2 + 0.05);
        circle(2 - 0.05);
    }
         
        }
         // final rocket weld
//    color("white",.125) translate([0, 0, 2]) color([0.6, 0.6, 0.6])   linear_extrude(14) difference() {
//        $fn = 360*0.05;
//        circle(2 + 0.024);
//        circle(2 - 0.05);
//    }     
   
     
     
function jsin(s) =
 (
        clamp(sin(  s*5*360   )  , -.25, .25) )*0 ;


function clamp(a, b, c) = min(max(a, min(b, c)), max(b, c));
    function lerp( v1, v2, bias) = (1-bias)*v1 + bias*v2;
