 let(newv =                       // revised original vertices 
         [ for (i = [0:len(pv)-1])
           let (v = pv[i],
                vf = [for (face = vertex_faces(i,pf)) vertex(face,newfv)],
                F = centroid(vf),
                R = centroid([for (edge = vertex_edges(i,pe)) vertex(edge,newev)]),
                n = len(vf))
           ( F + 2* R + (n  - 3 )* v ) / n
         ])

function vertex_faces(v,faces) =   // return the faces containing v
     [ for (f=faces) if(v!=[] && search(v,f)) f ];



function vertex_values(entries)= 
    [for (e = entries) e[1]];
function centroid_points(points) = 
     vadd(points, - centroid(points));
function vadd(points,v,i=0) =
      i < len(points)
        ?  concat([points[i] + v], vadd(points,v,i+1))
        :  [];