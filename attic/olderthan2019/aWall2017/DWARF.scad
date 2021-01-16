line( );





module line(p1=[0,0,0,1],p2=[0,0,10,1])
{hull(){
translate([p1[0],p1[1],p1[2]])scale([p1[3]])sphere();
translate([p2[0],p2[1],p2[2]])scale([p2[3]])sphere();
}
}