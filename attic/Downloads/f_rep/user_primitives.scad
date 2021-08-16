
//**********************************************************
// Some primitive functions defined externally to the system
//**********************************************************

// primitive ids
EQUIP   = 0;
BEZIER  = 1;
MBALLS  = 2;
CUSHION = 3;
CHAIR   = 4;
PARAB   = 5;
SCHWARZ = 6;
SPIRAL  = 7;
R_SQUARE = 8;
R_CIRCLE = 9;
SUPSPHERE= 10;
TEST= 100;

// operator ids
TAPERING = 1;

function Pasko_spiral(pt, data) =
    let( x=pt[0], y=pt[1], z=pt[2], 
         z2 = z*z,
         R  = sqrt(100.-z2),
         ro = z*90/PI + data,
         x0 = R*cos(ro), 
         y0 = R*sin(ro), 
         xt = x-x0,
         yt = y-y0, 
         r  = 2.- z2*0.02,
         ftrim  = r*r - xt*xt -yt*yt,
         offset = 10 - z2*0.1 )
     ftrim + offset;    
       
function paraboloid(pt, a, b) =
    let( x=pt[0], y=pt[1], z=pt[2],
         g = 2*norm([a*x, b*y, 0.5]),
         v = z - a*x*x - b*y*y )
    v / g;  

function chair_surface(pt, k, a, b) = 
// http://mathworld.wolfram.com/ChairSurface.html
    let( x = pt[0], y = pt[1], z = pt[2] )
    -pow((pt*pt - a*k*k),2) + b*( pow(z-k,2) - 2*x*x )*( pow(z+k, 2) - 2*y*y ); 

function cushion_surface(pt, a) =
// http://mathworld.wolfram.com/CushionSurface.html
    let( x = pt[0], y = pt[1], z = pt[2], 
         x2 = x*x, y2 = y*y,
         z2 = z*z, z3 = z*z2, z4 = z2*z2 )
    a*(z2*x2 - z4 - 2*z*x2 + 2*z3 + x2 - z2 
    - pow(x2-z,2) - y2*y2 - 2*x2*y2 - y2*z2 + 2*y2*z + y2);

function equipotential(pt, chrg, isos) = 
    isos + (norm(pt)<1e-6 ? 1e6 : chrg/norm(pt));

function meta_balls(pt, a, b, c) =
    let( r2 = (pt*pt)/(b*b), r4 = r2*r2, r6 = r4*r2 )
    r2 < 1 ?
        a*(9 - 4*r6 + 17*r4 - 22*r2)/9 - c :
        -c ;

function Schwarz_p(pt, a,b,c) =
    let( s = a*cos(pt[0]) + b*cos(pt[1]) + c*cos(pt[2]) )
    s;

function r_square(pt, a0, a1) =
    let( sx1 = a0/2 - pt[0],
         sx2 = a0/2 + pt[0],
         sy1 = a1/2 - pt[1],
         sy2 = a1/2 + pt[1],
         fx  = sx1 + sx2 - norm([sx1, sx2]),
         fy  = sy1 + sy2 - norm([sy1, sy2]) )
    fx + fy - norm([fx, fy]) - pt[2]; 

function r_circles(pt, r1, r2) =
    let( c1 = r1 - [pt[0], pt[1]]*[pt[0], pt[1]]/r1 ,
         c2 = r2 - [pt[0]-r1, pt[1]]*[pt[0]-r1, pt[1]]/r2  )
    - pt[2] + c1 - c2 - norm([c1, c2]);
    
function supersphere(p,r=15,d=2,c=0,s=1)=
    let(n=unit(p)) s*(-norm(p)+r-
(sin(atan2(n.y,n.x)*8)*d + sin(atan2(atan2(n.y,n.x)/90,n.z)*8)*d));

function abs3(v) = [abs(v[0]), abs(v[1]), abs(v[2])];
function max3(a, b) = [max(a[0], b), max(a[1], b), max(a[2], b)];

function sdCappedCylinder(p,data)= // from Quilez
let( d = [ norm([p.x, p.z]) - data[1], abs(p.y) - data[2] ] )
  - min(max(d),0.0) - norm(clampMin(d,0));

function sdCappedCone( p, c ) =
let(
    q  = [ norm([p.x,p.z]), p.y ],
    v  = [ c.z*c.y/c.x, -c.z ],
    w  = v - q,
    vv = [ v*v, v.x*v.x ],
    qv = [ v*w, v.x*w.x ],
    d = clampMin(qv,0)*q*[1/vv.x, 1/vv.y] )
    //[c,q,v,w,vv,qv,d];
    - sqrt( w*w - max(d) ) * sign(max(q.y*v.x-q.x*v.y, w.y));

function primitive_eval(pt, data) =
    let( prim = data[0] )
    prim==TEST ?
        sdCappedCone(pt,data) :
    prim==EQUIP ?
        equipotential(pt=pt, chrg=data[1], isos=data[2]) :
    prim==MBALLS ?
        meta_balls(pt = pt, a = data[1], b = data[2], c = data[3]) :
    prim==CUSHION ? 
        cushion_surface(pt, data[1]) :
    prim==CHAIR ?
        chair_surface(pt, data[1], data[2], data[3]) :
    prim==PARAB ?
        paraboloid(pt, data[1], data[2]) :
    prim==SCHWARZ ?
        Schwarz_p(pt, data[1], data[2], data[3]) :
    prim==SPIRAL ?
        Pasko_spiral(pt, data[1]) :
    prim==R_SQUARE ?
        r_square(pt, data[1], data[2]) :
    prim==R_CIRCLE ?
        r_circles(pt, data[1], data[2]) :
    prim==SUPSPHERE ?
        supersphere(pt,data[1],data[2],data[3],data[4]) :
    -3e6; 
   
function user_operator_eval( pt, left, right, data ) =
    let( op = data[0] ) 
    op == TAPERING ? 
        taper_eval( pt, left, data[1], data[2] ) : 
        undef;

function taper_eval( pt, f_rep, ratio, h ) =
    h == undef || abs(h) < 1e-6 ? 
        -2e6 :
        let( alpha = (ratio - 1)/h,
             size  = norm([pt[0], pt[1]]) )
        size < 1e-6 || abs(pt[2]) < 1e-6 || abs(alpha) < 1e-6 ?
            f_evaluate( pt, f_rep) :
            let( s = 1/(1 + alpha*pt[2]) ) 
            f_evaluate( [ s*pt[0], s*pt[1], pt[2] ], f_rep );

/*
s = 1*(1-z/h) + r2*z/h/r1 = 1 + z*(-1 + r2/r1)/h
*/
