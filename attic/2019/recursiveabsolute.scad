rotate([100,0,100]) 
translate([0,30,100]) 
rotate([33,0,100]) 
translate([0,0,100]) 
cube(100); 
//
//if you want to know where cube is mapped, or where any other point q will be 
//mapped, you just use the same transformation sequence in function syntax.   

q=[0,0,0]; 
q1 = 
rotate([100,0,100], 
translate([0,30,100], 
rotate([33,0,100], 
translate([0,0,100], q)))); 
echo(q1); 

//Here is my implementation of the three functions. The code looks more 
//difficult than it is, because the functions are part of a richer interface, 
//accept parameter calls without [] and work recursive. They operate over 
//points, lists of points, lists of lists of points and so on. I use them 
//mainly in connection with sweep(), but they will also serve your needs. 

function translate(x=0, y=0, z=0, v) = 
  let(v = (len(x)==3)?y:v, x = (len(x)==3)?x:[x, y, z]) 
  len(v[0])?[for (i=v) translate(x,i)]:v+x; 

function rotate(x=0, y=0, z=0, v) =  // 2D vectors allowed 
  let(v = (len(x)==3)?y:v, x=(len(x)==3)?x:[x, y, z]) 
  len(v[0])? [for(i=v) rotate(x,i)]:Rz(x[2], Ry(x[1], Rx(x[0], v)));   
function Rx(x, A) = len(A[0][0])?[for(i=A) Rx(x, i)]: 
    A*[[1, 0, 0], [0, cos(x), sin(x)], [0, -sin(x), cos(x)]]; 
function Ry(y, A) = len(A[0][0])?[for(i=A) Ry(y, i)]: 
    A*[[cos(y), 0, sin(y)], [0, 1, 0], [-sin(y), 0, cos(y)]]; 
function Rz(z, A) = len(A[0][0])? 
    [for(i=A) Rz(z, i)]: 
    len(A[0])==2? 
    A*[[cos(z), sin(z)], [-sin(z), cos(z)]]: 
    A*[[cos(z), sin(z), 0], [-sin(z), cos(z), 0], [0, 0, 1]]; 

function scale(x=1, y=1, z=1, v) = 
  let(v = (len(x)==3)?y:v, x = (len(x)==3)?x:[x, y, z]) 
  len(v[0])?[for (i=v) S_(x,i)]:[v[0]*x[0], v[1]*x[1], v[2]*x[2]]; 