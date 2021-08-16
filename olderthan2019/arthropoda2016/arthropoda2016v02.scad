/* todo
rings rotation
groves
horn
leg rotations and joint
wings
eyes mandibles 
gene smooth
evolution system
*/
ring=1;
nullstate=[[0,0,0],[0,90,0],[0,10,10]];
basering=basering(12);
map1=makemap();
map2=makemap();
for(i=[-0:0.5:0])
{translate([0,4000*i,0])
{run(map1*i+map2*(1-i));
    
    }    
    };
module run(map){
    n=map[4][0];
    hn=map[3][0];
trunk(map,4,n,nullstate);
color("Red") head(map,3,hn,nullstate);
};
module trunk(map,c,n,state)
{   
    nextstate=[state[0]+matrot(map[c][1][0],state[1]+map[c][1][1]),state[1]+map[c][1][1],[min(max(10,abs(state[2][1]+map[c][1][2][1])),max(10,abs(state[2][2]+map[c][1][2][2]))),max(10,abs(state[2][1]+map[c][1][2][1])),max(10,abs(state[2][2]+map[c][1][2][2]))]];
  //  write(state[0]+state[2],str(c,nextstate[2]));
    if(n>1 && c<len(map)){

    line(state[0],nextstate[0],state[2],nextstate[2],map[c][2],map[c][2]);
    translate(state[0]-[0,-state[2][1]*0.2,state[2][2]*0.3]){rotate([0,0,90-c*c]){leg(map[c][3],0,1,nullstate);}}
    translate(state[0]-[0,state[2][1]*0.2,state[2][2]*0.3]){mirror([0,1,0])rotate([0,0,90-c*c]){leg(map[c][3],0,1,nullstate);}}
    trunk(map,c,n-1,nextstate);
    }
    else if(c<len(map)){
    line(state[0],nextstate[0],state[2],nextstate[2],map[c][2],map[c+1][2]);
    translate(state[0]-[0,-state[2][1]*0.2,state[2][2]*0.3]){rotate([0,0,90-c*c]){leg(map[c][3],0,1,nullstate);}}
    translate(state[0]-[0,state[2][1]*0.2,state[2][2]*0.3]){mirror([0,1,0])rotate([0,0,90-c*c]){leg(map[c][3],0,1,nullstate);}}
    nextn=map[c+1][0];
    trunk(map,c+1,nextn,nextstate);
    }
    
    }

 module head(map,c,n,state)
{
    
    nextstate=[state[0]+matrot(map[c][1][0],state[1]+map[c][1][1]),state[1]+map[c][1][1],[min(max(10,abs(state[2][1]+map[c][1][2][1])),max(10,abs(state[2][2]+map[c][1][2][2]))),max(10,abs(state[2][1]+map[c][1][2][1])),max(10,abs(state[2][2]+map[c][1][2][2]))]];
   // write(state[0]+state[2],str(c,nextstate[2]));
 
    if(n>1 && c>=0){
    line(state[0],nextstate[0],state[2],nextstate[2],map[c][2],map[c][2]);
    translate(state[0]-[0,-state[2][1]*0.2,state[2][2]*0.3]){rotate([0,0,90]){leg(map[c][3],0,1,nullstate);}}
    translate(state[0]-[0,state[2][1]*0.2,state[2][2]*0.3]){mirror([0,1,0])rotate([0,0,90]){leg(map[c][3],0,1,nullstate);}}
    head(map,c,n-1,nextstate);}
    else if(c>=0){
    nextn=map[c-1][0];
    line(state[0],nextstate[0],state[2],nextstate[2],map[c][2],map[c-1][2]);
    translate(state[0]-[0,-state[2][1]*0.2,state[2][2]*0.3]){rotate([0,0,90]){leg(map[c][3],0,1,nullstate);}}
    translate(state[0]-[0,state[2][1]*0.2,state[2][2]*0.3]){mirror([0,1,0])rotate([0,0,90]){leg(map[c][3],0,1,nullstate);}}
    head(map,c-1,nextn,nextstate);
    }
    
    }
 module leg(map,c,n,state)
{ leng=map[c][1][0][0];
    nextstate=[state[0]+matrot(map[c][1][0],state[1]+map[c][1][1]),state[1]+map[c][1][1],[min(max(1,abs(state[2][1]+map[c][1][2][1])),max(1,abs(state[2][2]+map[c][1][2][2]))),max(1,abs(state[2][1]+map[c][1][2][1])),max(1,abs(state[2][2]+map[c][1][2][2]))]];
  //  write(state[0]+state[2],str(c,nextstate[2]));
    if(leng>2 && n>1 && c<len(map)){
       line(state[0],nextstate[0],state[2],nextstate[2],map[c][2],map[c][2]);
   
    leg(map,c,n-1,nextstate);
        }   
    else if(leng>0 && c<len(map)){
    line(state[0],nextstate[0],state[2],nextstate[2],map[c][2],map[c+1][2]);
       nextn=map[c+1][0];

    leg(map,c+1,nextn,nextstate);
    }
    
    }   
    module write(i,t){
       translate(i+[0,0,10]){
          rotate([90,0,0]) text(str(t),size=3);
           }
           }
    module line(i,o,s1=[1,1,1],s2=[1,1,1],ring1,ring2){
        hull (){
            
            sl1=[10,s1[1],s1[2]];
            sl2=[10,s2[1],s2[2]];
       // translate(i)resize(s1){rotate([0,90,0]){sphere(10,$fn=6);}}
       //translate(o)resize(s2){rotate([0,90,0]){sphere(10,$fn=6);}}     
         translate(i) resize(sl1){rotate([0,01,0]){ polyhedron (ring1,[[for(i=[0:len(ring1)-1])i]]);
}}
      translate(o) resize(sl2){rotate([0,01,0]){ polyhedron (ring2,[[for(i=[0:len(ring2)-1])i]]);
}}
      }
        }
        
      function  matrot(v,r)=let(x=v[0],y=v[1],z=v[2])
        [
        x*sin(r[1])+y*0+z*0  ,
        y*1+x*0+z*0 ,
        z*0+y*0+x*cos(r[1])
        ];
        
     function legs(l)=[


[1,[[rnd(40*l,150*l),0,0],[0,rnd(70,80),0],[0,rnd(10*l,10*l),rnd(10*l,40*l)]],xring(12,0.5),1],
[1,[[rnd(40*l,150*l),0,0],[0,rnd(-90,-45),0],[0,rnd(30,40),rnd(30,40)]],xring(12,0.5),1],
[1,[[rnd(100*l,480*l),0,0],[0,rnd(20,-55),0],[0,rnd(-20,25),rnd(-20,5)]],xring(12,0.5),1],
[rnd(2),[[rnd(50*l,40*l),0,0],[0,rnd(25,55),0],[0,rnd(-20,25),rnd(-20,25*l)]],xring(12,0.5),1],
[1,[[rnd(250*l,380*l),0,0],[0,rnd(20,120),0],[0,rnd(-20,25),rnd(-20,25*l)]],xring(12,0.5),1],
[1,[[rnd(50*l,10),0,0],[0,rnd(-30,-20),0],[0,rnd(-20,25),rnd(-20,25*l)]],xring(12,0.5),1],
[1,[[rnd(50*l,10),0,0],[0,rnd(-30,-20),0],[0,rnd(-20,-25),rnd(-20,25*l)]],xring(12,0.5),1],
[1,[[rnd(50*l,10),0,0],[0,rnd(-0,20),0],[0,rnd(-20,-25),rnd(-20,-25*l)]],xring(12,0.5),1],
[rnd(2),[[rnd(50*l,10),0,0],[0,rnd(-20,2),0],[0,rnd(-20,-25),rnd(-20,-25*l)]],xring(12,0.5),1],
[rnd(2),[[rnd(50*l,10),0,0],[0,rnd(-2,20),0],[0,rnd(-20,-25),rnd(-20,-25)]],xring(12,0.5),1],
[rnd(2),[[rnd(5*l,10),0,0],[0,rnd(-2,20),0],[0,rnd(-20,-25),rnd(-20,-25)]],xring(12,0.5),1],
[rnd(2),[[rnd(5*l,10),0,0],[0,rnd(-2,20),0],[0,rnd(-10,-15),rnd(-10,-15)]],xring(12,0.5),1]
];

function makemap()=[
[rnd(2,0),[[rnd(-100,-10),0,0],[0,rnd(-10,10),0],
    [0,rnd(-20,25),rnd(-20,25)]],xring(12,0.5),legs(0.5)],
[rnd(2,1),[[rnd(-100,-10),0,0],[0,rnd(-40,40),0],
    [0,rnd(-150,55),rnd(-150,155)]],xring(12,0.5),legs(0.05)],
[rnd(2,1),[[rnd(-100,-10),0,0],[0,rnd(-40,40),0],
    [0,rnd(-150,55),rnd(-150,155)]],xring(12,0.5),legs(0.05)],
[rnd(2,1),[[rnd(-100,-50),0,0],[0,rnd(-20,20),0],
    [0,rnd(110,350),rnd(115,375)]],xring(12,0.5),legs(0.05)],

[rnd(2),[[rnd(200,30),0,0],[0,rnd(-2,2),0],
    [0,rnd(140,250),rnd(145,275)]],xring(12,0.5),legs(rnd(1,1.2))],
[rnd(2),[[rnd(100,30),0,0],[0,rnd(-12,12),0],
    [0,rnd(-20,15),rnd(-20,5)]],xring(12,0.5),legs(rnd(1,1.2))],
[rnd(2),[[rnd(100,30),0,0],[0,rnd(-12,12),0],
    [0,rnd(-20,25),rnd(-20,25)]],xring(12,0.5),legs(rnd(1,1.2))],
[rnd(3),[[rnd(150,30),0,0],[0,rnd(-15,15),0],
    [0,rnd(-120,125),rnd(-20,25)]],xring(12,0.5),legs(0.25)],
[rnd(3),[[rnd(500,30),0,0],[0,rnd(-15,15),0],
    [0,rnd(-120,15),rnd(-20,25)]],xring(12,0.5),legs(0)],
[rnd(3),[[rnd(150,30),0,0],[0,rnd(-15,5),0],
    [0,rnd(-120,15),rnd(-20,25)]],xring(12,0.5),legs(0.25)],
[rnd(3),[[rnd(250,30),0,0],[0,rnd(-15,5),0],
    [   0,rnd(-120,25),rnd(-20,25)]],xring(12,0.5),legs(0.25)],
[rnd(3),[[rnd(150,30),0,0],[0,rnd(-15,115),0],
    [0,rnd(-120,125),rnd(-20,25)]],xring(12,0.5),legs(0.25)],
[rnd(3),[[rnd(250,30),0,0],[0,rnd(-15,45),0],
    [0,rnd(-120,125),rnd(-20,25)]],xring(12,0.5),legs(0.25)],
[rnd(3),[[rnd(50,30),0,0],[0,rnd(-15,45),0],
    [0,rnd(-20,25),rnd(-20,25)]],xring(12,0.5),legs(0.25)],
[rnd(3),[[rnd(150,30),0,0],[0,rnd(-15,15),0],
    [0,0,rnd(-10,15)]],xring(12,0.5),legs(0)]
];
 function rndR()=[rands(0,360,1)[0],rands(0,360,1)[1],rands(0,360,1)[0]];
 function rnd(s=1,t=0)=rands(min(s,t),max(s,t),1)[0];
 
    //  function xring(x=8,i=0.5)=lerp(basering, mirring([for(i=[(360/x)*0.5:360/x:359])[0,sin(i),cos(i)]+rndV2()*0.1]),i);
      function xring(x=8,i=0.5)=mirring([for(i=[(360/x)*0.5:360/x:359])[0,sin(i),cos(i)]+rndV2(3)*0.1]);
            ;
          function lerp(start,end,bias ) = (end * bias + start * (1 - bias));
        function basering(x=8)=mirring([for(i=[(360/x):360/x:359])[0,sin(i),cos(i)]+rndV2(3)]);
            
          function lerp(start,end,bias ) = (end * bias + start * (1 - bias));
function  mirring(ring)=
     let( n=floor((len(ring)-1 )/2))
     
     concat( 
     [for(i=[0:n])ring[i]],
     [for(i=[0:n])[ring[n-i][0],-ring[n-i][1],ring[n-i][2]]]
         ); 
function rndV2(t=130)=[rands(0,0,1)[0],rands(-t,t,1)[0],rands(-t,t,1)[0]];
