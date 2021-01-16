///////////////////////////////////////////
// Voxel oriented edge graph data structure
///////////////////////////////////////////

// next oriented edge in CCW order: same face
fnxt = [  1,  2,  3,  0, 14, 11, 
          7,  8, 12, 10, 13, 21, 
          6, 20, 22, 16, 17, 18, 
         15,  5,  9, 19, 23,  4 ];

// next oriented edge in CCW order: same origin vertex
onxt = [ 15, 12, 13, 14, 11,  7, 
          0, 18, 19,  8, 21, 17, 
         20, 22, 16,  6,  3,  4, 
          5,  9,  1, 23,  2, 10 ];

// origin vertex of an edge
eorg  = [  3, 0, 1, 6, 7, 4, 
           3, 4, 2, 2, 5, 7, 
           0, 1, 6, 3, 6, 7, 
           4, 2, 0, 5, 1, 5 ];

// face vertices of an edge
fvrt =  [ [3, 0, 1, 6], [0, 1, 6, 3], [1, 6, 3, 0], [6, 3, 0, 1], 
          [7, 6, 1, 5], [4, 7, 5, 2], [3, 4, 2, 0], [4, 2, 0, 3], 
          [2, 0, 3, 4], [2, 5, 1, 0], [5, 1, 0, 2], [7, 5, 2, 4], 
          [0, 3, 4, 2], [1, 0, 2, 5], [6, 1, 5, 7], [3, 6, 7, 4], 
          [6, 7, 4, 3], [7, 4, 3, 6], [4, 3, 6, 7], [2, 4, 7, 5], 
          [0, 2, 5, 1], [5, 2, 4, 7], [1, 5, 7, 6], [5, 7, 6, 1] ];

base_voxel_verts = [ [0,0,0], [0,0,1], [0,1,0], [1,0,0], 
                     [1,1,0], [0,1,1], [1,0,1], [1,1,1] ];

function voxel_vertices(i=undef) = 
    i==undef ?
        base_voxel_verts :
    base_voxel_verts[i];

// graph travelling functions
function fnext( edge ) = fnxt[ edge ];      // next edge in the left face (CCW)
function onext( edge ) = onxt[ edge ];      // next edge with same origin (CCW)
function sym( edge )   = (12 + edge) % 24 ; // same edge, inverted direction

// origin and destination vertex of an edge
function orig( edge )  = eorg[ edge ];
function dest( edge )  = eorg[ (12 + edge) % 24 ];

// list of face vertices of an edge
function fvert( edge ) = fvrt[ edge ] ;
// reference edges (x , y and z axis )
function ref_edges()   = [ 12, 20, 1 ];