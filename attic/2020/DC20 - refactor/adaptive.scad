cell=[[-1,-1,-1],[1,1,1]];
scene=function(p) norm(p)-1.5;
function eval(p,scene)=scene(p);
 
 
 
// echo(" x",bitMaskToValue(- [for(i=vertFromCell  (cell))i.x]), 
//     bitMaskToValue( [1, -1,-1,1,1,-1,-1,1]) 
// );
// echo("-x",bitMaskToValue( [for(i=vertFromCell  (cell))i.x]),  
//     bitMaskToValue( -[1, -1,-1,1,1,-1,-1,1]) 
//);
// echo("y",bitMaskToValue([for(i=vertFromCell  (cell))i.y]),  
//     bitMaskToValue([-1,-1,1,1,-1,-1,1,1]) 
// );
// echo("-y",bitMaskToValue(-[for(i=vertFromCell(cell))i.y]),  
//     bitMaskToValue(-[-1,-1,1,1,-1,-1,1,1]) 
//);
// echo(" z",bitMaskToValue( -[for(i=vertFromCell  (cell))i.z]),  
//     bitMaskToValue([1,1,1,1,-1,-1,-1,-1]) 
//);
// echo("-z",bitMaskToValue([for(i=vertFromCell  (cell))i.z]),  
//     bitMaskToValue(-[1,1,1,1,-1,-1,-1,-1]) 
// );
// 
// ECHO:" x", 153, 153
//ECHO:"-x", 102, 102
//ECHO:"y", 204, 204
//ECHO:"-y", 51, 51
//ECHO:" z", 15, 15
//ECHO:"-z", 240, 240

verts=vertFromCell  (cell) ;
evals=[for(p=verts)eval(p,scene)]; 
echo (evals); 
 echo(bitMaskToValue(evals));



function  vertFromCell  (cell)= [for(c=VERTICES ())
    [cell[c.x].x,cell[c.y].y,cell[c.z].z ] 
];
function  VERTICES ()= [
    [0,0,0],
    [1,0,0],
    [1,1,0],
    [0,1,0],
    [0,0,1],
    [1,0,1],
    [1,1,1],
    [0,1,1],
];

// Takes a vector. Any number >0 is 1 rest 0. use binary to build a number 
function bitMaskToValue(v=[0])= is_undef(v[0])?0:
 [for(j=v)1]* [for (i=[0:max(0,len(v)-1)]) max(0,sign(v[i]))*pow(2,i)] ;
     
 