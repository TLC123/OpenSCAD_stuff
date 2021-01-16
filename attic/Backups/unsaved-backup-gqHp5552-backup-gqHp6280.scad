cut(2,100,100,0,0)
circle(100);

module cut(i,xm,ym,x,y)
{
difference()       
{children();
offset(r=-1)children();
}

if (i>0){
cut(i, xm/2,ym,x-xm/2,y)
intersection(){
translate([-xm/2,0,0])square([xm/2,ym],center=true);
offset(r=-3)children(); }

cut(i, xm/2,ym,x+xm/2,y)
intersection(){
translate([xm/2,0,0])square([xm/2,ym],center=true);
offset(r=-3)children(); }}
}