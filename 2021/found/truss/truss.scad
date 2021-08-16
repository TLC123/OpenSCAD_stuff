//Length
l=400;
//Width
w=100;
////Length
//l=rnd(20,175);
////Width
//w=rnd(10,20);
n=floor(l/w);

//Wall 
wall=5;
//Beam
beam=5.1;
//Horizontal bars
horizontal=1;//[0,1]
//Diagonal bars
diagonal=1;//[0,1]
// Connecting holes radius
holer=6;
// Connecting holes length
holesl=30;
// Connecting holes offset from corner: holer+x 
holeo=3;
w2=l/n;
////Wall over width
//wall=rnd(10,50);
////Beam
//beam=rnd(10,50);
//// connecting holes radius
//holer=rnd(0.5,w/15);
//// connecting holes length
//holesl=rnd(1,10);
h=wall;
s=beam;
echo(l,w,n,h,s);
//h=w/rnd(10,40);
//s=h*rnd(0.3,2);



rotate([0,-90])color("lightgray"){
rotate([000,0,0])translate ([0,0,-w*0.5+h*0.5]) t();
 rotate([90,0,0])translate ([0,0,-w*0.5+h*0.5]) t();
 rotate([180,0,0])translate ([0,0,-w*0.5+h*0.5]) t();
 rotate([270,0,0])translate ([0,0,-w*0.5+h*0.5])  t();
 crossbeam();
 holes();
translate([l ,0,0])mirror([1,0,0]) holes();

}
 module crossbeam(){
 rotate([0,90,0])linear_extrude(l )difference(){
square(w-h*2,center=true);
offset(max(0,2*s-h ),$fn=20)offset(-max(0,2*s-h ))square(w-h*2,center=true);}
 
}
  


module holes(){
hole=holer+h+holeo;
 rotate([0,90,0])linear_extrude(s+h ){



 difference(){
offset(-max(0,2*s-h ) )offset(max(0,2*s-h ),$fn=20) union(){
square(w ,center=true);
difference(){
union(){
hull(){
 translate([(w*0.5- hole -h),(w*0.5- hole -h)]) circle(holer+h,$fn=20); 
 translate([(w*0.5  -h),(w*0.5  -h)]) square(h); 
}
mirror()hull(){
 translate([(w*0.5- hole -h),(w*0.5- hole -h)]) circle(holer+h,$fn=20); 
 translate([(w*0.5  -h),(w*0.5  -h)]) square(h); 
}
mirror([1,1,0])hull(){
 translate([(w*0.5- hole -h),(w*0.5- hole -h)]) circle(holer+h,$fn=20); 
 translate([(w*0.5  -h),(w*0.5  -h)]) square(h); 
}
mirror([0,1,0])hull(){
 translate([(w*0.5- hole -h),(w*0.5- hole -h)]) circle(holer+h,$fn=20); 
 translate([(w*0.5  -h),(w*0.5  -h)]) square(h); 
}

 }
 
 
translate([(w*0.5- hole -h),(w*0.5- hole -h)]) circle(holer,$fn=20);
translate([-(w*0.5- hole -h),(w*0.5- hole -h)]) circle(holer,$fn=20);
translate([(w*0.5- hole -h),-(w*0.5- hole -h)]) circle(holer,$fn=20);
translate([-(w*0.5- hole -h),-(w*0.5- hole -h)]) circle(holer,$fn=20);}}

offset(max(0,2*s-h ),$fn=20)offset(-max(0,2*s-h ))difference(){
square(w-h*2,center=true);
union(){
hull(){
 translate([(w*0.5- hole -h),(w*0.5- hole -h)]) circle(holer+h,$fn=20); 
 translate([(w*0.5  -h),(w*0.5  -h)]) square(h); 
}
mirror()hull(){
 translate([(w*0.5- hole -h),(w*0.5- hole -h)]) circle(holer+h,$fn=20); 
 translate([(w*0.5  -h),(w*0.5  -h)]) square(h); 
}
mirror([1,1,0])hull(){
 translate([(w*0.5- hole -h),(w*0.5- hole -h)]) circle(holer+h,$fn=20); 
 translate([(w*0.5  -h),(w*0.5  -h)]) square(h); 
}
mirror([0,1,0])hull(){
 translate([(w*0.5- hole -h),(w*0.5- hole -h)]) circle(holer+h,$fn=20); 
 translate([(w*0.5  -h),(w*0.5  -h)]) square(h); 
}

 }
 
}
translate([(w*0.5- hole -h),(w*0.5- hole -h)]) circle(holer,$fn=20);
translate([-(w*0.5- hole -h),(w*0.5- hole -h)]) circle(holer,$fn=20);
translate([(w*0.5- hole -h),-(w*0.5- hole -h)]) circle(holer,$fn=20);
translate([-(w*0.5- hole -h),-(w*0.5- hole -h)]) circle(holer,$fn=20);}

}

 rotate([0,90,0])linear_extrude(holesl )difference() {union(){
translate([(w*0.5- hole -h),(w*0.5- hole -h)]) circle(holer+h,$fn=20);
translate([-(w*0.5- hole -h),(w*0.5- hole -h)]) circle(holer+h,$fn=20);
translate([(w*0.5- hole -h),-(w*0.5- hole -h)]) circle(holer+h,$fn=20);
translate([-(w*0.5- hole -h),-(w*0.5- hole -h)]) circle(holer+h,$fn=20);
 
}

union(){
translate([(w*0.5- hole -h),(w*0.5- hole -h)]) circle(holer,$fn=20);
translate([-(w*0.5- hole -h),(w*0.5- hole -h)]) circle(holer,$fn=20);
translate([(w*0.5- hole -h),-(w*0.5- hole -h)]) circle(holer,$fn=20);
translate([-(w*0.5- hole -h),-(w*0.5- hole -h)]) circle(holer,$fn=20);}
}
}


module t(){
 

 
 linear_extrude(h,center=true){truss();}
 

 
 

}

function clamp(  b = 0, c = 1,a) = min(max(abs(a), b), c);
module truss(){


intersection(){
 translate([0,-w/2])square([l,w]);



offset(-s,$fn=20)
offset(s)
for(a=[-w2:w2:l+w2]){

if (horizontal==1)hull() {
translate([clamp(s,l-s,a),abs(a/w2)%(2)*w-w*0.5])circle(s);
translate([clamp(s,l-s,a),abs(b/w2)%(2)*w-w*0.5])circle(s);
}

b=a+w2;
if (diagonal==1)hull() {
translate([clamp(0,l,a),abs(a/w2)%(2)*w-w*0.5])circle(s);
translate([clamp(0,l,b),abs(b/w2)%(2)*w-w*0.5])circle(s);
}
c=b+w2;
hull() {
translate([a,abs(a/w2)%(2)*w-w*0.5])circle(s*2);
translate([c,abs(c/w2)%(2)*w-w*0.5])circle(s*2);
}
}
}}


function rnd(a = 1, b = 0, s = []) = 
s == [] ? 
(rands(min(a, b), max(   a, b), 1)[0]) 
: 
(rands(min(a, b), max(a, b), 1, s)[0])
; 