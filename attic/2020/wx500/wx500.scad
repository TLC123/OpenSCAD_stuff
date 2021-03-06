    include<polyround2019.scad>
cage=false;
//cage=true;
c1=17.5/2+1;
c2=4+1;
c3=59;
hc3=58/2;
l1=102/2-c1;
l2=102/2-c2*1.5+1;
l3=(24-c1*2)+c2-1.5;
fxtra=0;
shell=2;
wl1=l1+c1*1;
wl3=l3+c2/2+1;
wl3f=l3+c2/2+1+fxtra;
whc3=hc3+1.5;
r=4;
r2=10;
     path=  polyRound( [
     [ wl1-10,wl3f,whc3,3],
    [ wl1,wl3f,whc3,3], 
   [ wl1,wl3f,-whc3,r],  [wl1,-wl3,-whc3,r2], [-wl1,-wl3,-whc3,r2],
     [-wl1,wl3f,-whc3,r],[-wl1,wl3f,whc3,r],  
      [-wl1,-wl3,whc3,r2], 
     [ wl1-47,-wl3,whc3,r2], 
     [ wl1-47,wl3f,whc3,3], 
//     [ wl1-35,wl3f,whc3,3],   
//     [ wl1-35,wl3f,whc3-10,3],   
      
    ]
  ,fn=4);
  
  
       path2=   ( [
       [0, 0, 30], [0, 20, 30], 
       [21.2132, 20, 21.2132]       ,[21.2132, 0, 21.2132]       ,
       [30, 0, 0],    [30, 20, 0], 
       [21.2132, 20, -21.2132],        [21.2132, 0, -21.2132], 
       [0, 0, -30],   [0, 20, -30],
       [-21.2132, 20, -21.2132],  [-21.2132, 0, -21.2132], 
       [-30, 0, 0],[-30, 20, 0],
       [-21.2132, 20, 21.2132],        [-21.2132, 0, 21.2132], 
      [0, 00, 30], 
       
       ]*1.03
       
   );
//       echo(path2);
//*difference(){
//    union(){
//translate([0,-29,0])    rotate([0,90/4+0,0]) translate([0,l2 ,0])    polyline(path2,4);
//translate([0,10.5,0])rotate([-90,0,0])cylinder(8,hc3+6,hc3+6);
//    }
//translate([0,0,0])rotate([-90,0,0])cylinder(60,hc3,hc3);
//
//}
rotate([-90,0,0])difference(){
union(){
difference(){
hull(){
    linear_extrudeSH(c3+shell*2, $convexity=100,center=true) offset(delta=shell,$fn=1)topprofile();
//  translate([0,fxtra,0])  linear_extrudeSH(c3+shell*2, $convexity=100,center=true) offset(shell,$fn=1)topprofile();
    }
hull(){
    translate([l1-21,-10,hc3+shell-2])// top notch1
       cube([33,40,shell*3.6-3+3],center=true);
    translate([l1-21,-10,hc3+shell-2])// top notch1
       cube([38,35,shell*3.6-3+3],center=true);
    translate([l1-16,-15,hc3+shell-2])// top notch1
       cube([38,40,shell*3.6-3+3],center=true);}
    
//     #translate([l1-17,-15,hc3+shell]) rotate([0,0,45]) cube([40,20,80],center=true);// chamfer
}
        
//translate([0,0,0])hull()
//{
//        linear_extrudeSH(c3+shell*2, $convexity=100,center=true) offset(shell)topprofile();
//
// translate([-20,0,0])rotate([-90,0,0])cylinder(21,hc3+2.5,hc3+2.5);
//translate([20,0,0])rotate([-90,0,0])cylinder(21,hc3+2.5,hc3+2.5);
//     translate([-20,0,0])rotate([-90,0,0])cylinder(22,hc3+1,hc3+1);
//translate([20,0,0])rotate([-90,0,0])cylinder(22,hc3+1,hc3+1);
//}
if(cage)translate([0,-c2+2 ,0 ])polyline(path,4.1);
}


   translate([l1-13 ,0,hc3+shell])// top notch
hull(){
    cube([20-3,40-3,shell*3.6],center=true);
   cube([20,40,shell*3.6-3],center=true);
}   

translate([l1-13 ,0,hc3+shell+shell*1.25])// top notch
 hull(){
    cube([23-3,43-4,shell*3.6],center=true);
   cube([23,43,shell*3.6-4],center=true);
}

    
linear_extrudeSH(c3, $convexity=100,center=true) topprofile();
translate([0,0,-hc3])linear_extrudeSH(shell*34, $convexity=100,center=true) offset(7)offset(-10)scale([.5,1])topprofile();


translate([-90,-.5,-hc3+1])linear_extrudeSH(2, $convexity=100 ) topprofile();
//mirror([0,0,1])translate([-90,-4,-hc3+1])linear_extrudeSH(2, $convexity=100 ) topprofile();

 
//union( convexity=100){
//linear_extrude(2, $convexity=100) offset(3)  topprofile();
//translate([0,0,c3*2+3])linear_extrude(2, $convexity=20) offset(3)  topprofile();
//linear_extrude(c3*2+4, convexity=100)
//
//difference()
//{
// offset(2)   topprofile();
//    topprofile();
//}
//}

    
    
translate([0,0,0])hull()
{
 translate([-10,0,0])rotate([-90,0,0])cylinder(25,hc3,hc3);
translate([5,0,0])rotate([-90,0,0])cylinder(25,hc3,hc3);
}

 
translate([0,-20,0]) difference(){
    cube([120,15,56],center=true);// display
translate([-15,-0,28])     cube([50,15,2.5],center=true);// display
translate([-0,-0,-28])     cube([80,15,2.5],center=true);// display

}


//translate([l1-8,-10,hc3+shell])// top notch
//hull(){
//    cube([42-3,40-3,shell*3.6],center=true);
//   cube([42,40,shell*3.6-3],center=true);
//}
 translate([l1,-15,hc3+shell])  cube([40,40,40],center=true);
 translate([l1,-15,-10])  cube([40,30,8],center=true);
 translate([l1,-13,-10]) rotate([45,0,0]) cube([40,11,11],center=true);
 if(!cage) translate([l1-35,-13,hc3]) rotate([0,0,45]) cube([40,10,10],center=true);
 if(!cage) translate([l1+c1,-2,hc3]) rotate([0,0,45]) cube([40,10,36],center=true);
 translate([l1,-3-20,hc3+shell-20]) rotate([-45,0,0]) cube([40,20,40],center=true);// chamfer


}
function clamp(v,a=0,b=1)=min(max(v,min(a,b)),max(1,b));


module topprofile(){
 hull(){
     offset(1,$fn=1)
hull(){
translate([l1,0])  circle(c1,$fn=8);
translate([-l1,0])  circle(c1,$fn=8);
 

translate([c2*.25,-l3])
 {
translate([l2,0])  circle(c2,$fn=8);
translate([-l2,0])  circle(c2,$fn=8);
}




} 
translate([0,c2+1.5]) 
 {
translate([l2+c2/2,0])  circle(c2,$fn=4);
translate([-l2-c2/2,0])  circle(c2,$fn=4);
}
}
}

module linear_extrudeSH(h,convexity=100,center )
{
    hull(){
    linear_extrude(h-2, $convexity=convexity,center=center) children();
    linear_extrude(h , $convexity=convexity,center=center) offset(r=-1  )children();

    }
    }