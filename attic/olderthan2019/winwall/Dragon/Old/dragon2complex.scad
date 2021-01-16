//Bodypart=[d,s1,s2],[ulim,llim,anlge,change],[x,y,z],[[escape,bodypart],[escape,bodypart],[escape,bodypart]]]]

module grow(bp)
{ 
    grot0=1;
    grot1=1;
    grot2=1;
    
    t=bp[0][1]*0.25;
    d=bp[0][1];
    sphere(d=d,$fn=12);
    s=(bp[0][1]-bp[0][2])/bp[0][0]*1.7;
    
    if (bp[1][0][2]<bp[1][0][0]){grot0=1;};
    if (bp[1][0][2]<bp[1][0][1]){grot0=-1;};
    if (bp[1][1][2]<bp[1][1][0]){grot1=1;};
    if (bp[1][1][2]<bp[1][1][1]){grot1=-1;};
    if (bp[1][2][2]<bp[1][2][0]){grot2=1;};
    if (bp[1][2][2]<bp[1][2][1]){grot2=-1;};
    
    
    lx=t;
    ly=0;
    lz=0;
     echo(bp[0],(bp[0][1]-bp[0][2]),s);
    for (i=[0:len(bp[3])-1]){
    if(bp[3][i][0]==bp[0][0]){echo("escape",bp[3][i][1][1][2]);
        rotate([0,0,bp[3][i][1][1][2]]) grow(bp[3][i][1]);
        }
        }


if(bp[0][0]>0 ){
   
    rotate([gro,0,1]) translate([lx,ly,lz])
    grow ([
    [bp[0][0]-1, bp[0][1]-s,bp[0][2]],
    [
        [bp[1][0][0],bp[1][0][1],bp[1][0][2]+bp[1][0][3],bp[1][0][3]+grot0],
        [bp[1][1][0],bp[1][1][1],bp[1][1][2]+bp[1][1][3],bp[1][1][3]+grot1],
        [bp[1][2][0],bp[1][2][1],bp[1][2][2]+bp[1][2][3],bp[1][2][3]+grot2],
    ],
    [bp[2][0]+lx,bp[2][1]+ly,bp[2][2]+lz],
    bp[3]]);
    }

  

    
}

u=[-45,45,0,10];
v=[u,u,u];

leg=[[3,5,0],
[v,[-90,90,45,1],v],
["x","y","z"],
[["escape","bodypart"],["escape","bodypart"],["escape","bodypart"]]];

spade=[[3,5,0],
v,
["x","y","z"],
[["escape","bodypart"],["escape","bodypart"],["escape","bodypart"]]];

tail=[[15,10,2],//
v,
["x","y","z"],[[0,spade],
["escape","bodypart"],["escape","bodypart"]]];

body=[[6,10,10],v,["x","y","z"],[[0,tail],["escape","bodypart"],["escape","bodypart"]]];
 
 

dragon=[[10,10,5],v,["x","y","z"],[[body[0][0],body],[0,spade],[0,tail]]];


 grow(dragon);

//[[10,10,5],[ulim,llim,anlge,change],[x,y,z],bp[4]]