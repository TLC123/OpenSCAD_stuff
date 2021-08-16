
// No Preview. Just hit Create.   Always leave Part at 1"
part=1;//[1,2,3,4,5,6,7,8,9,10]
/* [Hidden] */

fwd=srnd(50,60);
war=[fwd,fwd+fwd*floor(rnd(0,2)),fwd,fwd,fwd,fwd,fwd,fwd,fwd,fwd];
rwd=fwd;
tw=rnd(50,60) ;
l=max(rwd*1.5+fwd*1.5,srnd(tw*3.5,350))-abs(rwd-fwd)*4;
h=min(tw*2,(srnd(tw*0.5,tw*2)+l*0.2))+abs(rwd-fwd);
hoodl=max(0.+1,l*srnd(0.01,0.3)+abs(rwd-fwd)*1.2);   
cabl=min(l-hoodl,max(tw*1.5,srnd(l*0.5,l*0.85)));

cabw=tw*srnd(0.8,1)+abs(rwd-fwd)*0.5;
cabh=max(tw,h+(l-cabl)*0.1+abs(rwd-fwd)*0.3);

hoodw=tw*srnd(0.3,0.8)-abs(rwd-fwd)*0.1;
hoodh=cabh*0.52-cabl*0.05;

trunkl=l-(cabl+hoodl)-cabl*0.1+40;
trunkw=cabw*srnd(0.2,0.9);
trunkh=max(cabh*0.2,h*srnd(0.2,0.9)+l*0.05);
fax=fwd*0.75;
rax=max(fax+fwd+rwd/2,min(l-trunkl/2+rwd*2,l-rwd)-abs(rwd-fwd));
fenderl=fwd*1.5;
fenderw=(fwd*0.75)+abs(rwd-fwd);
fenderh=max(0,fwd*0.75);
bodyl=max(0,l-abs(rwd-fwd)*3);
bodyw=tw*1.05;
bodyh=fenderh*0.7;
dice=rands(0,2,10);
wildstore=rands(-2,2,1000);
rsize=5;
fn=8;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

mirrorcopy() {
    
    
 difference() {    
union() {    union() {  
LINE1=vsharp([[0,hoodw,0],[0,tw,0],[hoodl,tw,0]]);
LINE2=vsharp([[0,hoodw,0],[0,tw,0],[0,tw,fenderh],[hoodl,tw,fenderh]]);
LINE3=vsharp([[0,hoodw,0],[0,hoodw,hoodh*0.8],[0,hoodw,hoodh*0.8],[0,cabw,hoodh*0.8],[hoodl,cabw,hoodh]]);
LINE4=vsharp([[0,0,0],[0,0,hoodh*0.8],[0,0,hoodh*0.8],[hoodl,0,hoodh]]);
Carbody(LINE1,LINE2,LINE3,LINE4);

LINE5=vsharp([[hoodl,tw,0],[hoodl+cabl*0.5,tw,0],[hoodl+cabl,tw,0]]);
LINE6=vsharp([[hoodl,tw,fenderh],[hoodl+cabl,tw,trunkh],[hoodl+cabl,tw,trunkh],[hoodl+cabl,tw,trunkh],[l,tw,trunkh]]);
LINE7=vsharp([[hoodl,cabw,hoodh],[hoodl+cabl*0.3,cabw,h],[hoodl+cabl*0.3,cabw,h],[hoodl+cabl,cabw,h],[hoodl+cabl,tw,trunkh],[l,trunkw,trunkh]]);
LINE8=vsharp([[hoodl,0,hoodh],[hoodl+cabl*0.3,0,h],[hoodl+cabl*0.3,0,h],[hoodl+cabl,0,h],[hoodl+cabl,0,trunkh],[l,0,trunkh]]);
difference() { 
Carbody(LINE5,LINE6,LINE7,LINE8); 
translate([(hoodl+cabl*0.5),0,hoodh]){
    
    difference() { 
    scale([0.9,2,0.85])translate([-(hoodl+cabl*0.5),0,-hoodh])Carbody(LINE5,LINE6,LINE7,LINE8);
    rotate([0,5,0])translate([-l*0.5,-10,-h])cube([l,tw*3,h]);
     rotate([0,5,0])   translate([cabl*0.5,-10,-h])cube([l,tw*3,h*2]);
   if(cabl>l*0.6){  rotate([0,5,0])translate([0,-10,0])cube([l*0.05,tw*3,h]);}

 }}
   difference() {translate([-10,-1,hoodh]) scale([1,0.9,0.85])translate([0,0,-hoodh])Carbody(LINE5,LINE6,LINE7,LINE8);
        color("cyan") translate([(hoodl+cabl*0.5),0,hoodh]) scale([0.95,1,0.95])translate([-(hoodl+cabl*0.5),0,-hoodh])Carbody(LINE5,LINE6,LINE7,LINE8);
       rotate([0,5,0])translate([0,-10,-h])cube([l,tw*3,h]);
     }
     
     }
 color("cyan") translate([(hoodl+cabl*0.5),0,hoodh]) scale([0.95,0.97,0.95])translate([-(hoodl+cabl*0.5),0,-hoodh])Carbody(LINE5,LINE6,LINE7,LINE8);

LINE9=vsharp([[hoodl+cabl,tw,0],[l,tw,0],[l,trunkw,0]]);
LINE10=vsharp([[l,tw,trunkh],[l,trunkw,0]]);
LINE11=vsharp([[l,trunkw,trunkh],[l,trunkw,0]]);
LINE12=vsharp([[l,0,trunkh],[l,0,0]]);
Carbody(LINE9,LINE10,LINE11,LINE12);

 }

translate([fax, tw, 0])scale(1.4) wheel(fwd);
if(trunkl * .4 > rwd||l>rwd*5) {
for(nax = [rax: -rwd: max(rax - rwd * 2, min(l-rwd*2,l - trunkl + rwd))]) {
translate([nax, tw, 0])scale(1.4) wheel(rwd);

}
} else {
translate([rax, tw+abs(rwd-fwd)*0.5, 0])scale(1.4)  wheel(rwd);

}

if(trunkl>cabl+hoodl) {
  

          
  color("white")translate([l-trunkl+35, 0, bodyh])  rotate([0,0,0])  scube([trunkl*1.1, tw*0.95, trunkh*1.2],rsize,fn,60);}
        
     /*
if (fwd==rwd){
color("red") translate([0, 0, 0]) {rcube([bodyl, bodyw, bodyh],rsize,fn,80);}
    
  color("red") translate([fax, tw, 0]) {
    translate([-fenderl * 0.5, -fenderw*0.7, 0]) rcube([fenderl, fenderw, fenderh],rsize,fn,90);}}
    
if (fwd==rwd) {     color("red") 
if(trunkl * .4 > rwd||l>rwd*5) {
     for(nax = [rax: -rwd: max(rax - rwd * 2, min(l-rwd*2,l - trunkl + rwd))]){
      translate([nax, tw, 0]) translate([-fenderl * 0.5, -fenderw*0.7, 0]) rcube([fenderl, fenderw, fenderh],rsize,fn,100);
    }
  } else {
    translate([rax, tw, 0]) scale(1.1) translate([-fenderl * 0.5, -fenderw*0.7, 0]) rcube([fenderl, fenderw, fenderh],rsize,fn,110);
  }}



/////////////cutters////////////////////////////////
*/}
translate([fax, tw, 0]) union(){
translate([0,-fwd*0.1,0])scale(1.1) flatwheel(fwd);
rotate([0, 0, 180]) translate([0,fwd*0.1,0])scale([1, 3, 1]) flatwheel(fwd);
 color("red") rotate([0, 0, 180]) translate([0,-fwd*0.2,0]) scale([2, 2, 2]) flatwheel(fwd);
}
if(trunkl * .4 > rwd||l>rwd*5) {
  for(nax = [rax: -rwd: max(rax - rwd * 2, min(l-rwd*2,l - trunkl + rwd))]){
  translate([nax, tw, 0]) {
    scale(1.1) flatwheel(rwd);
    rotate([0, 0, 180]) scale([1.1, 3, 1.1]) flatwheel(rwd);
  color("red")   rotate([0, 0, 180]) translate([0,-rwd*0.2,0]) scale([6, 6, 6]) flatwheel(rwd);
  }
}
} else {
translate([0,-fwd*0.1,0])translate([rax, tw+abs(rwd-fwd)*0.5, 0]) {
  scale(1.1) flatwheel(rwd);
  rotate([0, 0, 180]) scale([1.1, 3, 1.1]) flatwheel(rwd);
 color("red")  rotate([0, 0, 180]) translate([0,-rwd*0.2,0]) scale([6, 6, 6]) flatwheel(rwd);

}
}
translate([0,0,-50])cube([l,tw*2,50]);
}

/////////////////////////////////////////////////
color("lightgray")translate([-5,0,0])hull(){translate([-5,0,0])scube([5,tw*0.45,h*0.2],rsize,fn,120);
translate([-2,0,])scube([15,tw*1.05-abs(rwd-fwd)*0.5,h*0.2],rsize,fn,130);}


color("lightgray")translate([l+10,0,0])mirror([-1,0,0])hull(){translate([-5,0,0])scube([5,tw*0.45,h*0.2],rsize,fn,140);
translate([-2,0,])scube([15,tw*1.05-abs(rwd-fwd)*0.5,h*0.2],rsize,fn,150);}

color("lightgray")line([fax, 0, 0], [fax, tw, 0],3);
color("darkgrey"){line([fax, 0, 0], [fax, tw*0.9, 0],4);
    translate ([fax, 0, 0] )rotate([0,90,0])sphere(fwd*0.25,$fn=16) ;
translate([5,0,-2])scube([max(l-tw*0.45,rax),tw*0.45,rwd*0.5],rsize,fn,160);
translate([fax, tw, 0])rotate([rnd(-5,5),0,rnd(-5,5)]) wheel(fwd);
if(trunkl * .4 > rwd||l>rwd*5) {
for(nax = [rax: -rwd: max(rax - rwd * 2, min(l-rwd*2,l - trunkl + rwd))]) {
translate([nax, tw, 0])rotate([rnd(-15,5),0,0]) wheel(rwd);
 line([nax, 0, rwd/2-min(rwd,fwd)/2], [nax, tw*0.9, rwd/2-min(rwd,fwd)/2],5);
  translate ([nax, 0, rwd/2-min(rwd,fwd)/2] )rotate([0,90,0])sphere(fwd*0.25,$fn=16) ;
}
} else {
translate([rax, tw+abs(rwd-fwd)*0.5, 0])rotate([rnd(-15,5),0,0]) wheel(rwd);
 line([rax, 0, rwd/2-min(rwd,fwd)/2], [rax, tw*0.9, rwd/2-min(rwd,fwd)/2],5); 
     translate ([rax, 0, rwd/2-min(rwd,fwd)/2] )rotate([0,90,0])sphere(rwd*0.25,$fn=16) ;
}



}}
 //end main
////////////////////////////////////////////////
///////////////////////////////////////////////   

module Carbody(LINE1,LINE2,LINE3,LINE4,offset=0,offset2=0,D=8,Clinker=0){
hstep=1/D;
vstep=1/D;

  //  ShowControl(LINE1); 
  //  ShowControl(LINE2); 
  //  ShowControl(LINE3); 
  //  ShowControl(LINE4); 
   
for (t=[0:hstep:1-hstep+0.001]){
spar1=vsharp([ bez2(t, LINE1)+[0,0,-offset2],bez2(t, LINE2),bez2(t, LINE3),bez2(t, LINE3),bez2(t, LINE4)+[0,0,offset]]);
spar2=vsharp([ bez2(t+hstep, LINE1)+[0,0,-offset2],bez2(t+hstep, LINE2),bez2(t+hstep, LINE3),bez2(t+hstep, LINE3),bez2(t+hstep, LINE4)+[0,0,offset]]);
  
for (v=[0:vstep:1-vstep+0.001]){
 
      
    p1=[((bez2(v, spar1)[0] ) ) ,max(0,bez2(v, spar1)[1] ),bez2(v, spar1)[2]];
    p2=[((bez2(v+vstep, spar1)[0] ) ) ,max(0,bez2(v+vstep, spar1)[1] ),bez2(v+vstep, spar1)[2]];
    p3=[((bez2(v, spar2)[0] ) ) ,max(0,bez2(v, spar2)[1] ),bez2(v, spar2)[2]];
    p4=[((bez2(v+vstep, spar2)[0] ) ) ,max(0,bez2(v+vstep, spar2)[1] ),bez2(v+vstep, spar2)[2]];
    

poly(p1,p2,p3);
 poly(p4,p3,p2);
        
        
        
        
    
}
}
    }
  module poly(p1,p2,p3,h1=1) {
 
  hull() {
      
    translate(t(p1)) sphere(h1,$fn=4);
    translate(t(p2)) sphere(h1,$fn=4);
    translate(t(p3))  sphere(h1,$fn=4);
  
    translate(y(p1)) sphere(h1,$fn=4);
    translate(y(p2)) sphere(h1,$fn=4);
    translate(y(p3)) sphere(h1,$fn=4);
  }
}
module cab(){
      difference(){ rcube([cabl, cabw, cabh],2,6,20);
                   mirrorcopy(){ cutrcube([cabl, cabw, cabh],2,6,20);} }
    }
module rcube(v, r = 2, n = 6,s=0) {
rc = r;
x = v[0];
y = v[1];
z = v[2];
hull() { 
hull() {
    translate(ywilde(s+1)+[rc, 0, rc]) sphere(r, $fn = n);
    translate(wilde(s+1)+[rc, 0.7*y - rc, rc]) sphere(r, $fn = n);
    translate(ywilde(s+3)+[rc, 0, 0.7 * z - rc]) sphere(r, $fn = n);
    translate(wilde(s+3)+[rc, 0.7*y - rc, 0.7 * z - rc]) sphere(r, $fn = n);
} hull() { 
    translate(ywilde(s+5)+[0.4 * x, 0, z - rc]) sphere(r, $fn = n);
    translate(wilde(s+6)+[0.4 * x, 0.7*y - rc, z - rc]) sphere(r, $fn = n);
    translate(ywilde(s+7)+[0.8 * x, 0, z - rc]) sphere(r, $fn = n);
    translate(wilde(s+8)+[0.8 * x, 0.7*y - rc, z - rc]) sphere(r, $fn = n);
} hull() { 
    translate(ywilde(s+9)+[x, 0, rc]) sphere(r, $fn = n);
    translate(wilde(s+10)+[x, y - rc, rc]) sphere(r, $fn = n);
    //translate([x, 0, z - rc]) sphere(r, $fn = n);
    //translate([x, y - rc, z - rc]) sphere(r, $fn = n);
    
    translate(ywilde(s)+[x, 0, 0.9 * z - rc]) sphere(r, $fn = n);
    translate(wilde(s)+[x, 0.7*y - rc, 0.9 * z - rc]) sphere(r, $fn = n);
}}
}

module cutrcube(v, r = 4, n = 4,s=0) {
rc = 3;
    rh=rc*0.3;
r2=1;
x = v[0];
y = v[1]*0.95;
z = v[2];
 

   // translate(ywilde(s+1)+[rc, 0, rc]) sphere(r2, $fn = n);
   // translate(wilde(s+2)+[rc, 0.7*y - rc, rc]) sphere(r2, $fn = n);
 translate([-rc,0,0])hull(){
translate(ywilde(s+3)+[rc, 0, 0.7 * z ]) sphere(r2, $fn = n);
    translate(wilde(s+3)+[rc, 0.7*y - rc, 0.7 * z ]) sphere(r2, $fn = n);
    translate(ywilde(s+5)+[0.4 * x-rc, 0, z - rc*2]) sphere(r2, $fn = n);
  translate(wilde(s+6)+[0.4 * x-rc, 0.7*y - rc, z - rc*2]) sphere(r2, $fn = n);

translate(ywilde(s+3)+[-rc, 0, 0.7 * z + rh]) sphere(r2, $fn = n);
    translate(wilde(s+3)+[-rc, 0.7*y - rc, 0.7 * z + rh]) sphere(r2, $fn = n);
    translate(ywilde(s+5)+[0.4 * x-rc*2, 0, z-rc ]) sphere(r2, $fn = n);
  translate(wilde(s+6)+[0.4 * x-rc*2, 0.7*y - rc, z -rc]) sphere(r2, $fn = n);

}  // translate(ywilde(s+7)+[0.8 * x, 0, z - rc]) sphere(r2, $fn = n);
    //translate(wilde(s+8)+[0.8 * x, 0.7*y - rc, z - rc]) sphere(r2, $fn = n);

    //translate(ywilde(s+9)+[x, 0, rc]) sphere(r2, $fn = n);
    //translate(wilde(s+10)+[x, y - rc, rc]) sphere(r2, $fn = n);
    //translate([x, 0, z - rc]) sphere(r, $fn = n);
    //translate([x, y - rc, z - rc]) sphere(r, $fn = n);
    
    //translate(ywilde(s)+[x, 0, 0.9 * z - rc]) sphere(r2, $fn = n);
  hull(){     translate([0,rh,0]){ 
      translate(wilde(s+8)+[0.8 * x, 0.7*y , z - rc*2]) sphere(r2, $fn = n);
      translate(wilde(s)+[x-rc, 0.7*y , 0.9 * z-rc*2 ]) sphere(r2, $fn = n);
        translate(wilde(s+4)+[rc*2, 0.7*y , 0.7 * z-rc ]) sphere(r2, $fn = n);
        translate(wilde(s+6)+[0.4 * x, 0.7*y , z-rc*2 ]) sphere(r2, $fn = n);
        translate(wilde(s+4)+[x-rc*2, 0.76*y , 0.7 * z ]) sphere(r2, $fn = n);}
       translate([0,rc*5,0]){  
            translate(wilde(s+8)+[0.8 * x, 0.7*y , z - rc*2]) sphere(r2, $fn = n);
           translate(wilde(s)+[x-rc, 0.7*y , 0.9 * z-rc*2 ]) sphere(r2, $fn = n);
        translate(wilde(s+4)+[rc*2, 0.7*y , 0.7 * z-rc ]) sphere(r2, $fn = n);
        translate(wilde(s+6)+[0.4 * x, 0.7*y , z-rc*2 ]) sphere(r2, $fn = n);
        translate(wilde(s+4)+[x-rc*2, 0.76*y , 0.7 * z ]) sphere(r2, $fn = n);}}
}
module scube(v, r = 2, n = 6,s=0) {
rc = r;
x = v[0];
y = v[1];
z = v[2];
dewild=1;
hull() { 
hull() {
    translate(dewild*ywilde(s)+[rc, 0, rc]) sphere(r, $fn = n);
    translate(dewild*wilde(s+1)+[rc, y - rc, rc]) sphere(r, $fn = n);
    translate(dewild*ywilde(s+2)+[rc, 0, z - rc]) sphere(r, $fn = n);
    translate(dewild*wilde(s+3)+[rc, y - rc,  z - rc]) sphere(r, $fn = n);
} hull() { 
    translate(dewild*ywilde(s+4)+[ x, 0, z - rc]) sphere(r, $fn = n);
    translate(dewild*wilde(s+5)+[ x, y - rc, z - rc]) sphere(r, $fn = n);
} hull() { 
    translate(dewild*ywilde(s+6)+[x, 0, rc]) sphere(r, $fn = n);
    translate(dewild*wilde(s+7)+[x, y - rc, rc]) sphere(r, $fn = n);
 
    
 }
}}
function wilde(i)=[wildstore[i],wildstore[i*2],wildstore[i*3]];
function ywilde(i)=[wildstore[i],0,wildstore[i*3]];
module wheel(d){

translate ([0,0,d/2-min(rwd,fwd)/2]) 
rotate([90,0,0]) difference(){ hull(){
    scale([d*0.5,d*0.5,3])sphere(1,$fn=24);
    translate([0,0,d/4])
    rotate([0,0,7.5]) scale([d*0.5,d*0.5,3])sphere(1,$fn=24);}
 //cylinder(d/4,d/2,d/2);
      translate([0,0,-d/30])
    scale([d*0.3,d*0.3,4.5])sphere(1,$fn=24);
          translate([0,0,d/3.5])
   scale([d*0.3,d*0.3,3.5])sphere(1,$fn=24);}
    }


module flatwheel(d){

translate ([0,0,d/2-min(rwd,fwd)/2]) 
rotate([90,0,0])  cylinder(d/3,d/2,d/2);
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

module ShowControl(v)  
{  // translate(t(v[0])) sphere(v[0][3]);
  for(i=[1:len(v)-1]){
   // vg  translate(t(v[i])) sphere(v[i][3]);
      hull(){
          translate(t(v[i])) sphere(0.5);
          translate(t(v[i-1])) sphere(0.5);
          }          }
  } 
  
module line(a,b,c=0.5){
    hull(){
        translate(a)sphere(c);
        translate(b)sphere(c);
        
        }
    
    }  
  module ShowControl(v)  
  {  // translate(t(v[0])) sphere(v[0][3]);
      for(i=[1:len(v)-1]){
       // vg  translate(t(v[i])) sphere(v[i][3]);
          hull(){
              translate(t(v[i])) sphere(2);
              translate(t(v[i-1])) sphere(2);
              }          }
      }  
module mirrorcopy(vec=[0,1,0]) 
{ union(){
children(); 
mirror(vec) children(); }
} 

function  subdv(v)=[
let(last=(len(v)-1)*3)
for (i=[0:last])
  let(j=floor((i+1)/3))

i%3 == 0?
v[j]
:
i%3  == 2?
   v[j]- un(un(pre(v,j))+un(post(v,j)))*(len3(pre(v,j))+len3(post(v,j)))*0.1
    :
   v[j] +un(un(pre(v,j)) +un(post(v,j)))*(len3(pre(v,j))+len3(post(v,j)))*0.1

]
;     
function bz2t(v,stop,precision=0.01,t=0,acc=0)=
acc>=stop||t>1?
t:
bz2t(v,stop,precision,t+precision,acc+len3(bez2(t,v)-bez2(t+precision,v)));

function len3bz(v,precision=0.01,t=0,acc=0)=t>1?acc:len3bz(v,precision,t+precision,acc+len3(bez2(t,v)-bez2(t+precision,v)));

function bez2(t, v) = (len(v) > 2) ? bez2(t, [
for(i = [0: len(v) - 2]) v[i] * t + v[i + 1] * (1 - t)
]): v[0] * t + v[1] * (1 - t);
function lim31(l, v) = v / len3(v) * l;
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
function bez2euler(i, v) = [0, -asin(bez2v(i, v)[2]), atan2(bez2xy(bez2v(i, v))[1], bez2xy(bez2v(i, v))[0])];

function bez2xy(v) = lim31(1, [v[0], v[1], 0]); // down xy projection
function bez2v(i, v) = lim31(1, bez2(i - 0.0001, v) - bez2(i, v)); // unit vector at i
function t(v) = [v[0], v[1], v[2]];
function rndR()=[rands(0,360,1)[0],rands(0,360,1)[1],rands(0,360,1)[0]];
function rndV()=[rands(-1,1,1)[0],rands(-1,1,1)[0],rands(-1,1,1)[0]];
function midpoint(start,end) = start + (end  - start )/2;
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];     
  
  function rnd(a,b)=a+gauss(rands(0,1,1)[0])*(b-a);     
  function srnd(a,b)=rands(a,b,1)[0];     

function t(v) = [v[0], v[1], v[2]];
function y(v) = [v[0], 0, v[2]];

function vsharp(v) = [
  for(i = [0: 0.5: len(v) - 1]) v[floor(i)]
];

function un(v) = v / max(len3(v),0.000001) * 1;
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
function pre(v,i)= i>0?         (v[i]-v[i-1]):[0,0,0,0];
function post(v,i)=i<len(v)-1?  (v[i+1]-v[i]):[0,0,0,0] ;
function SC3 (a)= let( b=clamp(a))(b * b * (3 - 2 * b));
function clamp (a,b=0,c=10)=min(max(a,b),c);
function gauss(x)=x+(x-SC3(x));