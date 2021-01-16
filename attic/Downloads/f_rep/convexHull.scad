use <lists.scad>
include <voxel_base.scad>
use     <f-mesh.scad>
include <user_primitives.scad>
include <F-rep_API_2.1.a.scad>

// This is a test of the convex hull approximation
//  based on distance fields


//***********************************************
//  Convex hull
//***********************************************
ConvexHull();
module ConvexHull(){
/*
seed = floor(rands(0,1000,1)[0]);
echo(Seed=seed);
s1 = f_sphere(10);
s2 = f_translation(s1,[8,8,8]);
s3 = f_translation(s1,[0,0,-5]);
U1 = f_union(s2,s3);
S = f_convHull(U1,150,seed);
*/
/*
s1 = f_sphere(10);
s2 = f_translation(s1,[8,8,8]);
s3 = f_translation(s1,[0,0,-5]);
U1 = f_union(s2,s3);
S  = f_convHull(U1,6);
*/
    //*
dsl = [0,0,0];
t1 = f_translation(f_torus(r=10,R=30),dsl); 
hs = f_hspace([0,0,0], d=[1,0,0]);
df = f_intersection(t1,hs);
S  = f_convHull(t1,c=4); //echo(t1=t1,S=S);
//*/

//S1 = f_offset(f_block([80,60,40],0,10),4);
//b2 = f_translation(f_block(100),[20,20,0]);
//b2 = f_block(50,r=10);
//S  = f_intersection(b2,SS); echo(b2);
//S  = f_convHull(SS,c=4); 

/*
s1 = f_sphere(10);
s2 = f_translation(s1,[5,5,5]);
d1 = f_difference(s1,s2);
d2 = f_translation(d1,[30,0,0]);
ch = f_convHull(d1,20,seed);
S  = f_union(ch,d2);
*/
domain = [ [-45,-45,-25]+dsl, [45,45,25]+dsl ];
msh1 = f_mesh_evaluation(S, domain, 0.7);
msh2 = f_mesh_evaluation(t1, domain, 0.7);
//intersection(){
//    translate([-40,-30,-20])
//color([0.5,0.5,1,0.5]) 
color([1,0.5,0.5]) 
mesh_surface(msh1, "Torus");
//    translate([-40,-30,-20])
//color([1,0.5,0.5]) mesh_surface(msh2, "Torus");
//cube(100);
//}
//color([1,0.5,0.5,0.5]) mesh_surface(msh2, "Hull");
}


function f_convHull(f_rep,c=4) =
    !_is_node(f_rep) ?
        _void() :
    let( vs = _autohull(f_rep,c)) // list of vectors to build a bounding plane from
    echo(planes=len(vs)) _convHull(f_rep,vs);

function _autohull(model,c) =
    let( far = 1000, // too far out field lines anrent too usefull
         p1 = unit([ 1,  1,  1]),    // tet cornes
         p2 = unit([-1, -1,  1]), 
         p3 = unit([ 1, -1, -1]), 
         p4 = unit([-1,  1, -1]), 
         n = concat( _autohullworker(p1, p2, p3, model, far, c), 
                     _autohullworker(p1, p2, p4, model, far, c), 
                     _autohullworker(p2, p3, p4, model, far, c), 
                     _autohullworker(p1, p4, p3, model, far, c)))
    n ;
    
function _autohullworker(p1, p2, p3, model, far, c) =
    let( e1 = unit(t(_evalGrad(p1*far, model))), 
         e2 = unit(t(_evalGrad(p2*far, model))), 
         e3 = unit(t(_evalGrad(p3*far, model))), 
         p12 = unit((p1 + p2) / 2), 
         p23 = unit((p2 + p3) / 2), 
         p31 = unit((p3 + p1) / 2), 
         C = unit(_avrg([e1, e2, e3])), 
         meancurve = (e1*e2 + e2*e3 + e1*e3) )
    meancurve > 2.7 || c <= 0 ?
     [C] 
    :
     concat( _autohullworker(p1,  p12, p31, model, far, c - 1), 
             _autohullworker(p2,  p23, p12, model, far, c - 1), 
             _autohullworker(p3,  p23, p31, model, far, c - 1), 
             _autohullworker(p12, p23, p31, model, far, c - 1)) ;

function t(v) = [v.x, v.y, v.z]; // Isloate first triplet from list 
function _avrg(l) = [for(i=l) 1]*l/len(l);
    
function _evalGrad(p,f_rep) =
    let( v  = f_evaluate(p, f_rep),
         gx = f_evaluate(p+[1,0,0], f_rep)-v,
         gy = f_evaluate(p+[0,1,0], f_rep)-v,
         gz = f_evaluate(p+[0,0,1], f_rep)-v )
    [gx, gy, gz, v];
/*  
function _convHull(f_rep,pts,i=0,res=[]) =
    i==len(pts)?
        res:
        _convHull(f_rep,pts,i+1,_addHspace(f_rep,pts[i],res));
*/
function _convHull(f_rep,pts,i=0,res=[]) =
    i==len(pts)?
        f_convex_polyhedron(res):
        _convHull(f_rep,pts,i+1,_addHspace(f_rep,pts[i],res));

faraway = 9999999999;

/*
function _addHspace(f_rep,dp,fr) =
    let( q  = faraway*dp,
         v  = f_evaluate(q, f_rep))//-Hulltrace(q,q,f_rep,100))//
    v >=0 ? fr : // q is inside the model
        let( hs = f_hspace( point = (v+faraway)*dp, dir=-dp) )
        f_intersection(fr,hs);
*/
function _addHspace(f_rep,dp,fr) = 
    let( q  = faraway*dp, 
         gv = _evalGrad(q, f_rep),
         g  = [gv.x, gv.y, gv.z],
         v  = gv[3] )
    v >=0 ? fr : // q is inside the model
        let( hs = [-(v+faraway)*g, g] )
        concat(fr,[hs]);

function _addHspace0(f_rep,dp,fr) =
    let( q  = faraway*dp,
         v  = f_evaluate(q, f_rep))
    v >=0 ? fr : // q is inside the model
        let( hs = [(v+faraway)*dp, -dp] )
        concat(fr,[hs]);
        
   //-(q-p0)*dp = -(fw*dp + (-v-fw)*dp)*dp = v*dp*dp = v
