 scale ([3,2,1])sphcube(0.75,16);
module sphcube(bias,res){
rotate([00,00,00])Sixth(bias,res);
rotate([90,00,00])Sixth(bias,res);
rotate([00,90,00])Sixth(bias,res);
rotate([-90,00,00])Sixth(bias,res);
rotate([00,-90,00])Sixth(bias,res);
rotate([180,00,00])Sixth(bias,res);


}
module Sixth(bias,res){
rstep=1/round(res);

for(i=[-0.5:rstep:0.5-rstep/2]){
for(j=[-0.5:rstep:0.5-rstep/2]){
p1=([i,j,0.5]);
p2=([i+rstep,j,0.5]);
p3=([i+rstep,j+rstep,0.5]);
p4=([i,j+rstep,0.5]);
lp1=limin3(1,lerp(p1,un(p1),bias));
lp2=limin3(1,lerp(p2,un(p2),bias));
lp3=limin3(1,lerp(p3,un(p3),bias));
lp4=limin3(1,lerp(p4,un(p4),bias));
polyhedron([lp1,lp2,lp3,lp4],[[2,1,0,3]]);}
}}
function len3(v)=len(v)==2?sqrt(pow(v[0],2)+pow(v[1],2)):sqrt(pow(v[0],2)+pow(v[1],2)+pow(v[2],2));
function un(v)=v/max(len3(v),0.000001)*1;
function lerp(start,end,bias)=(end*bias+start*(1-bias));
function lim3(l, v) = v / len3(v) * l; // normalize Vec37Vec4 to magnitude l
function limin3(l,v) = v / len3(v) * smin(l,len3(v));// limit  Vec3 to no more than magnitude l
function clamp (a,b=0,c=10)=min(max(a,b),c);

function mix(a,b,h)=a*h+b*(1-h);
// polynomial smooth min (k = 0.1);
//function smin( a, b, k=-1)=let( h = clamp( 0.5+0.5*(b-a)/k, 0.0, 1.0 ))mix( b, a, h ) - k*h*(1.0-h);

 	
// power smooth min (k = 8);
function smin(   a,   b,   k=128 )=    let(a = pow( a, k ), b = pow( b, k ))     pow( (a*b)/(a+b), 1.0/k );

// exponential smooth min (k = 32);
//float smin( float a, float b, float k ){    float res = exp( -k*a ) + exp( -k*b );    return -log( res )/k;}