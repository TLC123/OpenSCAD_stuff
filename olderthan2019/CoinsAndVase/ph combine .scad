//input is a list of [points, faces] 
//For each faces, increment the point references by the previous number of points 
function combine_polyhedrons(list, points=[], faces=[], point_count=0, i=0) = 
    i < len(list) ? 
        combine_polyhedrons(list, 
            concat(points, list[i][0]), 
            concat(faces, [for (face_i = [0:len(list[i][1])-1]) 
                [for (point_i = [0:len(list[i][1][face_i])-1]) 
                    list[i][1][face_i][point_i] + point_count]]), 
            point_count + len(list[i][0]), 
            i + 1) 
        : [points, faces]; 
            
//Each poly is [points, faces] 
poly1 = [[ [0,0,0],[10,0,0],[10,0,10],[0,0,10], 
           [0,10,0],[0,10,10],[10,10,10],[10,10,0] 
         ], 
         [ [0,3,2,1,0], [0,4,5,3],[5,4,7,6,5],[1,2,6,7,1], [0,1,7,4,0] ] 
        ];                 
poly2 = [[ [0,0,10],[0,10,10],[10,10,10],[10,0,10] ], 
         [ [0,1,2,3,0] ] 
        ]; 
                
new_polyhendron = combine_polyhedrons([poly1, poly2]); 
polyhedron(points=new_polyhendron[0], faces=new_polyhendron[1]);