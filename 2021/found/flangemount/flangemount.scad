//Bearing radius
r=30;
//Bearing width
w=30;
//Bolt radius
br=10;
//Height flange ears
fh=19;
//Material thickness around bearing
bm=20;
//Material thickness around flange
m=5;
//Bolt distance
bd=20;
//Go easy with deatil, minkowski sums ahead,
$fa=15;

cc=max(bd,r+bm+br);

bar=fh;

color("LightSteelBlue")
intersection(convexity=10){
 cylinder(max(fh ,w ),cc+br+m ,cc+br+m );

difference(){
union(){
minkowski(convexity=10){
linear_extrude(max(0.0001,bar-m),convexity=10)offset(-m*2)offset(m*2){
offset(max(0,(bm-m)))centerhouse();
hull(){
bolthouse();

}}
bullet(m);
}

minkowski(){
linear_extrude(max(0.0001,min(bar-m,max(m,bar*(3/5)-m))),convexity=10)offset(-m*2)offset(m*2)hull(){
bolthouse();
offset(max(0,(bm-m)))centerhouse();
}bullet(m);}

 hull(){
minkowski(){ 
linear_extrude(max(0.0001,w-bm),convexity=10){centerhouse();}
bullet(bm);}

minkowski(){
linear_extrude(max(0.0001,bar-m),convexity=10){
offset(-m*2)offset(m*2)offset(max(0,(bm-m)))
centerhouse(); }bullet(m);
}


}


}





 linear_extrude(w*3+fh,center=true,convexity=10)centerhole();
 linear_extrude(w*3+fh,center=true,convexity=10)bolthole();
}
 }




module centerhouse()
{
circle(r);
}
module centerhole()
{
circle(r);
}
module centerbolthouse()
{
circle(br+m);
}
module bolthole()
{
translate([cc,0,0])circle(br);
translate([-cc,0,0])circle(br);
}

module bolthouse()
{
translate([cc,0,0])circle(br);
translate([-cc,0,0])circle(br);
}

module bullet(m)
{
 rotate_extrude($fn=12,convexity=10) union(){
square([m*(2/3),m ]);
square([m ,m*(2/3)]);
intersection(){
$fn=16;
square(m,m,m);

translate([m*(2/3),m*(2/3),0])circle(m/3);
}}}