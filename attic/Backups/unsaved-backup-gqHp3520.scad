$fn=20;
num=10;
c=concat([[0,0,-40,4],[0,0,-5,4]],make_points(num,l1=[-30,-30,-2],l2=[30,30,2]),[[0,0,5,4],[0,0,40,4]]);
b=[for(cm=[0:0.125:len(c)-1]) listlerp(c,cm)];
//*for(j=[1:2:10]){
// a=collide(
//b,j,b);
// for(i=[0:len(a)-1]){
//
//#translate(take3(a[i]))sphere(a[i][3]);
//}
// 
//}

 a=collide(b, 80,b);

polyline(a);
translate([50,0,0]) for(i=[0:len(a)-2],j=[0:len(a)-2])if(abs(i-j)>5){
intersection(){
hull(){
translate(take3(a[i]))sphere(a[i][3],$fn=20);
translate(take3(a[i+1]))sphere(a[i+1][3],$fn=20);}
hull(){
translate(take3(a[j]))sphere(a[j][3],$fn=20);
translate(take3(a[j+1]))sphere(a[j+1][3],$fn=20);}

}}
*%translate([30,0,0])polyline(b);

//for(i=[0:len(b)-1]){translate(take3(b[i]))sphere(b[i][3]);}








function collide(l,n=0,org)= 
let(nl=[for(i=[1:len(l)-2])
let( 
li=[for(j=[0:len(l)-1])
let(
p1=take3(l[i])
,p2=take3(l[j])
,r1=l[i][3]
,r2=l[j][3]
,d=norm(p1-p2)
//,e=echo(i,j,p1,p2,r1,r2,d,p1-p2,un(p1-p2))
)
 if(i!=j)
 abs(i-j)<4? 
abs(i-j)>1?[0,0,0]:
let(fd=take3(l[max(0,i-1)]),ed=take3(l[min(len(l)-1,i+1)]),md=(p1+fd+ed)/3)  un(md-p1)*norm(md-p1)*0.25 
: d<(r1+r2)-1e-16? max(0, (r1+r2)*3-d)*un(p1-p2)  *1/ sqrt(max(1,r1))   :[0,0,0]

]

,
 ,move=addl(li)  
//,ee=echo("li",move)
)
 n>0?
lerp(org[i],l[i]+[move.x,move.y,move.z,0]+[rnd(1e-16),rnd(1e-16),rnd(1e-16),0],0.95)
:l[i]+[move.x,move.y,move.z,0]
])

n>0?collide(concat([l[0]],nl,[l[len(l)-1]]),n-1,org):
concat([l[0]],nl,[l[len(l)-1]])
;















function make_points(j=10,l1=[0,0,0],l2=[1,1,1])= 
     ([for(i=[1:j])
[
roundlist(rnd(l1.x,l2.x)),
roundlist(rnd(l1.y,l2.y)),
roundlist(rnd(l1.z,l2.z)/2)+i*l2.z/10,
roundlist(rnd(3,4))

]
]);
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 

function roundlist(v, r = 1) = len(v) == undef ? v - (v % r) : len(v) == 0 ? [] : [
    for (i = [0: len(v) - 1]) roundlist(v[i], r)
];
function take3(i)=[i.x,i.y,i.z];

 

function lerp(start, end, bias) = (end * bias + start * (1 - bias));

function un(v)=v/max(norm(v),1e-16);
function addl(l, c = 0) = c < len(l) - 1 ? l[c] + addl(l, c + 1) : l[c];
function listlerp (l,I)=let(f=len(l)-1,start=max(0,min(f,floor(I))),end=max(0,min(f,ceil(I))),bias=I%1) (l[end]* bias + l[start] * (1 - bias));

module polyline(p) {for(i=[0:max(0,len(p)-2)])line(p[i],p[i+1]);
}

module line(p1, p2 ,width=0.5) 
{
    hull() {
        translate(take3(p1)) sphere(max(1e-4,p1[3]));
        translate(take3(p2)) sphere(max(1e-4,p2[3]));
    }
}