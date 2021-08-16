 $fn=30;
 v1=[[-4500,-3000],[-5000,-3000],[-5000,-4000],[000,-5000],[5000,-4000],[5000,-3000],[4500,-3000], [2000,3000],   [00,3500],   [-2000,3000]];
//v1= [[76, 86, 69, 2, [0, 0, 0]], [80, 11, 4, 4, [0, 0, 0]], [39, 75, 53, 3, [0, 0, 0]], [49, 87, 68, 2, [0, 0, 0]], [78, 2, 85, 2, [0, 0, 0]], [58, 8, 27, 3, [0, 0, 0]], [42, 41, 73, 2, [0, 0, 0]], [31, 45, 57, 3, [0, 0, 0]] ];
 path1=[for(t=[0:1/12:1]) (smooth_animate(t, v1) )];




lenghts=s( i([0,0,35000,45000,46000,46000] ) );
 
 scales=s( i([[1,1],[1,1],[1.2,1],[0.4,0.4],[0,0],[0,0],

] ) );

rotations= (  i([0,0 ] ) );
 
 
//color("Red")  polyline(v1) ;
 r=45;
 scale([1.2,1,1]){
 translate([0,3000,0])color("darkgray")express() offset(500)offset(-500)polygon(path1);
  translate([-450,2100,-300]) scale(100)hiwing(r);
  translate([-500,0,0]) scale([1.2,1,1]*100)lowwing(r);
 mirror([1,0,0]){
  translate([-450,2100,-300]) scale(100)hiwing(r);
  translate([-500,0,0]) scale([1.2,1,1]*100)lowwing(r);
 }
 
 
 }
 
     function wrapi(x,tak) =  ((x  % tak) + tak) % tak; // wraps index 0 - x 
 
function lerp( v1, v2, bias) = (1-bias)*v1 + bias*v2;

function smooth_animate(t,v)=let(
ll=len(v),        i=round(ll*t),       T= ((ll*t+0.5)%1) , 
p0=    lerp(v[ wrapi(i-1,ll)], v[wrapi(i,ll)],0.5),
p1=    v[wrapi(i,len(v))], 
p2=    lerp( v[wrapi(i,ll)],v[ wrapi(i+1,ll)],0.5) ) 
lerp(lerp( p0,p1,T),lerp(p1,p2,T),(T)) ;



function i(v,l=10)=[for(n=[0:1/l:1])listlerp (v,n*(len(v)-1))];
function s(vi,c=2)=c>0?let(v=s(vi,c-1))[for(i=[0:len(v)-1])( v[i]+v[max(0,i-1)]+v[min(len(v)-1,i+1)])/3]:vi;
function listlerp (l,I)=
let(f=len(l)-1,start=max(0,min(f,floor(I))),end=max(0,min(f,ceil(I))),bias=smooth(I%1)) (l[end]* bias + l[start] * (1 - bias));


function smooth (a) =
let (b =max(0, min(1,a)))(b * b * (3 - 2 * b));
 
 
module express(){
    for(i=[0:len(scales)-2])
{
translate([0,0,lenghts[i]])

linear_extrude(lenghts[i+1] -lenghts[i],scale=[scales[i+1].x /scales[i].x,scales[i+1].y /scales[i].y] ,slices= (lenghts[i+1] -lenghts[i])
/10)
rotate([0,0,rotations[i]])
scale(scales[i] )
children();
}}

module lowwing(r=0)


{color("gray")
translate([43,0,0])
rotate(r)
translate([-43,0,0])
rotate([90,0,0])   linear_extrude(5,center=true)   polygon([[43,5],[50,10],[85,20],[85,60],[43,170]]); 


}       


module hiwing(r=0)


{color("gray")
translate([43,0,0])
rotate(r)
translate([-43,0,0])
rotate([90,0,0])  
linear_extrude(5,center=true)   polygon([[43,335],[73,345],[73,365],[43,410] ]);   
    
color("darkgray")
rotate([90,0,0])  
linear_extrude(5,center=true)   polygon([[43,335],[43,410],[10,450] ]);   



}