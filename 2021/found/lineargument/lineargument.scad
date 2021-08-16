module line(p0, p1,p2, thickness=1) {
    v = p1-p0;
    v2 = p2-p1;
hull(){
    translate(p0)
        multmatrix(rotate_from_to([0,0,1],v))
            cylinder(d=thickness, h=norm(v)*0.1, $fn=4);
    translate(p1)
              multmatrix(rotate_from_to([0,0,1],v2))
            cylinder(d=thickness, h=norm(v)*0.1, $fn=4);
}
}

knot = [ for(i=[0:5:360])
         [ (19*cos(3*i) + 40)*cos(2*i),
            19*sin(3*i),
           (19*cos(3*i) + 40)*sin(2*i) ] ];
for(i=[0:len(knot)-2]) 
    line(knot[i], knot[(i+1)%(len(knot)-1)],knot[(i+2)%(len(knot)-1)], thickness=5);
// Line drawings with this function is usually excruciatingly lengthy to render
// Use it in preview mode to debug geometry

function unit(v) = norm(v)>0 ? v/norm(v) : undef; 
// Find the transpose of a rectangular matrix
function transpose(m) = // m is any rectangular matrix of objects
  [ for(j=[0:len(m[0])-1]) [ for(i=[0:len(m)-1]) m[i][j] ] ];
// The identity matrix with dimension n
function identity(n) = [for(i=[0:n-1]) [for(j=[0:n-1]) i==j ? 1 : 0] ];

// computes the rotation with minimum angle that brings a to b
// the code fails if a and b are opposed to each other
function rotate_from_to(a,b) = 
    let( axis = unit(cross(a,b)) )
    axis*axis >= 0.99 ? 
        transpose([unit(b), axis, cross(axis, unit(b))]) * 
            [unit(a), axis, cross(axis, unit(a))] : 
        identity(3);