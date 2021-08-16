include<DCmath.scad>

opU = 1; // 1 union
opI = 2; // 1 intersection
opS = 3; // 1 subtraction
opT = 4; // M transformation 4X4 functional
opH = 5; // 1 Convex hull
opE = 6; // 3 Extrude 2d shape, simple Z extrude of a subtree of Z plane cut (Q collapsed to z=0)
opO = 7; // 1 offset usually by distance but xyz surface normal or ambinet occlusion is possiblites
opD = 8; // ""not impleneted"" deformation modifyers [twist, bend, pinch, displace, taper]
opX = 9; // ""not impleneted"" deformation modifyers [twist, bend, pinch, displace, taper]
f_cube = 10; // unit radius cube
f_sphere = 11; // unit radius sphere
f_torus = 12; // unit radius torus
//named numbers
opc = 0;params = 1;subTree = 2;x = 0;y = 1;z = 2;null3 = [0, 0, 0];tiny = 0.01;far = 10000;

 
function union(r,subtree)=[opU,r,subtree];
function intersection(r,subtree)=[opI,r,subtree];
function subtraction(r,subtree)=[opS,r,subtree];
function cube(q)=[f_cube,q];
function sphere(q)=[f_sphere,q];
function torus(q)=[f_torus,q];
function translate(q,subtree)=[opT,[q,[0,0,0],[1,1,1]],subtree];
function rotate(q,subtree)=[opT,[[0,0,0],q,[1,1,1]],subtree];
function scale(q,subtree)=[opT,[[0,0,0],[0,0,0],q ],subtree];