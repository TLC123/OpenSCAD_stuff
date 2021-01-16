//demo mesh
 mesh = [
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
//     [23, 22, 21, 20]
     [0, 1, 2],
     [0,  2, 3],
     [7, 6, 5],
     [7,  5, 4],
     [11, 10, 9],
     [11, , 9, 8],
     [15, 14, 13],
     [15,  13, 12],
     [19, 18, 17],
     [19,  17, 16],
     [23, 22, 21],
     [23,  21, 20]
 
   ]
 ];
 mesh=fp_flip(bunny());
 midmesh = tesselate(mesh,1);
nm = tesselate(mesh,2);
n=neighbours(nm);


newmesh=relax (nm[0],nm[1],n);
 dmaesh=fp_decimate ( mesh  );
translate ([60,0,0]) polyhedron(nm[0], nm[1]);
translate ([120,0,0]) polyhedron(midmesh[0], midmesh[1]);

translate ([-60,0,0]) polyhedron(dmaesh[0], dmaesh[1]);
  polyhedron(newmesh[0], newmesh[1]);
  for (i = [0: len(dmaesh) - 1]) echo(dmaesh[i]);
 

function tesselate(m,i=1)=
i>=1?
 let (
   pr = fp_privatetize(m), /* convert indexed polyhedron */

 subdv=fp_flatten([for(i=[0:len(pr)-1])let(
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
tesselate(newmesh,i-1)
:

m;
 
function fp_decimate (m,i=0)=
let(points=m[0],faces=m[1])
i<len(faces)-1?
flattness(m,i)==0? fp_decimate (fp_decimateinidex(m,i),0) :fp_decimate (m,i+1)
:
m;
function flattness(m,i)=round(rnd(40));
function fp_decimateinidex(m,i)=
let(points=m[0],faces=m[1])
let(
ni=neighboursofi(m,i),
removies=[for(i=[0:len(ni)-1])([points[(faces[ni[i]][0])],points[(faces[ni[i]][1])],points[(faces[ni[i]][2])]  ])],
newfaces=fp_removevertex(removies,m[0][i]),
nn=notneighboursofi (m,i),
keepers=[for(i=[0:len(nn)-1])([points[(faces[nn[i]][0])],points[(faces[nn[i]][1])],points[(faces[nn[i]][2])]  ])]
)
fp_glue( concat(keepers,newfaces))
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
 let (p = m[0], f = m[1], l = len(f) - 1)[
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

function relax(points, faces, neighbours,  c =  2) = 
c > 0 ?
 let (
midpoints = 
[ for (i = [0: len(faces) - 1]) avrg( len(faces[i])==3?[points[faces[i][0]], points[faces[i][1]], points[faces[i][2]]]:[points[faces[i][0]], points[faces[i][1]], points[faces[i][2]], points[faces[i][3]]] ) ], 

points2 = [ for (i = [0: len(points) - 1]) len(
neighbours[i]) > 0 ? 

 avrg([ for (j = [0: len(neighbours[i]) - 1]) midpoints[ neighbours[i] [j]]
 ])  : points[i] ])

relax(points2, faces, neighbours,   c - 1)
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

function fp_removevertex(faces,vertex)=let(
d= fp_tricylceb(faces,vertex),
c= fp_segorder(d),
e=fp_segcollapse(c),
f=fp_triangulate(e))
f;
function fp_tricylceb(b,p)=[for(i=[0:len(b)-1])fp_tricycle (b[i],p)];

function fp_triangulate(a)=len(a)>3?let(b=concat([for(i=[2:len(a)-1])a[i]],[a[0]] )
) concat([[a[0],a[1],a[2]]],fp_triangulate(b)):[[a[0],a[1],a[2]]];

function fp_tricycle(f,p)=fp_is_equal(f[0],p)?[f[1],f[2]]:let(f1=[f[1],f[2],f[0]])fp_is_equal(f1[0],p)?[f1[1],f1[2]]:let(f2=[f1[1],f1[2],f1[0]])fp_is_equal(f2[0],p)?[f2[1],f2[2]]:f;

 function fp_is_equal(a, b, d=1e-16) = (a==b) || (abs(a-b)<d) || (norm(a-b)<d);
    function flatten(l) = [ for (li = l, lij = li) lij ];

function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);

 function fp_segorder(n,acc=0,c=0)=c<=len(n)-1?let(newacc= (acc==0)?[n[0]]:let(lookfor= acc[0][0]) concat([for(i=[0:len(n)-1])if(fp_is_equal(lookfor,n[i][1])==true)n[i]],acc ))fp_segorder(n,newacc,c+1):acc;

function fp_segcollapse(n)=
[for(i=[0:len(n)-1])n[i][0]];




function bunny()=[[[33.718,-8.247,33.616],[-30.065,-22.111,41.454],[1.142,14.457,35.998],[20.205,-17.34,49.075],[36.378,-2.827,7.022],[-11.251,13.5,5.136],[29.105,-18.728,7.239],[-9.845,8.083,9.951],[-36.86,-24.079,60.289],[-28.976,-3.302,3.436],[-11.413,-13.526,50.148],[28.736,-0.816,42.915],[-32.116,4.195,42.182],[29.812,-7.088,2.935],[-37.993,-15.409,34.838],[-28.78,-18.857,66.373],[-29.289,21.548,77.615],[-28.191,23.665,69.162],[-36.226,-11.242,66.87],[31.967,2.895,30.506],[-25.318,1.605,64.068],[-41.72,-13.563,47.396],[3.505,-27.667,8.246],[18.251,9.502,40.482],[-40.705,-8.309,57.649],[-34.759,-14.864,24.435],[41.326,-8.903,12.497],[7.937,-25.727,1.639],[0.142,18.861,18.906],[37.372,0.543,12.665],[11.469,-25.566,39.178],[-11.3,-25.322,6.98],[16.983,0.961,50.904],[25.417,10.084,22.882],[12.196,16.124,13.812],[-38.798,-23.136,44.566],[-6.906,16.568,23.283],[-11.406,5.707,70.997],[27.876,3.576,10.072],[-29.124,6.104,23.795],[30.252,-19.533,18.403],[-24.95,-3.186,68.402],[-21.5,4.288,1.733],[-20.217,0.035,59.846],[-16.111,-1.157,53.825],[9.791,18.388,28.806],[-20.449,-9.927,10.118],[-5.697,-29.44,3.937],[-14.075,-24.543,1.192],[-38.314,-4.065,30.749],[-17.348,-6.564,61.51],[39.723,-14.873,17.026],[-24.142,-11.883,1.318],[4.044,-18.973,49.654],[-25.128,-21.576,4.037],[28.884,-15.239,42.197],[-7.042,-23.574,16.146],[-22.782,1.057,13.904],[-30.957,-28.833,46.933],[-13.723,10.348,24.112],[-6.4,7,79.935],[0.38,8.58,73.547],[-2.751,-29.774,24.603],[32.871,-16.125,29.207],[-3.623,17.983,31.576],[17.513,4.686,2.883],[-30.017,-27.275,56.561],[13.323,-29.14,13.068],[-20.244,-21.378,18.476],[-20.735,-20.229,49.671],[34.577,-0.469,19.663],[-32.728,2.082,59.206],[1.448,8.004,45.899],[-21.1,-24.65,32.38],[-3.299,14.822,3.265],[37.681,-9.851,21.953],[10.732,-31.947,27.781],[-25.458,13.814,68.264],[14.963,11.754,4.948],[-21.548,-8.801,67.863],[2.005,-5.173,1.969],[-23.472,3.741,51.505],[21.968,-9.013,50.599],[-9.451,7.934,17.546],[41.184,-5.284,20.179],[-39.539,-2.907,46.751],[-39.019,-9.922,42.553],[-16.487,10.221,37.797],[-9.537,-0.368,72.53],[-13.553,-22.428,41.139],[-5.875,-25.824,33.532],[10.433,-17.548,2.653],[-40.968,-17.45,57.613],[-32.842,15.053,71.785],[-4.31,-4.034,51.575],[10.947,-7.696,54.207],[1.296,-30.04,33.917],[-33.833,1.324,66.787],[-27.494,-6.782,16.239],[-21.944,-17.558,61.153],[-38.475,-27.624,50.311],[24.879,-24.385,33.536],[-21.259,-16.919,7.059],[-21.259,-16.919,7.059],[-21.259,-16.919,7.059]],[[80,91,48],[27,48,91],[68,98,46],[48,52,80],[98,25,49],[54,52,48],[42,74,80],[52,42,80],[42,5,74],[6,13,26],[25,98,68],[9,42,52],[46,103,68],[58,35,1],[1,35,21],[80,74,65],[100,35,58],[80,65,13],[91,80,13],[27,91,6],[6,91,13],[47,48,27],[51,75,40],[87,59,39],[5,7,74],[2,72,23],[28,74,7],[54,104,52],[64,28,36],[60,61,37],[39,57,98],[64,45,28],[34,74,28],[31,48,47],[102,54,31],[7,42,57],[59,57,39],[12,81,87],[37,43,41],[2,45,64],[74,34,78],[41,43,20],[59,7,57],[28,45,34],[87,39,12],[45,33,34],[37,41,60],[12,71,81],[34,33,78],[72,2,87],[38,29,65],[65,29,4],[49,12,39],[50,79,99],[94,72,44],[23,11,19],[27,6,67],[72,81,44],[44,81,43],[87,81,72],[70,75,84],[43,81,20],[45,2,23],[29,70,84],[19,33,23],[33,45,23],[32,72,94],[83,7,59],[98,57,46],[57,9,46],[71,85,24],[97,71,24],[97,93,71],[85,12,49],[49,39,98],[9,57,42],[32,94,95],[23,72,32],[71,93,17],[18,24,92],[5,42,7],[86,1,21],[83,59,36],[83,36,7],[36,28,7],[64,36,59],[23,32,11],[93,16,17],[12,85,71],[18,8,15],[92,35,100],[87,2,59],[22,62,56],[9,52,46],[8,92,100],[90,62,96],[14,1,86],[93,97,16],[14,25,73],[25,68,73],[1,14,73],[16,77,17],[30,90,96],[2,64,59],[8,100,66],[77,71,17],[32,82,11],[41,79,60],[15,79,41],[3,55,82],[82,55,11],[10,94,44],[44,50,10],[20,77,16],[79,88,60],[20,71,77],[99,69,10],[21,92,24],[50,99,10],[16,41,20],[8,18,92],[97,41,16],[22,27,67],[51,84,75],[15,66,99],[97,18,41],[55,0,11],[4,26,13],[55,63,0],[70,38,33],[102,46,52],[14,49,25],[75,0,63],[74,78,65],[19,70,33],[38,65,78],[33,38,78],[86,85,49],[97,24,18],[65,4,13],[86,49,14],[70,29,38],[50,61,88],[6,26,51],[37,61,43],[30,76,101],[40,101,67],[101,76,67],[30,101,3],[101,40,63],[55,3,101],[40,75,63],[22,47,27],[67,6,40],[60,88,61],[43,50,44],[19,11,0],[63,55,101],[26,4,29],[84,26,29],[31,54,48],[69,99,66],[58,1,69],[69,66,58],[76,62,67],[3,53,30],[67,62,22],[43,61,50],[30,96,76],[96,62,76],[22,31,47],[53,89,30],[89,90,30],[95,3,82],[56,31,22],[95,53,3],[10,89,53],[90,56,62],[90,73,56],[40,6,51],[89,73,90],[21,85,86],[56,68,31],[0,75,70],[73,68,56],[69,89,10],[68,102,31],[84,51,26],[15,41,18],[89,69,1],[1,73,89],[92,21,35],[82,32,95],[24,85,21],[0,70,19],[71,20,81],[8,66,15],[79,50,88],[66,100,58],[94,53,95],[15,99,79],[10,53,94]]];