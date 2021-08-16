torus(rnd(00,200),rnd(100,300));
module torus (ri,ro)
{
r=(max(ro,ri)-min(ro,ri))/2;
rotate_extrude(angle = 360, convexity = 2) translate([ri+r,0,0])circle(r);
}
function rnd(a=1,b=0)=rands(min(a,b),max(a,b),1)[0];