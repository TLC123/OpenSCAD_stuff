line=[rands(0,10,3),un(rands(-1,1,3))];
translate(line[0])color("blue") sphere(0.3);
planex=rands(0,10,1)[0];
planey=rands(0,10,1)[0];
planez=rands(0,10,1)[0];

#translate([planex,0,0]) rotate([0,-90,0])linear_extrude(0.01)square(10 );
#translate([0,planey,0]) rotate([90,0,0])linear_extrude(0.01)square(10);
#translate([0,0,planez]) rotate([0,0,0])linear_extrude(0.01)square(10);

function intersectXPlane(planex,line=[[0,0,0],[1,0,0]])=[planex,line[0].y,line[0].z]+((planex-line[0].x))*[0,line[1].y,line[1].z]/line[1].x;


function intersectYPlane(planey,line=[[0,0,0],[0,1,0]])=[line[0].x,planey,line[0].z]+((planey-line[0].y))*[line[1].x,0,line[1].z]/line[1].y;


function intersectZPlane(planez,line=[[0,0,0],[0,0,1]])=[line[0].x,line[0].y,planez]+((planez-line[0].z))*[ line[1].x,line[1].y,0]/line[1].z;



 
translate(intersectXPlane(planez,line )) sphere(0.2);
translate(intersectYPlane(planey,line )) sphere(0.2);
translate(intersectZPlane(planez,line )) sphere(0.2);


function un(v) = v / max(norm(v), 0.000001) * 1; // div by zero safe unit normal
translate(line[0])
hull(){
    sphere(0.1);
    translate(line[1]*10)sphere(0.1); 
    translate(-line[1]*10)sphere(0.1); }