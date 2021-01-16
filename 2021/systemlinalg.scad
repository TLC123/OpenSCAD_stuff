

e=distance_point2plane([0,0,-2], [0,0,-2], [0,0,1]);
echo(e);

function baseform(pn)=[pn[1],distance_point2plane(pn[0],[0,0,0], pn[1]) ];


function distance_point2plane(point, planesOrigin, planes_normal) =
 

(point.x-planesOrigin.x) * planes_normal.x + (point.y-planesOrigin.y) * planes_normal.y + (point.z-planesOrigin.z) * planes_normal.z ;



//v.x*n1.x+v.y*n1.y+v.z*n1.z =norm(planesOrigin1)
//v.x*n2.x+v.y*n2.y+v.z*n2.z =norm(planesOrigin2)
//v.x*n3.x+v.y*n3.y+v.z*n3.z =norm(planesOrigin3)
