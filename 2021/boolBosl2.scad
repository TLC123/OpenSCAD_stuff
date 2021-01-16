include <BOSL2/std.scad >
include <BOSL2/polyhedra.scad >
include <BOSL2/vnf.scad >
include <BOSL2/triangulation.scad >

c = triangulate_vnf(cylinder(2, 5, 5, $fn = 10));
s = triangulate_vnf(move([4, 0, 2.5], sphere(6, $fn = 12)));
color("red") vnf_wireframe(c, 0.05);
vnf_wireframe(s, 0.05);
//color("blue") inside(c, s);
//color("blue") inside(s, c);
 A=s;B=c;
 
color("pink")showbound(A,B);
showbound(B,A);


// #polyhedron(bf[0],bf[1]);
//


module showbound(A,B){
bf=getBoundary(B, A) ;
 
 for( f=bf[1] )
 {
 p0=bf[0][f[0]];
 p1=bf[0][f[1]];
 p2=bf[0][f[2]];
 v0 = SDF_Polyhedron(p0, A);
 v1 = SDF_Polyhedron(p1, A);
 v2 = SDF_Polyhedron(p2, A);
 
 
 
        if ((   bsign(v0)==-1 && bsign(v1)==1 && bsign(v2)==1) || ( bsign(v0)==1 &&  bsign(v1)==-1&& bsign(v2)==-1) )
        {
        // echo("p0");
        for(i=[0:0.05:1])
        { pint=lerp(p1,p2,i);
        Zp=bisectToZero(p0,pint,v0,SDF_Polyhedron(pint, A),A);
        if(norm(Zp-pint)>0.1)color("blue")translate(Zp) sphere(.1);
        } 
        }
        else if ( (  bsign(v1)==-1 && bsign(v2)==1&& bsign(v0)==1) ||(  bsign(v1)==1 && bsign(v2)==-1&& bsign(v0)==-1) )
        {
        // echo("p1");
        for(i=[0:0.05:1])
        { pint=lerp(p2,p0,i);
        Zp=bisectToZero(p1,pint,v1,SDF_Polyhedron(pint, A),A);
        if(norm(Zp-pint)>0.1)color("blue") translate(Zp) sphere(.1);
        } 
        }
        
        else if ( (  bsign(v2)==-1 && bsign(v0)==1&& bsign(v1)==1) ||(  bsign(v2)==1 && bsign(v0)==-1&& bsign(v1)==-1) ) {
        // echo("p2");
        for(i=[0:0.05:1])
        { pint=lerp(p0,p1,i);
        Zp=bisectToZero(p2,pint,v2,SDF_Polyhedron(pint, A),A);
        if(norm(Zp-pint)>0.1)color("blue") translate(Zp) sphere(.1);
        } 
        }


 }
 }




 
 function bisectToZero(p1,p2,v1,v2,A)=norm(p1-p2)<.015? 
// echo("-")
 p1: //to EPSILON
 let(pint=lerp(p1,p2,0.5))
 let (vi=SDF_Polyhedron(pint, A))
// echo(p1,pint,p2,v1,vi,v2,v1-v2)
 bsign(vi)== bsign(v1)?bisectToZero(pint,p2,vi,v2,A):bisectToZero(p1,pint,v1,vi,A);


function  bsign(v)=sign(sign(v)+.5);//non zero sign()
 
 
 
 
module inside(A, B) {

 for (a = A[0]) {
 if (SDF_Polyhedron(a, B) < 0)
 translate(a) sphere(.2);
 }
}




function getBoundary(A, B) =
//len(A[0])<len(B[0])?getBoundary(B, A):
 let(sides=[for(p=A[0])SDF_Polyhedron(p, B)]) 
 let( boundaryFaces=[
 for(f=A[1])
 let(faceSides=[for(p=f)sign(sides[p])])
// let(ech=echo(faceSides,faceSides[0],all(faceSides,faceSides[0])))
 if(!all(faceSides,faceSides[0]) )
 f
 ]
 )
 [A[0],boundaryFaces]


;


 function all(v,bool=true)=len(search([bool] ,v,0)[0])==len(v);
function triangulate_vnf(m) = [m[0], triangulate_faces(m[0], m[1])];
function clamp(a, b = 0, c = 1) = min(max(a, min(b, c)), max(b, c));
function dotself(v) = v * v;
function dot(a, b) = a * b;
 function un(v) = v / max(norm(v), 1e-64) * 1;
function clamp(a,b=0,c=1) = min(max(a,min(b,c)),max(b,c));
function lerp(start,end,bias) = (end * bias + start * (1 - bias));
function rnd(a,b)=a+(rands(0,1,1)[0])*(b-a);



//vec2
function SDF_Tringle(v1, v2, v3, p) =
//echo(v1, v2, v3, p)
let (

 /* vec3 */
 v21 = v2 - v1, /* vec3 */ p1 = p - v1,
 /* vec3 */
 v32 = v3 - v2, /* vec3 */ p2 = p - v2,
 /* vec3 */
 v13 = v1 - v3, /* vec3 */ p3 = p - v3,
 /* vec3 */
 nor = cross(v21, v13),
 side = dot(p - v1, nor),
 // float
 dist = sqrt((sign(dot(cross(v21, nor), p1)) +
 sign(dot(cross(v32, nor), p2)) +
 sign(dot(cross(v13, nor), p3)) < 2.0) ?
 min(min(
 dotself(v21 * clamp(dot(v21, p1) / dot(v21, v21), 0.0, 1.0) - p1),
 dotself(v32 * clamp(dot(v32, p2) / dot(v32, v32), 0.0, 1.0) - p2)),
 dotself(v13 * clamp(dot(v13, p3) / dot(v13, v13), 0.0, 1.0) - p3)) :
 dot(nor, p1) * dot(nor, p1) / dotself(nor)))
// return
/*vec2 */
[dist, side];



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
function SDF_Polyhedron(p, points, faces, count, v) =
//let(e=echo(str("points:",len(points)," points:",len(faces),"at:",count)))
/*if*/
is_undef(faces) ? SDF_Polyhedron(p, points[0], points[1]) : /*else*/
 /*if*/
 is_undef(count) ? SDF_Polyhedron(p, points, faces, len(faces) - 1) : /*else*/
 /*if*/
 count < 0 ? /*return*/ (v.x * sign(v.y)) : /*else*/
 /*if*/
 is_undef(v) ?
 let (vo = SDF_Tringle(
 points[faces[count][0]],
 points[faces[count][1]],
 points[faces[count][2]], p))
SDF_Polyhedron(p, points, faces, count - 1, vo):
 /*else*/
 let (v1 = SDF_Tringle(
 points[faces[count][0]],
 points[faces[count][1]],
 points[faces[count][2]], p))
let (vo = SDF_Tringle_distlogic(v, v1))
SDF_Polyhedron(p, points, faces, count - 1, vo);



