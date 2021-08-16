use <lists.scad>
use <lines3.scad>
include <user_primitives.scad>
include <f-mesh.scad>
include <F-rep_API_2.1.a.scad>

//////////////////////////////////////////////////////////
// This file is a test bench of many aspects of the system
// Not all tests were reviewed
// Uncomment the test to do
//////////////////////////////////////////////////////////

// f_Rep API memo
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

// evaluation 
function f_evaluate( pt, f_rep ) =

// user provided primitive evaluation
function primitive_eval(pt, data) =

// user provided operator evaluation
user_operator_eval( pt, left, right, data ) =

*/

//*********************************************
//  Torleif's scene
//*********************************************

//Scene();
module Scene() {
    function rnd(a=1, b=0, s=[]) = 
        s == [] ? 
            (rands(min(a,b),max(a,b),1)[0]) : 
            (rands(min(a,b),max(a,b),1,s)[0]);
    
    rot1 = [rnd(-90, 90), rnd(-90, 90), rnd(-90, 90)];
    tl1  = [rnd(-20, 20), rnd(-20, 20), 0];
    rot2 = [rnd(-90, 90), rnd(-90, 90), rnd(-90, 90)];
    tl2  = [rnd(-20, 20), rnd(-20, 20), 0];
    rot3 = [rnd(-90, 90), rnd(-90, 90), rnd(-90, 90)];
    tl3  = [rnd(-20, 20), rnd(-20, 20), 0];
    
    S1  = f_translation(f_rotation(f_block(size=30), rot1), tl1);
    S2  = f_translation(f_rotation(f_sphere(20), rot2), tl2);
    S3  = f_translation(f_rotation(f_block(size=30,r=5), rot3), tl3);
    S23 = f_union(S2, S3);
    S0  = f_union(S1, S23);
    S   = f_translation(S0,[1,0,1]); 
    
    
    domain = [ [-50,-50,-50], [50,50,50] ];
    msh = f_mesh_evaluation(S, domain, 0.85);
    //echo(msh[1][0]);
    mesh_surface(msh, "Torleifs Scene");
}

//*********************************************
//  Capsule primitive
//*********************************************

Capsule();
module Capsule() {
    tst = f_capsule([0,0,0], [6,6,6], 1,-2,2) ;
    val0 = f_evaluate([0,0,0], tst); 
    domain = [ [-10,-10,-10], [10,10,10] ];
    msh = f_mesh_evaluation(tst, domain, 0.7);
    //echo(msh[1][0]);
    mesh_surface(msh, "test");
}

//*********************************************
//  Tapering
//*********************************************

//Taper();
module Taper() {
    // uses an user operator to taper
    bl = f_block([20,20,50]); 
    S  = f_operator(bl,data=[TAPERING, 0.0, 50]);
        
    domain = [ [-15,-15,-30], [15,15,30] ];
    msh = f_mesh_evaluation(S, domain, 0.7); 
    color("brown") mesh_surface(msh, "Taper");
    msh2 = f_mesh_evaluation(bl, domain, 0.5);
    color([0.8,0.8,1,0.3]) mesh_surface(msh2, "block");
    
}
//*********************************************
//  Capsule primitive
//*********************************************
// Based on https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/User-Defined_Functions_and_Modules#Recursive_Modules
// a very complex case requiring fine refinement
//Tree(); 
module Tree(){
    
    function union(mods) = 
        _union(mods,len(mods)-2,mods[len(mods)-1]);
    
    function _union(mods,i,res) =
        i<0 ? 
            res : 
            _union(mods,i-1, f_union(res,mods[i]));
    
    function simple_tree(size, dna, n) =   
        (n > 0) ? 
            let( U =union([for(bd = dna) let( angx = bd[0], angz = bd[1], scal = bd[2])
                        f_rotation(simple_tree(scal*size, dna, n-1),[angx,0,angz]) ] ) )
            //echo(U=U)
            f_union(
                // trunk
                f_capsule([0,0,0],[0,0,size],size/10,0.95),
                // branches
                //echo(size=size,Ut=f_translation(U, [0,0,size]))
                f_translation(U, [0,0,size])
                )
            : // leaves
                f_scale( f_translation(f_rotation( 
                            f_cylinder(r=size/6,h=size/10),
                    [90,0,0]),[0,0,size/6]), [1,1,3]);
    
    // dna is a list of branching data bd of the tree:
    //      bd[0] - inclination of the branch
    //      bd[1] - Z rotation angle of the branch
    //      bd[2] - relative scale of the branch
    dna = [ [12,  80, 0.85], [55,    0, 0.6], 
            [62, 125, 0.6],  [57, -125, 0.6] ];
    
    tree = simple_tree(50, dna, 4); echo(f_treeSize(tree));
    
    
    
    domain = [ [-100,-100,-5], [100,100,250] ];
    msh = f_mesh_evaluation(tree, domain, 0.9);
    color("brown") mesh_surface(msh, "Capsule");
    
}


//***********************************************************
//  Graph of the dist from an ellipsis
//***********************************************************
// Ellipsis(); // to run this, uncomment the follwing def
/*
    // override the user_primitives definition
    function primitive_eval(pt,a) = 
        let( x=pt[0], y=pt[1], z=pt[2], s = 0.08,
             g = s*norm([2*a[0]*x, 2*a[1]*y]),
             v = s*(a[2] - a[0]*x*x - a[1]*y*y ) )
        let( g = 1)
        - z + v / g;   
*/
module Ellipsis(){


    d  = [0,0.7,0];
    a = 1;
    b = 3/8;
    c = 200;
    sc = sqrt(c) / min(a,b);

    elipsis = f_translation(f_primitive([a, b, c]), d);
    domain  = [ [-sc-5,  -sc-5, -5], 
                [sc+5,    sc+5,  17] ];
    msh    = f_mesh_evaluation(elipsis, domain, 0.7);

    union() {
        color([0.8,0.8,1]) mesh_surface(msh, "dist function");
        translate(d)
            color("red") 
              scale([1/sqrt(a), 1/sqrt(b), 1])
                cylinder(r=sqrt(c), h=0.4,center=true);
    }
}

//***********************************************************
//  Graph of the intersection of a circle and a parabola
//***********************************************************
/*
 CirParab(); // to run this, uncomment this whole section
    function circle(pt, r) =
        let( v = r - norm([pt[0], pt[1]]) )
    v;

function parabola(pt, a, b) =
        let( v = -a*pt[0]*pt[0] + b*pt[1] ,
             p0 = -b/a/2,
             w  = norm([b*p0, a*p0*p0]) )
    w;//5*v;///norm([2*a*pt[0],b]);

function primitive_eval(pt, r) =
    let( c1 = parabola(pt, 0.01, 0.06),
         c2 = circle(pt,r) )
     -pt[2]+ c1;//(c1 + c2 + norm([c1, c2]))/2;
         
*/

module CirParab(){
d  = [2.21,0.7,0];
r1 = 20;
r2 = 8.5;

diff   = f_translation(f_primitive(r1), d);
domain = [ [-r1-5,  -r1-5, -45], 
           [r1+5, r1+5,  40] ];
msh    = f_mesh_evaluation(diff, domain, 0.7);
echo(msh[1][1][5]);
union() {
    color([0.8,0.8,1]) mesh_surface(msh, "r-function");
//    translate(d) color("red")cylinder(r=r1, h=1,center=true);
}
}

//***********************************************************
//  Graph of the intersection of a circle and a parabola
//***********************************************************
/*
CirParab();

function circle(pt, r) =
        let( v = r - [pt[0], pt[1]]*[pt[0], pt[1]] )
    v;//r*v/norm([pt[0], pt[1]])/5;

function parabola(pt, a, b) =
        let( v = -a*pt[0]*pt[0] + b*pt[1] )
    v/norm([-a*pt[0],b]);

// this is a r-difference of the circle and parabola
function primitive_eval(pt, data) =
    let( r1 = data[0], 
         c1 = circle(pt, r1) ,
         p1 = parabola(pt, data[1], data[2])  )
     c1;//c1 + p1 + norm([c1, p1]);//-pt[2] + min(c1,p1);//
         
*/
module CirParab(){
d  = [0,0.7,0];
r1 = 20;
r2 = 8.5;

diff   = f_translation(f_primitive([r1, .01, .06]), d);
domain = [ [-r1-5,  -max(r1,r2)-5, -5], 
           [r1+r2+5, max(r1,r2)+5,  20] ];
msh    = f_mesh_evaluation(diff, domain, 0.6);

union() {
    color([0.8,0.8,1]) mesh_surface(msh, "r-diff");
    translate(d)
        color("red") 
            cylinder(r=r1, h=0.3,center=true);
    translate(d)
        color("red") 
            translate([r1,0,0]) 
                cylinder(r=r2, h=0.3,center=true);
}
}
//***********************************************************
//  Graph of the r-function of the difference of 2 circles
//***********************************************************
/*

function circle(pt, r) =
        let( v = r - [pt[0], pt[1]]*[pt[0], pt[1]]/r )
    r*v/norm([pt[0], pt[1]]);

function primitive_eval(pt, data) =
    let( r1 = data[0], r2 = data[1],
         c1 = circle(pt, r1) ,
         c2 = circle(pt-[r1,0], r2) )
     -pt[2] + (c1 - c2 - norm([c1, c2]))/2;
         

d  = [0,0.6,0];
r1 = 10;
r2 = 8;

diff   = f_translation(f_primitive([r1, r2]), d);
domain = [ [-r1-5,  -max(r1,r2)-5, -5], 
           [r1+r2+5, max(r1,r2)+5,  5] ];
msh    = f_mesh_evaluation(diff, domain, 0.8);

union() {
    color([0.8,0.8,1]) mesh_surface(msh, "r-function");
    translate(d)
        color("red") 
            cylinder(r=r1, h=0.1,center=true);
    translate(d)
        color("red") 
            translate([r1,0,0]) 
                cylinder(r=r2, h=0.1,center=true);
}
*/
//*****************************************
//  Graph of the r-function of a rectangle 
//*****************************************

// to run this, uncomment this whole section

/*
    // redefine the primitive_eval of user_primitives.scad
    function primitive_eval(pt, data) =
        let( a0  = data[0], a1 = data[1],
             sx1 = a0/2 - pt[0],
             sx2 = a0/2 + pt[0],
             sy1 = a1/2 - pt[1],
             sy2 = a1/2 + pt[1],
             fx  = sx1 + sx2 - norm([sx1, sx2]),
             fy  = sy1 + sy2 - norm([sy1, sy2]) )
     //   min(sx1, sx2, sy1, sy2) - 1.2*pt[2];
        fx + fy - norm([fx, fy]) - pt[2]/2; 

r_function_graph();
*/
module r_function_graph(){
    d  = [0,0,0];
    sx = 20;
    sy = 16;
    square = f_translation(f_primitive([sx, sy]), d);
    domain = [ [-15, -12, -10], [15, 12, 10] ];
    msh    = f_mesh_evaluation(square, domain, 0.6);
    show_mesh_bounds(msh);
    union() {
        color([0.8,0.8,1]) mesh_surface(msh, "rectangle r-function");
        color("red") translate(d) cube([sx,sy,0.2],center=true);
    }
}

//******************************
//  Random sphere union
//*****************************

//Spheres(50);
module Spheres(ns){ 

    sphere  = f_sphere(10);

    function random_spheres(ns, res=[]) =
        ns == 0 ?
            res :
            random_spheres(ns-1, f_union(f_translation(sphere,rands(-50,50,3)) , res) );

    S = random_spheres(ns,res=sphere); 
    domain = [ [-100,-100,-50], [100,100,100] ];
    msh = f_mesh_evaluation(S, domain, 0.8);

    difference(){
        color([0.8,0.8,1]) mesh_surface(msh, "Random spheres");
        translate([-100,0,0]) cube(200);
    }
}

//******************************
//  General cylinders
//*****************************

//Cylinder();
module Cylinder(){ 

    cylinder  = f_cylinder(r=10,rt=15, h=12);

    S = f_scale(cylinder,0.5);

    domain = [ [-10,-10,-10], [10,10,10] ];
    msh = f_mesh_evaluation(S, domain, 0.8);

    difference(){
        color([0.8,0.8,1]) mesh_surface(msh, "Cylinders");
 //       translate([-100,0,0]) cube(200);
    }
}

//******************************
//  Torus
//*****************************

//Torus();
module Torus(){ 

    torus  = f_torus(r=10, R=30);
    skewMt = [[1,0,0,0],
               [0,1,0,0],
               [0.7,0.7,2.5,0],
               [0,0,0,1]];
    S = f_transform(torus,skewMt);

    domain = [ [-50,-50,-50], [50,50,50] ];
    msh = f_mesh_evaluation(S, domain, 0.7);

    difference(){
        color([0.8,0.8,1]) mesh_surface(msh, "Torus");
 //       translate([-100,0,0]) cube(200);
    }
}

//******************************
//  Interference test 1
//*****************************
//interference1();
module interference1(){
    // PARAB is a user_primitive
    parab  = f_offset(f_primitive([PARAB, 0.1, 0.1]), 0);
    sphere = f_translation(f_sphere(r=40), [0,0,40]);
    S      = f_intersection_r(parab, sphere);

    domain = [ [-35.1,-35.1,-25.1], [40,40,100] ];
    msh = f_mesh_evaluation(S, domain, 0.7);
    color([0.8,0.8,1])
    mesh_surface(msh, "Interference test 1");
}

//******************************
//  Interference test 2
//*****************************

//interference2();
module interference2(){
    sphere1 = f_scale(f_sphere(r=25),[1.1,0.5,1]);
    sphere2 = f_translation(f_sphere(r=20), [0,0,30]);
    S      = f_union(sphere1, sphere2);
    
    domain = [ [-31,-31,-31], [30,30,100] ];
    msh = f_mesh_evaluation(S, domain, 0.7);
    color([0.8,0.8,1])
    mesh_surface(msh, "Interference test 2");
}

//******************************
//  Interference test 3
//*****************************

//interference3();
module interference3(){
    cylin   = f_translation(f_cylinder(r=15, h=50),[0,0,20]);
    sphere = f_sphere(r=30);
    dif    = f_difference(sphere,cylin);
    S      = f_rotation_to(dif, to=[10,10,10]);
    
    domain = [ [-31,-31,-31], [30,30,100] ];
    msh = f_mesh_evaluation(S, domain, 0.8);        
    color([0.8,0.8,1])
    mesh_surface(msh, "Interference test 3");
}

//******************************
//  Interference test 4
//*****************************
//interference4();
module interference4(){
    parab0 = f_primitive([PARAB, 0.1, 0.1]);
    parab1 = f_offset(parab0, -5);
    diff   = f_difference_r(parab1, parab0);
    S      = f_intersection(diff, f_sphere(50));
    
    domain = [ [-30.1,-30.1,-8.1], [30,30,55] ];
    msh = f_mesh_evaluation(S, domain, 0.8);
    color([0.8,0.8,1])
    mesh_surface(msh, "Interference test 4");
}

//***************************************
//  Blending two tori with one sphere: an apple
//***************************************

//apple();
module apple() {
    torus0 = f_scale(f_torus(r=15, R=30),[1,1,1.3]);
    torus  = f_translation(torus0,[0,0,33]);
    torus2 = f_scale(f_translation(f_torus(r=3,R=16),[0,0,-20]),[1,1,1.2]);
    sphere = f_sphere(29);
    b1  = f_Pasko_blend(torus, sphere,[1000,2.2,2.15]);
    S   = f_Pasko_blend(b1,torus2,[500,2.2,1.8]);
    
    domain = [ [-55,-55,-45] , [55,55,70] ];
    msh = f_mesh_evaluation(S, domain, 0.8);
    difference(){
        mesh_surface(msh, "Blend apple");  
    //  cube(120);
    }
}

//***************************************
//  Blending tori: a pot
//***************************************
//pot();
module pot() {
    torusa  = f_torus(r=5, R=50);
    torusb  = f_torus(r=2, R=65);
/*
    torus0 = f_translation(f_scale(torusa2,[1,1,3]),[0,0,25]);
    torus1 = f_translation(f_scale(torusb,[1,1,6]),[0,0,50]);
    torus2 = f_translation(f_scale(torusa1,[1,1,4]),[0,0,80]);
*/
    torus0 = f_translation(f_operator(f_scale(torusa,[1,1,2.5]),data=[TAPERING,0.97,3]),[0,0,85]);
    torus1 = f_translation(f_scale(torusb,[1,1,2.5]),[0,0,40]);
    torus2 = f_translation(f_operator(f_scale(torusa,[1,1,3]),data=[TAPERING,1.03,3]),[0,0,23]);
    cyl    = f_cylinder(r=35,h=4); 
    bl1  = f_Pasko_blend(torus0, cyl,[350,1,1.5]);
    bl2  = f_Pasko_blend(torus1, torus2,[-100,1,1]);
    S   = f_Pasko_blend(bl1,torus2,[350,1,1]); echo(S);

    domain = [ [-70,-70,-45] , [70,70,100] ];
    msh = f_mesh_evaluation(S, domain, 0.7);
//    echo(msh[1][1]);
    difference(){
        mesh_surface(msh, "Blend teapot");  
    //  cube(120);
    }
}

//******************************
//  Schwarz P surface
//*****************************

//Schwarz(); // make a small break, take a coffe 
module Schwarz(){
    // The Schwarz surface is an user primitive
    // A very expensive primitive
    schwarz = f_primitive([ SCHWARZ, 1, 1, 1 ]);
    S = f_difference(schwarz, f_offset(schwarz, 0.5));
    domain  = [ [-200,-200,-200], [570, 570, 570] ];
    msh = f_mesh_evaluation(S, domain, 0.8);

    render(convexity=12)
    intersection() {
        mesh_surface(msh, "Schwarz surface");  
/*
        difference(){
            translate([180,180,180]) 
                cube([720, 720, 720], center=true);
            translate([180,180,-190]) 
                cube([540, 540, 740]);
            translate([180,-360,180]) 
                cube([540, 540, 540]);
            translate([-360,180,180]) 
                cube([540, 540, 540]);
        }
*/
    }
}


// comparison with Hyperfun
/*
sphere = f_sphere(5.0);
    domain = [ [-10,-10,-10], [10,10,10] ];
    msh = f_mesh_evaluation(sphere, domain, n=[22,22,22]);
//difference(){
//    import("sphere_fixed.stl");
//    translate([15,0,0]) 
//mesh_surface(msh, "Sphere");  
//    cube(60);
//}
*/

//******************************
//  Sweeping the Trefoil Knot
//*****************************

//Trefoil_knot();
module Trefoil_knot(){
    // sweep works with spheres
    trefoil_knot =  
        [ for(a=[0:5:360]) 
            7*[ sin(a) + 2*sin(2*a), cos(a) - 2*cos(2*a), -sin(3*a) ] ];
    sphere = f_sphere(r=3);
    S = f_sweep(sphere, trefoil_knot);
    domain = [ [-25,-25,-10], [25,19,10] ];
    msh = f_mesh_evaluation(S, domain, 0.8);

    union() {
        mesh_surface(msh, "Trefoil knot");  
 //       sphere(3);
    }

}

//*****************************************************
//  Sweeping a smashed sphere along a Trefoil Knot
//*****************************************************

//Trefoil_knot2();
module Trefoil_knot2() {
    trefoil_knot =  
        [ for(a=[0:5:360]) 
            7*[ sin(a) + 2*sin(2*a), cos(a) - 2*cos(2*a), -sin(3*a) ] ];
    sphere = f_sphere(3);
    def_sphere = f_scale(sphere,[1/2,1,1]);
    S = f_union(f_sweep(def_sphere, trefoil_knot), def_sphere);
    domain = [ [-25,-25,-10], [25,19,10] ];
    msh = f_mesh_evaluation(S, domain, 0.8);
    mesh_surface(msh, "Trefoil knot 2");
echo(def_sphere);
}

//******************************
//  Sweep test
//*****************************

//sweep_test(); //* sweep is not right for torus and cylinders yet
module sweep_test(){
    torus  = f_torus(r=10, R=40);
    sphere = f_sphere(30);
    a      = f_union_r(torus, sphere, alpha=0);
    b      = f_union(torus, sphere);
    c      = f_translation(b, [0,0,70]);
    d      = f_union(a,c);
    line   = [ [0,0,0], [0,0,100], [100,100,100] ];
    domain = [ [-60,-60,-40], [60, 60, 110] ];
    msh = f_mesh_evaluation(d, domain, 0.6, surf=false);

    mesh_surface(msh,"Sweep");  
}

//******************************
//  Union test: disjoint f_rep
//******************************
//Disjoint();
module Disjoint(){
    sphere1 = f_sphere(15);
    sphere2 = f_translation(sphere1, [0,0,40]);
    sphere3 = f_translation(sphere1, [0,0,80]);
    sphere4 = f_translation(sphere1, [0,0,120]);
    u1      = f_union(sphere1, sphere2);
    u2      = f_union(sphere3, sphere4);
    u3      = f_union(u1, u2);
    S = u3;
    domain = [ [-20,-20,-20], [20,20,160] ];
    msh = f_mesh_evaluation(S, domain, 0.8);

    union() {
        mesh_surface(msh, "Disjoint union");
    //    translate([50,0,0]) cube(15,center=true);
    }
}

//******************************
//  Twisted paraboloid
//*****************************

//twisted_paraboloid();
module twisted_paraboloid(){
    // paraboloid is an user primitive
    parab  = f_twist(f_primitive([PARAB, 0.1, 0.2, 1]), 45, 10);
//    parab  = f_primitive([PARAB, 0.1, 0.2, 1]);
    sphere = f_translation(f_sphere(r=30), [0,0,30]);
    S       = f_intersection(parab, sphere);

    domain = [ [-30.1,-30.1,-5.1], [30,30,100] ];
    msh = f_mesh_evaluation(S, domain, 0.9);
    color([0.8,0.8,1])
    mesh_surface(msh, "Twisted paraboloid");
}


//************************************
//  Blending torus with equipotential
//************************************

//BlendEqTorus();
module BlendEqTorus() {
    torus   = f_scale(f_torus(2,1),[10,10,10]);
    eqdata  = [EQUIP, 1.2*0.5, -0.05*0.5]; 
    eq1     = f_translation(f_primitive(eqdata), [17.2,  17.2, 0]);
    eq2     = f_translation(f_primitive(eqdata), [17.2, -17.2, 0]);
    equipot = f_blend(eq1, eq2, 0.5);
    S = f_blend(equipot, torus, 0.017);

    domain = [[-40,-40,-25], [40, 40, 25]];
    msh = f_mesh_evaluation(S, domain, 0.7);
    difference(){
        mesh_surface(msh,"Blend equipotential");
//        translate([25,25,0]) sphere(15);
    }
}

//************************************
//  Tori union
//************************************

//Four_tori();
module Four_tori(){
    torus   = f_scale(f_torus(2,0.4),10);
    d1 = [0,22,0];
    rot1 = [-71,0,0];
    tor1    = f_translation(f_rotation(f_translation(torus, -d1),rot1),d1);
    tor2 = f_rotation(tor1, [0,0,120]);
    tor3 = f_rotation(tor2, [0,0,120]);
    b1  = f_union(tor1, torus);
    b2  = f_union(tor2, tor3);
    b3  = f_union(b2, f_translation(f_sphere(10),[0,0,20]));
    S = f_union(b1,b3);
    domain = [ [-35,-35,-10], [35, 35, 50] ];
    msh = f_mesh_evaluation(S, domain, 0.8);
    mesh_surface(msh,"Torus union");
}

//************************************
//  Meta balls
//************************************

//Meta_balls();
module Meta_balls() {
    prim_data = [MBALLS, 14.3, 38.3, 2.9];
    ball = f_primitive(prim_data);
    b1   = f_translation(ball, [25,0,0]);
    b2   = f_rotation(b1, [0,0,120]);
    b3   = f_rotation(b1, [0,0,-120]);
    b4   = f_translation(ball, [0,0,35]);
    bl1  = f_blend(b1,  b2,  0.5);
    bl2  = f_blend(b3,  b4,  0.5);
    S    = f_blend(bl1, bl2, 0.5);
    //S = torus;
    domain = [[-30,-40,-20], [35, 40, 60]];
    msh = f_mesh_evaluation(S, domain, 0.7);
    union(){
        mesh_surface(msh,"Meta balls");
    //    translate([0,0,55]) sphere(10);
    }
}

//************************************
//  Meta balls II
//************************************

//Meta_balls_2();
module Meta_balls_2(){
    up = [MBALLS,14.3,38.3,2.9];
    lw = [MBALLS,14.3,38.3,2.9];
    hd = [MBALLS,8.3,18.3,0.3];
    upperbody = f_scale(f_translation(f_primitive(up),[0,0,100]),[1,0.7,1]);
    lowerbody = f_translation(f_primitive(lw),[0,0,60]);
    head      = f_translation(f_primitive(hd),[0,0,135]);
    armsup    = f_translation(f_primitive([MBALLS,18.3,8.3,0.8]),[0,20,100]);
    arminf    = f_translation(armsup,[0,0,-10]);
    armright  = f_blend(armsup, arminf, 0.5);
    armleft   = f_translation(armright,[0,-40,0]);
    arms      = f_translation(f_union(armright,armleft),[0,0,0]);
    body    = f_blend(upperbody, lowerbody, 0.5);
    bdarms  = f_blend(head, f_blend(body,arms,0.5), 0.5);
    S     = bdarms;//f_union(body, head);

    domain = [[-30,-40,-20], [35, 40, 150]];
    msh = f_mesh_evaluation(S, domain, 0.8);
    union(){
        mesh_surface(msh,"Meta balls II");
    //    translate([0,0,55]) sphere(10);
    }
}

//************************************
//  Cushion surface
//  http://mathworld.wolfram.com/CushionSurface.html
//************************************
//Cushion(); // not reviewed
module Cushion(){
prim_data = [CUSHION, 10];
cush = f_scale(f_primitive(prim_data),30);
S    = cush;
msh = f_mesh_evaluation(S, [-30,-40,-20], 75, 80, 80, 30, 30, 30);
difference(){
    mesh_surface(msh,"Cushion surface");
    cylinder(r=10,h=200, center=true);
}
}

//************************************
//  Chair surface
//  http://mathworld.wolfram.com/ChairSurface.html
//************************************
//ChairS(); // not reviewed
module ChairS(){
    prim_data = [CHAIR, 5, 0.95, 0.8];
chair = f_scale(f_primitive(prim_data), 6);
S    = chair;
msh = f_mesh_evaluation(S, [-33,-33,-33], 66, 66, 66, 40, 40, 40);
union(){
    mesh_surface(msh,"Chair surface");
    sphere(12);
}
}

//************************************
//  Roman surface
//  http://mathworld.wolfram.com/RomanSurface.html
//************************************
// an special case of the chair surface
//Roman(); // not reviewed
module Roman(){
prim_data = [CHAIR, 5, 1, 1];
roman = f_scale(f_primitive(prim_data), 6);
S    = roman;
msh = f_mesh_evaluation(S, [-33,-33,-33], 66, 66, 66, 50, 50, 50);
union(){
    mesh_surface(msh,"Roman surface");
//    sphere(12);
}
}

//************************************
//  R operators: union
//************************************
//  union_r is a union with an almost everyewhere 
//  differenctiable function 
//UnionR(); // not reviewed
module UnionR(){
sphere1 = f_sphere(rad=5);
sphere2 = f_translation(sphere1, [8.01,0,0]);
S    = f_union_r(sphere1, sphere2, alpha = -0.2);
msh = f_mesh_evaluation(S, [-5.05,-5.05,-6], 24,14,12, 30, 30, 30);
difference(){
    mesh_surface(msh,"R-union");
    translate([-12.5,0,0]) cube(25);
}
//show_mesh_bounds(msh);
}

//************************************
//  R operators: difference
//************************************
//  difference_r is a union with an almost everyewhere 
//  differenctiable function 
//DifferenceR(); // not reviewed
module DifferenceR(){
sphere1 = f_sphere(rad=5);
sphere2 = f_translation(sphere1, [8.01,0,0]);
S    = f_difference_r(sphere1, sphere2, alpha = 0.5);
msh = f_mesh_evaluation(S, [-5.05,-5.05,-6], 14,14,12, 30, 30, 30);
difference(){
    mesh_surface(msh,"R-diff");
    translate([0,8.01,0]) sphere(5);
}
//show_mesh_bounds(msh);
}

//************************************
//  R intersection
//  and Twist
//************************************
//TwistRintersections(); // not reviewed
module TwistRintersections(){
half1 = f_halfspace([-5, 0, 0], [ 1, 0, 0]);
half2 = f_halfspace([ 5, 0, 0], [-1, 0, 0]);
half3 = f_halfspace([ 0,-5, 0], [ 0, 1, 0]);
half4 = f_halfspace([ 0, 5, 0], [ 0,-1, 0]);
half5 = f_halfspace([ 0, 0,-5], [ 0, 0, 1]);
half6 = f_halfspace([ 0, 0, 5], [ 0, 0,-1]);
intr1 = f_intersection_r(half1, half2, alpha=0);
intr2 = f_intersection_r(half3, half4, alpha=0);
intr3 = f_intersection_r(half5, half6, alpha=0);
intr4 = f_intersection_r(intr1, intr2, alpha=0);
cube  = f_intersection_r(intr4, intr3, alpha=0);
cyl   = f_rotation(f_cylinder(rad=2, hgt=20), [90,0,0]); 
holed = f_difference_r(cube, cyl, -0.9);
S     = f_twist(holed, 90, 10);
//echo(S);
msh = f_mesh_evaluation(S, [-6.5,-6.5,-6.5], 13,13,13, 30, 30, 30);
//echo(msh[1][0]);
difference(){
    mesh_surface(msh,"R-intersection");
    cylinder(r=2,h=20,center=true);
}
//show_mesh_bounds(msh);
}

//******************************
//  Pasko spiral
//*****************************
//PaskoSpiral();
module PaskoSpiral(){
    spiral1  = f_primitive([SPIRAL, 0]);
    spiral2  = f_primitive([SPIRAL, 120]);
    spiral3  = f_primitive([SPIRAL, -120]);
    sp       = f_union(spiral1, f_union(spiral2, spiral3));
    S        = f_rotation_to(sp, [0,0,1], [1,1,1] );
    domain = [ [-15,-15,-12], [15,15,12] ];
    msh = f_mesh_evaluation(S, domain, 0.8);
    color([0.8,0.8,1])
    union() {
        mesh_surface(msh, "Pasko Spiral");
    //    cube(50);
    }

}




// diagnostic tool
//show_specific_voxel(msh,11,1,10,thickness=0.01);
//show_specific_voxel(msh,11,1,11,thickness=0.01);
//polygonize_voxel(f_mesh_vox_data(msh,11,1,10), "blue");
//show_roots(f_mesh_vox_data(mesh, 11,1,10));

