v=[
[[-14,0,1] ,[0,350,0]],
[[4,40,1] ,[-20,350,30]],
 [[3,55,1]   ,[-10,180+45,0]], 
 
  [[-3,55,1]  ,[-10,180-45,0]],  
 [[-4,40,0]  ,[-20, 0,-30]],
 [[14,0,0]  ,[0, 0,0]],
];


for(i=[1:len(v)-1]){
for(j=[0.1:0.1:1])
{
T1=lerp(v[i-1],v[i],j);
T2=lerp(v[i-1],v[i],j-0.1);
hull(){
translate(T1[0])rotate(T1[1])translate([ 0,0,-1])rotate([0,0,90])translate([ -10,0,-0])cube([10,1,1]  );
translate(T2[0])rotate(T2[1])translate([ 0,0,-1])rotate([0,0,90])translate([ -10,0,-0])cube([10,1,1] );
}}}
function lerp(start,end,bias ) = (end * bias + start * (1 - bias));