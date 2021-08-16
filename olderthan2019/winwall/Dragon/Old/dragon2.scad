//Bodypart=[d,s1,s2],[ulim,llim,anlge,change],[x,y,z],[[escape,bodypart],[escape,bodypart],[escape,bodypart]]]]

module grow(bp)
{ 
    
    
    t=bp[0][1]*0.25;
    d=bp[0][1];
    sphere(d=d,$fn=12);
    s=(bp[0][1]-bp[0][2])/bp[0][0]*1.7;
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
   
    translate([lx,ly,lz])grow ([[bp[0][0]-1,bp[0][1]-s,bp[0][2]],bp[1],[bp[2][0]+lx,bp[2][1]+ly,bp[2][2]+lz],bp[3]]);
    }

  

    
}  
leg=[[3,5,0],
["ulim","llim",10,"change"],
["x","y","z"],
[["escape","bodypart"],["escape","bodypart"],["escape","bodypart"]]];

spade=[[3,5,0],
["ulim","llim",10,"change"],
["x","y","z"],
[["escape","bodypart"],["escape","bodypart"],["escape","bodypart"]]];

tail=[[15,10,2],//
["ulim","llim",45,"change"],
["x","y","z"],[[0,spade],
["escape","bodypart"],["escape","bodypart"]]];

body=[[6,10,10],["ulim","llim",180,"change"],["x","y","z"],[[0,tail],["escape","bodypart"],["escape","bodypart"]]];
 
 

dragon=[[10,10,5],["ulim","llim",0,"change"],["x","y","z"],[[body[0][0],body],[0,spade],[0,tail]]];


 grow(dragon);

//[[10,10,5],[ulim,llim,anlge,change],[x,y,z],bp[4]]