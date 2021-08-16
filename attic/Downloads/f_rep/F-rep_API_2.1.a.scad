use <../github/util-libs/lists.scad>
use <../github/util-libs/linear_algebra.scad> 
//include <user_primitives.scad>

// Change log from version 2 and 2.1
//
//  - f_mesh_evaluation parameters
//  - sweep revision: _tree_max_eval, _primitive_max_eval definitions
//  - f_primitive, primitive_eval
//  - f_operator, user_operator_eval
//  - f_offset definition
//  - f_block definition
//  - f_convex_polihedron definition
//  - f_capsule definition
//  - transform composition
//  - transform corrections 
//  - move f_mesh_evaluation to f_mesh.scad

// This library defines all functions to define f-rep solids, 
// transform and operate them. Besides, it includes an evaluation
// function that returns the field value of a f-rep solid.
//
// If the user code needs to define its own primitive and/or its
// own operator, this file must be included<> in the user code.
// Otherwise, it may be just used.

// f_rep API
/*
// primitives
function f_hspace( point = [0,0,0], dir=[1,0,0]) =
function f_convex_polyhedron(hsl) =
function f_cylinder( h, r, rt) =
function f_block(size=1, r=0, ch=0) =
function f_sphere( r=1 ) = 
function f_torus( R=3, r=1 ) = 
function f_capsule(p0=[0,0,0],p1=[0,0,1],r=1, a=1) =
function f_primitive( data ) = 

// CSG operators
function f_union(f_rep1, f_rep2) =
function f_difference(f_rep1, f_rep2) =
function f_intersection(f_rep1, f_rep2) =
function f_difference(f_rep1, f_rep2) =
function f_complement(f_rep1) = 

// other operators
function f_twist(f_rep, angle, extent) =       
function f_sweep(f_rep, line) =
function f_blend(f_rep1, f_rep2, factor=0.5) =
function f_offset(f_rep, value=0) =
function f_Pasko_blend(f_rep1, f_rep2, a ) =
function f_union_r(f_rep1, f_rep2, alpha) =
function f_intersection_r(f_rep1, f_rep2, alpha) =
function f_difference_r(f_rep1, f_rep2, alpha) =
function f_operator(f_rep1, f_rep2=[], data) =

// affine transforms
function f_mirror(f_rep, v=[1,0,0]) =
function f_rotation(f_rep, rot=[0,0,0]) =
function f_axis_rotation(f_rep, point=[0,0,0], axis=[0,0,1], angle=0) = ////
function f_rotation_to(f_rep, from=[0,0,1], to=[0,0,1]) =
function f_translation(f_rep, vect=[0,0,0]) =
function f_scale(f_rep, scale=1) =
function f_transform(f_rep, transf4=ident4()) = 

// helper functions
function is_frep(f_rep) = 
function f_treeSize(f_rep) = 

// evaluation 
function f_evaluate( pt, f_rep ) =

// user provided primitive evaluation
function primitive_eval(pt, data) =

// user provided operator evaluation
user_operator_eval( pt, left, right, data ) =

*/

// *******************************
//  Operator tree data structure
//********************************
// primitive types
_HFSP = 30; // halfspace

_RBLK = 33; // rounded block
_CRBL = 34; // chamfered and rounded block
_SPH  = 35; // sphere
_CYL  = 36; // cylinder
_TOR  = 37; // torus
_CAPS = 38; // capsule
_FUNC = 39; // user primitive
_HBAG = 40; // intersection of half-spaces
_CIRC = 20; // 2D circle

// node types
_TRANS = 100;   // transform
_UNI   = 101;   // union
_CMPL  = 102;   // complement
_INTRS = 103;   // intersection
_DIFF  = 104;   // difference
_SWP   = 105;   // sweep
_BLND  = 106;   // blend
_RUNI  = 107;   // r union
_RINT  = 108;   // r intersection
_RDIF  = 109;   // r difference
_PBLN  = 110;   // Pasko blend
_TWST  = 111;   // twist
_OFFS  = 112;   // offset
_USOP  = 120;   // user operator
_LEAF  = -1;    // tree leaf (primitive)

_node_sign = 7812; // just for API checks

// Primitive data structure
// Each primitive is a leaf of the f_rep tree.
// The list of a primitive stores 
//      id     - an identification of the primitive
//      transf - an affine transformation in the form of a 4x4 matrix
//      data   - a data field specific of the primitive
function _prim_new(id, data, transf=ident4()) =
    [_node_sign, _LEAF, transf, id, data ];

function _prim_id(prim)     = prim[3];
function _prim_data(prim)   = prim[4];
function _prim_transf(prim) = prim[2];

// Tree node data structure
// The tree nodes store
//      type     - the operator the node represents
//      ltree  - the left sub-tree
//      rtree - the right sub-tree or [] if none
//      data  - appropriate data list for the node
function _node_new(type, ltree, rtree=[], data=0 ) =
    [_node_sign, type, ltree, rtree, data ];

function _node_type(node)  = node[1];
function _node_data(node)  = node[4];
function _node_left(node)  = node[1] == _LEAF ? [] : node[2];
function _node_right(node) = node[1] == _LEAF ? [] : node[3];

function _is_prim(f_rep) = ( f_rep[1] == _LEAF );

function _is_node(f_rep) = ( f_rep[0] == _node_sign );

//*************************
// 2D Primitives
//*************************
// 
// Each primitive defined in the system has two functions:
// an API function which generates a tree with just a leaf node
// and an internal evaluation function to be called by the
// tree evaluation function.

function f_circle(r=1) =
    let( rr   = r == undef ? 1 : r*r )
    _prim_new( _CIRC, [ rr ] );

function _circle_eval( pt2D, data) =
    data.x - pt[0]*pt[0] - pt[1]*pt[1];

function f_rectangle(w, h) =
    _prim_new(_RECT, [w/2, h/2]);

function _rectangle_eval( pt2D, data) = // Ravachev definition
    let( a= data.x, b=data.y )
    data*data - pt*pt 
        -sqrt( pow(a*a-pt[0]*pt[0], 2) + pow(b*b-pt[1]*pt[1], 2) );

//*************************
// 3D Primitives
//*************************

// 
// Each primitive defined in the system has two functions:
// an API function which generates a tree with just a leaf node
// and an internal evaluation function to be called by the
// tree evaluation function.

// Void primitive for internal use
function _void() = [];
function _void_eval() = -1e32;

// Primitive half-space *********************
// The API of half-spaces has as arguments:
//      point - a point in the boundary of the half-space
//      dir   - the normal to the plane passing by point, 
//              pointing to the interior of the half-space
function f_hspace(p=[0,0,0], d=[0,0,1]) =
    is_list_of([p,d],[0,0,0]) ?
        let( dir = unit(d) )
        _prim_new(_HFSP, [ p*dir, dir ]):
        _void();

function _hspace_eval( pt, data) =
    pt*data.y - data.x;

function _hspace_max_eval( pt1, pt2, data) =
    max(_hspace_eval( pt2, data), _hspace_eval( pt2, data)) ;
    
// Convex polyhedron ****************************
// a primitive representing a convex polyhedron
// It is the intersection of a list of half-spaces
// hsl is a list of [point, vector]
function f_convex_polyhedron(hsl) =
    is_list_of(hsl,[[0,0,0],[0,0,0]]) ?
        let( val = [for(h=hsl) h[0]*unit(h[1])],
             dir = [for(h=hsl) unit(h[1])])
        _prim_new(_HBAG, [val, dir]) :
        _void();
    
function _convPolyh_eval(pt, data) = min(data.y*pt-data.x);
         
// Primitive block, eventually rounded and/or chamfered ***********************
function f_block(size=1, r=0, ch=0) =
    let( s = len(size)==3 ? size/2 : [1,1,1]*size/2 ) 
    _is_pos(s) ?
        r>=0 && ch==0 ? // simple or rounded block
            _prim_new(_RBLK,[s-[r,r,r],r]):
        r==0 && ch>0 ? // chamfered block
            let( u=[0,0,0,ch,ch,ch,ch*sqrt(3)]/sqrt(2))
            _prim_new(_CRBL,[s,0,u]):
        r> 0 && ch>0 ? // chamfered and rounded block
            let( cr = ch/sqrt(2)-r/tan(67.5),
                 u  = [0,0,0,cr,cr,cr,cr*sqrt(3)] )
           _prim_new(_CRBL,[s-[r,r,r],r,u]):
           _void():
        _void();
             
// Rounded block eval
function _Rblock_eval(pt,data)= 
    let( d = _abs(pt) - data.x) 
    data.y                   // offset for rounding
    - min(max(d),0)          // model interior
    - norm(clampMin(d,0)) ;  // model exterior

// normals to side and chamfer planes
_M = [[1,0,0],[0,1,0],[0,0,1],  // octant bounding planes
      [1,1,0]/sqrt(2),[0,1,1]/sqrt(2),[1,0,1]/sqrt(2), // edge chamfer planes
      [1,1,1]/sqrt(3)]; // vertex chamfer plane

// Chanfered and rounded block eval
function _Cblock_eval(p,data)= 
    let( d = _M*(_abs(p)-data.x) + data.z )
    data.y                   // offset for rounding
    - max(d)                 // distance inside model
    - norm(clampMin(d,0)) ;  // distance outside model
    
// Primitive cylinder/cone  ***************************************
// The API of cylinders has as arguments:
//      h  - the cylinder height along the z axis
//      r  - the radius of the cylinder base centered at the origin of the xy plane
//      rt - top radius; ignored if either r or d is defined
// The cylinder has its axis middle point at the origin
function f_cylinder( h, r, rt) =
    let( rb = r  != undef ? r  : 1 ,
         r2 = rt != undef ? rt : r ,
         h0 = h  != undef ? h  : 1 )
    (rb==0 && r2==0) || (rb<0) || (h0<=0) ?
        _void() :
        _prim_new( _CYL, [ rb, h0/2, (r2-rb)/h0 ] );
        
function _cyl_eval(pt, data) = 
    let( v = data.x + (pt[2]+data.y)*data.z - norm([ pt[0], pt[1] ]) ) 
    min(v, data.y - pt[2], pt[2] + data.y); // intersection

function _cyl_max_eval(pt1, pt2, data) = // ****
    let( m = min([abs(pt1[2]), abs(pt2[2])]) )
    m > 2 ?
        -m*m :
        let( p = [ pt2[1]-pt1[1], pt2[0]-pt1[0] ],
             pr = p*[ pt1[0], pt1[1] ] )
        data.x - pr;

// Primitive capsule  ***********************************
// A capsule is a cylinder with spherical basis
// The basis center are p0 and p1 and r is their radius.
// The a parameter controls the radius along the cylinder:
//  if a==1 the radius is constant
//  if 0<a<1 the radius is proportionally smaller in the middle
//  if a>1 the radius grows proportionally in the middle
function f_capsule(p0=[0,0,0],p1=[0,0,1],r=1, a=1, r2=1) =
    _prim_new( _CAPS, [ p0,p1,r,a,r2-r ] );
    
function _caps_eval0(pt,data) =
    let( v = data.x, w = data.y, r=data.z,
         a = data[3],
         pv = pt-v, 
         wv = w-v,
         h  = a==1? 0: clamp( pv*wv/(wv*wv), 0, 1) )
     a==1 ? 
        r - norm(pv-wv*h) :
        r*((1-a)*(cos(360*h)/2+1/2)+ a) - norm(pv-wv*h);

function _caps_eval(pt,data) =
    let( v = data.x, w = data.y, r=data.z,
         a = data[3],
         pv = pt-v, 
         wv = w-v)
//     a==0 ? 
  //      r - norm(pv-wv*h) :
        let( h  = clamp( pv*wv/(wv*wv), 0, 1), 
             g  = data[4],
             ds = h*h*( 4*a*(h-1)*(h-1) + g*(-2*h +3)) )
             
        r+ds - norm(pv-wv*h);
        
//        x*x*( (a-1)*(x-1)^2 + g*(9*x-8) )

// Primitive sphere  ***************************************
// The API of spheres has only one argument:
//      r - the radius of the sphere centered at the origin
function f_sphere( r=1 ) = 
    let( r0   = r == undef ? 1 : r )
    r0<=0 ? 
        _void() :
        _prim_new( _SPH, r0 );

function _sphere_eval( pt, data) =
    data - norm(pt);

function _sphere_max_eval( pt1, pt2, data) =
    let( a = (pt1-pt2)*(pt1-pt2) )
    a < 1e-2*data ?
        data - norm(pt1) :
        let( b = (pt2-pt1)*pt2 )
        b <= 0 ?
            data - norm(pt2) :
            b >= a ? 
                data - norm(pt1) :
                data - norm((b/a)*(pt1-pt2) + pt2);

// Primitive torus  ***********************************
// The API of tori has as arguments:
//      R - the major radius of the torus
//      r - the minor radius of the torus   
function f_torus( R=3, r=1 ) = 
    let( RR     = R == undef ? 3 : R,
         rr     = r == undef ? r : r )
    _prim_new( _TOR, [ RR, rr ] );

// Quilez definition
/*
function _torus_eval0( pt, data) =  
    let( q = [norm([pt.x,pt.y])-data.x, pt.z] )
        data.y - norm(q);
*/

function _torus_eval( pt, data) =  
    // R = data.x, r = data.y
    let( n = norm([pt.x,pt.y]) )
    n < 1e-12 ?
        data.y - data.x :
        data.y - norm(pt - [pt.x, pt.y, 0]*data.x/n);

// alternative torus eval definition
//function _torus_eval( pt, data) = 
//    let( R = data.x, r = data.y, x = pt[0], y = pt[1], z = pt[2] )
//    4*R*R*( x*x + y*y ) - pow( x*x + y*y + z*z + R*R - r*r ,2);

// Primitive user functions  *************************************
// The primitive user function is primitive that may be user defined.
// It is defined by a user provided function with a standard name: primitive_eval
// which should be an evaluation function:
//
//      primitive_eval( point, data )
//
//  that is it returns a real value for a given 3D point and data.
//  By convention, the solid is formed by the points [x,y,z]
//  where the user primitive function has a positive value.
//  The semantics of data is free to be defined by the user.
//  The API of user defined function has only one argument:
//      data - the private data of the primitive which is sent
//             to primitive_eval() when an evaluation is needed
function f_primitive( data ) =
     _prim_new( _FUNC, data );

function _function_eval( pt, data) =
    primitive_eval( pt, data);

//**************************
//  Operators
//************************

// Classical CSG operators

function f_union(f_rep1, f_rep2) =
    !_is_node(f_rep1) || !_is_node(f_rep2) ?
       _void() :
    _node_new(type=_UNI, ltree=f_rep1, rtree=f_rep2 );

function f_intersection(f_rep1, f_rep2) =
    !_is_node(f_rep1) || !_is_node(f_rep2) ?
        _void() :
    _node_new(type=_INTRS, ltree=f_rep1, rtree=f_rep2 );

function f_difference(f_rep1, f_rep2) =
    !_is_node(f_rep1) || !_is_node(f_rep2) ?
        _void() :
    _node_new(type=_DIFF, ltree=f_rep1, rtree=f_rep2 );

// The complement of a solid is the closure of the set 
// of points not belonging to it
function f_complement(f_rep) = 
    !_is_node(f_rep) ?
        _void() :
    _node_new(type=_CMPL, ltree=f_rep, rtree=[] );

// Special geometric operators

function f_twist(f_rep, angle=0, extent=1) = // twist angle for a unitary vertical displacement
    !_is_node(f_rep) ?
        _void() :
    angle<1e-12 ?
        f-rep :
        _node_new(type=_TWST, ltree=f_rep, data=[angle/extent] );

function f_sweep(f_rep, line) =
    !_is_node(f_rep) ?
        _void() :
    _node_new(type=_SWP, ltree=f_rep, data=line );

function f_blend(f_rep1, f_rep2, factor=0.5) =
   !_is_node(f_rep1) || !_is_node(f_rep2) ?
        _void() :
   _node_new(type=_BLND, ltree=f_rep1, rtree=f_rep2, data=factor );

function f_offset(f_rep, value=0) =
    !_is_node(f_rep) ?
        _void() :
    _node_new(type=_OFFS, ltree=f_rep, data=value );

// Pasko and Revachev operators

function f_Pasko_blend(f_rep1, f_rep2, a ) =
    !_is_node(f_rep1) || !_is_node(f_rep2) ?
        _void() :
    _node_new(type=_PBLN, ltree=f_rep1, rtree=f_rep2, data=[a[0], a[1], a[2]] );

function f_union_r(f_rep1, f_rep2) =
    !_is_node(f_rep1) || !_is_node(f_rep2) ?
        _void() :
    _node_new(type=_RUNI, ltree=f_rep1, rtree=f_rep2);

function f_intersection_r(f_rep1, f_rep2) =
    !_is_node(f_rep1) || !_is_node(f_rep2) ?
        _void() :
    _node_new(type=_RINT, ltree=f_rep1, rtree=f_rep2 );

function f_difference_r(f_rep1, f_rep2) =
    !_is_node(f_rep1) || !_is_node(f_rep2) ?
        _void() :
    _node_new(type=_RDIF, ltree=f_rep1, rtree=f_rep2 );

// User operator

function f_operator(f_rep1, f_rep2=[], data) =
    _is_node(f_rep1) ?
        !_is_node(f_rep2) ?
            _node_new(type=_USOP, ltree=f_rep1, rtree=_void(),  data=data ) :
            _node_new(type=_USOP, ltree=f_rep1, rtree=f_rep2, data=data ) :
        _void();
        
// this is a dummy user operator eval for the case the user
// hasn't defined it
//function user_operator_eval( pt, left, right, data ) = -1e6;
        
/*
function f_rot_extrusion(f_rep1, angle) =
    let( max(min(alpha, 1), -0.9) )
    _node_new(type=_RCMP, ltree=f_rep1, rtree=[], data=alph );
*/
//**************************
//  Affine transforms
//**************************

// Mirror

function f_mirror(f_rep, v=[1,0,0]) =
    !_is_node(f_rep) ?
        _void() :
    len(v) != 3 ?
        f_rep :
        let( transf = _mirror(v) )
        _transf(f_rep, transf);

// the mirror transform in respect to plane by the origem orthogonal to v 
function _mirror(v) =
    let(u = unit(v))
    [ [1,0,0] - 2*u[0]*u, [0,1,0] - 2*u[1]*u, [0,0,1] - 2*u[2]*u ];

// Rotations

function f_rotation(f_rep, rot=[0,0,0]) =
    !_is_node(f_rep) ?
        _void() :
    len(rot) != 3 ?
        f_rep :
        let( rx = _rotx(-rot[0]),
             ry = _roty(-rot[1]),
             rz = _rotz(-rot[2]) )
        _transf(f_rep, rx*ry*rz) ;

function f_axis_rotation(f_rep, axis=[0,0,1], angle=0) = 
    !_is_node(f_rep) ?
        _void() :
    let( transf = _axis_rot(axis, angle) )
    _transf(f_rep, transf);

function _axis_rot(axis,ang) =
    let( ax = unit(axis),
         u = cross(ax,[0,1,0]),
         v = u*u>1e-6 ? unit(u) : unit(cross(ax,[1,0,0])),
         w = sin(ang/2)*cross(ax,v) + cos(ang/2)*v )
    _mirror(w)*_mirror(v);

/*
function f_axis_rotation(f_rep, point=[0,0,0], axis=[0,0,1], angle=0) = 
    let( transf = _f_g_rotation(point, axis, angle) )
    _transf(f_rep, transf);
function _f_g_rotation(pt, ax, a) = 
    let( c = cos(-a), 
         s = sin(-a),
         x = ax[0],
         y = ax[1],
         z = ax[2] )
    [ [ c+x*x*(1-c),   x*y*(1-c)-z*s, x*z*(1-c)+y*s, 0 ],
      [ x*y*(1-c)+z*s, c+y*y*(1-c),   y*z*(1-c)-x*s, 0 ],
      [ x*z*(1-c)-y*s, y*z*(1-c)+x*s, c+z*z*(1-c),   0 ],
      [ -pt[0],        -pt[1],        -pt[2],        1 ] ];
*/

function _rotz(a) =
    [ [cos(a),sin(a),0,0], [-sin(a),cos(a),0,0],[0,0,1,0], [0,0,0,1] ];

function _rotx(a) =
    [ [1,0,0,0], [0,cos(a),sin(a),0], [0,-sin(a),cos(a),0], [0,0,0,1] ];

function _roty(a) =
    [ [cos(a),0,sin(a),0], [0,1,0,0], [-sin(a),0,cos(a),0],[0,0,0,1] ];

function f_rotation_to(f_rep, from=[0,0,1], to=[0,0,1]) =
    !_is_node(f_rep) ?
        _void() :
    let( t  = _rotFromTo(from, to),
         t2 = [ concat( t[0], [ 0 ] ),
                concat( t[1], [ 0 ] ),
                concat( t[2], [ 0 ] ),
                [ 0, 0, 0, 1 ] ] )
    _transf(f_rep, t2);

// minimum angle rotation that brings vi to vo
function _rotFromTo(vi,vo) =
    _mirror(unit(vo)+unit(vi))*_mirror(vi);
/*
function f_rotation_to(f_rep, from=[1,0,0], to=[1,0,0]) =
    !_is_node(f_rep) ?
        _void() :
    let( t  = _rotate_from_to(from, to),
         t2 = [ concat( t[0], [ 0 ] ),
                concat( t[1], [ 0 ] ),
                concat( t[2], [ 0 ] ),
                [ 0, 0, 0, 1 ] ] )
    _transf(f_rep, t2);

// based on a rotation function by Oskar Linde found in sweep.scad
function _rotate_from_to(a, b, _axis=[]) = 
    len(_axis) == 0 ?
        _rotate_from_to(a, b, unit(cross(a,b))) :
        _axis*_axis >= 0.99 ? 
            transpose([unit(b),_axis, cross(_axis,unit(b))]) * 
                [unit(a), _axis, cross(_axis,unit(a))] :
            identity_3(); 
*/

// Translation 

function f_translation(f_rep, vect=[0,0,0]) =
    !_is_node(f_rep) ?
        _void() :
    vect == undef || vect*vect < 1e-6 ?
        f_rep :
        _transf(f_rep, _translation(vect));

function _translation(v) = 
    [ [1,0,0,0], [0,1,0,0], [0,0,1,0], [-v[0], -v[1], -v[2], 1 ] ];

// Scale

function f_scale(f_rep, scale=1) =
    !_is_node(f_rep) ?
        _void() :
    let( s = len(scale) == 3 ? scale : 
                len(scale)==1 ? [1,1,1]*scale[0] :
                    abs(scale)>=0 ? [1,1,1]*scale : [1,1,1] )
    norm(s - [1,1,1])<1e-6 || abs(s[0]) < 1e-6 
    || abs(s[1]) < 1e-6 || abs(s[2]) < 1e-6 ? 
        f_rep : 
        _transf(f_rep, _scale(s));
    
function _scale(s) = 
    [ [1/s[0],0,0,0], [0,1/s[1],0,0], [0,0,1/s[2],0], [0,0,0,1] ];

// General affine transform

// Allows that a general affine transformation (4X4 matrix) be applied
// to the f-rep solid similarly to multmatrix.
function f_transform(f_rep, transf4=identity_4()) = 
    !_is_node(f_rep) ?
        _void() :
    let( t = len(transf4)==4 ? len(transf4[0])==4 ? transf4 : undef : undef )
    t == undef ? 
        f_rep : 
        let( inv = invMatrix(t) )
        inv==undef?
            f_rep:
            _transf(f_rep, inv);
/*
//  Geometric transforms does not generate a new node in the tree.
//  Instead, the transform is applied to each primitive of the tree
//  so to reduce the work in the many tree evaluations.
//  At each tree leaf (a primitive) the transform is composed with
//  the primitive transform.
//  Note that each geometric transform generates a new fresh tree.
function _transf0(f_rep, trans ) = 
    _is_prim(f_rep) ?  
        // compose the transform trans with the primitive transform
        let( tr = trans*_prim_transf(f_rep) )
        _prim_new( id     = _prim_id(f_rep), 
                        data   = _prim_data(f_rep), 
                        transf = tr 
                      ) :
        // apply the transform trans to both sub-trees of f_rep
        // the right node may not exist
        let( left  = _transf0( _node_left(f_rep), trans ),
             right = _node_right(f_rep)==[] ? 
                         [] :
                        _transf0( _node_right(f_rep), trans ) )
        _node_new( type     = _node_type(f_rep), 
                   ltree  = left,
                   rtree = right
                 );
*/

// If f_rep is a primitive or a affine transform, f_transf composes
// transf with the transform of f_rep. Otherwise, creates a new
// transform node
function _transf(f_rep, transf ) = 
    _is_prim(f_rep) ?  
        // compose the transform transf with the primitive transform
        let( tr = transf*_prim_transf(f_rep) )
        _prim_new( id     = _prim_id(f_rep), 
                   data   = _prim_data(f_rep), 
                   transf = tr 
                      ) :
    _node_type(f_rep) == _TRANS ?
        // compose the transform trans with the node transform
        _node_new( type     = _TRANS, 
                   ltree  = _node_left(f_rep),
                   right    = [],
                   data = transf * _node_data(f_rep)
                 ):
        _node_new( type     = _TRANS, 
                   ltree  = f_rep,
                   right    = [],
                   data = transf
                 ) ;

///////////////////////////////
//  Point evaluations
///////////////////////////////

function is_frep(f_rep) = _is_node(f_rep);

// Number of nodes in a f-rep tree
function f_treeSize(f_rep) = 
    f_rep==undef || f_rep==[] ?
        0 :
    _is_prim(f_rep) ?
        1 :
        f_treeSize(_node_left(f_rep)) + f_treeSize(_node_right(f_rep)) + 1;

// This is the main function of this file.
// It evaluates a f-rep expression stored in a f_rep tree.

function f_evaluate( pt, f_rep ) =
    !_is_node(f_rep) ? 
        _void_eval() :
        _tree_evaluation( pt, f_rep);

function _tree_evaluation( pt, f_rep) =
    f_rep==undef || f_rep==[] ?
        -1e12 :
    _is_prim(f_rep) ? 
        _prim_eval(pt, f_rep) :
    let( type  = _node_type(f_rep),
         left  = _node_left(f_rep),
         right = _node_right(f_rep),
         data  = _node_data(f_rep) )
    // one operand operators
    type == _TRANS ?
        let( ptt = _transf_points( pt, data) )
        _tree_evaluation( ptt, left) :
    type == _SWP ?
        _sweep_eval( pt, left, data) :
    type == _TWST ?
        _twist_eval( pt, left, data) :
    type == _OFFS ?
        _tree_evaluation( pt, left ) - data :
    // two operand operators
    type == _USOP ?
        user_operator_eval( pt, left, right, data ) :
    let( vleft  = _tree_evaluation( pt, left),
         vright = _tree_evaluation( pt, right) )
    type == _UNI ?
       max( vleft, vright ) :
    type == _CMPL ?
        - vleft :
    type == _INTRS ?
       min( vleft, vright ) :
    type == _DIFF ?
       min( vleft, -vright ) :
    type == _BLND ?
        _blend_eval( pt, vleft, vright, data ) :
    type == _RUNI ?
        _union_r_eval( pt, vleft, vright, data ) :
    type == _RINT ?
        _inters_r_eval( pt, vleft, vright, data ) :
    type == _RDIF ?
        _diff_r_eval( pt, vleft, vright, data ) :
    type == _PBLN ?
        _Pasko_blend_eval( pt, vleft, vright, data ) : //echo("_tree_eval")
    -5e12 ;

function _prim_eval ( pt, prim ) =
    let( id   = _prim_id(prim),
         tr   = _prim_transf(prim),
         ptt  = _transf_points(pt, tr),
         data = _prim_data(prim) )
    id == _HFSP ?
        _hspace_eval( ptt, data ) :
    id == _RBLK ?
        _Rblock_eval( ptt, data ) :
    id == _CRBL ?
        _Cblock_eval( ptt, data ) :
    id == _SPH ?
        _sphere_eval( ptt, data) :
    id == _CYL ?
        _cyl_eval( ptt, data) :
    id == _TOR ?
        _torus_eval( ptt, data) :

    id == _FUNC ?
        _function_eval( ptt, data) :
    id == _CAPS ?
        _caps_eval( ptt, data) :
    id == _HBAG ?
        _convPolyh_eval( ptt, data) :
    id == _CIRC ?
        _circle_eval( ptt, data) :
        undef ;

////////////////////////////////////////
// Evaluations of non-boolean operators  
////////////////////////////////////////

function _blend_eval( pt, vleft, vright, factor ) =
    (1-factor) * vleft + factor * vright;

function _Pasko_blend_eval( pt, vleft, vright, a ) =
    let( den = (1 + pow(vleft/a[1],2) + pow(vright/a[2],2) ) )
    vleft + vright + norm([vleft, vright]) + a[0] / den;

function _union_r_eval( pt, vleft, vright ) =
    ( vleft + vright + norm([vleft, vright]) )/2;

function _inters_r_eval( pt, vleft, vright ) =
    ( vleft + vright - norm([vleft, vright]) )/2;

function _diff_r_eval( pt, vleft, vright ) =
    ( vleft - vright - norm([vleft, vright]) )/2;

function _sweep_eval( pt, f_rep, line) = 
    _tree_max_eval( [ for(p=line) pt-p ], f_rep ) ; 

function _twist_eval( pt, f_rep, data ) =
    let( a = -data.x*pt[2],
         c = cos(a),
         s = sin(a),
         p = [pt[0]*c-pt[1]*s, pt[0]*s+pt[1]*c, pt[2] ] )
    _tree_evaluation(p, f_rep);

// this tree evaluation is used 
function _tree_max_eval( pts, f_rep) =
    _is_prim(f_rep) ? 
        _primitive_max_eval(pts, f_rep) :
    let( type  = _node_type(f_rep),
         left  = _node_left (f_rep),
         right = _node_right (f_rep),
         data  = _node_data(f_rep) )
    type == _UNI ?
        max( _tree_max_eval( pts, left),
             _tree_max_eval( pts, right) ) :
    type == _CMPL ?
        - _tree_max_eval( pts, left) :
    type == _INTRS ?
        min( _tree_max_eval( pts, left),
             _tree_max_eval( pts, right) ) :
    type == _DIFF ?
       min( _tree_max_eval( pts, left), 
            - _tree_max_eval( pts, right) ) :
    type == _OFFS ?
        _tree_max_eval( pts, left) - data :
    type == _TRANS ?
       let( ptts  = _transf_points(pts, data ) )
       _tree_max_eval( ptts, left) : 
        max([ for(pt=pts) _tree_evaluation(pt, f_rep) ]);

function _primitive_max_eval( pts, prim ) =
    let( id   = _prim_id(prim),
         data = _prim_data(prim),
         tr   = _prim_transf(prim),
         ptts = _transf_points(pts, tr) )
    id == _HFSP ?
        max([ for(i=[0:len(pts)-2]) _hspace_max_eval( ptts[i], ptts[i+1], data ) ]) :
    id == _SPH ?
        max([ for(i=[0:len(pts)-2]) _sphere_max_eval( ptts[i], ptts[i+1], data ) ]) :
    id == _CYL ?
        max([ for(i=[0:len(pts)-2]) _cyl_max_eval( ptts[i], ptts[i+1], data ) ]) :
    id == _FUNC ?
        max([ for(pt=ptts) _function_eval( pt, data ) ]) :
        max([ for(pt=ptts) _prim_eval(pt, f_rep) ]);
            
// Some helper functions

function ident4() = [ [1,0,0,0], [0,1,0,0], [0,0,1,0], [0,0,0,1 ] ];

// a general Euclidean norm for nD spaces
function _norm_(a) = sqrt([for(ai=a) ai*ai]*[for(ai=a) 1]);

function unit(v) = _norm_(v)==0? v : v/_norm_(v);

function _is_pos(v) = clampMax(v,0)==0*v;
function _abs(v) = [for(vi=v) abs(vi) ];

// Transform a 3D point p or a list of 3D points p by the 4x4 transform transf
// The result is a 3D point
function _transf_points(p, transf) =
    len(p[0]) == undef ? // it is just a point?
        let( p4D = [ p[0], p[1], p[2], 1 ] * transf )
        [ p4D[0], p4D[1], p4D[2] ] :
        // suppose p is a list of 3D points
        let( p4Ds = [ for(pt=p) [pt[0], pt[1], pt[2], 1] ]* transf )
        [ for(q=p4Ds) [q[0], q[1], q[2]] ];
        

/////////////////////////////////
// Tests
/////////////////////////////////
