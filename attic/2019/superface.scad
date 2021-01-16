#translate([0,-30,0])rotate([30,-3,0])
translate ([-27,20,-850])import("D:/g/OpenSCAD/HEAD_low_poly.stl");

for(i=[0:10:360],j=[-90:10:90]){
p=fu([i,j]); 
translate(p)cube(5,center=true);
 }
    function fu(p)=[
 (sin(p.x)  ) *cos(p.y),
 (cos(p.x)  ) *cos(p.y),
 sin(p.y) ] 
*(30+
 
 
 cos(p.y*1+20)*16*infront(p.x)+
 cos(p.y*2+80)*-8*infront(p.x)+
 cos(p.y*4+10)*4*infront(p.x)+
 cos(p.y*8-50)*-2*infront(p.x)+
 cos(p.y*16+60)*1*infront(p.x)+
 cos(p.y*32+60)*-5*infront(p.x)
 
 )
 ;
 
 function infront(p)= (
 cos(p+180)*0.5+0.5 )*0.5-
 (cos(p*2+180)*0.5+0.5 )*0.65-
 (cos(p*4+180)*0.5+0.5 )*0.75-
 (cos(p*8+180)*0.5+0.5 )*0.5
 ;