C0 = (un(rndc()) + [2, 0, 0]);
C1 = (un(rndc()) + [2, 2, 0]);
C2 = (un(rndc()) + [0, 2, 2]);
m=[ringrot(ringon(6)),[[1,2,0],[0,2,3],[4,5,0],[3,4,0]]];


d=extrude(m,[0,1,2,3,4,5],1,2);
//polyhedron(d[0],d[1]);
t=cc(d,0);

for (i=[0:max(0,len(d[1])-1)])echo(d[0][i]);

//trender(t);
polyhedron(t[0],t[1]);

function extrude(mesh,ring, length,n=0)=let(rl=len(ring),oldfaces=mesh[1],oldpoints=mesh[0],pl=len(oldpoints),

newpoints=[for (i=[0:rl-1])oldpoints[ring[i]]+[0,0,length]],

newfaces=[for (ii=[0:0.5:rl-0.5])let(i=floor(ii))i==ii?[ring[i],rl+i,rl+((i+1)%rl)]:[ring[i],rl+((i+1)%rl),ring[((i+1)%rl)]]],



newmesh=[concat(oldpoints,newpoints),concat(oldfaces,newfaces)]
)n>1?
let(newring=[for (i=[0:rl-1])(pl+i)])
extrude(newmesh,newring,length,n-1)
:
let(newring=[for (i=[0:rl-1])(pl+(rl-i-1))])
[concat(oldpoints,newpoints),concat(oldfaces,newfaces,[newring ])]
 ;





































module trender(t){
for (i=[0:max(0,len(t[1])-1)]){
  n = un(p2n(t[0][t[1][i][0]],t[0][t[1][i][1]],t[0][t[1][i][2]]));
color(un((C0 * abs(n[0]) + C1 * abs(n[1]) + C2 * abs(n[2]) + [1, 1, 1] * abs(n[2])) / 4)) 
polyhedron(t[0],[t[1][i]]);

}}



function cc(V,n=1,curve=0.61803398875)=n<=0?V:n==1?
let(w=V)
let(ed= cccheck(ccquicksort(ccquicksort(ccquicksort(ccquicksort(ccde(w[1],len(w[0])-1),2),1),0),1)))

let (nf=ccnf(ed))
[ccnv(w,nf,curve),nf]
:
let(w=cc(V,n-1,curve))
let(ed= cccheck(ccquicksort(ccquicksort(ccquicksort(ccquicksort(ccde(w[1],len(w[0])-1),2),1),0),1)))
let (nf=ccnf(ed))
[ccnv(w,nf,curve),nf]
;


function ccnv(v,nf,curve)=
let (nv=[for(i=[0:len(v[1])-1]) (v[0][v[1][i][0]]+v[0][v[1][i][1]]+v[0][v[1][i][2]])/3 ])
let(sfv= [ for(i=[0:len(v[0])-1]) avrg(ccfind(i,v[1],nv))])
concat(lerp(v[0],sfv,curve),nv);

function ccnf(hf)=
[for(i=[0:1:len(hf)-1])
(i%2)==0?
[hf[i][4],hf[(i+1)%len(hf)][2],hf[i][2]]
:
[hf[i][4],hf[(i-1)%len(hf)][2],hf[i][2]]
];

function ccde(faces,points) =
let(l=len(faces)-1)
   [for (i=[0:l])
    let(f = faces[i])
       for (j=[0:len(f)-1])
          let(p=f[j],q=f[(j+1)%len(f)])
              [min(p,q),max(p,q),i+points+1,p,q]  // no duplicates
   ];
function cccheck(ed)=concat(
[for(i=[0:len(ed)-1])if(
(ed[i][0]==ed[i-1][0]&&ed[i][1]==ed[i-1][1])
||(ed[i][0]==ed[i+1][0]&&ed[i][1]==ed[i+1][1])
)ed[i]]);
function ccfind(lookfor,faces,nv) =  
     [ for (i=[0:len(faces)-1]) if(
faces[i][0]==lookfor||faces[i][1]==lookfor||faces[i][2]==lookfor) nv[i] ];

function ccquicksort(arr,o) = !(len(arr)>0) ? [] : let(
    pivot   = arr[floor(len(arr)/2)],
    lesser  = [ for (y = arr) if (y[o]  < pivot[o]) y ],
    equal   = [ for (y = arr) if (y[o] == pivot[o]) y ],
    greater = [ for (y = arr) if (y[o]  > pivot[o]) y ]
) 
concat(
    ccquicksort(lesser,o), equal, ccquicksort(greater,o)
);
function wave(w,a=1,b=1)=[[for(i=[0:len(w[0])-1])
let(x=w[0][i][0],y=w[0][i][1],z=w[0][i][2])
w[0][i]+[sin((y+z)*b)*a,sin((z+x)*b)*a,sin((x+y)*b)*a]],w[1]]; 
function ccweld(v)=let(data=v[0])
[v[0],[for (i= [0:len(v[1])-1])let(index1=v[1][i][0],index2=v[1][i][1],index3=v[1][i][2])

concat(search(data[index1][0],data),search(data[index2][0],data),search(data[index3][0],data,1))
]];

function ccflip(w)=[w[0],[for(i=[0:len(w[1])-1])[w[1][i][0],w[1][i][1],w[1][i][2]] ]];
function un(v) = v / max(len3(v), 0.000001) * 1;
function p2n(pa, pb, pc) =
let (u = pa - pb, v = pa - pc) un([u[1] * v[2] - u[2] * v[1], u[2] * v[0] - u[0] * v[2], u[0] * v[1] - u[1] * v[0]]);
function avrg(v) = sumv(v, len(v) - 1) / len(v);
function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function len3(v) = len(v) == 2 ? sqrt(pow(v[0], 2) + pow(v[1], 2)) : sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
function sumv(v, i, s = 0) = (i == s ? v[i] : v[i] + sumv(v, i - 1, s));
function rnd(a = 0, b = 1) = (rands(min(a, b), max(a, b), 1)[0]);

function rndc() = [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]];

function tiny() = [
[[1,1,-1],[1.30656,0.541196,-1],[1.41421,-0,-1],[1.30656,-0.541196,-1],[1,-1,-1],[0.541196,-1.30656,-1],[0,-1.41421,-1],[-0.541196,-1.30656,-1],[-1,-1,-1],[-1.30656,-0.541196,-1],[-1.41421,0,-1],[-1.30656,0.541196,-1],[-1,1,-1],[-0.541195,1.30656,-1],[0.006,1.41421,-1],[0.541197,1.30656,-1],[1,0.999999,1],[1.30656,0.541195,1],[1.41421,-0.006,1],[1.30656,-0.541198,1],[0.999998,-1,1],[0.541194,-1.30656,1],[-0.006,-1.41421,1],[-0.541199,-1.30656,1],[-1,-0.999998,1],[-1.30656,-0.541193,1],[-1.41421,0.006,1],[-1.30656,0.5412,1],[-0.999997,1,1],[-0.541192,1.30657,1],[0.006,1.41421,1],[0.541201,1.30656,1],[0,0,-1],[0,0,1]],

[[32,0,1],[33,17,16],[32,1,2],[33,18,17],[32,2,3],[33,19,18],[32,3,4],[33,20,19],[32,4,5],[33,21,20],[32,5,6],[33,22,21],[32,6,7],[33,23,22],[32,7,8],[33,24,23],[32,8,9],[33,25,24],[32,9,10],[33,26,25],[32,10,11],[33,27,26],[32,11,12],[33,28,27],[32,12,13],[33,29,28],[32,13,14],[33,30,29],[32,14,15],[33,31,30],[15,0,32],[33,16,31],[0,16,17],[0,17,1],[1,17,18],[1,18,2],[2,18,19],[2,19,3],[3,19,20],[3,20,4],[4,20,21],[4,21,5],[5,21,22],[5,22,6],[6,22,23],[6,23,7],[7,23,24],[7,24,8],[8,24,25],[8,25,9],[9,25,26],[9,26,10],[10,26,27],[10,27,11],[11,27,28],[11,28,12],[12,28,29],[12,29,13],[13,29,30],[13,30,14],[14,30,31],[14,31,15],[16,0,15],[16,15,31]]];


function ringtrans(v, t) = [
  for (i = [0: len(v) - 1])
    [
      v[i][0] + t[0],
      v[i][1] + t[1],
      v[i][2] + t[2]
    ]
];

function ringrot(r = [  [0, 0, 0]], v=0) = [
  for (i = [0: len(r) - 1]) let (inx = r[i][0], iny = r[i][1], inz = r[i][2])[
    inx * sin(v) - inz * cos(v),
    iny,
    inx * cos(v) + inz * sin(v)
  ]
];

function xring(x = 8,r=1,n=0 ) = concat([[n*0.5,0,0]],[  for (i = [(360 / x) * 0.5: 360 / x: 359])[n, sin(i)*r,  cos(i)*r]]);
function ringon(x = 8,r=1,n=0 ) = concat([  for (i = [(360 / x) * 0.5: 360 / x: 359])[n, sin(i)*r,  cos(i)*r]]);
function cyl()=[concat(xring(8,10,-10), ringrot(xring(8,2,1),30)),[
[0,1,2],[0,2,3],[0,3,4],[0,4,5],[0,5,6],[0,6,7],[0,7,8],[0,8,1],

[2,1,10],[2,10,11],[3,2,11],[3,11,12],[4,3,12],[4,12,13],[5,4,13],[5,13,14],
[6,5,14],[6,14,15],[7,6,15],[7,15,16],[8,7,16],[8,16,17],[1,8,17],[1,17,10],

[10,9,11],[11,9,12],[12,9,13],[13,9,14],[14,9,15],[15,9,16],[16,9,17],
[17,9,10]]]
;
