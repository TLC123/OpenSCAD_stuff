$fn=36;


maxp=10;
r=4;
h=40;
v= 
[for(i=[-90:10:90])
 duax( ((maxp-r)+abs(cos(i))*r)/maxp,sign(i)*(h-r)/2+ sin(i)*r )

]
 
 ;

echo (v.x);
echo (v.y);
//echo (v.z);
express(v){
    r=9;
    offset(-r)offset(r*2)    offset(-r){
translate([0,5])circle(10);
translate([0,-5])circle(10);
}}
function duax(a,b)=[a,a,b];
//function wrapi(x,tak) =  ((x  % tak) + tak) % tak; // wraps index 0 - x 
// 
//function lerp( v1, v2, bias) = (1-bias)*v1 + bias*v2;
//
//function smooth_animate(t,v)=let(
//ll=len(v),        i=round(ll*t),       T= ((ll*t+0.5)%1) , 
//p0=    lerp(v[ wrapi(i-1,ll)], v[wrapi(i,ll)],0.5),
//p1=    v[wrapi(i,len(v))], 
//p2=    lerp( v[wrapi(i,ll)],v[ wrapi(i+1,ll)],0.5) ) 
//lerp(lerp( p0,p1,T),lerp(p1,p2,T),(T)) ;
// 
//function i(v,l=10)=[for(n=[0:1/l:1])listlerp (v,n*(len(v)-1))];
//function s(vi,c=2)=c>0?let(v=s(vi,c-1))[for(i=[0:len(v)-1])( v[i]+v[max(0,i-1)]+v[min(len(v)-1,i+1)])/3]:vi;
//function listlerp (l,I)=
//let(f=len(l)-1,start=max(0,min(f,floor(I))),end=max(0,min(f,ceil(I))),bias=smooth(I%1)) (l[end]* bias + l[start] * (1 - bias));
//function smooth (a) =
//let (b =max(0, min(1,a)))(b * b * (3 - 2 * b));
 
 
module express(v){
 
    
    for(i=[0:len(v)-2])
{
translate([0,0,v[i].z])

linear_extrude(
    v[i+1].z -v[i].z,
    scale=[max(0.000001, v[i+1].x /v[i].x ), max(0.000001, v[i+1].y /v[i].y )] ,
    slices= (v[i+1].z -v[i].z)/10
//  ,  twist =(v[rotations][i+1] -v[rotations][i])
    )
//rotate([0,0,v[rotations][i]])
scale([max(0.000001,v[i].x),max(0.0000001,v[i].y)] )
children();
}}