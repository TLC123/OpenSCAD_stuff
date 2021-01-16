range=[0:30];

dA=1;
dB=.5;
k=.052;
feed=.055;

clampmax=max([each range]);
clampmmin=min([each range]);
grid=[for(x=range)[for(y=range)    rands(-2,2,2)]];
 
  ng=reactdiff(grid);

for(x=range,y=range) {
color([ng[x][y].x,ng[x][y].y,0])translate([x,y]) square(1);
}

function reactdiff(grid,c=26)=
c>0?
reactdiff([for(x=range)[for(y=range)

let(  a = grid[x][y][0],   b = grid[x][y][1])
let(lap=[[0,0],[-1,0],[1,0],[0,1],[0,-1],[-1,-1],[1,-1],[1,1],[-1,1] ]  )
let(mul= [-1,0.2,0.2,0.2,0.2,0.05,0.05,0.05,0.05] )
let ( fetch=[for(p=lap) grid[clamp(x+p.x,clampmmin,clampmax)][clamp(y+p.y,clampmmin,clampmax)] ])
  
 let (vals=mul*fetch)
    
let(laplaceAxy=vals[0],laplaceBxy=vals[1])
[
clamp (a + dA * laplaceAxy -a * b * b + feed * (1 -a) ),
clamp (b + dB * laplaceBxy + a * b * b -(k + feed) * b )
] 

]],c-1)
:
grid
;



function un(v) = v / max(norm(v), 1e-64) * 1;
function clamp(a,b=0,c=1) =  min(max(a,min(b,c)),max(b,c));
function lerp(start,end,bias) = (end * bias + start * (1 - bias));
function rnd(a,b)=a+(rands(0,1,1)[0])*(b-a);
