//scales=s(i([[2,1],3,3,4, 1.5,1.5,3,3,4, 1.5,1.5,1,0.5,0.35],30),2);
scales=s(i([[1,3],[1,2],[3,2],[4,2],[3,2],[3,2],[3,2],[3,2],
[1,1],[1.5,0.5],[0.5,0.5],[001,0.1],

],30),0);

lenghts=s(i([0,10,12,15,20,25,27,35,37,41,45,60,70,70],30),0);
rotations=s( i([0,0,0,0,0,00,0,0,0,0,0,0],30),0);
echo(len (scales));



function i(v,l)=[for(n=[0:1/l:1])listlerp (v,n*(len(v)-1))];
function s(vi,c=1)=c>0?let(v=s(vi,c-1))[for(i=[0:len(v)-1])( v[i]+v[max(0,i-1)]+v[min(len(v)-1,i+1)])/3]:vi;
function listlerp (l,I)=
let(f=len(l)-1,start=max(0,min(f,floor(I))),end=max(0,min(f,ceil(I))),bias=smooth(I%1)) (l[end]* bias + l[start] * (1 - bias));


function smooth (a) =
let (b =max(0, min(1,a)))(b * b * (3 - 2 * b));


express()obj2();
*obj2();
module express(){for(i=[0:len(scales)-2])
{
translate([0,0,lenghts[i]])

linear_extrude(lenghts[i+1] -lenghts[i],scale=[scales[i+1].x /scales[i].x,scales[i+1].y /scales[i].y] ,twist=-(rotations[i+1]-rotations[i]),slices= (lenghts[i+1] -lenghts[i])
/10)
rotate([0,0,rotations[i]])
scale(scales[i] )
children();
}}

module obj2()
{
scale([3,1])
difference(){
square([3,2] ,center =true);
translate([1.2,1])circle(1.1,$fn=60);
translate([-1.2,1])circle(1.1,$fn=60);
translate([-1.2,-1])circle(1.1,$fn=60);
translate([1.2,-1])circle(1.1,$fn=60);
translate([0,-0.8 ])circle(0.3,$fn=60);
translate([0,0.8 ])circle(0.3,$fn=60);

}}

module obj(){render()
offset(0.4,$fn=50)offset(-0.8,$fn=20)offset(0.4,$fn=20)
intersection(){
difference(){circle(4.5,$fn=100);
*circle(3,$fn=100);}
union()
{
union(){
translate([0,0])square(4);
square(3,center=true);
}
rotate(180)
union(){
translate([0,0])square(4);
square(3,center=true);
}
rotate(90)
union(){
translate([0,0])square(4);
square(3,center=true);
}
rotate(-90)
union(){
translate([0,0])square(4);
square(3,center=true);
}


}}
}