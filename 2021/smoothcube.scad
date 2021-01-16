a=cubemesh3();
b=glue(a);
c=smoothMesh(b);

polyhedronMesh(c);
 

function glue(points,faces)=
faces==undef?glue(points[0],points[1]):
    let( usedpoints=([for(i=faces,j=i)points[j]]),

upoints=truepoints(unique(points)),
nfaces= [for(i=faces)[for(j=i)
    search([points[j]],upoints,1)[0]]])
[upoints,nfaces];

function truepoints(p)=[for(i=p)if(i!=undef)i];

function  uniquejoin(m,n) =  
    concat(m,[   for (i = n)    if (search([i],m,1)==[[]]) i  ]);

//function  unique(m) = [   for (i = [0: len(m) - 1])    if (search([m[i]],m,1)==[i]) m[i] ];

function  unique(m,first,last) = last==undef?unique(m,0,len(m)-1) :
last-first>1? let(mid=(first+last)/2)
uniquejoin(  unique(m,first,floor(mid)),         unique(m,ceil(mid),last) )
 :m[first]==undef? [m[last]]: m[last]==undef?[m[first]] :concat([m[first]],[if( m[last]!=m[first])m[last]] ) ;





function cubemesh3() =  [[[-10, -10, -10], [10, -10, -10], [10, 10, -10], [-10, 10, -10], [10, -10, 10], [-10, -10, 10], [10, 10, 10], [-10, 10, 10]], [[0, 1, 2], [0, 2, 3], [5, 4, 1], [5, 1, 0], [4, 6, 2], [4, 2, 1], [6, 7, 3], [6, 3, 2], [7, 5, 0], [7, 0, 3],[4,5,6],[6,5,7]]];
 
 module polyhedronMesh(mesh){polyhedron(mesh[0],mesh[1]);}

function smoothMesh(points, faces,  c = 1,neighbours) =
is_undef(faces )?smoothMesh(points[0],points[1],  c,neighbours):
is_undef(neighbours)?let(neighbours=pointneighbours (points,faces)) smoothMesh(points ,faces,  c,neighbours):
  echo("smoothMesh",points,faces,neighbours)

    let ( t = relaxmesh(points, faces, neighbours, c))
    t;


function relaxmesh(points, faces, neighbours, c = 1) = c >0 ?
 let(fmp=   facemidpoints(points ,faces))  
echo(fmp) 
 relaxmesh(
pointneighbourscenterpoint(
 fmp,neighbours,points)
, faces, neighbours, c - 1):
 [points, faces];

function pointneighbours (points,faces)= [
    for (i = [0: len(points) - 1])
        [for (j = [0: len(faces) - 1])
    if (faces[j][0] == i || faces[j][1] == i || faces[j][2] == i || faces[j][3] == i) j]
        ];
        
function pointneighbourscenterpoint(midpoints,neighbours,points)=
[for (i = [0: len(points) - 1]) len(neighbours[i]) > 1 ?
avrgp([for (j = [0: len(neighbours[i]) - 1]) midpoints[neighbours[i][j] ] ]):points[i]];
    
function facemidpoints (points,faces)= echo("\nfacemidpoints",points,"\n",faces)
let(p=points)
[for (f=faces)  (p[f[0]]+p[f[1]]+p[f[2]])/3];
    



function avrgp(l) =len(l) > 1 ? [for(l)1]* l / (len(l)) : l;

 
     
 module polyhedronMesh(mesh){polyhedron(mesh[0],mesh[1]);}
