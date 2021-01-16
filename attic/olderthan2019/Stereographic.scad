filename_variable = "pattern3.png"; // [image_surface:30x30]
treshold=0.5;//[0:0.01:1]
stereographic();
*pix();
module stereographic(){
intersection(){
translate([0,0,5])
difference(){
sphere(5.5,$fn=50);
sphere(5,$fn=50);
 }
 
 for(i=[-10:1:10]){
    for(j=[-10:1:10])
{
hull(){
translate([0,0,10])  cube(0.01,center=true);
 intersection(){
 translate([i,j,0 ])scale([1 ,1,1])cube([1,1,0.001],center=true);//scale to aero you cant generate 0 hright cube
pix();// flat map
}

}}}
}}

module
pix(){
 
translate([0,0,-10*treshold])resize([20,20,10])surface(filename_variable,center=true);
 
}

function rnd(a=1,b=0)=(rands(min(a,b),max(a,b),1)[0]); 