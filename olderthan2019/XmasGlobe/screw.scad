HEIGHT=60;
TURNS=15;
CROWN=10;
ROOT=8;
TH=CROWN-ROOT;
HPT=HEIGHT/TURNS;


hcap0=concat([for(i=[1:-1/36:0])[sin(i*360)*ROOT,cos(i*360)*ROOT ,0 ]],[[0,0,0]]);
hcap1=concat([for(i=[0:1/36:1])[sin(i*360)*ROOT,cos(i*360)*ROOT ,HEIGHT ]],[[0,0,HEIGHT]]);
 polyhedron(hcap0,[for(i=[0:35])[36,i,(i+1)%36]]);
 polyhedron(hcap1,[for(i=[0:35])[36,i,(i+1)%36]]);
 
h0=[for(i=[-1:1/36:TURNS+1])[sin(i*360)*ROOT,cos(i*360)*ROOT ,clamp(i*HPT)]];
 
h1=[for(i=[-1:1/36:TURNS+1])
let(CR=max(0,min(1,i+.25 ,( TURNS-i-0.5)))*TH)
[sin(i*360)*(ROOT+CR),cos(i*360)*(ROOT+CR),clamp(i*HPT+HPT*0.25 )]];

h2=[for(i=[-1:1/36:TURNS+1])
let(CR=max(0,min(1,i+.25 ,( TURNS-i-0.5)))*TH)
[sin(i*360)*(ROOT+CR),cos(i*360)*(ROOT+CR),clamp(i*HPT+HPT*0.5)]];

h3=[for(i=[-1:1/36:TURNS+1])[sin(i*360)*ROOT,cos(i*360)*ROOT,clamp(i*HPT+HPT*0.75 )]];
//ShowControl(h0);
//ShowControl(h1);
//ShowControl(h2);
//ShowControl(h3);
function clamp(a,b = 0,c = (HEIGHT)) = min(max(a,b),c);
function  unique(m) = [   for (i = [0: len(m) - 1])    if (search([m[i]],m,1)==[i]&&m[i]!=undef) m[i] ];




  for (i = [0: len(h0) - 2]) {
      // vg  translate(t(v[i])) sphere(v[i][3]);
p0=unique([
        h0[i] 
       ,h0[i+1] 
       ,h1[i+1]
       ,h1[i] ]);

 if(len(p0)==4) polyhedron(p0 ,[[0,1,2],[0,2,3]]);
 if(len(p0)==3) polyhedron(p0 ,[[0,1,2] ]);
p1=unique([
        h1[i] 
       ,h1[i+1] 
       ,h2[i+1]
       ,h2[i] ]);
if(len(p1)==4)      polyhedron( p1,[[0,1,2],[0,2,3]]);
if(len(p1)==3) polyhedron(p1 ,[[0,1,2] ]);

p2=unique( [
        h2[i] 
       ,h2[i+1] 
       ,h3[i+1]
       ,h3[i] ]);
 if(len(p2)==4)     polyhedron(p2,[[0,1,2],[0,2,3]]);
 if(len(p2)==3) polyhedron(p2 ,[[0,1,2] ]);

p3=unique([
        h3[i] 
       ,h3[i+1] 
       ,h0[ (   i+36)+1]
       ,h0[ (  i+36)] ]);
 if(len(p3)==4)    polyhedron( p3,[[0,1,2],[0,2,3]]);
 if(len(p3)==3) polyhedron(p3 ,[[0,1,2] ]);

  

 
    }



module ShowControl(v) { // translate(t(v[0])) sphere(v[0][3]);
 
    for (i = [1: len(v) - 1]) {
      // vg  translate(t(v[i])) sphere(v[i][3]);
      hull() {
        translate( v[i]) sphere(0.1);
        translate( v[i - 1]) sphere(0.1);
      }
    }
}