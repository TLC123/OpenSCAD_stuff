verts=[rands(-10,10,3),rands(-10,10,3),rands(-10,10,3)];


//polyhedron(verts,[[0,1,2]]);
a=split(verts,egdelimit=12);
polyhedron(a[0],a[1]);

for(f=a[1]){
    p=a[0];
b=split([for(i=f)p[i]],egdelimit=6);
polyhedron(b[0],b[1]);
}

//
translate(verts[0])rotate($vpr)color("black")text("0",size=1);
translate((verts[0]+verts[1])/2)rotate($vpr)translate([0,0,2])color("black")text("1",size=1);
translate(verts[1])rotate($vpr)color("black")text("2",size=1);
translate((verts[1]+verts[2])/2)rotate($vpr)translate([0,0,2])color("black")text("3",size=1);
translate(verts[2])rotate($vpr)color("black")text("4",size=1);
translate((verts[2]+verts[0])/2)rotate($vpr)translate([0,0,2])color("black")text("5",size=1);


function dotself(d)=d*d;
function un(v) = v / max(norm(v), 1e-64) * 1;
function clamp(a,b=0,c=1) =  min(max(a,min(b,c)),max(b,c));
function lerp(start,end,bias) = (end * bias + start * (1 - bias));
function rnd(a,b)=a+(rands(0,1,1)[0])*(b-a);

function split(vs,egdelimit)=
let( e01=dotself(vs[0]-vs[1]))
let( e12=dotself(vs[1]-vs[2]))
let( e20=dotself(vs[2]-vs[0]))
let(sqEdgeLimit=egdelimit*egdelimit)
echo(sqEdgeLimit,e01)
let(truth=[e01>sqEdgeLimit,e12>sqEdgeLimit,e20>sqEdgeLimit])
let(nvs=[vs[0],(vs[0]+vs[1])/2,vs[1],(vs[1]+vs[2])/2,vs[2],(vs[2]+vs[0])/2])
 truth==[true,true,true]?
 echo("case all")
[nvs,[[0,1,5],[1,2,3],[3,4,5],[1,3,5]]]:
 
 truth==[true,false,false]?
echo("case one 01")[nvs,[[0,1,4],[1,2,4]]]: 


 truth==[false,true,false]?
echo("case one 12")[nvs,[[0,2,3],[0,3,4]]]: 


 truth==[false,false,true]?
 echo("case one 02")[nvs,[[0,2,5],[2,4,5]]]:


 truth==[false,true,true]?
echo("case0")
dotself(nvs[3]-nvs[0])<dotself(nvs[2]-nvs[5])?[nvs,[[0,3,5],[0,2,3],[3,4,5]]]:[nvs,[[0,2,5],[2,3,5],[3,4,5]]]:


 truth==[true,false,true]?
echo("case1")
dotself(nvs[1]-nvs[4])<dotself(nvs[2]-nvs[5])?[nvs,[[0,1,5],[1,2,4],[1,4,5]]]:[nvs,[[0,1,5],[1,2,5],[2,4,5]]]:
 truth==[true,true,false]?
echo("case2")
dotself(nvs[1]-nvs[4])<dotself(nvs[0]-nvs[3])?[nvs,[[0,1,4],[1,3,4],[1,2,3]]]:[nvs,[[0,1,3],[0,3,4],[1,2,3]]]:
echo("case none")

[vs,[[0,1,2]]]

;