fibonacci_sphere(50,n=10000);
module fibonacci_sphere(r, n, $fn){
    $n = n==undef? ceil((0.5*$fn*$fn)/2) : n;
    hull()
    polyhedron(points = [
        for(i=[-$n:($n-2)])
            r * _pos(i,$n)
    ], faces=[
        for(i=[0:3:2*$n])
            [i,i+1,i+2]
        // for(i=[-$n:3:($n-2)])
        //     [i+$n,i+1+$n,i+2+$n]
    ]);
}

//calculates ith vertex position on a fibonacci unit sphere of 2*n vertices
function _pos(i, n) =
	[cos(_lon(i)) * _xy(_z(i,n)), 
	 sin(_lon(i)) * _xy(_z(i,n)), 
	 _z(i,n)];

function _lon(i) = _golden_angle*i;
function _z(i,n) = 2*i/(2*n+1);
function _xy(z)  = sqrt(1-pow(z,2));

_golden_ratio = 1.61803;
_golden_angle = 360 * _golden_ratio; 
