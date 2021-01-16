echo(distance_point2plane([0,0,50],[100,0,0],[-1,0,0]));

function distance_point2plane(point, planes_origin, planes_normal) =
let (v = point - planes_origin)   (v.x * planes_normal.x + v.y * planes_normal.y + v.z * planes_normal.z)); 