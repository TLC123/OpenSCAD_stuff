/// offset?
fn=20;

linear_extrude(height=30)
    RoundedPolygon([[0,0],[20,70],[70,7],[30.,-7],[70,-27]],-1,fn);
linear_extrude(height=20)
    RoundedPolygon([[0,0],[20,70],[70,7],[30.,-7],[70,-27]],0,fn);

linear_extrude(height=10)
    RoundedPolygon([[0,0],[20,70],[70,7],[30.,-7],[70,-27]],2,fn);

module RoundedPolygon(P,r,fn)
{
    v = rounded_polygon_v(P,r,fn);
    polygon(v);
}

function rounded_polygon_v(P,r,fn) =
let
(
    step = 360 / fn,
    n = len(P),
    o_v = [ for(i=[0:n-1]) atan2(P[(i+1)%n].y - P[i].y, P[(i+1)%n].x - P[i].x) + 90 + 360 ]
)
[ 
        for(i=[0:n-1])
            let 
            (
                n1 = i, 
                n2 = (i+1)%n,
                w1 = o_v[n1],
                w2 = (o_v[n2] < w1) ? o_v[n2] : o_v[n2] - 360,
            rm = (o_v[n2] < w1) ? 1: 1
)
            for (w=[w1:-step:w2]) 
                [ cos(w)*r*rm+P[n2][0], sin(w)*r*rm+P[n2][1] ] 
] ;
