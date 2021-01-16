function dotself(v) = v * v;

//vec2
function SDF_Tringle(v1, v2, v3, p) =
let (
    /* vec3 */    v21 = v2 - v1, /* vec3 */ p1 = p - v1,
    /* vec3 */    v32 = v3 - v2, /* vec3 */ p2 = p - v2,
    /* vec3 */    v13 = v1 - v3, /* vec3 */ p3 = p - v3,
    /* vec3 */    nor = cross(v21, v13),
    // float     side = dot(p - v1, nor),
    //  float
    dist = sqrt((sign(dot(cross(v21, nor), p1)) +
            sign(dot(cross(v32, nor), p2)) +
            sign(dot(cross(v13, nor), p3)) < 2.0) ?
        min(min(
                dotself(v21 * clamp(dot(v21, p1) / dot(v21, v21), 0.0, 1.0) - p1),
                dotself(v32 * clamp(dot(v32, p2) / dot(v32, v32), 0.0, 1.0) - p2)),
            dotself(v13 * clamp(dot(v13, p3) / dot(v13, v13), 0.0, 1.0) - p3)) :
        dot(nor, p1) * dot(nor, p1) / dot2(nor)))
//    return
/*vec2 */ [dist, side];



//=====================================================
//vec2 
function SDF_Tringle_distlogic( /* vec2 */ v, /* vec2 */ v1) =
//return /*if*/ abs(v1.x - v.x) < // if distances are
    0.00001 * // closer than some fugde factor
    max(max(v1.x, v.x), 1.) // that gets a little larger further out but never below 1
    ?
    (v1.y > v.y ? v1 : v) : //select most positive side
    v1.x <= v.x ? v1 : v; // else the common case;
;

//float 
function sdf_Polyhedron(p, points, faces, count,v) =
//let(e=echo(str("points:",len(points)," points:",len(faces),"at:",count)))
 /*if*/ is_undef(faces) ? sdf_Polyhedron(p, points[0], points[1]) : /*else*/
     /*if*/ is_undef(count) ? sdf_Polyhedron(p, points, faces, len(faces)) : /*else*/
        /*if*/    count < 0 ? /*return*/ (v.x * sign(v.y)) : /*else*/
            /*if*/    is_undef(v) ?    
                let (vo = SDF_Tringle(
                    points[faces[count][0]], 
                    points[faces[count][1]], 
                    points[faces[count][2]], p))
                sdf_Polyhedron(p, points, faces, count - 1, vo): 
            /*else*/
                let (v1 = SDF_Tringle(
                    points[faces[count][0]], 
                    points[faces[count][1]], 
                    points[faces[count][2]], p))
                let (vo = SDF_Tringle_distlogic(v, v1))
                sdf_Polyhedron(p, points, faces, count - 1, vo);