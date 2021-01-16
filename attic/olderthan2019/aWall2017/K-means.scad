p=make_points(75);
K=Kmeans(p,round(rnd(1,20)),round(rnd(1,10)));
for(i=[0:len(p)-1])translate(p[i])sphere(0.5);  
for(i=[0: max(0,len(K[0])-1)])
    translate(K[0][i])color("Red",0.5)sphere(2,$fn=20);
for(i=[0: max(0,len(K[1])-1)]){
    color([rnd(),rnd(),rnd()] ,0.5)hull(){
    for(j=[0: max(0,len(K[1][i])-1)])translate(K[1][i][j])sphere( 3,$fn=1 );}}

function Kmeans(v,K,c=5,inmeans=undef) =  len(v) < K ? [v,v] :
let(
maxlenv= max(0,len(v)-1),maxK=max(0,K-1),
means=inmeans==undef? /* Initailize means if not done */    [for(i=[0:maxlenv])
        (v[rnd(maxlenv)]+v[rnd(maxlenv)]+v[rnd(maxlenv)])/3]:inmeans, 
vbuckets=[for(i=[0:maxlenv])index_min([for(k=[0:maxK])norm(v[i]-means[k])])],
new_means=[for(k=[0:maxK]) mean([for(i=[0:maxlenv]) if(vbuckets[i]==k)v[i]])]   )
c>0? Kmeans(v,K,c-1,new_means):
let(inbuckets=[for(k=[0:maxK])[for(i=[0:maxlenv]) if(vbuckets[i]==k)v[i]] ])
[new_means,inbuckets] ;


function index_min(l) = search(min(l), l)[0];
function index_max(l) = search(max(l), l)[0];
function mean(a) = !(len(a) > 0) ?  undef :   ([ for(b=a) 1 ] * a )/len(a);
function make_points(j=10)= ([for(i=[0:j])[rnd(-30,30),rnd(-20,20),rnd(-10,10)]]);
function rnd(a = 1, b = 0, s = [] ) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 