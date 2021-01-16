p0 = [-1, -1, 1];
p1 = [1, 1, 1];
p2 = [1, -1, -1];
p3 = [-1, 1, -1];
a = tet(p0, p1, p2, p3);
b = dflatten(a);
//echo(b );
for (i = [-1: 0.1: 1], j = [-1: 0.1: 1], k = [-1: 0.1: 1]) {
    Qp = [i, j, k];
    //bb=max_bounds(b);
    //bb2=max_bounds(concat(bb,[Qp]));
    //echo(concat(bb,[[1,1,2]]),bb2, bb==bb2);
    //
    //echo(PointInTetrahedron(p0,p1, p2, p3, Qp));
    intet = in_tet(p0, p1, p2, p3, Qp);
    echo(intet);
}

function in_tet(p0, p1, p2, p3, point, name = "0", c = 5) =
    let (

        p01 = (p0 + p1) / 2,
        p02 = (p0 + p2) / 2,
        p03 = (p0 + p3) / 2,
        p13 = (p1 + p3) / 2,
        p32 = (p3 + p2) / 2,
        p21 = (p2 + p1) / 2)
c > 0 ?
    PointInTetrahedron(p0, p1, p2, p3, point) ?
    PointInTetrahedron(p0, p01, p02, p03, point) ? in_tet(p0, p01, p02, p03, point, str(name, "A"), c - 1) :
    PointInTetrahedron(p1, p01, p21, p13, point) ? in_tet(p1, p01, p21, p13, point, str(name, "B"), c - 1) :
    PointInTetrahedron(p3, p13, p32, p03, point) ? in_tet(p3, p13, p32, p03, point, str(name, "C"), c - 1) :
    PointInTetrahedron(p2, p02, p32, p21, point) ? in_tet(p2, p02, p32, p21, point, str(name, "D"), c - 1) :
    PointInTetrahedron(p01, p02, p03, p13, point) ? in_tet(p01, p02, p03, p13, point, str(name, "E"), c - 1) :
    PointInTetrahedron(p02, p21, p13, p01, point) ? in_tet(p02, p21, p13, p01, point, str(name, "F"), c - 1) :
    PointInTetrahedron(p21, p13, p32, p02, point) ? in_tet(p21, p13, p32, p02, point, str(name, "G"), c - 1) :
    PointInTetrahedron(p13, p32, p02, p03, point) ? in_tet(p13, p32, p02, p03, point, str(name, "H"), c - 1) : ["error", name] :
    "outside" :
    name;

function PointInTetrahedron(v1, v2, v3, v4, p) =
    SameSide(v1, v2, v3, v4, p) &&
    SameSide(v2, v3, v4, v1, p) &&
    SameSide(v3, v4, v1, v2, p) &&
    SameSide(v4, v1, v2, v3, p);

function SameSide(v1, v2, v3, v4, p) =
    let (
        normal = cross(v2 - v1, v3 - v1),
        dotV4 = dot(normal, v4 - v1),
        dotP = dot(normal, p - v1))
sign(dotV4) == sign(dotP) || sign(dotP) == 0;

function dot(u, v) = u[0] * v[0] + u[1] * v[1] + u[2] * v[2];

function depth(a) = len(a) == undef ? 0 : 1 + depth(a[0]);

function flatten(l) = [
    for (a = l)
        for (b = a) b
];

function dflatten(l, d = 1) = flatten([
    for (a = l) depth(a) > d ? dflatten(a, d) : [a]
]);

function max_bounds(l) =
    let (ll = len(l) - 1)[[min([
        for (i = [0: ll]) l[i].x
    ]), min([
        for (i = [0: ll]) l[i].y
    ]), min([
        for (i = [0: ll]) l[i].z
    ])], [max([
        for (i = [0: ll]) l[i].x
    ]), max([
        for (i = [0: ll]) l[i].y
    ]), max([
        for (i = [0: ll]) l[i].z
    ])]];

function tet(p0, p1, p2, p3, name = "0", c = 4) =
    let (

        p01 = (p0 + p1) / 2,
        p02 = (p0 + p2) / 2,
        p03 = (p0 + p3) / 2,
        p13 = (p1 + p3) / 2,
        p32 = (p3 + p2) / 2,
        p21 = (p2 + p1) / 2)
c > 0 ? [

        tet(p0, p01, p02, p03, str(name, "A"), c - 1),
        tet(p1, p01, p21, p13, str(name, "B"), c - 1),
        tet(p3, p13, p32, p03, str(name, "C"), c - 1),
        tet(p2, p02, p32, p21, str(name, "D"), c - 1),

        tet(p01, p02, p03, p13, str(name, "E"), c - 1),
        tet(p02, p21, p13, p01, str(name, "F"), c - 1),
        tet(p21, p13, p32, p02, str(name, "G"), c - 1),
        tet(p13, p32, p02, p03, str(name, "H"), , c - 1)

    ] :
    p0;

module tet(p0, p1, p2, p3, c = 3) {
    color((p0 + p1 + p2 + p3) / 4) {
        line(p0, p1);
        line(p0, p2);
        line(p0, p3);
        line(p1, p2);
        line(p2, p3);
        line(p3, p1);
    }
    p01 = (p0 + p1) / 2;
    p02 = (p0 + p2) / 2;
    p03 = (p0 + p3) / 2;
    p13 = (p1 + p3) / 2;
    p32 = (p3 + p2) / 2;
    p21 = (p2 + p1) / 2;
    if (c > 0) {

        tet(p0, p01, p02, p03, c - 1);
        tet(p1, p01, p21, p13, c - 1);
        tet(p3, p13, p32, p03, c - 1);
        tet(p2, p02, p32, p21, c - 1);

        tet(p01, p02, p03, p13, c - 1);
        tet(p02, p21, p13, p01, c - 1);
        tet(p21, p13, p32, p02, c - 1);
        tet(p13, p32, p02, p03, c - 1);

    }

}

module line(p1, p2) {
    hull() {
        translate(p1) sphere(0.05);
        translate(p2) sphere(0.05);
    }
}

/*    Can someone point me to an algorithm that determines if a point is within a tetrahedron?
Let the tetrahedron have vertices

        V1 = (x1, y1, z1)
        V2 = (x2, y2, z2)
        V3 = (x3, y3, z3)
        V4 = (x4, y4, z4)
and your test point be

        P = (x, y, z).
Then the point P is in the tetrahedron if following five determinants all have the same sign.

             |x1 y1 z1 1|
        D0 = |x2 y2 z2 1|
             |x3 y3 z3 1|
             |x4 y4 z4 1|

             |x  y  z  1|
        D1 = |x2 y2 z2 1|
             |x3 y3 z3 1|
             |x4 y4 z4 1|

             |x1 y1 z1 1|
        D2 = |x  y  z  1|
             |x3 y3 z3 1|
             |x4 y4 z4 1|

             |x1 y1 z1 1|
        D3 = |x2 y2 z2 1|
             |x  y  z  1|
             |x4 y4 z4 1|

             |x1 y1 z1 1|
        D4 = |x2 y2 z2 1|
             |x3 y3 z3 1|
             |x  y  z  1|
Some additional notes:

If by chance the D0=0, then your tetrahedron is degenerate (the points are coplanar).
If any other Di=0, then P lies on boundary i (boundary i being that boundary formed by the three points other than Vi).
If the sign of any Di differs from that of D0 then P is outside boundary i.
If the sign of any Di equals that of D0 then P is inside boundary i.
If P is inside all 4 boundaries, then it is inside the tetrahedron.
As a check, it must be that D0 = D1+D2+D3+D4.
The pattern here should be clear; the computations can be extended to simplicies of any dimension. (The 2D and 3D case are the triangle and the tetrahedron).
If it is meaningful to you, the quantities bi = Di/D0 are the usual barycentric coordinates.
Comparing signs of Di and D0 is only a check that P and Vi are on the same side of boundary i.*/