//use <salvador_richter_primitives.scad>

all();
//holder_simple();
//holder_clamp();
//fan_mount();
//fan_duct();

fan_size      = 40; // [30:10:120]
fan_drill_dist= 32.5; // [30:0.5:120]
fan_drill     =  3; // [2:0.1:6]
channel_len   = 50; // [30:1:100]
channel_open  = 10; // [2:1:20]
channel_wall  =  1; // [0.4:0.1:2]
channel_round =  4; // [2:1:10]
channel_shift = -10; // [-20:1:120]
channel_rotate = -15; // [-30:1:30]

fan_mount_len    = 7; // [5:1:15]
fan_mount_offset = 0; // [0:1:30]

holder_height = 10.1; // [10:1:30]
holder_wall   =  5.0; // [3.5:0.5:8]

holder_simple_drill           =  3.5; // [2:0.1:5]
holder_simple_drill_distance  = 23;   // [15:1:50]

holder_clamp_width = 40; // [20:1:60]
holder_clamp_len   = 15; // [10:1:30]
holder_clamp_gap   =  3; // [1:0.1:5]
holder_clamp_drill =  3; // [2:0.1:6]

selector = "all"; // [all,holder simple,holder clamp,fan duct]


echo ( someparam ) ;

function rnd(a=1,b=0)=(rands(min(a,b),max(a,b),1)[0]);

module all()
{
    if(selector == "all" || selector == "fan duct")
        fan_duct();
    if(selector == "all" || selector == "holder simple")
        translate([-25,0,0]) mirror([1,0,0]) holder_simple();
    if(selector == "all" || selector == "holder clamp")
        translate([-45,0,0]) mirror([1,0,0]) holder_clamp();
}

module fan_mount()
{
    $fn=40;
    difference()
    {
        hull()
        {
            translate([-fan_mount_len,-holder_wall/2,0]) 
                cube([fan_mount_len,holder_wall,holder_height]);
            translate([-fan_mount_len,0,holder_height/2+fan_mount_offset]) 
                rotate([90,0,0]) 
                   cylinder(d=holder_height, h=holder_wall, center=true);
        }
        translate([-fan_mount_len,0,holder_height/2+fan_mount_offset]) 
            rotate([90,0,0]) 
                cylinder(d=holder_height/2, h=holder_wall+0.01, center=true);
    }
}

module fan_duct()
{
    difference()
    {
        union()
        {
            fan_duct_channel();
            translate([0,fan_size/2,0]) fan_mount();
        }
        fan_duct_drills();
    }
}

module holder_simple()
{
    $fn=40;
    
    translate([0,(holder_simple_drill_distance+10)/2,0]) fan_mount();
    difference()
    {
        // base plate
        cube([holder_wall,holder_simple_drill_distance+10,holder_height]);
        // drills inkl counter sunk
        // drill
        translate([0,5,holder_height/2]) rotate([0,90,0]) 
            cylinder(d=holder_simple_drill, h=holder_wall);
        // counter sunk
        translate([0,5,holder_height/2]) rotate([0,90,0]) 
            cylinder(d1=2*holder_simple_drill, d2=0, h=2*holder_simple_drill);
        // drill 
        translate([0,holder_simple_drill_distance+5,holder_height/2]) 
            rotate([0,90,0]) cylinder(d=holder_simple_drill, h=holder_wall);
        // counter sunk
        translate([0,holder_simple_drill_distance+5,holder_height/2]) 
            rotate([0,90,0]) cylinder(d1=2*holder_simple_drill, d2=0, h=2*holder_simple_drill);
    }
}

module holder_clamp()
{
    translate([0,holder_clamp_width/2,0]) fan_mount();
    clamp();
}

module clamp()
{
    $fn=20;
    
    difference()
    {
        // connector and clamp
        hull()
        {
            translate([0,(holder_clamp_width-holder_wall)/2,0]) 
                cube([holder_wall,holder_wall,holder_height]);
            translate([holder_wall,0,0]) 
                cube([holder_clamp_len,holder_clamp_width,holder_height]);
        }
        // clamp cut
        translate([holder_wall+1,0,(holder_height-holder_clamp_gap)/2]) 
            cube([holder_clamp_len-1,holder_clamp_width,holder_clamp_gap]);
        // drills
        translate([holder_wall+holder_clamp_len-5,holder_clamp_width/2,0]) 
            cylinder(d=holder_clamp_drill, h=holder_height/2);
        translate([holder_wall+holder_clamp_len-5,holder_clamp_width/2,holder_height/2]) 
            cylinder(d=holder_clamp_drill+0.5, h=holder_height/2);
    }
}

module fan_duct_drills()
{
    s1 = (fan_size-fan_drill_dist)/2;
    s2 = (fan_size-fan_drill_dist)/2+fan_drill_dist;
    $fn=20;
    
    // drills
    translate([s1,s1,0]) cylinder(d=fan_drill, h=holder_height);
    translate([s1,s2,0]) cylinder(d=fan_drill, h=holder_height);
    translate([s2,s1,0]) cylinder(d=fan_drill, h=holder_height);
    translate([s2,s2,0]) cylinder(d=fan_drill, h=holder_height);
}

module fan_duct_channel()
{
    $fn=40;
    
    difference()
    {
        // outer channel
        hull()
         {
            rounded_cube([fan_size,fan_size,holder_height], rCorner=channel_round, dimensions=2);
            translate([channel_shift,0,channel_len]) 
                rotate([0,channel_rotate,0]) 
            rounded_cube([channel_open, fan_size,0.01], rCorner=channel_round, dimensions=2);
        }
        
        // inner channel
        hull()
        {
            translate([fan_size/2,fan_size/2,0])
                cylinder(r=fan_size/2-channel_wall, h=holder_height, $fn=100);
            translate([channel_shift,channel_wall,channel_len]) 
                rotate([0,channel_rotate,0]) translate([channel_wall,0,0])
            rounded_cube([channel_open-2*channel_wall, fan_size-2*channel_wall,0.02], rCorner=channel_round-channel_wall, dimensions=2);
        }
    }
}

/**********************************************************************/
/******************** required to work in customizer ******************/
/** uncomment "use <salvador_richter_primitives.scad>" for local use **/
/**********************************************************************/

/*
 * cube with rounded edges and corners, depends on param dimensions
 * dimensions 2:   4 edges rounded
 * dimensions 3: all edges rounded corners as well
 */
module rounded_cube(outerCube, rCorner, dimensions=3)
{
    hull()
    {
        for(xPos = [rCorner,outerCube[0]-rCorner])
        {
            for(yPos = [rCorner,outerCube[1]-rCorner])
            {
                if(dimensions==2)
                {
                    translate([xPos,yPos,0]) cylinder(r=rCorner, h=outerCube[2]);
                }
                if(dimensions==3)
                {
                    for(zPos = [rCorner,outerCube[2]-rCorner])
                    {
                        translate([xPos,yPos,zPos]) sphere(r=rCorner);
                    }
                }
            }
        }
    }
}

/*
 * hollow cube, rounded edges only, what else? check param names
 */
module hollow_rounded_cube(outerCube, rCorner, wall, lid=true, bottom=true)
{
    w2 = wall*2;
    innerCube=[outerCube[0]-w2,
               outerCube[1]-w2,
               outerCube[2]-addDelta(wall,-wall,!lid)-addDelta(wall,-wall,!bottom)];
    difference()
    {
        rounded_cube(outerCube, rCorner, dimensions=2);
        translate([wall,wall,addDelta(wall,-wall,!bottom)+0.0001]) 
            rounded_cube(innerCube, rCorner-wall, dimensions=2);
    }
}

function addDelta(value, delta, add=true) = (add==true) ? value+delta : value;
