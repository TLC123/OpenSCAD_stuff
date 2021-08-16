 scale([10,10,0]) {pix();}
  //intersection(){
//translate([0,0,5])
//difference(){
//sphere(5.5,$fn=50);
//sphere(5,$fn=50);
//}
// for(i=[-10:1:10]){
//    for(j=[-10:1:10])
{
//hull(){
//translate([0,0,10])  cube(0.01,center=true);
//if((round(rnd()))==0){
//intersection(){
// translate([i,j,0 ])scale([1 ,1,1])cube([1,1,1],center=true);//scale to aero you cant generate 0 hright cube
///scale([10,10,0]) pic();
//}
//}
//}
//}

//}

module
pic(){
for(i=[0:13])
cylinder();
}

function rnd(a=1,b=0)=(rands(min(a,b),max(a,b),1)[0]); 