DNA1=[
[5,[3,[5,0,0]]],
[5,[1,[15,0,1]]],
[5,[3,[5,0,0]]],
[15,[1,[5,0,-1]]]
]
;
DNA2=[
[2,[1,[5,0,0]]],
[2,[4,[5,0,0]]],
[7,[3,[5,0,0]]],
[10,[2,[5,0,0]]]
];

ring=[
[0,0,-1],[0,0.7,-0.7],
[0,1,0],[0,0.7,0.7],
[0,0,1],[0,-0.7,0.7],
[0,-1,0],[0,-0.7,-0.7]];
groove=0.3;
for(r=[0:0.1:0]){
   translate([0,100*r,0]){
       runner(DNA1*r+DNA2*(1-r)) ;
       };
       }

module runner(DNA) {
size=DNA[0][1][0];
nextsize=DNA[1][1][0];
steps=ceil(DNA[0][0]);
stepsize=(nextsize-size)/steps;

startstate=[[0,0,0],size,stepsize,0,
        steps];
polyhedron (ring*size*groove,[[for(i=[0:len(ring)-1])i]]);

trunk(startstate,ring,DNA );
}

module trunk(state,ring,map)
{  echo(m,state);
    pos=state[0];
    m1=0.8;m2=0.2;
    m=state[3];
    n=state[4];
    sizestep=state[2];
    size=state[1]+sizestep;
    nextsize=size ; 
         
    move=map[m][1][1];
    nextpos=pos+move;
    thisring=[for(i=[0:len(ring)-1])ring[i]*size*groove+pos];
    midring1=[for(i=[0:len(ring)-1])ring[i]*(size*m1+nextsize*m2)+(pos*m1+nextpos*m2)];   midring2=[for(i=[0:len(ring)-1])ring[i]*(size*m2+nextsize*m1)+(pos*m2+nextpos*m1)];
        
    nextring=[for(i=[0:len(ring)-1])ring[i]*nextsize*groove+nextpos];
    union(){
        bridge(thisring,midring1);
        bridgeext(midring1,midring2);
        bridge(midring2,nextring);
//polyhedron (thisring,[[for(i=[0:len(ring)-1])i]]);
//polyhedron (midring1,[[for(i=[0:len(ring)-1])i]]);
//polyhedron (midring2,[[for(i=[0:len(ring)-1])i]]);
//polyhedron (nextring,[[for(i=[0:len(ring)-1])i]]);
};
 if (m<len(map) && n<=0){
     
     nextsizestep=(map[min(m+2,len(map))][1][0]-map[min(m+1,len(map))][1][0])/(map[m+1][0]);
     nextstate=[nextpos,map[m+1][1][0]-nextsizestep,nextsizestep,m+1,ceil(map[m+1][0])];
     
     trunk(nextstate,ring,map);} 
     
     else if (m<len(map)-1){ 
         nextstate=[nextpos,size,sizestep,m,n-1];
         trunk(nextstate,ring,map);}
         polyhedron (nextring,[[for(i=[0:len(ring)-1])i]]);
 }    
 
 module bridge(r1,r2){
     n=len(r1);
     l=[for(i=[0:n])[i, (i+1)%n,n+(i+1)%n,n+i]];
     polyhedron(
     concat(r1,r2),l);
     
 };
 
  module bridgeext(r1,r2){
     n=len(r1);
      
     polyhedron(
     concat(r1,r2),[[0,1,9,8],[1,2,10,9]]); 

  
      color(rndc()) polyhedron(
     concat(r1,r2),[[2,3,11,10],[3,4,12,11]]);
     
color(rndc()) polyhedron(
     concat(r1,r2),[[4,5,13,12],[5,6,14,13]]); 
     
      polyhedron(
     concat(r1,r2),[[6,7,15,14],[7,0,8,15]]);
    
 };
                  
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 function rndR()=[rands(0,360,1)[0],rands(0,360,1)[1],rands(0,360,1)[0]];
function rndV()=[rands(-1,1,1)[0],rands(-1,1,1)[0],rands(-1,1,1)[0]];
function midpoint(start,end) = start + (end  - start )/2;
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];

 
 
 
 function lerp(start,end,bias ) = (end * bias + start * (1 - bias));
function geteuler(v) = [0, -asin(v[2]), atan2(v2xy(v)[1], v2xy(v)[0])]; //Euler angles from Vec3
function v2xy(v) = lim3(1, [v[0], v[1], 0]); // down projection xyz2xy
function lim3(l, v) = v / len3(v) * l; // normalize Vec37Vec4 to magnitude l
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2)); // find magnitude of Vec3
function v(i,v)=v[i+1]-v[i]; // vec3 from polyline segment
function t(v) = [v[0], v[1], v[2]];// purge vec4... down to vec3 (for translate to play nice)