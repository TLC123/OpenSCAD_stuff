////////////////////
//Dead Tree generator by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike
////////////////////
// preview[view:south west, tilt:top diagonal]

//RandomSeed
seed=17894759;//[1111:9999]
part=0;//[0,1]
mycolor=[0.3,0.15,0.09];
module grow(d,i,rho,gro,grot)
{ 
    echo(d,i,rho,gro);
    t=i*1.5;
sphere(d=(0.004*abs(i)*abs(i)*abs(i)),$fn=12);


    if (i<39&&i>38) {
color("Red") rotate([gro,0,0]) translate([0,0,t])
rotate([-10,75,0])grow(d,i*0.98,rho+gro,gro+grot,grot);
color("Red") rotate([gro,0,0]) translate([0,0,t])
rotate([-10,-75,0])grow(d,i*0.98,rho+gro,gro+grot,grot);
        
        echo("here");}             
    
  if (i<-35&&i>-36) {
color("Red") rotate([gro,0,0]) translate([0,0,t])
rotate([-90,-90,90])grow(17,i*0.9,-rho+gro,-gro+grot,-grot*0.5);
color("Red") rotate([gro,0,0]) translate([0,0,t])
rotate([-90,90,-90])grow(17,i*0.9,-rho+gro,-gro*1.5+grot,-grot*1.7);
        
        echo("here");}
        
     //   Head
          if (i<-24&&i>-25) {
color("Red") rotate([gro,0,0]) translate([0,0,t])
rotate([-90,-90,90])grow(17,i*0.9,-rho+gro,-gro+grot,-grot*0.5);
color("Red") rotate([gro,0,0]) translate([0,0,t])
rotate([-90,90,-90])grow(17,i*0.9,-rho+gro,-gro*1.5+grot,-grot*1.7);
        
        echo("here");}


                if(abs(rho)>25){
if(abs(i)>d ){rotate([gro,0,1]) translate([0,0,t])grow(d,i*0.98,rho+gro,gro-grot,grot);}

}else
{
if(abs(i)>d ){    rotate([gro,0,1]) translate([0,0,t])grow(d,i*0.98,rho+gro,gro+grot,grot);}
}
  

    
}

 
   
 rotate([50,0,0])grow(24,40,0,5,1);
 rotate([50,0,0]) grow(24,-40,0,10,1.5);

