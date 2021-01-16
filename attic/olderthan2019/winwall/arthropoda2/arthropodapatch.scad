controlpoints=3;//[1:20]

grove=0.5;
LINE1=[[1,0*grove,-1*grove],    [1,0,-2],   [4,0,-2],   [4,0*grove,-1*grove]];
LINE2=[[1,0.5*grove,-1*grove],  [1,0.5,-2],   [4,.5,-2],    [4,.5*grove,-1*grove]];
LINE3=[[1,1*grove,-1*grove],    [1,2,-1],   [4,2,-1],  [4,1*grove,-1*grove]];

LINE4b=[[1,1*grove, 0*grove],  [1,2, 0],   [4,2, 0], [4,1*grove, 0*grove]];

LINE4=[[1,1*grove, 1*grove],    [1,2, 1],   [4,2, 1],   [4,1*grove, 1*grove]];
LINE5=[[1,0.5*grove, 1*grove],  [1,0.5, 2], [4,.5, 2],  [4,.5*grove, 1*grove]];
LINE6=[[1,0*grove, 1*grove],    [1, 0,2],     [4,0, 2], [4,0*grove, 1*grove]];
linepack=[LINE1,LINE2,LINE3,LINE4b,LINE4,LINE5,LINE6];
v1 =vsmooth( [ [-21,0,15,1],[-20,0,20,1], [0,0,20,1],[25,0,10,1],[50,0,0,1]]);

  v2 = [[1,0.1,0.1],[1,2,1],[1,0.8,0.4]];
  DistrubuteAlong2(v1,v2,10,0,1,[0,0,0,0]){
translate([-2.5,0,0]) scale(8,10,10)rotate([0,0,0]) 

scale([0.4,1,1]){
   
   bptach(vecmul(linepack,[1,1,1]),5,0.1);
 bptach(vecmul(linepack,[1,-1,1]),5,0.1);}

    
    }

 //end main
////////////////////////////////////////////////
///////////////////////////////////////////////   
   module DistrubuteAlong2(v,v2,d=8,start=0,stop=1,modify=[0,0,0,0]) {
         detail=1/d;
    if($children>0)for(i3 = [start: detail: stop+detail]) {
        i2=i3>stop?stop:i3;
                i=bz2t(v,len3bz(v)*i2,0.005);

        for (j=[0:$children-1]) 
      
translate(t(bez2(i,v))) rotate(bez2euler(i, v))
         
         // rotate([bez2(i  , v2)[2]+modify[2],0,0])
          //translate([0,0,bez2(i  , v2)[1]*bez2(i  , v)[3]+modify[1]])
          scale(        t(bez2(i  , v2))) children(j);
   
      
      
    }
  }
 module bptach(linepack,D=12,Tension=0.7){
hstart=0.00001;
hstop=1.00001;
vstart=0.00001;
vstop=1.00001;
hstep=(hstop-hstart)/D;
vstep=(hstop-hstart)/D;
*union(){
 for(i = [0:  len(linepack) - 1]){
    ShowControl(linepack[i],0.03);}
}  
for (t=[hstart:hstep:hstop-hstep]){

spar1=[for(i = [0:  len(linepack) - 1])bez2(t, linepack[i])];
spar2=[for(i = [0:  len(linepack) - 1])bez2(t+hstep, linepack[i])];
cage1=[for(i = [0:  len(linepack) - 1])pol2(t, linepack[i])];
cage2=[for(i = [0:  len(linepack) - 1])pol2(t+hstep, linepack[i])];
    
   *ShowControl(cage1,0.03); 
   *ShowControl(cage2,0.03); 
for (v=[vstart:vstep:vstop-vstep]){
 
      
    p1=[((bez2(v, spar1)[0] ) ) ,max(-3,bez2(v, spar1)[1] ),bez2(v, spar1)[2]];
    p2=[((bez2(v+vstep, spar1)[0] ) ) ,max(-3,bez2(v+vstep, spar1)[1] ),bez2(v+vstep, spar1)[2]];
    p3=[((bez2(v, spar2)[0] ) ) ,max(-3,bez2(v, spar2)[1] ),bez2(v, spar2)[2]];
    p4=[((bez2(v+vstep, spar2)[0] ) ) ,max(-3,bez2(v+vstep, spar2)[1] ),bez2(v+vstep, spar2)[2]];      
  
    c1=[((pol2(v, cage1)[0] ) ) ,max(-3,pol2(v, cage1)[1] ),pol2(v, cage1)[2]];
    c2=[((pol2(v+vstep, cage1)[0] ) ) ,max(-3,pol2(v+vstep, cage1)[1] ),pol2(v+vstep, cage1)[2]];
    c3=[((pol2(v, cage2)[0] ) ) ,max(-3,pol2(v, cage2)[1] ),pol2(v, cage2)[2]];
    c4=[((pol2(v+vstep, cage2)[0] ) ) ,max(-3,pol2(v+vstep, cage2)[1] ),pol2(v+vstep, cage2)[2]];
   
    sp1= lerp(p1,c1,Tension);
     sp2= lerp(p2,c2,Tension);
     sp3= lerp(p3,c3,Tension);
     sp4= lerp(p4,c4,Tension);  
  color([t,v,0.5]){
   
   
   
   * line(p1,c1,0.01);
   * line(p2,c2,0.01);
  * line(p3,c3,0.01);
   * line(p4,c4,0.01);
    
    polyhedron(

    points = [t(sp1),t(sp2),t(sp3),t(sp4)]    ,
  //  points = [t(c1),t(c2),t(c3),t(c4)]    ,
//    points = [t(p1),t(p2),t(p3),t(p4)]    ,
   faces = [[0,1,2],[3,2,1]]
    );}
//poly(p1,p2,p3,0.1,false);
// poly(p4,p3,p2,0.1,false);
        
        
        
        
    
}
}
    }
    module poly(p1,p2,p3,h1=1,tomidline=true) {
 
  hull() {
      
    translate(t(p1)) sphere(h1,$fn=4);
    translate(t(p2)) sphere(h1,$fn=4);
    translate(t(p3))  sphere(h1,$fn=4);
  if (tomidline){
    translate(y(p1)) sphere(h1,$fn=4);
    translate(y(p2)) sphere(h1,$fn=4);
    translate(y(p3)) sphere(h1,$fn=4);
  }}
}


module extrudeT(v,d=8,start=0,stop=1) {
     detail=1/d;
for(i = [start+detail: detail: stop]) {
   for (j=[0:$children-1]) 
  hull() {
    translate(t(bez2(i,v))) rotate(bez2euler(i, v))scale(bez2(i  , v)[3]) children(j);
    translate(t(bez2(i - detail, v))) rotate(bez2euler(i - detail, v))scale(bez2(i- detail  , v)[3]) children(j);
  }
}
}

module mirrorextrudeT(v,d=8,start=0,stop=1) {
     detail=1/d;
for(i = [start+detail: detail: stop]) {
   for (j=[0:$children-1]) 
  hull() {mirrorcopy([0,-1,0]){
    translate(t(bez2(i,v))) rotate(bez2euler(i, v))scale(bez2(i  , v)[3]) children(j);
    translate(t(bez2(i - detail, v))) rotate(bez2euler(i - detail, v))scale(bez2(i- detail  , v)[3]) children(j);
  }}
}
}

module ShowControl(v,d=1)  
{  // translate(t(v[0])) sphere(v[0][3]);
  for(i=[1:len(v)-1]){
   // vg  translate(t(v[i])) sphere(v[i][3]);
      hull(){
          translate(t(v[i])) sphere(d);
          translate(t(v[i-1])) sphere(d);
          }          }
  } 
  
module line(a,b,c=0.5){
    hull(){
        translate(a)sphere(c);
        translate(b)sphere(c);
        
        }
    
    }  
 
module mirrorcopy(vec=[0,1,0]) { union(){
children(); 
mirror(vec) children(); }
} 

function subdv(v)=[let(last=(len(v)-1)*3)for (i=[0:last])let(j=floor((i+1)/3))i%3 == 0?v[j]:i%3  == 2?  v[j]- un(un(pre(v,j))+un(post(v,j)))*(len3(pre(v,j))+len3(post(v,j)))*0.1 :   v[j] +un(un(pre(v,j)) +un(post(v,j)))*(len3(pre(v,j))+len3(post(v,j)))*0.1];     
function bz2t(v,stop,precision=0.01,t=0,acc=0)=acc>=stop||t>1?t:bz2t(v,stop,precision,t+precision,acc+len3(bez2(t,v)-bez2(t+precision,v)));

function len3bz(v,precision=0.01,t=0,acc=0)=t>1?acc:len3bz(v,precision,t+precision,acc+len3(bez2(t,v)-bez2(t+precision,v)));
function bez2euler(i, v) = [0, -asin(bez2v(i, v)[2]), atan2(bez2xy(bez2v(i, v))[1], bez2xy(bez2v(i, v))[0])];
function bez2(t, v) = (len(v) > 2) ? bez2(t, [for(i = [0: len(v) - 2]) v[i] * t + v[i + 1] * (1 - t)]): v[0] * t + v[1] * (1 - t);

function pol2(i, v) =t(v2t(v,len3v(v)*(1-i)));

  // lenght along vetorlist to point 
  function v2t(v,stop,p=0)=p+1>len(v)-1|| stop<len3(v[p]-v[p+1])?   v[p]+un(v[p+1]-v[p])*stop:  v2t(v,stop-len3(v[p]-v[p+1]),p+1);

  // the total lenght op multisegment vektor
function len3v(v,acc=0,p=0)=p+1>len(v)-1?acc:len3v(v,acc+len3(v[p]-v[p+1]),p+1)  ;
function lerp(start,end,bias = 0.5) = (end * bias + start * (1 - bias));
function lerplist(v1,v2,bias) = [  for(i = [0:  len(v) - 1])(v2[i] * bias + v2[i] * (1 - bias)) ];
 // function  vecmul(v,mul)= (len(v)==3&&len(v[0])==1&&len(v[1])==1&&len(v[2])==1)?[v[0]*mul[0],v[1]*mul[1],v[2]*mul[2]]: [  for(i = [0:  len(v) - 1]) vecmul(v[i],mul) ]; // 
function  vecmul(v,mul)= (len(v)==3)?[v[0]*mul[0],v[1]*mul[1],v[2]*mul[2]]:[for(i = [0:  len(v) - 1]) vecmul(v[i],mul)] ;
function vsmooth(v) = [
  for(i = [0: 1 / len(v): 1]) bez2(i,v)
];
function lim31(l, v) = v / len3(v) * l;
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
function bez2xy(v) = lim31(1, [v[0], v[1], 0]); // down xy projection
function bez2v(i, v) = lim31(1, bez2(i - 0.0001, v) - bez2(i, v)); // unit vector at i
function t(v) = [v[0], v[1], v[2]];
function rndR()=[rands(0,360,1)[0],rands(0,360,1)[1],rands(0,360,1)[0]];
function rndV()=[rands(-1,1,1)[0],rands(-1,1,1)[0],rands(-1,1,1)[0]];
function midpoint(start,end) = start + (end  - start )/2;
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];     
function rnd(a,b)=a+(rands(0,1,1)[0])*(b-a);     
function t(v) = [v[0], v[1], v[2]];
function y(v) = [v[0], 0, v[2]];
function vsharp(v) = [  for(i = [0: 0.5: len(v) - 1]) v[floor(i)]];
function un(v) = v / max(len3(v),0.000001) * 1;
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
function pre(v,i)= i>0?         (v[i]-v[i-1]):[0,0,0,0];
function post(v,i)=i<len(v)-1?  (v[i+1]-v[i]):[0,0,0,0] ;
function SC3 (a)= let( b=clamp(a))(b * b * (3 - 2 * b));
function clamp (a,b=0,c=10)=min(max(a,b),c);
function gauss(x)=x+(x-SC3(x));