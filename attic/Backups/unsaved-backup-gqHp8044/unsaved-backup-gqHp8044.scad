step=15;
baser=rnd(1.4,2);
phase=rnd(360);

mag1=rnd(6)*baser;
rep1=round(rnd(0,8));
ophase1=rnd(360);

mag2=rnd(6)*baser;
rep2=round(rnd(3,10));
ophase2=rnd(360);

phase0=rnd(360);
r0=rnd(0,1);
phase1=rnd(360);
r1=rnd(0,1)/2;
phase2=rnd(360);
r2=rnd(0,1)/3;
phase3=rnd(360);
r3=rnd(0,1)/4;
phase8=rnd(360);
r8=rnd(0,1)/8;
rsym=round(rnd(0,rnd(16)));
msym=round(rnd(0,rsym));
rsum=baser+r0+r1+r2+r3+r8;
difference(){
symmetries();
scale([0.5,0.5,1.1])symmetries();}


module symmetries(){
for(j=[0:360/rsym:360])rotate([0,0,j]){
intersection(){
if(msym==0)it();else union(){
    intersection(){
    it ();
    translate([-1,0,-0.05])scale([2,1,0.2])cube(1);
    }
    mirror([0,1,0]) intersection(){
    it ();
    translate([-1,0,-0.05])scale([2,1,0.2])cube(1);
    }}

if(rsym>1){intersection(){
rotate ([0,0,(360/rsym)*0.5])translate([-1,0,-0.05])scale([2,1,0.2])cube(1);
mirror([0,1,0])rotate ([0,0,(360/rsym)*0.5])translate([-1,0,-0.05])scale([2,1,0.2])cube(1);
}}else {scale([1,1,0.2])cube(2,center=true);
}
}}}

module it(){
for(i=[0:step:360]){hull(){
theta = i+ sin((i+ophase1)*rep1)*mag1+ sin((i+ophase2)*rep2)*mag2;
translate([
sin(theta+phase)*(baser+sin((i+phase0))*r0 +sin((i+phase1)*2)*r1+sin((i+phase2)*3)*r2+sin((i+phase3)*4)*r3+sin((i+phase8)*8)*r8)/rsum
,
cos(theta+phase)*(baser+sin((i+phase0))*r0+sin((i+phase1)*2)*r1+sin((i+phase2)*3)*r2+sin((i+phase3)*4)*r3+sin((i+phase8)*8)*r8)/rsum
,0

])cube(0.03,$fn=10);
ii=(i+step)%360;
theta2 = ii+ sin((ii+ophase1)*rep1)*mag1+ sin((ii+ophase2)*rep2)*mag2;
translate([
sin(theta2+phase)*(baser+sin((ii+phase0))*r0 +sin((ii+phase1)*2)*r1+sin((ii+phase2)*3)*r2+sin((ii+phase3)*4)*r3+sin((ii+phase8)*8)*r8)/rsum
,
cos(theta2+phase)*(baser+sin((ii+phase0))*r0+sin((ii+phase1)*2)*r1+sin((ii+phase2)*3)*r2+sin((ii+phase3)*4)*r3+sin((ii+phase8)*8)*r8)/rsum
,0

])cube(0.03,$fn=10);
cube(0.03,$fn=10);}}}



function un(v)=v/max(len3(v),0.000001)*1;
function p2n(pa,pb,pc)=
let(u=pa-pb,v=pa-pc)un([u[1]*v[2]-u[2]*v[1],u[2]*v[0]-u[0]*v[2],u[0]*v[1]-u[1]*v[0]]);
function avrg(v)=sumv(v,max(0,len(v)-1))/len(v);
function lerp(start,end,bias)=(end*bias+start*(1-bias));
function len3(v)=len(v)==2?sqrt(pow(v[0],2)+pow(v[1],2)):sqrt(pow(v[0],2)+pow(v[1],2)+pow(v[2],2));
function sumv(v,i,s=0)=(i==s?v[i]:v[i]+sumv(v,i-1,s));
function rnd(a=0,b=1)=(rands(min(a,b),max(a,b),1)[0]);
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];