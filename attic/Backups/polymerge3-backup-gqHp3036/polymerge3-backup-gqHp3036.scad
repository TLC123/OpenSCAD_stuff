//demo mesh
Flat_treshold=0.009;
  //mesh=trimesh(cubemesh4() );
mesh=trimesh(cubemesh3() );
  //  mesh= (diamond() );

 // mesh=fp_flip(bunny());

echo(len(  mesh[0]),len(mesh[1]));

midmesh =  relax( tesselate( (mesh),2)) ;
 dmaesh= fp_decimate( midmesh );
 //nm = fp_decimate (tesselate(dmaesh,0));


 newmesh=relax (midmesh);
translate ([120,0,0]) polyhedron(midmesh[0], midmesh[1]);

// translate ([60,0,0]) polyhedron(nm[0], nm[1]);
translate ([ 0,0,0]) polyhedron(newmesh[0], newmesh[1]);

translate ([-60,0,0]) polyhedron(dmaesh[0], dmaesh[1]);
  // for (i = [0: len(newmesh) - 1]) echo(newmesh[i]);
echo(len( midmesh[0]),len(dmaesh[0]));
echo(len( dmaesh[0]),len(dmaesh[0]));


function fp_decimate (m,i=0,changed=0  )=
let(points=m[0],faces=m[1],n= neighbours(m) )
i<len(points)-1?
let(
removies=[for(k=[0:max(0, len(n[i])-1 )] ) faces[n[i][k]]],
 r=flattness(m,removies) 
//, e=echo(i,"removies",removies,"flattness",r)
)

r<=Flat_treshold? 
let(
newm=fp_decimateinidex(m,i,removies),
newch=len(newm[0])==len(m[0])?changed:changed+1,
newi=len(newm[0])==len(m[0])?i  :i
)
fp_decimate (newm,newi,newch  ) 
:fp_decimate (m,i+1,changed  )
:
changed>0?

 fp_decimate( m)
:
fusepoints(m)

;

/*needs change*/

function fp_decimateinidex(m,j,n)=
let( points=m[0],faces=m[1])
let(
removies=n,
newfaces=fp_removevertex(m,removies,j,alt=3),
r= flattness(m,newfaces),
h= flattness(m,removies)

) 
r<=h?
    let(nn=notneighboursofi (m,j),keepers= [for(k=[0:len(nn)-1]) faces[nn[k]]]
 //, e=echo("n",removies,"j",keepers)
)
    [points, concat(keepers,newfaces)]
    :
m
;
function fp_removevertex(m,removies,vertex,alt=0)=
let(points=m[0] )
let(

n= avrg([for(i=[0:max(0,len(removies)-1)])
p2n(  [points[removies[i][0]], points[removies[i][1]], points[removies[i][2]]])    ] ),


d= fp_tricylceb(removies,vertex),
c= fp_segorder(d),
e=fp_segcollapse(c),
g=shuffle(e,alt-round(rnd(2))),
f=fp_triangulate(m,g,n)
//,eco=echo( len(d),len(c))
)
 len(removies)>2&&len(c)==len(d)&&len(f)+2==len(removies)?f: removies 
;
function flattness(m,n)=

let(points=m[0],faces=m[1], 

normals=[for(i=[0:max(0,len(n)-1)])p2n(
 [
//let(e=echo("normals",n))
points[n[i][0]],
points[n[i][1]],
points[n[i][2]] 
])

],
ne=normeq(normals)



)  

ne
;


/*needs change*/

function newflattness(m)=

let(points=m[0],faces=m[1],

normals=[for(i=[0:max(0,len(m)-1)])p2n(m[i])

],
ne=normeq(normals)


) 
ne
;
function fp_glue(m)= let (
   hashed = fp_addhash(fp_flatten(m)), /*flatten and pair points with hash*/
   sorted = fp_hashQS(hashed),/*sort by hash*/
   unique = fp_unique(sorted),/*unique by hash*/
   newmesh = [fp_removehash(unique), fp_relink(unique, m)])/* combine to new mesh*/
 newmesh;
 function fusepoints(m) =
 let (
   privatetized = fp_privatetize(m), /* convert indexed polyhedron */
 newmesh= fp_glue(privatetized))
 newmesh;

 function fp_privatetize(m) = 
/* convert indexed polyhedron to vetrtex polygons with private vertex*/
 let (p = m[0], f = m[1], l = max(0,len(f) - 1))[
   for (i = [0: l])[     for (j = [0: len(f[i]) - 1]) p[f[i][j]]   ]];

 function fp_flatten(l) = [   for (a = l)     for (b = a) b ];
 
 function fp_addhash(m) = 
/*pair each point with a hash of the point*/
[   for (i = [0: len(m) - 1])[fp_encode(m[i]), m[i]] ];

 function fp_encode(v) =
 let (xseed = round(fp_rnd(1e8, -1e8, round(v.x * 1e6))),
   yseed = round(fp_rnd(1e8, -1e8, xseed + round(v.y * 1e6))),
   zseed = round(fp_rnd(1e8, -1e8, yseed + round(v.z * 1e6))),
   hash =   round(fp_rnd(1e8, -1e8, zseed)))
 hash;

 function fp_hashQS(arr) = !(len(arr) > 0) ? [] :
 let (pivot = arr[floor(len(arr) / 2)][0],
 lesser = [ for (y = [0: len(arr) - 1]) if (arr[y][0] < pivot) arr[y] ],
 equal = [ for (y = [0: len(arr) - 1]) if (arr[y][0] == pivot) arr[y] ],
 greater = [ for (y = [0: len(arr) - 1]) if (arr[y][0] > pivot) arr[y] ])
 concat(fp_hashQS(lesser), equal, fp_hashQS(greater));

 function fp_unique(m) = [   for (i = [0: len(m) - 1])     if (m[i] != m[i - 1]) m[i] ];

 function fp_rnd(a = 1, b = 0, s = []) = s == [] ? (rands(min(a, b), max(   a, b), 1)[0]) : (rands(min(a, b), max(a, b), 1, s)[0]); 

 function fp_removehash(m) = [   for (i = [0: len(m) - 1]) m[i][1] ];
 function fp_relink(p, f) =
/*convert polygons with private vertex to indexed by searching for hash matches  */
 let (l = len(f) - 1)[   for (i = [0: l])[     for (j = [0: len(f[i]) - 1]) search(fp_encode(f[i][j]), p)[0]] ];
 
 function fp_flip(w)=[w[0],[for(i=[0:len(w[1])-1])[w[1][i][0],w[1][i][2],w[1][i][1]]]];

function lerp(start, end, bias) = (end * bias + start * (1 - bias));

function relax(m, c =  2,nn=0) = 
let(points=m[0], faces=m[1], n=nn==0?neighbours(m):nn)
c > 0 ?
let(
midpoints = 
[ for (i = [0: len(faces) - 1]) avrg( 
[points[faces[i][0]], points[faces[i][1]], points[faces[i][2]]]
) ], 

points2 = [ for (i = [0: len(points) - 1]) len(
n[i]) > 0 ?  avrg([ for (j = [0: len(n[i]) - 1]) midpoints[ n[i] [j]]
 ])  : points[i] ])

relax([points2, faces]  , c - 1,n)
:
 [points, faces];

function neighbours (m)=let(points=m[0],faces=m[1]) [ for (i = [0: len(points) - 1])[ for (j = [0: len(faces) - 1])
 if (faces[j][0] == i || faces[j][1] == i || faces[j][2] == i || faces[j][3] == i) j] ];
function notneighbours (m)=let(points=m[0],faces=m[1]) [ for (i = [0: len(points) - 1])[ for (j = [0: len(faces) - 1])
 if ( (faces[j][0] != i && faces[j][1] != i && faces[j][2] != i && faces[j][3] != i)) j] ];
function neighboursofi (m,i)=let(points=m[0],faces=m[1])
  [ for (j = [0: len(faces) - 1])
 if (faces[j][0] == i || faces[j][1] == i || faces[j][2] == i || faces[j][3] == i) j] ;
function notneighboursofi (m,i)=let(points=m[0],faces=m[1])
  [ for (j = [0: len(faces) - 1])
 if ( (faces[j][0] != i && faces[j][1] != i && faces[j][2] != i && faces[j][3] != i)) j] ;
function addl(l, c = 0) = c < len(l) - 1 ? l[c] + addl(l, c + 1) : l[
 c];
function avrg(l) = len(l) > 1 ? addl(l) / (len(l)) : l;




function shuffle(b,l=1)=let(
c=concat( [for(i=[1:len(b)-1])b[i]],[b[0]]))
l>0?shuffle(c,l-1):c
;
function fp_tricylceb(b,p)=[for(i=[0:len(b)-1])fp_tricycle (b[i],p)];

function fp_tricycle(f,p)=
fp_is_equal(f[0],p)?
[f[1],f[2]]:
     let(f1=[f[1],f[2],f[0]])
    fp_is_equal(f1[0],p)?
        [f1[1],f1[2]]:
        let(f2=[f1[1],f1[2],f1[0]])
        fp_is_equal(f2[0],p)?[f2[1],f2[2]]:
        f;

function fp_triangulate(m,a,n ,count=0)=
let(points=m[0],faces=m[1])
count>len(a)?
a
:
len(a)<=3?
[[a[0],a[1],a[2]]]:
sign(dot(p2n([points[a[0]],points[a[1]],points[a[2]]  ]),n))>0?
let(b=concat([for(i=[2:len(a)-1])a[i]],[a[0]] )) 
concat([[a[0],a[1],a[2]]],fp_triangulate( m,shuffle(b,2),n )):fp_triangulate(m, shuffle(a,1),n,count+1 );

function fp_trimeshulate(a)=len(a)>3?let(b=concat([for(i=[2:len(a)-1])a[i]],[a[0]] )
) concat([[a[0],a[1],a[2]]],fp_trimeshulate(shuffle(b,2))):[[a[0],a[1],a[2]]];



 function fp_is_equal(a, b, d=1e-16) = (a==b) || (abs(a-b)<d) || (norm(a-b)<d);
    function flatten(l) = [ for (li = l, lij = li) lij ];

function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);

 function fp_segorder(n,acc=0,c=0)=c<=len(n)-1?let(newacc= (acc==0)?[n[0]]:let(lookfor= acc[0][0]) concat([for(i=[0:len(n)-1])if(fp_is_equal(lookfor,n[i][1])==true)n[i]],acc ))fp_segorder(n,newacc,c+1):acc;

function fp_segcollapse(n)=
[for(i=[0:len(n)-1])n[i][0]];

function normeq(pl) = 

let (list= [
 for (i = [0: len(pl) - 1],j = [0: len(pl) - 1])
 
 (-1 + dot(pl[i], pl[j])  )
   ]
,
sums = avrg(list) )
 
abs(sums)
 ;

function p2n4(p) =un(p2n(p0,p1,p3)+p2n(p3,p1,p2));
function p2n(p) =
let (pa=p[0], pb=p[1], pc=p[2],
u = pa - pb, v = pa - pc) un([u[1] * v[2] - u[2] * v[1], u[2] *
 v[0] - u[0] * v[2], u[0] * v[1] - u[1] * v[0]
]);
function un(v) = v / max(len3(v), 0.000001) * 1; // div by zero safe unit normal
function dot(v1, v2) = v1[0] * v2[0] + v1[1] * v2[1] + v1[2] * v2[2];
function addl(l, c = 0) = c < len(l) - 1 ? l[c] + addl(l, c + 1) : l[
 c];
function len3(v) = len(v) > 1 ? sqrt(addl([
 for (i = [0: len(v) - 1]) pow(v[i], 2)
])) : len(v) == 1 ? v[0] : v;

function  trimesh (t)=
let(
t1=t[1],
t2=fp_flatten([for(i=[0:len(t1)-1]) 
 (len( t1[i])==3)?[t1[i]]:[[t1[i][0],t1[i][1],t1[i][2]],[t1[i][0],t1[i][2],t1[i][3]]]     ] )
)[t[0],t2]
;
function tesselate(m,c=1)=
c>=1?
 let (
   pr = fp_privatetize(m), /* convert indexed polyhedron */

 subdv=fp_flatten([for(i=[0:max(0,len(pr)-1)])let(
pr01=lerp(pr[i][0],pr[i][1],0.5),
pr12=lerp(pr[i][1],pr[i][2],0.5),
pr20=lerp(pr[i][2],pr[i][0],0.5)
)[
[pr[i][0],pr01,pr20],
[pr[i][1],pr12,pr01],
[pr[i][2],pr20,pr12],
[pr01,pr12,pr20]

]
]),
 
  newmesh =   fp_glue(subdv)
)
tesselate(newmesh,c-1)
:

m;
 

module trender(t) {
 C0 = (un(rndc()) + [2, 0, 0]);
 C1 = (un(rndc()) + [2, 2, 0]);
 C2 = (un(rndc()) + [0, 2, 2]);
 for (i = [0: max(0, len(t[1]) - 1)]) {
 n = un(p2n(t[0][t[1][i][0]], t[0]
 [t[1][i][1]], t[0][t[1][i][
 2
 ]]));
 color(un((C0 * abs(n[0]) + C1 * abs(n[1]) + C2 * abs(n[2]) + [
 1, 1, 1
 ] * abs(n[2])) / 4)) polyhedron(t[0], [t[1][i]]);
 }
}
function rndc(a = 1, b = 0,seed) = [rnd(a, b,seed),
 rnd(a, b,seed+1), rnd(a, b,seed+2)
];
function bunny()=[[[33.718,-8.247,33.616],[-30.065,-22.111,41.454],[1.142,14.457,35.998],[20.205,-17.34,49.075],[36.378,-2.827,7.022],[-11.251,13.5,5.136],[29.105,-18.728,7.239],[-9.845,8.083,9.951],[-36.86,-24.079,60.289],[-28.976,-3.302,3.436],[-11.413,-13.526,50.148],[28.736,-0.816,42.915],[-32.116,4.195,42.182],[29.812,-7.088,2.935],[-37.993,-15.409,34.838],[-28.78,-18.857,66.373],[-29.289,21.548,77.615],[-28.191,23.665,69.162],[-36.226,-11.242,66.87],[31.967,2.895,30.506],[-25.318,1.605,64.068],[-41.72,-13.563,47.396],[3.505,-27.667,8.246],[18.251,9.502,40.482],[-40.705,-8.309,57.649],[-34.759,-14.864,24.435],[41.326,-8.903,12.497],[7.937,-25.727,1.639],[0.142,18.861,18.906],[37.372,0.543,12.665],[11.469,-25.566,39.178],[-11.3,-25.322,6.98],[16.983,0.961,50.904],[25.417,10.084,22.882],[12.196,16.124,13.812],[-38.798,-23.136,44.566],[-6.906,16.568,23.283],[-11.406,5.707,70.997],[27.876,3.576,10.072],[-29.124,6.104,23.795],[30.252,-19.533,18.403],[-24.95,-3.186,68.402],[-21.5,4.288,1.733],[-20.217,0.035,59.846],[-16.111,-1.157,53.825],[9.791,18.388,28.806],[-20.449,-9.927,10.118],[-5.697,-29.44,3.937],[-14.075,-24.543,1.192],[-38.314,-4.065,30.749],[-17.348,-6.564,61.51],[39.723,-14.873,17.026],[-24.142,-11.883,1.318],[4.044,-18.973,49.654],[-25.128,-21.576,4.037],[28.884,-15.239,42.197],[-7.042,-23.574,16.146],[-22.782,1.057,13.904],[-30.957,-28.833,46.933],[-13.723,10.348,24.112],[-6.4,7,79.935],[0.38,8.58,73.547],[-2.751,-29.774,24.603],[32.871,-16.125,29.207],[-3.623,17.983,31.576],[17.513,4.686,2.883],[-30.017,-27.275,56.561],[13.323,-29.14,13.068],[-20.244,-21.378,18.476],[-20.735,-20.229,49.671],[34.577,-0.469,19.663],[-32.728,2.082,59.206],[1.448,8.004,45.899],[-21.1,-24.65,32.38],[-3.299,14.822,3.265],[37.681,-9.851,21.953],[10.732,-31.947,27.781],[-25.458,13.814,68.264],[14.963,11.754,4.948],[-21.548,-8.801,67.863],[2.005,-5.173,1.969],[-23.472,3.741,51.505],[21.968,-9.013,50.599],[-9.451,7.934,17.546],[41.184,-5.284,20.179],[-39.539,-2.907,46.751],[-39.019,-9.922,42.553],[-16.487,10.221,37.797],[-9.537,-0.368,72.53],[-13.553,-22.428,41.139],[-5.875,-25.824,33.532],[10.433,-17.548,2.653],[-40.968,-17.45,57.613],[-32.842,15.053,71.785],[-4.31,-4.034,51.575],[10.947,-7.696,54.207],[1.296,-30.04,33.917],[-33.833,1.324,66.787],[-27.494,-6.782,16.239],[-21.944,-17.558,61.153],[-38.475,-27.624,50.311],[24.879,-24.385,33.536],[-21.259,-16.919,7.059],[-21.259,-16.919,7.059],[-21.259,-16.919,7.059]],[[80,91,48],[27,48,91],[68,98,46],[48,52,80],[98,25,49],[54,52,48],[42,74,80],[52,42,80],[42,5,74],[6,13,26],[25,98,68],[9,42,52],[46,103,68],[58,35,1],[1,35,21],[80,74,65],[100,35,58],[80,65,13],[91,80,13],[27,91,6],[6,91,13],[47,48,27],[51,75,40],[87,59,39],[5,7,74],[2,72,23],[28,74,7],[54,104,52],[64,28,36],[60,61,37],[39,57,98],[64,45,28],[34,74,28],[31,48,47],[102,54,31],[7,42,57],[59,57,39],[12,81,87],[37,43,41],[2,45,64],[74,34,78],[41,43,20],[59,7,57],[28,45,34],[87,39,12],[45,33,34],[37,41,60],[12,71,81],[34,33,78],[72,2,87],[38,29,65],[65,29,4],[49,12,39],[50,79,99],[94,72,44],[23,11,19],[27,6,67],[72,81,44],[44,81,43],[87,81,72],[70,75,84],[43,81,20],[45,2,23],[29,70,84],[19,33,23],[33,45,23],[32,72,94],[83,7,59],[98,57,46],[57,9,46],[71,85,24],[97,71,24],[97,93,71],[85,12,49],[49,39,98],[9,57,42],[32,94,95],[23,72,32],[71,93,17],[18,24,92],[5,42,7],[86,1,21],[83,59,36],[83,36,7],[36,28,7],[64,36,59],[23,32,11],[93,16,17],[12,85,71],[18,8,15],[92,35,100],[87,2,59],[22,62,56],[9,52,46],[8,92,100],[90,62,96],[14,1,86],[93,97,16],[14,25,73],[25,68,73],[1,14,73],[16,77,17],[30,90,96],[2,64,59],[8,100,66],[77,71,17],[32,82,11],[41,79,60],[15,79,41],[3,55,82],[82,55,11],[10,94,44],[44,50,10],[20,77,16],[79,88,60],[20,71,77],[99,69,10],[21,92,24],[50,99,10],[16,41,20],[8,18,92],[97,41,16],[22,27,67],[51,84,75],[15,66,99],[97,18,41],[55,0,11],[4,26,13],[55,63,0],[70,38,33],[102,46,52],[14,49,25],[75,0,63],[74,78,65],[19,70,33],[38,65,78],[33,38,78],[86,85,49],[97,24,18],[65,4,13],[86,49,14],[70,29,38],[50,61,88],[6,26,51],[37,61,43],[30,76,101],[40,101,67],[101,76,67],[30,101,3],[101,40,63],[55,3,101],[40,75,63],[22,47,27],[67,6,40],[60,88,61],[43,50,44],[19,11,0],[63,55,101],[26,4,29],[84,26,29],[31,54,48],[69,99,66],[58,1,69],[69,66,58],[76,62,67],[3,53,30],[67,62,22],[43,61,50],[30,96,76],[96,62,76],[22,31,47],[53,89,30],[89,90,30],[95,3,82],[56,31,22],[95,53,3],[10,89,53],[90,56,62],[90,73,56],[40,6,51],[89,73,90],[21,85,86],[56,68,31],[0,75,70],[73,68,56],[69,89,10],[68,102,31],[84,51,26],[15,41,18],[89,69,1],[1,73,89],[92,21,35],[82,32,95],[24,85,21],[0,70,19],[71,20,81],[8,66,15],[79,50,88],[66,100,58],[94,53,95],[15,99,79],[10,53,94]]];


function diamond()=



[[[-4.10863, -0.140602, -3.6055], [-3.84601, -3.60175, -1.47346], [-3.97796, -4.24691, -0.613285], [-2.53813, -0.848251, -6.37256], [-2.18844, -1.82373, -4.13948], [-0.0333337, -0.848251, -6.37256], [-0.107152, -1.93214, -3.8401], [-1.97693, -1.14585, -5.02233], [-0.274562, -1.22818, -4.66476], [-3.44904, -3.49388, -1.8379], [-2.53813, -6.1872, 0.213072], [-0.037514, -3.74431, -1.36103], [1.90021, -5.55326, 1.49797], [-2.17048, -4.75789, 0.0422999], [0.38598, -5.22305, 0.760223], [-4.55809, -2.31577, -1.67114], [-6.44044, -0.0759498, -0.538324], [-6.32277, -1.73312, 0.916171], [-5.9166, -0.0467461, -1.88034], [-5.65828, -2.40612, -0.340622], [-6.96031, -0.89379, 0.448986], [-6.65543, -1.13852, -0.358017], [-2.88119, -2.59327, -3.09619], [-0.0989006, -2.70754, -2.83311], [-3.60055, -1.31693, -3.26812], [-2.53813, -2.6279, 0.213072], [-0.0333337, -0.848251, -1.98214], [-0.0333337, -2.6279, 0.213072], [2.15047, -1.95664, -3.656], [3.80216, -1.72573, -3.28922], [1.56304, -1.48258, -4.06836], [3.83668, -0.578218, -3.60172], [2.68802, -3.77158, -1.23882], [2.83805, -5.71606, 1.54781], [5.02919, -3.92323, -0.983753], [3.92337, -5.44133, 1.27551], [2.72541, -4.80807, 0.236576], [5.02994, -4.6583, 0.245474], [7.48106, -0.848251, -4.17735], [7.48106, -4.40755, -1.98214], [6.60705, -3.53789, 1.16426], [2.83029, -2.38095, -3.21484], [5.84927, -2.95745, -2.39152], [2.47146, -0.848251, -1.98214], [2.47146, -2.6279, 0.213072], [6.11744, -0.664958, -2.92074], [6.43254, -3.13239, -0.469602], [7.22257, -2.26381, -1.08929], [6.65182, -0.574654, -2.63706], [8.58868, -1.57387, 0.498089], [9.98586, -2.6279, 0.213072], [8.86667, -0.790335, 0.374336], [8.84603, -0.149826, 1.18825], [-4.87593, 1.50124, -3.97146], [-4.70862, 2.29828, -4.04328], [-2.53813, 0.931399, -6.37256], [-0.0333337, 0.931399, -6.37256], [-2.53813, 2.71105, -6.37256], [-1.92777, -0.992021, -5.03321], [-0.0333337, 2.71105, -6.37256], [-0.995141, 0.58903, -5.22706], [-2.83857, 2.64671, -4.83497], [-0.750299, 2.94568, -5.55327], [-4.06563, 3.93282, -3.18426], [-6.40319, 0.425744, -0.412854], [-5.75953, 0.527687, -2.25537], [-6.99193, 0.969201, 1.4556], [-5.02031, 3.91375, -2.41588], [-6.36916, 1.93535, 0.391189], [-7.54773, 2.71105, 0.213072], [-5.83043, 2.72602, -0.366366], [-0.0333337, 4.4907, -6.37256], [-2.95489, 4.38504, -3.58535], [-0.877111, 5.02743, -4.1213], [-2.53813, 6.27035, -4.17735], [-0.0333337, 6.27035, -4.17735], [-4.76143, 4.15636, -2.33779], [-4.16403, 4.15885, 0.111998], [-3.22708, 5.14215, -0.9632], [-1.14664, 5.60559, -1.71968], [-1.66131, 5.80306, -0.514935], [-2.62796, 5.5636, 0.410056], [-1.52977, 5.81804, -0.660227], [-0.446236, 5.67479, 0.418208], [-1.75275, 5.8585, -0.193377], [-1.41853, 5.85982, -0.269016], [-4.54762, -3.75071, 3.14745], [-3.71454, -3.78975, 3.72922], [-2.53813, -6.1872, 2.40828], [1.95471, -5.51812, 2.02936], [-1.98562, -4.49762, 2.43775], [0.605838, -5.10006, 2.73186], [-0.0333337, -6.1872, 4.60349], [-2.1796, -4.16354, 4.20972], [0.220772, -4.657, 5.04817], [-6.28168, -1.83123, 1.66813], [-5.33131, -3.05158, 3.25984], [-6.7583, -0.821015, 1.81635], [-6.00906, -0.691373, 3.23509], [-5.01305, -2.50056, 4.10666], [-7.54773, -0.848251, 4.60349], [-5.05032, -1.18996, 4.9624], [-2.53813, -2.6279, 2.40828], [-2.13919, -2.76434, 5.27905], [-0.478659, -3.32594, 5.65739], [-2.8572, -1.53707, 5.73698], [-0.0333337, -0.848251, 4.60349], [1.40225, -3.9013, 6.19035], [-5.04293, -0.848251, 6.7987], [-0.907379, -2.11602, 6.31779], [0.598011, -2.49364, 6.82502], [-1.09261, -1.85583, 6.29929], [0.925692, -0.912368, 6.68243], [2.47146, 2.71105, -6.37256], [1.57593, 0.832456, -4.50757], [3.86489, 1.76097, -4.05165], [1.83142, 2.49517, -4.66334], [3.50857, 2.16194, -4.07357], [7.48106, 0.931399, -4.17735], [7.48106, 2.71105, -4.17735], [0.927679, 4.60082, -3.54521], [4.97626, 4.4907, -4.17735], [5.60468, 1.48375, -3.48449], [3.02465, 3.60509, -3.20588], [4.69642, 3.79178, -2.32503], [4.97626, 2.71105, 0.213072], [7.28769, 1.33692, -2.80066], [7.10103, 3.30374, -1.62038], [8.91038, 0.594316, 0.471455], [8.79874, 0.177289, 1.19532], [7.25544, 3.28327, -1.09866], [9.98586, 2.71105, 0.213072], [2.38489, 4.5449, -2.73796], [4.94993, 4.02157, -1.7848], [2.47146, 6.27035, -1.98214], [2.25305, 5.13412, 1.26447], [5.98923, 4.14473, 0.694604], [2.47146, 6.27035, 0.213072], [4.97626, 6.27035, 0.213072], [6.10839, 3.74254, -1.03395], [6.44784, 3.85258, 0.124204], [3.63356, -5.93983, 1.99458], [4.29407, -5.80738, 1.96402], [2.1521, -5.36055, 3.48979], [3.60251, -5.58484, 3.54027], [4.63112, -5.61119, 1.90199], [4.43858, -5.3304, 3.31399], [2.56493, -5.20374, 5.66859], [6.64743, -4.16945, 4.61148], [6.58158, -3.88963, 2.51602], [6.69287, -4.22084, 4.47167], [4.97626, -2.6279, 2.40828], [6.20177, -3.5936, 5.36913], [6.10459, 0.186099, 5.5842], [2.47146, -6.1872, 6.7987], [3.07735, -4.60228, 6.48149], [4.68258, -4.24091, 5.85724], [7.82046, -2.66139, 2.57944], [8.30424, -0.773894, 2.36074], [6.92055, -3.89612, 4.68602], [8.72116, -0.105558, 1.58722], [7.42911, -0.759798, 4.85241], [2.83186, -2.96797, 7.53465], [5.33017, -2.67575, 6.59174], [3.03607, -0.677601, 7.2506], [2.47146, -2.6279, 8.99391], [5.45436, -0.369361, 6.53547], [2.47146, -0.848251, 8.99391], [6.58971, -2.335, 6.0984], [6.71974, -1.44671, 6.08463], [-7.01509, 0.965476, 1.33196], [-5.93065, 1.78085, 2.42897], [-7.54773, 2.71105, 2.40828], [-4.25257, 3.10903, 3.81421], [-4.43171, 1.05919, 4.67493], [-3.97833, 2.70613, 4.44912], [-3.54766, 3.65164, 3.31828], [-2.1615, 0.698256, 5.44592], [-1.45723, 3.44114, 3.69473], [-0.612926, 1.46768, 5.68235], [-2.62304, 2.53125, 4.88518], [-0.354467, 2.18707, 5.50257], [-3.87248, 3.96791, 1.69684], [-5.04293, 4.4907, 4.60349], [-3.00649, 4.61703, 2.02873], [-0.272702, 4.3237, 2.4991], [-2.53813, 6.27035, 2.40828], [-2.53813, 4.4907, 4.60349], [-0.0333337, 6.27035, 2.40828], [0.867876, 3.48696, 3.71022], [-0.81646, -0.0217327, 5.9989], [0.883914, 1.53673, 6.15091], [-2.53813, 2.71105, 6.7987], [1.23386, 1.82958, 5.98969], [2.47146, 2.71105, 2.40828], [2.47146, 0.931399, 4.60349], [5.95758, 3.73293, 3.30952], [5.1154, 1.90952, 5.45984], [2.52823, 2.7118, 4.86052], [5.17682, 2.81784, 4.6537], [8.6324, 1.13685, 2.31573], [8.73021, 0.22765, 1.5864], [7.20341, 2.796, 2.56305], [7.80901, 0.297881, 3.82064], [6.6867, 2.07576, 3.69413], [2.85691, 4.93536, 1.7438], [5.42898, 4.50011, 2.37199], [2.47146, 6.27035, 2.40828], [2.57168, 3.62621, 3.54726], [4.97626, 6.27035, 2.40828], [4.18949, 3.69698, 3.4517], [3.26533, 1.08488, 7.0259], [4.41927, 1.24853, 6.66006], [2.66961, 1.95828, 5.88189], [3.93665, 1.97327, 5.74871], [6.38898, 3.73076, 1.44543]], [[19, 2, 1], [19, 1, 15], [21, 19, 15], [21, 15, 18], [24, 22, 4], [24, 4, 7], [31, 29, 42], [31, 42, 45], [42, 34, 37], [42, 37, 46], [48, 47, 49], [48, 49, 51], [65, 18, 0], [65, 0, 53], [66, 20, 16], [66, 16, 64], [67, 65, 53], [67, 53, 54], [70, 68, 65], [70, 65, 67], [76, 67, 54], [76, 54, 63], [77, 70, 67], [77, 67, 76], [84, 81, 78], [84, 78, 80], [82, 79, 83], [82, 83, 85], [91, 89, 12], [91, 12, 14], [96, 86, 2], [96, 2, 19], [97, 95, 17], [97, 17, 20], [99, 87, 86], [99, 86, 96], [101, 99, 96], [101, 96, 98], [110, 107, 94], [110, 94, 104], [111, 109, 103], [111, 103, 105], [115, 31, 45], [115, 45, 122], [117, 115, 122], [117, 122, 124], [126, 48, 51], [126, 51, 128], [127, 126, 128], [127, 128, 130], [120, 116, 123], [120, 123, 132], [139, 127, 130], [139, 130, 140], [37, 35, 142], [37, 142, 145], [147, 144, 141], [147, 141, 143], [145, 142, 146], [145, 146, 148], [49, 40, 149], [49, 149, 157], [51, 49, 157], [51, 157, 158], [157, 149, 150], [157, 150, 159], [158, 157, 159], [158, 159, 161], [152, 148, 156], [152, 156, 163], [161, 159, 168], [161, 168, 169], [170, 97, 20], [170, 20, 66], [173, 171, 68], [173, 68, 70], [174, 101, 98], [174, 98, 171], [175, 174, 171], [175, 171, 173], [182, 173, 70], [182, 70, 77], [189, 181, 178], [189, 178, 185], [190, 111, 105], [190, 105, 177], [193, 191, 179], [193, 179, 181], [129, 52, 160], [129, 160, 201], [130, 128, 200], [130, 200, 202], [200, 158, 161], [200, 161, 203], [202, 200, 203], [202, 203, 204], [206, 196, 199], [206, 199, 210], [197, 153, 166], [197, 166, 212], [199, 197, 212], [199, 212, 214], [140, 130, 202], [140, 202, 215], [9, 1, 2], [9, 2, 13], [11, 9, 13], [11, 13, 14], [18, 16, 20], [18, 20, 21], [6, 4, 22], [6, 22, 23], [7, 0, 18], [7, 18, 24], [32, 11, 14], [32, 14, 36], [34, 32, 36], [34, 36, 37], [28, 6, 23], [28, 23, 41], [29, 28, 41], [29, 41, 42], [47, 42, 46], [47, 46, 49], [68, 66, 64], [68, 64, 65], [78, 76, 63], [78, 63, 72], [79, 78, 72], [79, 72, 73], [81, 77, 76], [81, 76, 78], [85, 84, 80], [85, 80, 82], [13, 2, 86], [13, 86, 90], [14, 13, 90], [14, 90, 91], [90, 86, 87], [90, 87, 93], [91, 90, 93], [91, 93, 94], [19, 17, 95], [19, 95, 96], [104, 103, 109], [104, 109, 110], [124, 123, 116], [124, 116, 117], [132, 79, 73], [132, 73, 120], [135, 83, 79], [135, 79, 132], [136, 135, 132], [136, 132, 133], [140, 136, 133], [140, 133, 139], [33, 12, 89], [33, 89, 141], [35, 33, 141], [35, 141, 142], [142, 141, 144], [142, 144, 146], [143, 91, 94], [143, 94, 147], [40, 37, 145], [40, 145, 149], [149, 145, 148], [149, 148, 150], [147, 94, 107], [147, 107, 155], [148, 147, 155], [148, 155, 156], [52, 51, 158], [52, 158, 160], [159, 152, 163], [159, 163, 168], [169, 166, 153], [169, 153, 161], [171, 170, 66], [171, 66, 68], [180, 175, 173], [180, 173, 176], [181, 180, 176], [181, 176, 178], [184, 182, 77], [184, 77, 81], [185, 184, 81], [185, 81, 83], [191, 190, 177], [191, 177, 179], [201, 200, 128], [201, 128, 129], [204, 199, 196], [204, 196, 202], [205, 185, 83], [205, 83, 135], [206, 205, 135], [206, 135, 136], [208, 189, 185], [208, 185, 205], [210, 208, 205], [210, 205, 206], [213, 193, 181], [213, 181, 198], [214, 213, 198], [214, 198, 199], [215, 206, 136], [215, 136, 140], [7, 4, 6], [7, 6, 8], [20, 17, 19], [20, 19, 21], [15, 1, 9], [15, 9, 22], [22, 9, 11], [22, 11, 23], [18, 15, 22], [18, 22, 24], [8, 6, 28], [8, 28, 30], [30, 28, 29], [30, 29, 31], [14, 12, 33], [14, 33, 36], [36, 33, 35], [36, 35, 37], [23, 11, 32], [23, 32, 41], [41, 32, 34], [41, 34, 42], [45, 42, 47], [45, 47, 48], [46, 37, 40], [46, 40, 49], [53, 0, 7], [53, 7, 58], [58, 7, 8], [58, 8, 60], [54, 53, 58], [54, 58, 61], [61, 58, 60], [61, 60, 62], [64, 16, 18], [64, 18, 65], [63, 54, 61], [63, 61, 72], [72, 61, 62], [72, 62, 73], [80, 78, 79], [80, 79, 82], [85, 83, 81], [85, 81, 84], [98, 96, 95], [98, 95, 97], [103, 93, 87], [103, 87, 99], [104, 94, 93], [104, 93, 103], [105, 103, 99], [105, 99, 101], [112, 110, 109], [112, 109, 111], [60, 8, 30], [60, 30, 114], [114, 30, 31], [114, 31, 115], [62, 60, 114], [62, 114, 116], [116, 114, 115], [116, 115, 117], [73, 62, 116], [73, 116, 120], [122, 45, 48], [122, 48, 126], [124, 122, 126], [124, 126, 127], [128, 51, 52], [128, 52, 129], [132, 123, 124], [132, 124, 133], [133, 124, 127], [133, 127, 139], [143, 141, 89], [143, 89, 91], [148, 146, 144], [148, 144, 147], [159, 150, 148], [159, 148, 152], [162, 155, 107], [162, 107, 110], [163, 156, 155], [163, 155, 162], [164, 162, 110], [164, 110, 112], [166, 163, 162], [166, 162, 164], [169, 168, 163], [169, 163, 166], [171, 98, 97], [171, 97, 170], [177, 105, 101], [177, 101, 174], [180, 177, 174], [180, 174, 175], [181, 179, 177], [181, 177, 180], [184, 176, 173], [184, 173, 182], [185, 178, 176], [185, 176, 184], [191, 112, 111], [191, 111, 190], [201, 160, 158], [201, 158, 200], [203, 161, 153], [203, 153, 197], [204, 203, 197], [204, 197, 199], [208, 198, 181], [208, 181, 189], [210, 199, 198], [210, 198, 208], [211, 164, 112], [211, 112, 191], [212, 166, 164], [212, 164, 211], [213, 211, 191], [213, 191, 193], [214, 212, 211], [214, 211, 213], [215, 202, 196], [215, 196, 206]]]





;
function cubemesh4() = [
   [
     [-10, -10, -10],
     [10, -10, -10],
     [10, 10, -10],
     [-10, 10, -10],
     [-10, -10, -10],
     [10, -10, -10],
     [10, -10, 10],
     [-10, -10, 10],
     [10, -10, -10],
     [10, 10, -10],
     [10, 10, 10],
     [10, -10, 10],
     [10, 10, -10],
     [-10, 10, -10],
     [-10, 10, 10],
     [10, 10, 10],
     [-10, 10, -10],
     [-10, -10, -10],
     [-10, -10, 10],
     [-10, 10, 10],
     [-10, -10, 10],
     [10, -10, 10],
     [10, 10, 10],
     [-10, 10, 10]
   ],
   [
     [0, 1, 2, 3],
     [7, 6, 5, 4],
     [11, 10, 9, 8],
     [15, 14, 13, 12],
     [19, 18, 17, 16],
    [23, 22, 21, 20]

//,
//     [0, 1, 2],
//     [0,  2, 3]
//,
//     [7, 6, 5],
//     [7,  5, 4],
//     [11, 10, 9],
//     [11, , 9, 8],
//     [15, 14, 13],
//     [15,  13, 12],
//     [19, 18, 17],
//     [19,  17, 16]
//,
//    [23, 22, 21],
//    [23,  21, 20]
 
   ]
 ];
function cubemesh3() = [
   [
     [-10, -10, -10],
     [10, -10, -10],
     [10, 10, -10],
     [-10, 10, -10],
     [-10, -10, -10],
     [10, -10, -10],
     [10, -10, 10],
     [-10, -10, 10],
     [10, -10, -10],
     [10, 10, -10],
     [10, 10, 10],
     [10, -10, 10],
     [10, 10, -10],
     [-10, 10, -10],
     [-10, 10, 10],
     [10, 10, 10],
     [-10, 10, -10],
     [-10, -10, -10],
     [-10, -10, 10],
     [-10, 10, 10],
     [-10, -10, 10],
     [10, -10, 10],
     [10, 10, 10],
     [-10, 10, 10]
   ],
   [
//     [0, 1, 2, 3],
//     [7, 6, 5, 4],
//     [11, 10, 9, 8],
//     [15, 14, 13, 12],
//     [19, 18, 17, 16],
//    [23, 22, 21, 20]

 
     [0, 1, 2],
     [0,  2, 3]
,
     [7, 6, 5],
     [7,  5, 4],
     [11, 10, 9],
     [11, , 9, 8],
     [15, 14, 13],
     [15,  13, 12],
     [19, 18, 17],
     [19,  17, 16]
,
    [23, 22, 21],
    [23,  21, 20]
 
   ]
 ];