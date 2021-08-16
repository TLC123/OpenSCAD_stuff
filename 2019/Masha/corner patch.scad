mesh=[[[0,0,0],[10,-10,0],[10,10,0],[0,10,0],[0,0,10],[10,-10,10],[10,10,10],[0,10,10]],
[[0,1,2],[0,2,3], [0, 3,7,],[0, 7,4,], [ 0,4,5],[0, 5,1,],]];

midpoints=[for(i=mesh[1])avrgp([ mesh[0][ i[1]],mesh[0][ i[2]]])];
echo(midpoints);
 polyhedron(mesh[0],mesh[1]);
 
midpointt=[for(i=mesh[1]) ( mesh[0][ i[2]])];
echo(midpointt);
//    for(j=[0.5:1/10:0.5]){
// color([j,1-j,0])polyhedron(lerp(midpoints,midpointt,j),[[for(i=[0:len(midpoints)-1])i]]);
 polyhedron( midpoints ,[[for(i=[0:len(midpoints)-1])i]]);
// color([j,1-j,0])translate(avrgp(lerp(midpoints,midpointt,j))) sphere(0.5);

//}

 


function avrgp(l) = len(l) > 1 ? addlp(l) / (len(l)) : l;

 function addlp(v, i=0, r=[0,0,0]) = i<len(v) ? addlp(v, i+1, r+v[i]) : r;

function lerp(start, end, bias) = (end * bias + start * (1 - bias));
