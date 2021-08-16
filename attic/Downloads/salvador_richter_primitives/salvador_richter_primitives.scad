Test();
minVal = 0.001;

module Test()
{
    translate([-10,10,0]) pyramid(xFloor=10,yFloor=20, yTop=10);
    translate([-30,10,0]) pyramid(xFloor=20,yFloor=20, xTop=5, yTop=5);
    tri_angle(10,20,5, direction=1);
    //tri_angle(10,20,2, direction=2);
    //tri_angle(10,20,2, direction=3);
    translate([20,10,0]) hollow_cylinder(r1=10,r2=10,h=5,wall=2,center=false, $fn=100);
    translate([-30,-20,0]) rounded_cube(outerCube=[15,15,15], rCorner=3, dimensions=3, $fn=40);
    translate([-7.5,-20,0]) rounded_cube(outerCube=[15,15,15], rCorner=3, dimensions=2, $fn=40);
    translate([15,-20,0]) hollow_rounded_cube(outerCube=[15,15,15], rCorner=3, wall=2, lid=false, $fn=40);
    //hollow_cube([10,20,30], 2, true);
    //hollow_rounded_cube([40,30,30], 5, 1.2, lid=false, bottom=true);
}

/*
 * rectangular pyramid x and y may differ on floor and top
 * possible to create roofs
 */
module pyramid(xFloor=10, yFloor=10, xTop=minVal, yTop=minVal, z=10)
{
    hull()
    {
        cube([xFloor,yFloor, minVal], center=true);
        translate([0,0,z]) cube([xTop,yTop,minVal], center=true);
    }
}

/*
 * rectangular tri angle, with height
 * directions 1-3: the rect angle is located at coordinates 0,0,0
 * direction 0: default, legacy, the rect angle is at x,0
 * negative values changes direction
 * direction 1: xy
 * direction 2: xz
 * direction 3: yz
 */
module tri_angle(a, b, wall, direction=0)
{
    myPoints=[
    [[0,0],[a,0],[a,b]],
    [[0,0],[a,0],[0,b]],
    [[0,0],[a,0],[0,b]],
    [[0,0],[a,0],[0,b]]
    ];
    myRotate=[
    [0,0,0],
    [0,0,0],
    [90,0,0],
    [90,0,90]
    ];
    
    rotate(myRotate[direction])
        linear_extrude(height = wall) 
            polygon( points=myPoints[direction]);
}

/*
 * hollow sphere, outer diameter an wall given
 */
module hollow_sphere(outerDia, wall=1)
{
    difference()
    {
        sphere(d = outerDia);
        sphere(d = outerDia-2*wall);
    }
}

/*
 * hollow cylinder (ring) 
 * uses r1, r2 as outer perimters and h like normal cylinder
 * wall means wall
 */
module hollow_cylinder(r1, r2, h, wall, center=false)
{
    difference()
    {
        cylinder(r1=r1, r2=r2, h=h, center=center);
        cylinder(r1=r1-wall, r2=r2-wall, h=h, center=center);
    }
}

/*
 * hollow cube, what else? check param names
 */
module hollow_cube(outerCube, wall, center=false)
{
    w2 = wall*2;
    difference()
    {
        cube(outerCube, center=center);
        if(center) {
            cube([outerCube[0]-w2,outerCube[1]-w2,outerCube[2]-w2], center=center);
        }
        else {
            translate([wall,wall,wall]) 
                cube([outerCube[0]-w2,outerCube[1]-w2,outerCube[2]-w2], center=center);
        }
    }
}

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
