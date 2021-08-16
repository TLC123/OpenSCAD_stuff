Bearing_Radius=20;
Bearing_Width=19;
boltholeradius=5;
boltheadradius=10;

boltholeCC=72;
 footheight=12;
footwidth=23;
material=6;
chamfer=2;
$fn=30;

//Bearing_Radius=rnd(7,25);
//Bearing_Width=rnd(10,30);
//boltholeradius=rnd(Bearing_Width/6,Bearing_Width/4 );
//boltheadradius=rnd(boltholeradius*1.3,boltholeradius*2);
//
//boltholeCC=rnd(Bearing_Radius *2 ,Bearing_Radius*4);
// footheight=rnd(Bearing_Radius/4 ,Bearing_Radius/2 );
//footwidth=rnd(1,Bearing_Radius/2 );
//material=rnd(3,Bearing_Radius/4 );
//chamfer=rnd(1,2);
//$fn=30;




 fw=max(boltheadradius*2,footwidth);

 difference(){
translate([0,0,Bearing_Radius+material]){rotate([90,0,0])roundcyl(Bearing_Radius+material ,Bearing_Width  ,center=true);}
bearinghole();
}
difference(){
union(){
 translate([0,0,Bearing_Radius+material]){rotate([90,0,0])roundcyl(Bearing_Radius+material*0.5,Bearing_Width  ,center=true);}
 linear_extrude(material*2 ) {
 square([Bearing_Radius*2+material*2,min(Bearing_Width,fw)],center=true);}
union(){
 smallfoothouse();
hull(){
intersection(){smallfoothouse();
 hull(){
scale([1,5,1.5])foot();}
}
foot();}
}
mirror([1,0,0])union(){
 smallfoothouse();
hull(){
intersection(){smallfoothouse();
 hull(){
scale([1,5,1.5])foot();}
}
foot();}
}}
 
holes1();}

module holes1(){
//holes
bearinghole();

//bolt hole
translate([boltholeCC*0.5,0,0])cylinder(footheight*2,boltholeradius,boltholeradius,center=true);
translate([-boltholeCC*0.5,0,0])cylinder(footheight*2,boltholeradius,boltholeradius,center=true);

 hull(){
 translate([boltholeCC*0.5,0,footheight*0.99])
roundcyl(boltheadradius ,chamfer*3 ,boltheadradius  );

 translate([boltholeCC*0.5+boltheadradius*3,0,footheight*0.99+Bearing_Radius +material*2])
roundcyl(boltheadradius*2 ,Bearing_Radius*2 ,boltheadradius*4 );

translate([boltholeCC+fw*0.5 ,0,footheight*0.99])
roundcyl(boltheadradius*2,Bearing_Radius ,boltheadradius*4 );
}
 mirror([1,0,0])hull(){
 translate([boltholeCC*0.5,0,footheight*0.99])
roundcyl(boltheadradius ,chamfer*3 ,boltheadradius  );

 translate([boltholeCC*0.5+boltheadradius*3,0,footheight*0.99+Bearing_Radius +material*2])
roundcyl(boltheadradius*2 ,Bearing_Radius*2 ,boltheadradius*4 );

translate([boltholeCC+fw*0.5 ,0,footheight*0.99])
roundcyl(boltheadradius*2,Bearing_Radius ,boltheadradius*4 );
}

}
module bearinghole(){
translate([0,0,Bearing_Radius+material])rotate([90,0,0])roundcyl(Bearing_Radius,(Bearing_Width+chamfer*2)  ,center=true);
translate([0,-Bearing_Width*0.499,Bearing_Radius+material])rotate([90,0,0])roundcyl(Bearing_Radius+material*0.5,Bearing_Width ,Bearing_Radius*2+material*2 );
mirror([0,1,0])translate([0,-Bearing_Width*0.499,Bearing_Radius+material])rotate([90,0,0])roundcyl(Bearing_Radius+material*0.5,Bearing_Width ,Bearing_Radius*2+material*2);
}


module roundcyl(r,h,r2=0,center=false){
if(center==true)
rotate_extrude(convex=10){
 offset(delta=+chamfer,chamfer=true) offset(delta=-chamfer,chamfer=true)translate([0,-h*0.5]) 
polygon([[0,0],[r,0],[r2==0?r:r2,h],[0,h]]);
translate([0,-h*0.5])square([r*0.5,h]);

}
else
rotate_extrude(convex=10){
 offset(delta=+chamfer,chamfer=true) offset(delta=-chamfer,chamfer=true)translate([0,0])
polygon([[0,0],[r,0],[r2==0?r:r2,h],[0,h]]);
translate([0,0])square([r*0.5,h]);

}
}

module foot(){
intersection(){translate([Bearing_Radius+material,-fw*0.5,0])cube([(boltheadradius+boltholeCC)*0.5,fw,footheight]);
 hull(){
linear_extrude(footheight
//-(fw-Bearing_Width)/2 
){
 translate([boltholeCC*0.5,0,0])circle(boltheadradius-chamfer);
 square([boltholeCC  ,fw-chamfer*2],center=true);
 }

linear_extrude(footheight-chamfer ) {
 translate([boltholeCC*0.5,0,0])circle(boltheadradius );
square([boltholeCC  ,fw],center=true);

//translate([0,0,Bearing_Radius+material])rotate([90,0,0])roundcyl(Bearing_Radius +material,Bearing_Width ,center=true);
}}}}
module smallfoot(){
intersection(){translate([Bearing_Radius+material,-fw*0.5,0])cube([(boltheadradius+boltholeCC)*0.5,fw,footheight]);
hull(){
linear_extrude(footheight
//-(fw-Bearing_Width)/2 
)
offset(delta=-chamfer,chamfer=true) 
offset(delta=+chamfer,chamfer=true)
 offset(delta=-chamfer,chamfer=true)
square([boltholeCC ,fw],center=true);

linear_extrude(footheight-chamfer )  offset(delta=+chamfer,chamfer=true) offset(delta=-chamfer,chamfer=true)square([boltholeCC ,fw],center=true);
//translate([0,0,Bearing_Radius+material])rotate([90,0,0])roundcyl(Bearing_Radius +material,Bearing_Width ,center=true);
}}}
module smallfoothouse(){
hull(){
smallfoot();

//linear_extrude(footheight)
////offset((fw-Bearing_Width)/2)
//offset(delta=(fw-Bearing_Width)/2,chamfer=true)square([boltholeCC,Bearing_Width],center=true);
 
house();


}};
module house(){
intersection(){
 union(){translate([-material,-fw*0.5,Bearing_Radius]){
cube([(boltheadradius*2+boltholeCC)*0.5,fw,(Bearing_Radius+material)*2]);}
translate([Bearing_Radius*0.5,-fw*0.5,0]){
cube([(boltheadradius+boltholeCC)*0.5,fw,(Bearing_Radius+material)*2]);}
}
translate([0,0,Bearing_Radius+material])rotate([90,0,0])roundcyl(Bearing_Radius+material,Bearing_Width ,center=true);}
 linear_extrude(material  ) {
 translate([Bearing_Radius+material,0,0])square([Bearing_Radius ,Bearing_Width],center=true);}
}


function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 