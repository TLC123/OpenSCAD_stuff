HEIGHT=60;
TURNS=15;
CROWN=10;
ROOT=8;
TH=CROWN-ROOT;
HPT=HEIGHT/TURNS;
echo(search([[-2.73616, 7.51754, 60]] ,
[[-2.73616, 7.51754, 60], [-1.38919, 7.87846, 60], [-1.38919, 7.87846, 60], [-2.73616, 7.51754, 60]]
,0));

hcap0=roundlist(concat([for(i=[1:-1/36:0])[sin(i*360)*ROOT,cos(i*360)*ROOT ,0 ]],[[0,0,0]]));
hcap1=roundlist(concat([for(i=[0:1/36:1])[sin(i*360)*ROOT,cos(i*360)*ROOT ,HEIGHT ]],[[0,0,HEIGHT]]));

 polyhedron(hcap0,[for(i=[0:1:35])[i,36,(i+1)%36]]);
 polyhedron(hcap1,[for(i=[0:1:35])[i,36,(i+1)%36]]);
 
h0=roundlist([for(i=[-1:1/36:TURNS+1])[sin(i*360)*ROOT,cos(i*360)*ROOT ,clamp(i*HPT)]]);
 
h1=roundlist([for(i=[-1:1/36:TURNS+1])
let(CR=max(0,min(1,i+.25 ,( TURNS-i-0.5)))*TH)
[sin(i*360)*(ROOT+CR),cos(i*360)*(ROOT+CR),clamp(i*HPT+HPT*0.25 )]]);

h2=roundlist([for(i=[-1:1/36:TURNS+1])
let(CR=max(0,min(1,i+.25 ,( TURNS-i-0.5)))*TH)
[sin(i*360)*(ROOT+CR),cos(i*360)*(ROOT+CR),clamp(i*HPT+HPT*0.5)]]);

h3=roundlist([for(i=[-1:1/36:TURNS+1])[sin(i*360)*ROOT,cos(i*360)*ROOT,clamp(i*HPT+HPT*0.75 )]]);
//ShowControl(h0);
//ShowControl(h1);
//ShowControl(h2);
//ShowControl(h3);
function clamp(a,b = 0,c = (HEIGHT)) = min(max(a,b),c);
function  unique(m) = [   for (i = [0: len(m) - 1])    if (search([m[i]],m,0)[0][0]==i&&m[i]!=undef) m[i] ];
function rev(v) = [ for(i = [len(v)-1:-1:0]) v[i] ];
function roundlist(v,r = 0.01) = len(v) == undef ? v - (v % r) : len(v) == 0 ? [] : [
  for (i = [0: len(v) - 1]) roundlist(v[i],r)];


 polyhedron(hcap0,[for(i=[0:1:35])[i,36,(i+1)%36]]);
 polyhedron(hcap1,[for(i=[0:1:35])[i,36,(i+1)%36]]);


  for (i = [0: len(h0) - 36-1]) {
      // vg  translate(t(v[i])) sphere(v[i][3]);
p0=rev(unique([
        h0[i] 
       ,h0[i+1] 
       ,if(  h0[i]!=h1[i+1] ) h1[i+1]
       ,if(  h0[i+1]!=h1[i] )h1[i] ]   ));

 color(rands(0,1,3))
if(len(p0)==4) polyhedron(p0 ,[[0,1,2],[0,2,3]]);

 color(rands(0,1,3))
 if(len(p0)==3) polyhedron(p0 ,[[0,1,2] ]);
p1=rev(unique([
        h1[i] 
       ,h1[i+1] 
       ,h2[i+1]
       ,h2[i] ]));
 color(rands(0,1,3))
if(len(p1)==4)      polyhedron( p1,[[0,1,2],[0,2,3]]);
 color(rands(0,1,3))
if(len(p1)==3) polyhedron(p1 ,[[0,1,2] ]);

p2=rev(unique( [
        h2[i] 
       ,h2[i+1] 
       ,h3[i+1]
       ,h3[i] ]));
 color(rands(0,1,3))
 if(len(p2)==4)     polyhedron(p2,[[0,1,2],[0,2,3]]);
 color(rands(0,1,3))
if(len(p2)==3) polyhedron(p2 ,[[0,1,2] ]);

p3=rev(unique([
        h3[i] 
       ,h3[i+1] 
       , if(  h3[i+1]!=  h0[ (   i+36)+1])   h0[ (   i+36)+1]
       ,  if(  h3[i]!=  h0[ (  i+36)] )  h0[ (  i+36)] 
]));
 color(rands(0,1,3))
 if(len(p3)==4)    polyhedron( p3,[[0,1,2],[0,2,3]]);
 color(rands(0,1,3))
  if(len(p3)==3) polyhedron(p3 ,[[0,1,2] ]);

 if(len(p3)==4)  echo( (p3 ));
 if(len(p3)==3)  echo( (p3 ));

 
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