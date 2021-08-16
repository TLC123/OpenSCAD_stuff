// hydrofonwobbler
difference()
{  translate([0,0,25]) 
    hull(){
    scale([.25,.25,1])sphere(100,$fn=80);
  translate([0,0,-5])  for(a=[0:360/4:360])rotate(a) translate([20,20,0] ) scale([.05,.05,.55])sphere(100,$fn=12);
    }
    
  cylinder(220,3,3 );
  cylinder(40,15,10 );
  rotate([90,0,0])cylinder(50,13,13,center= true)   ;
  hull(){
  rotate([90,0,0])cylinder(20,20,20,center= true)   ;
  translate([0,30, 0])rotate([90,0,0])cylinder(30,15,15,center= true)   ;
  }
  step=40;
  for(t=[0:1/step:1]){
    v=[0, 1,1];
 union()hull(){  
      z=bez(t,v);
      zz=bez(t-(1/step),v);
 
  translate([0,0,z*130])rotate([0,0,90+sin(70+z*120)*-90])scale([1,1,0.01])rotate([90,0,0])cylinder(35,2,2 ,$fn=20)   ;
  translate([0,0,zz *130 ])rotate([0,0,90+sin(70+zz*120)*-90])scale([1,1,0.01])rotate([90,0,0])cylinder(35,2,2,$fn=20 )   ;
  }
  
  }
 

}

function bez(t, v) = (len(v) > 2) ? bez(t, [   for (i = [0: len(v) - 2])  lerp( v[i]* (t), v[i + 1] , t)]):  lerp( v[0]* (t), v[ 1] , t) ;
  
  
function lerp(start,end,bias) = (end * bias + start * (1 - bias));
