//Barricade by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike

// preview[view:north east, tilt:top diagonal]
// settings
/* [Wall] */
WallHeight=100;//[1:100]
Width=50;//[1:200]
Base=2.5;//[1:4]
BaseHeight=10;//[5:20]
mpv = [[[-33.088418424945985,1.5543267633236684],[-31.718555411247358,1.8282993660633944],[-30.074719794809003,2.1022719688031204],[-28.704856781110372,2.6502171742825724],[-27.334993767411742,2.9241897770222987],[-25.96513075371311,3.4721349825017502],[-24.869240342754207,4.2940527907209285],[-23.499377329055577,4.84199799620038],[-22.403486918096675,5.663915804419559],[-21.033623904398045,5.663915804419559],[-19.663760890699415,5.663915804419559],[-18.293897877000784,5.937888407159285],[-17.19800746604188,5.115970598940107],[-15.828144452343249,4.568025393460655],[-15.006226644124071,3.4721349825017502],[-14.458281438644619,2.1022719688031204],[-12.814445822206261,1.5543267633236684],[-11.444582808507633,1.0063815578442163],[-10.074719794809003,0.7324089551044904],[-8.704856781110372,0.7324089551044904],[-7.334993767411742,0.18446374962503834],[-5.965130753713111,-0.0895088531146877],[-4.5952677400144815,-0.6374540585941397],[-3.225404726315851,-0.6374540585941397],[-1.855541712617221,-1.1853992640735918],[-0.4856786989185908,-1.7333444695530438]],[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25]]]; //[draw_polygon:40x40]
/* [Settings] */

Density=8;//[0.5:15]
TimberDensity=3;//[0.001:15]
Height=WallHeight/12*Density;
Minsize=30;//[10;100]
Maxsize=40;//[10;100]
TimbLength=160;//[50:200]
TimbL=TimbLength/10*Density;
TimbW=10;//[5:40]

Wallstructure=1;


union(){
// wall
    
    intersection(){
                
                translate([-1000,-1000,-1])cube([2000,2000,1000]);
	for( i = [1:1/Density:len(mpv[0])]) {
					
			
        
    color( [0.554,0.55,0.57]) union(){           
                    translate([10*mpv[0][i][0]+rands(-Width*0.25,Width*0.25,1)[0],10*mpv[0][i][1] +rands(-Width*0.35,Width*0.35,1)[0],rands(-Height*0.25,Height,1)[0]]) scale(rands(Minsize,Maxsize*0.7,1)[0]) stone();
                    
           translate([10*mpv[0][i][0]+rands(-Width*0.7,Width*0.7,1)[0],10*mpv[0][i][1] +rands(-Width*0.7,Width*0.7,1)[0],rands(-Height*0.5,Height*0.5,1)[0]])scale(rands(Minsize,Maxsize,1)[0]) stone();
    }
    
    }	
    
    // next i
    }
// wall




//timber    
    intersection(){
                
               color( [0.54,0.25,0.07]) translate([-500,-500,-1])cube([1000,1000,500]);
        color( [0.71,0.61,0.3
])
	for( i = [1:1/TimberDensity:len(mpv[0])]) {
					
			
        
             
                    
                    
translate([10*mpv[0][i][0]+rands(-Width*0.1,Width*0.1,1)[0],10*mpv[0][i][1] +rands(-Width*0.1,Width*0.1,1)[0],rands(Height*0.7,Height*0.8,1)[0]])
rotate([rands(-55, 55, 1)[0],rands(-55, 55, 1)[0],rands(0, 90, 1)[0]]) translate([0,0,-TimbL*0.5])rotate([-90,0,0])resize([    rands(TimbW*0.3, TimbW*0.7, 1)[0]
,    rands(TimbL*0.3, TimbL, 1)[0]
,    rands(TimbW*0.7, TimbW, 1)[0]
]) timber();
    
    }	
    
    // next i
    }

// baseplate       
    
    translate([0,0,-BaseHeight])
    color( [0,0.16,0.05])intersection(){  translate([-500,-500,1])cube([1000,1000,BaseHeight]);
    color( [0.254,0.8,0.27])union(){
                      

        
	for( i = [0:len(mpv[0])]) {
    
        translate([10*mpv[0][i][0],10*mpv[0][i][1],0])
        rotate ([0,0,0+rands(0,90,1)[0]])
        resize([Width*Base,Width*Base,BaseHeight*1.5])
        intersection(){  sphere(center=true,0.5, $fn=7);
            translate([0,0,0.5])cube(1,center=true);}
        
		
				
            }}} 
    
            
        
        // innerstructure       
    
    translate([0,0,-BaseHeight])
    intersection(){  translate([-500,-500,1.001])cube([1000,1000,Height]);
   color( [0.54,0.25,0.07])  union(){
                      

        
	for( i = [0:len(mpv[0])]) {
    
        translate([10*mpv[0][i][0],10*mpv[0][i][1],0])
        rotate ([0,0,0+rands(0,90,1)[0]])
        resize([Width*Wallstructure,Width*Wallstructure,Height*0.7])
        intersection(){sphere(center=true,0.5, $fn=7);
            translate([0,0,0.5]) cube(1,center=true);}
        
		
				
            }} 
    
        }}  
module stone(){
   union(){
   translate([0,0,-1])cylinder(h=2,d=0.7,center=true);
    resize([1,1,1])
       rotate([rands(0, 360, 1)[0],rands(0, 360, 1)[0],rands(0, 360, 1)[0]])intersection(){
    
    rotate([rands(0, 360, 1)[0],rands(0, 360, 1)[0],rands(0, 360, 1)[0]])resize([rands(3, 10, 1)[0],rands(3, 10, 1)[0],rands(3, 10, 1)[0]])
    sphere(center=true,1, $fa=15, $fs=1); 
    
    
    rotate([rands(0, 360, 1)[0],rands(0, 360, 1)[0],rands(0, 360, 1)[0]])resize([rands(5, 8, 1)[0],rands(5, 8, 1)[0],rands(5,8, 1)[0]])
    cube(center=true,1);
        }
    
} }
module timber(){

color( [0.54,0.25,0.07]) 
   difference(){
     color( [0.54,0.25,0.07]) 
        rotate([90,0,0])rotate([0,0,45])        cylinder(1,$fn=floor(rands(4,8,1)[0]));
for(i=[1:rands(3,5,1)[0]]){
//translate([-rands(-.8,.8,1)[0],0,0])scale([1,rands(1,5,1)[0],1])rotate([0,0,45])cube([0.1,0.1,2],center=true);

translate([-rands(-.8,.8,1)[0],-1,0])scale([5,rands(1,5,1)[0],5])rotate([0,0,45])cube([0.1,0.1,2],center=true);}}

}
//Barricade by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike

// preview[view:north east, tilt:top diagonal]