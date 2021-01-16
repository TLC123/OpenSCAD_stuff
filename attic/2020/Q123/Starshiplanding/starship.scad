//  $t=.65;
$convexity=100;
ta=$t*1000;
//cx=sin(ta)*5;
//cy=cos(ta)*5;
//cz=sin(ta*0.1)*2+2;
cd=1600+cos(10-ta*0.7)*150;

 
 
 attack=abs(sin(40+ta*2)*.3+sin(20+ta*13)*.05)*4;
$vpt=[0,-250+100*attack,-10];


$vpr=[70+sin(ta)*10,0,-ta*.25+150];
$vpd=(cd);  
wings=[
10+sin(10+ta*9)*10+sin(110+ta*129)*2,
10+sin(20+ta*18)*10+sin(210+ta*121)*1,
10+sin(30+ta*27)*10+sin(103+ta*123)*2,
10+sin(40+ta*12)*10+sin(310+ta*139)*1

]*2;
  
  fire=    [    [0.35, 0.75, 0.55],
        [1., 1.2, 0.95],
        [ .20,   .25, .5],
        [ 0.,  0.13, 0.13] ];
shipwithattitude();
ground();

module ground(){

 

color("lightgreen")   for (i=[-2100:99:2100]){

translate([i,0,-1000]) scale([6*min(1,(1000/abs(i))),3500])rotate(45)square([1,1],center=true);
translate([0,i,-1000])  scale([3500,6*min(1,(1000/abs(i)))])rotate(45)square([1,1],center=true);
}



}


module         dragpoint()
{         rotate([

-45-(sin(40+ta*2)*30+sin(20+ta*13)*5)


,0,0])
translate([0, 100,1500]) 
scale (60*(1.1+sin(ta*10)))sphere (1);
}

module shipwithattitude()
{




ship(wings);}




module attitude(){

rotate([

45+sin(40+ta*2)*30+sin(20+ta*13)*5


,0,0]) 
rotate([0,0,sin(11+ta*5)*45]) 
translate([0,-60,-150])
children();
}
module trunk(){
   difference(){  color([.9,.9,.9])
rotate_extrude(,$fn=12)
{
   
    
    hull()   {
intersection (){
square([41,465]);
translate([0,454])circle(6);
}
intersection (){
square([41,459]);

union(){    
square([41,330]);
translate([-135,352])circle(175,$fn=34);


}}}


}

color([0.2,0.2,0.2])cylinder(40,37,37,center=true);
}
}
module ship(w){


attitude()  trunk();

compose(12,0) attitude()translate([0,0,455]) sphere(8,$fn=6);
compose(13,0) attitude()translate([0,1,0]) scale([40,40,0.01])sphere(1,$fn=6);

compose(2)  {  attitude()   lowwing(w[0]);
attitude()   mirror([1,0,0]) lowwing(w[2]);}



compose(13) {   attitude()   hiwing(w[1]);
attitude()  mirror([1,0,0])   hiwing(w[3]);
}}




module compose(i,v=1)
{
if (v==1) children();
col=pal((1+sin(i*11+ta*12))*0.5,fire); 
alpha=0.3+0.1*max(0,min(1,(
(1+sin(i*10+ta*12))*0.5
+(1+sin(i*5+ta*80))*0.5
+(1+sin(i*25+ta*121))*0.5)/3
)

);
color(
[0.5,0.5,0.5]+col*0.5

,alpha

)  hull(){  
dragpoint();       
translate([0,0,-1])  children();


}

}
module lowwing(r)


{color("gray")
translate([43,0,0])
rotate(r)
translate([-43,0,0])
rotate([90,0,0])   linear_extrude(5,center=true)   polygon([[43,5],[50,10],[85,20],[85,60],[43,170]]); 


}       


module hiwing(r)


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



 
    

function  pal(   t,   p )=[
for (i=[0:2]) max(0,min(1,
      p[0][i] + p[1][i]*cos( 360*(p[2][i]*(1-t)+p[3][i]) )))
];