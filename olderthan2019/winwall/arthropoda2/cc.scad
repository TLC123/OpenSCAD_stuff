
function C() = 
   p_resize(poly(name= "C",
       vertices= [
[ 0.5,  0.5,  0.5],
[ 0.5,  0.5, -0.5],
[ 0.5, -0.5,  0.5],
[ 0.5, -0.5, -0.5],
[-0.5,  0.5,  0.5],
[-0.5,  0.5, -0.5],
[-0.5, -0.5,  0.5],
[-0.5, -0.5, -0.5]],
      faces=
 [
[ 4 , 5, 1, 0],
[ 2 , 6, 4, 0],
[ 1 , 3, 2, 0],
[ 6 , 2, 3, 7],
[ 5 , 4, 6, 7],
[ 3 , 1, 5, 7]]
   ));

function depth(a) =
   len(a)== undef 
       ? 0
       : 1+depth(a[0]);
        
function flatten(l) = [ for (a = l) for (b = a) b ] ;

function dflatten(l,d=2) =
// hack to flattened mixed list and list of lists
   flatten([for (a = l) depth(a) > d ? dflatten(a, d) : [a]]);
    
function reverse(l) = 
     [for (i=[1:len(l)]) l[len(l)-i]];

function shift(l,shift=0) = 
     [for (i=[0:len(l)-1]) l[(i + len(l)- shift)%len(l)]];  
         
//  functions for creating the matrices for transforming a single point

function m_translate(v) = [ [1, 0, 0, 0],
                            [0, 1, 0, 0],
                            [0, 0, 1, 0],
                            [v.x, v.y, v.z, 1  ] ];

function m_scale(v) =    [ [v.x, 0, 0, 0],
                            [0, v.y, 0, 0],
                            [0, 0, v.z, 0],
                            [0, 0, 0, 1  ] ];
                            
function m_rotate(v) =  [ [1,  0,         0,        0],
                          [0,  cos(v.x),  sin(v.x), 0],
                          [0, -sin(v.x),  cos(v.x), 0],
                          [0,  0,         0,        1] ]
                      * [ [ cos(v.y), 0,  -sin(v.y), 0],
                          [0,         1,  0,        0],
                          [ sin(v.y), 0,  cos(v.y), 0],
                          [0,         0,  0,        1] ]
                      * [ [ cos(v.z),  sin(v.z), 0, 0],
                          [-sin(v.z),  cos(v.z), 0, 0],
                          [ 0,         0,        1, 0],
                          [ 0,         0,        0, 1] ];
                            
function vec3(v) = [v.x, v.y, v.z];
function m_transform(v, m)  = vec3([v.x, v.y, v.z, 1] * m);

function m_rotate_to(normal) = 
      m_rotate([0, atan2(sqrt(pow(normal.x, 2) + pow(normal.y, 2)), normal.z), 0]) 
    * m_rotate([0, 0, atan2(normal.y, normal.x)]);  
    
function m_rotate_from(normal) = 
      m_rotate([0, 0, -atan2(normal.y, normal.x)]) 
    * m_rotate([0, -atan2(sqrt(pow(normal.x, 2) + pow(normal.y, 2)), normal.z), 0]);  
    
function m_to(origin,normal) = 
      m_rotate([0, atan2(sqrt(pow(normal.x, 2) + pow(normal.y, 2)), normal.z), 0]) 
    * m_rotate([0, 0, atan2(normal.y, normal.x)]) 
    * m_translate(normal);   
   
function m_from(origin,normal) = 
      m_translate(-origin)
    * m_rotate([0, 0, -atan2(normal.y, normal.x)]) 
    * m_rotate([0, -atan2(sqrt(pow(normal.x, 2) + pow(normal.y, 2)), normal.z), 0]); 


function m_rotate_about_line(a,v1,v2) =
      m_from(v1,v2-v1)*m_rotate([0,0,a])*m_to(v1,v2-v1);
      
// modules to orient objects for rendering
module orient_to(origin, normal) {   
      translate(origin)
      rotate([0, 0, atan2(normal.y, normal.x)]) //rotation
      rotate([0, atan2(sqrt(pow(normal.x, 2)+pow(normal.y, 2)),normal.z), 0])
      children();
}

// vector functions
function unitv(v)=  v/ norm(v);

function signx (x) =
     x==0 ? 1 : sign(x);
     
function angle_between(u, v, normal) = 
// protection against inaccurate computation
     let (x= unitv(u) * unitv(v))
     let (y = x <= -1 ? -1 :x >= 1 ? 1 : x)
     let (a = acos(y))
     normal == undef
        ? a 
        : signx(normal * cross(u,v)) * a;
     
function vadd(points,v,i=0) =
      i < len(points)
        ?  concat([points[i] + v], vadd(points,v,i+1))
        :  [];

function vsum(points,i=0) =  
      i < len(points)
        ?  (points[i] + vsum(points,i+1))
        :  [0,0,0];
          
function norm2(v) = v.x*v.x+ v.y*v.y + v.z*v.z;

function reciprocal(v) = v/norm2(v);
           
function ssum(list,i=0) =  
      i < len(list)
        ?  (list[i] + ssum(list,i+1))
        :  0;

function vcontains(val,list) =
     search([val],list)[0] != [];
   
function index_of(key, list) =
      search([key],list)[0]  ;

function value_of(key, list) =
      list[search([key],list)[0]][1]  ;

// dictionary shorthand assuming present
function find(key,array) =  array[search([key],array)[0]];
  
function count(val, list) =  // number of occurances of val in list
   ssum([for(v= list) v== val ? 1 :0]);
    
function distinct(list,dlist=[],i=0) =  // return only distinct items of d 
      i==len(list)
         ? dlist
         : search(list[i],dlist) != []
             ? distinct(list,dlist,i+1)
             : distinct(list,concat(dlist,list[i]),i+1)
      ;

// points functions
        
function as_points(indexes,points) =
    [for (i=[0:len(indexes)-1])
          points[indexes[i]]
    ]; 

function centroid(points) = 
      vsum(points) / len(points);
    
function vnorm(points) =
     [for (p=points) norm(p)];
      
function average_norm(points) =
       ssum(vnorm(points)) / len(points);

function transform_points(points, matrix) = 
    [for (p=points) m_transform(p, matrix) ] ;
   
// vertex functions
    
function vertex_faces(v,faces) =   // return the faces containing v
     [ for (f=faces) if(v!=[] && search(v,f)) f ];
    
function ordered_vertex_faces(v,vfaces,cface=[],k=0)  =
   k==0
       ? let (nface=vfaces[0])
           concat([nface],ordered_vertex_faces(v,vfaces,nface,k+1))
       : k < len(vfaces)
           ?  let(i = index_of(v,cface))
              let(j= (i-1+len(cface))%len(cface))
              let(edge=[v,cface[j]])
              let(nface=face_with_edge(edge,vfaces))
                 concat([nface],ordered_vertex_faces(v,vfaces,nface,k+1 ))  
           : []
;       
      
function ordered_vertex_edges(v,vfaces,face,k=0)  =
   let(cface=(k==0)? vfaces[0] : face)
   k < len(vfaces)
           ?  let(i = index_of(v,cface))
              let(j= (i-1+len(cface))%len(cface))
              let(edge=[v,cface[j]])
              let(nface=face_with_edge(edge,vfaces))
                 concat([edge],ordered_vertex_edges(v,vfaces,nface,k+1 ))  
           : []
;     
     
function vertex_edges(v,edges) = // return the ordered edges containing v
      [for (e = edges) if(e[0]==v || e[1]==v) e];
                       
// edge functions
          
function distinct_edge(e) = 
     e[0]< e[1]
           ? e
           : reverse(e);
          
function ordered_face_edges(f) =
 // edges are ordered anticlockwise
    [for (j=[0:len(f)-1])
        [f[j],f[(j+1)%len(f)]]
    ];

function all_edges(faces) =
   [for (f = faces)
       for (j=[0:len(f)-1])
          let(p=f[j],q=f[(j+1)%len(f)])
             [p,q] 
   ];

function distinct_face_edges(f) =
    [for (j=[0:len(f)-1])
       let(p=f[j],q=f[(j+1)%len(f)])
          distinct_edge([p,q])
    ];
    
function distinct_edges(faces) =
   [for (f = faces)
       for (j=[0:len(f)-1])
          let(p=f[j],q=f[(j+1)%len(f)])
             if(p<q) [p,q]  // no duplicates
   ];
      
function check_euler(obj) =
     //  E = V + F -2    
    len(p_vertices(obj)) + len(p_faces(obj)) - 2
           ==  len(distinct_edges(obj[2]));

function edge_length(edge,points) =    
    let (points = as_points(edge,points))
    norm(points[0]-points[1]) ;
             
function edge_lengths(edges,points) =
   [ for (edge = edges) 
     edge_length(edge,points)
   ];
 
function tangent(v1,v2) =
   let (d=v2-v1)
   v1 - d * (d*v1)/(d*d);
 
function edge_distance(v1,v2) = norm(tangent(v1,v2));
 
function face_with_edge(edge,faces) =
     flatten(
        [for (f = faces) 
           if (vcontains(edge,ordered_face_edges(f)))
            f
        ]);
           
function dihedral_angle(edge,faces,points)=
    let(f0 = face_with_edge(edge,faces),
        f1 = face_with_edge(reverse(edge),faces)
        )
    let(angle = 
           angle_between(
               normal(as_points(f0,points)),
               normal(as_points(f1,points))))
    180-angle;     

function dihedral_angle_faces(f0,f1,faces,points)=
    let(angle = 
           angle_between(
               normal(as_points(faces[f0],points)),
               normal(as_points(faces[f1],points))))
    180-angle; 
           
//face functions
function selected_face(face,fn) = 
     fn == [] || search(len(face),fn) != [] ;

function orthogonal(v0,v1,v2) =  cross(v1-v0,v2-v1);

function normal(face) =
     let (n=orthogonal(face[0],face[1],face[2]))
     - n / norm(n);

function triangle(a,b) = norm(cross(a,b))/2;

function face_area(face) =
     ssum([for (i=[0:len(face)-1])
           triangle(face[i], face[(i+1)%len(face)]) ]);
     
function face_areas(obj) =
   [for (f=p_faces(obj))
       let(face_points = as_points(f,p_vertices(obj)))
       let(centroid=centroid(face_points))
          face_area(vadd(face_points,-centroid))
   ];

function face_areas_index(obj) =
   [for (face=p_faces(obj))
       let(face_points = as_points(face,p_vertices(obj)))
       let(centroid=centroid(face_points))
          [face,face_area(vadd(face_points,-centroid))]
   ];

function max_area(areas, max=[undef,0], i=0) =
   i <len(areas)
      ? areas[i][1] > max[1]
         ?  max_area(areas,areas[i],i+1)
         :  max_area(areas,max,i+1)
      : max[0];

function average_face_normal(fp) =
     let(fl=len(fp))
     let(normals=
           [for(i=[0:fl-1])
            orthogonal(fp[i],fp[(i+1)%fl],fp[(i+2)%fl])
           ]
          )
     vsum(normals)/len(normals);
    
function average_normal(fp) =
     let(fl=len(fp))
     let(unitns=
           [for(i=[0:fl-1])
            let(n=orthogonal(fp[i],fp[(i+1)%fl],fp[(i+2)%fl]))
            let(normn=norm(n))
              normn==0 ? [] : n/normn
           ]
          )
     vsum(unitns)/len(unitns);
     
function average_edge_distance(fp) =
     let(fl=len(fp))
     ssum( [for (i=[0:fl-1])
                edge_distance(fp[i],fp[(i+1)%fl])
             ])/ fl;
    
function face_sides(faces) =
    [for (f=faces) len(f)];
        
function face_coplanarity(face) =
       norm(cross(cross(face[1]-face[0],face[2]-face[1]),
                  cross(face[2]-face[1],face[3]-face[2])
            ));


function face_edges(face,points) =
     [for (edge=ordered_face_edges(face)) 
           edge_length(edge,points)
     ];
         
function min_edge_length(face,points) =
    min(face_edges(face,points));
   
function face_irregularity(face,points) =
    let (lengths=face_edges(face,points))
    max(lengths)/ min(lengths);

function face_analysis(faces) =
  let (edge_counts=face_sides(faces))
  [for (sides=distinct(edge_counts))
        [sides,count(sides,edge_counts)]
   ];

function vertex_face_list(vertices,faces) =
    [for (i=[0:len(vertices)-1])
     let (vf= vertex_faces(i,faces))
     len(vf)];
    
function vertex_analysis(vertices,faces) =
  let (face_counts=vertex_face_list(vertices,faces))
  [for (vo = distinct(face_counts))
        [vo,count(vo,face_counts)]
   ];
// ensure that all faces have a lhs orientation
function cosine_between(u, v) =(u * v) / (norm(u) * norm(v));

function lhs_faces(faces,vertices) =
    [for (face = faces)
     let(points = as_points(face,vertices))
        cosine_between(normal(points), centroid(points)) < 0
        ?  reverse(face)  :  face
    ];
  
// poly functions
//  constructor
function poly(name,vertices,faces,debug=[],partial=false) = 
    [name,vertices,faces,debug,partial];
    
// accessors
function p_name(obj) = obj[0];
function p_vertices(obj) = obj[1];
function p_faces(obj) = obj[2];
function p_debug(obj)=obj[3];
function p_partial(obj)=obj[4];
function p_edges(obj) = 
       p_partial(obj)
           ? all_edges(p_faces(obj))
           : distinct_edges(p_faces(obj));
function p_description(obj) =
    str(p_name(obj),
         ", ",str(len(p_vertices(obj)), " Vertices " ),
         vertex_analysis(p_vertices(obj), p_faces(obj)),
         ", ",str(len(p_faces(obj))," Faces "),
         face_analysis(p_faces(obj)),
         " ",str(len(p_non_planar_faces(obj))," not planar"),
          ", ",str(len(p_edges(obj))," Edges ")
     ); 
     
function p_faces_as_points(obj) =
    [for (f = p_faces(obj))
        as_points(f,p_vertices(obj))
    ];
    
function p_non_planar_faces(obj,tolerance=0.001) =
     [for (face = p_faces(obj))
         if (len(face) >3)
             let (points = as_points(face,p_vertices(obj)))
             let (error=face_coplanarity(points))
             if (error>tolerance) 
                 [tolerance,face]
     ];

function p_dihedral_angles(obj) =
     [for (edge=p_edges(obj))
         dihedral_angle(edge, p_faces(obj),p_vertices(obj))
     ];     
function p_irregular_faces(obj,tolerance=0.01) =
     [for (face = p_faces(obj))
         let(ir=face_irregularity(face,p_vertices(obj)))
         if(abs(ir-1)>tolerance)
               [ir,face]
      ];
             
function p_vertices_to_faces(obj)=
    [for (vi = [0:len(p_vertices(obj))-1])    // each old vertex creates a new face, with 
       let (vf=vertex_faces(vi,p_faces(obj)))   // vertex faces in left-hand order    
       [for (of = ordered_vertex_faces(vi,vf))
              index_of(of,p_faces(obj))    
       ]
    ];
       
module show_points(points,r=0.1) {
    for (point=points)
        if (point != [])   // ignore null points
           translate(point) sphere(r);
};

module show_edge(edge, r) {
    p0 = edge[0]; 
    p1 = edge[1];
    hull() {
       translate(p0) sphere(r);
       translate(p1) sphere(r);
    }
};

module show_edges(edges,points,r=0.1) {
    for (edge = edges)
        show_edge(as_points(edge, points), r); 
};
        
module p_render(obj,show_vertices=false,show_edges=false,show_faces=true, rv=0.04, re=0.02) {
     if(show_faces) 
          polyhedron(p_vertices(obj),p_faces(obj),convexity=10);
     if(show_vertices) 
         show_points(p_vertices(obj),rv);
     if(show_edges)
       show_edges(p_edges(obj),p_vertices(obj),re);
};


module p_hull(obj,r=0.01){
  hull() {
      for (p=p_vertices(obj))
          translate(p) sphere(r);
      
  }
  };  
module p_describe(obj){
    echo(p_description(obj));
}

module p_print(obj) {
    p_describe(obj);
    echo(" Vertices " ,p_vertices(obj));
    echo(" Faces ", p_faces(obj));
    edges=p_edges(obj);
    echo(str(len(edges)," Edges ",edges));
    non_planar=p_non_planar_faces(obj);
    echo(str(len(non_planar)," faces are not planar", non_planar));
    debug=p_debug(obj);
    if(debug!=[]) echo("Debug",debug);
};

// centering and resizing
        
function centroid_points(points) = 
     vadd(points, - centroid(points));
        
function p_inscribed_resize(obj,radius=1) =
    let(pv=centroid_points(p_vertices(obj)))
    let (centroids= [for (f=p_faces(obj))
                       norm(centroid(as_points(f,pv)))
                      ])
    let (average = ssum(centroids) / len(centroids))
    poly(name=p_name(obj),
         vertices = pv * radius /average,
         faces=p_faces(obj),
         debug=centroids
         );

function p_midscribed_resize(obj,radius=1) =
    let(pv=centroid_points(p_vertices(obj)))
    let(centroids= [for (e=p_edges(obj))
                  let (ep = as_points(e,pv))
                  norm((ep[0]+ep[1])/2)
                  ])
    let (average = ssum(centroids) / len(centroids))
    poly(name=p_name(obj),
         vertices = pv * radius /average,
         faces=p_faces(obj),
         debug=centroids
         );

function p_circumscribed_resize(obj,radius=1) =
    let(pv=centroid_points(p_vertices(obj)))
    let(average=average_norm(pv))
    poly(name=p_name(obj),
         vertices=pv * radius /average,
         faces=p_faces(obj),
         debug=average
    );
 
function p_resize(obj,radius=1) =
    p_circumscribed_resize(obj,radius);

// canonicalization

function rdual(obj) =
    let(np=p_vertices(obj))
    poly(name=p_name(obj),
           vertices =
                [ for (f=p_faces(obj))
                  let (c=centroid(as_points(f,np)))
                     reciprocal(c)
                ]
           ,
           faces= p_vertices_to_faces(obj)  
           );
          
function plane(obj,n=5) = 
    n > 0 
       ? plane(rdual(rdual(obj)),n-1)   
       : p_resize(poly(name=str("P",p_name(obj)),
              vertices=p_vertices(obj),
              faces=p_faces(obj)
             ));

function ndual(obj) =
      let(np=p_vertices(obj))
      poly(name=p_name(obj),
           vertices = 
                [ for (f=p_faces(obj))
                  let (fp=as_points(f,np),
                       c=centroid(fp),
                       n=average_normal(fp),
                       cdotn = c*n,
                       ed=average_edge_distance(fp))
                  reciprocal(n*cdotn) * (1+ed)/2
                ]
           ,  
           faces= p_vertices_to_faces(obj)        
           );
                
function canon(obj,n=5) = 
    n > 0 
       ? canon(ndual(ndual(obj)),n-1)   
       : p_resize(poly(name=str("K",p_name(obj)),
              vertices=p_vertices(obj),
              faces=p_faces(obj)
             ));   
             
function dual(obj) =
    poly(name=str("d",p_name(obj)),
         vertices = 
              [for (f = p_faces(obj))
               let(fp=as_points(f,p_vertices(obj)))
                 centroid(fp)  
              ],
         faces= p_vertices_to_faces(obj)        
        )
;  // end dual
              
// Conway operators 
/*  where necessary, new vertices are first created and stored in an associative array, keyed by whatever is appropriate to identify the new vertex - this could be an old vertex id, a face, an edge or something more complicated.  This array is then used to create an associative array of key and vertex ids for use in face construction, and to generate the new vertices themselves. 
*/

function vertex_ids(entries,offset=0,i=0) = 
// to get position of new vertices 
    len(entries) > 0
          ?[for (i=[0:len(entries)-1]) 
             [entries[i][0] ,i+offset]
           ]
          :[]
          ;
   
function vertex_values(entries)= 
    [for (e = entries) e[1]];
 
function vertex(key,entries) =   // key is an array 
    entries[search([key],entries)[0]][1];
    
// operators
    
function kis(obj,height=0.1, fn=[]) =
// kis each n-face is divided into n triangles which extend to the face centroid
// existimg vertices retained
              
   let(pf=p_faces(obj),
       pv=p_vertices(obj))
   let(newv=   // new centroid vertices    
        [for (f=pf)
         if (selected_face(f,fn))                      
             let(fp=as_points(f,pv))
             [f,centroid(fp) + normal(fp) * height]    // centroid + a bit of normal
        ]) 
   let(newids=vertex_ids(newv,len(pv)))
   let(newf=
       flatten(
         [for (face=pf)   
            selected_face(face,fn)                     
         //replace face with triangles
              ? let(centroid=vertex(face,newids))
                [for (j=[0:len(face)-1])           
                 let(a=face[j],
                     b=face[(j+1)%len(face)])    
                  [a,b,centroid]
                ]
              : [face]                              // original face
         ]) 
        )         
  
   poly(name=str("k",p_name(obj)),
       vertices= concat(pv, vertex_values(newv)) , 
       faces=newf
   )
; // end kis

function gyro(obj, ratio=0.3333, height=0.2) = 
// retain original vertices, add face centroids and directed edge points 
//  each N-face becomes N pentagons
    let(pf=p_faces(obj),
        pv=p_vertices(obj),
        pe=p_edges(obj))
    let(newv= 
          concat(
           [for (face=pf)  // centroids
            let(fp=as_points(face,pv))
             [face,centroid(fp) + normal(fp) * height]    // centroid + a bit of normal
           ] ,
           flatten(      //  2 points per edge
              [for (edge = pe)                 
               let (ep = as_points(edge,pv))
                   [ [ edge,  ep[0]+ ratio*(ep[1]-ep[0])],
                     [ reverse(edge),  ep[1]+ ratio*(ep[0]-ep[1])]
                   ]
               ]         
           ) 
          ))
    let(newids=vertex_ids(newv,len(pv)))
    let(newf=
         flatten(                        // new faces are pentagons 
         [for (face=pf)   
             [for (j=[0:len(face)-1])
                let (a=face[j],
                     b=face[(j+1)%len(face)],
                     z=face[(j-1+len(face))%len(face)],
                     eab=vertex([a,b],newids),
                     eza=vertex([z,a],newids),
                     eaz=vertex([a,z],newids),
                     centroid=vertex(face,newids))                   
                [a,eab,centroid,eza,eaz]  
            ]
         ]
       )) 
               
    poly(name=str("g",p_name(obj)),
      vertices=  concat(pv, vertex_values(newv)),
      faces= newf
      )
; // end gyro

            
function meta(obj,height=0.1) =
// each face is replaced with 2n triangles based on edge midpoint and centroid
    let(pe=p_edges(obj),
        pf=p_faces(obj),
        pv=p_vertices(obj))
    let (newv =concat(
           [for (face = pf)               // new centroid vertices
            let (fp=as_points(face,pv))
             [face,centroid(fp) + normal(fp)*height]                                
           ],
           [for (edge=pe)
            let (ep = as_points(edge,pv))
            [edge,(ep[0]+ep[1])/2]
           ]))
     let(newids=vertex_ids(newv,len(pv)))
          
     let(newf =
          flatten(
          [for (face=pf) 
             let(centroid=vertex(face,newids))  
             flatten(
              [for (j=[0:len(face)-1])    //  replace face with 2n triangle 
               let (a=face[j],
                    b=face[(j+1)%len(face)],
                    mid=vertex(distinct_edge([a,b]),newids))
                 [ [ mid, centroid, a],
                    [b,centroid, mid] ]  
                 ] )
         ])
      )   
               
     poly(name=str("m",p_name(obj)),
          vertices= concat(pv,vertex_values(newv)),                
          faces=newf
      ) 
 ; //end meta

function cant(obj,height=0.1) =
// each face is replaced with n quadralaterals based on edge midpoints vertices and centroid moved normally (like ortho)
    let(pe=p_edges(obj),
        pf=p_faces(obj),
        pv=p_vertices(obj))
    let (newv =concat(
           [for (face = pf)               // new centroid vertices
            let (fp=as_points(face,pv))
             [face,centroid(fp) + normal(fp)*height]                                
           ],
           [for (edge=pe)
            let (ep = as_points(edge,pv))
            [edge,(ep[0]+ep[1])/2]
           ]))
     let(newids=vertex_ids(newv,len(pv)))
          
     let(newf =
          flatten(
          [for (face=pf) 
             let(centroid=vertex(face,newids))  
             flatten(
              [for (j=[0:len(face)-1])    //  
               let (a=face[j],
                    b=face[(j+1)%len(face)],
                    c=face[(j+2)%len(face)],
                    mid1=vertex(distinct_edge([a,b]),newids),
                    mid2=vertex(distinct_edge([b,c]),newids)
           
              )
//                 [ [ mid1, centroid, mid2,b] ]
                   [ [ b, mid2, centroid, mid1]]
              ])
           ]))   
               
     poly(name=str("o",p_name(obj)),
          vertices= concat(pv,vertex_values(newv)),                
          faces=newf
      ) 
 ; //end cant

function cc(obj) =
// Catmull-Clark smoothing
// each face is replaced with n quadralaterals based on edge midpoints vertices and centroid
// edge midpoints are average of edge endpoints and adjacent centroids
// original vertices replaced by weighted average of original vertex, face centroids and edge midpoints

    let(pe=p_edges(obj),
        pf=p_faces(obj),
        pv=p_vertices(obj))
    let (newfv =
           [for (face = pf)               // new centroid vertices
            let (fp=as_points(face,pv))
             [face,centroid(fp)]                                
           ])
    let (newev =                          // new edge 'midpoints'
           [for (edge=pe)
            let (ep = as_points(edge,pv),
                 af1 = face_with_edge(edge,pf),
                 af2 = face_with_edge(reverse(edge),pf),
                 fc1 = vertex(af1, newfv),
                 fc2 = vertex(af2, newfv))
             [edge,(ep[0]+ep[1]+fc1+fc2)/4]
           ])
     let(newfvids=vertex_ids(newfv,len(pv)))
     let(newevids=vertex_ids(newev,len(pv)+len(newfv)))
         
     let(newf =
          flatten(
          [for (face=pf) 
             let(centroid=vertex(face,newfvids))  
             flatten(
              [for (j=[0:len(face)-1])    //  
               let (a=face[j],
                    b=face[(j+1)%len(face)],
                    c=face[(j+2)%len(face)],
                    mid1=vertex(distinct_edge([a,b]),newevids),
                    mid2=vertex(distinct_edge([b,c]),newevids)         
              )
                   [[ centroid, mid1,b,mid2]]
              ])
           ]))   
     let(newv =                       // revised original vertices 
         [ for (i = [0:len(pv)-1])
           let (v = pv[i],
                vf = [for (face = vertex_faces(i,pf)) vertex(face,newfv)],
                F = centroid(vf),
                R = centroid([for (edge = vertex_edges(i,pe)) vertex(edge,newev)]),
                n = len(vf))
           ( F + 2* R + (n  - 3 )* v ) / n
         ])         
     poly(name=str("v",p_name(obj)),
          vertices= concat(newv,vertex_values(newfv),vertex_values(newev)),                
          faces=newf
      ) 
 ; //end cc

function rcc(s,n=0) =
// multilevel Catmull-Clark
    n == 0
         ? s
         : rcc(cc(s),n-1)
;            
function pyra(obj,height=0.1) =   
// very like meta but different triangles
    let(pe=p_edges(obj),
        pf=p_faces(obj),
        pv=p_vertices(obj))
    let(newv=concat(
          [for (face = pf)               // new centroid vertices
            let(fp=as_points(face,pv))
            [face,centroid(fp) + normal(fp)*height]                                  
          ],
         [for (edge=pe)               // new midpoints
          let (ep = as_points(edge,pv))
            [edge,(ep[0]+ep[1])/2]
         ]))
     let(newids=vertex_ids(newv,len(pv)))
     let(newf=flatten(
         [ for (face=pf) 
           let(centroid=vertex(face,newids))  
           flatten( [for (j=[0:len(face)-1]) 
             let(a=face[j],
                 b=face[(j+1)%len(face)], 
                 z=face[(j-1+len(face))%len(face)],        
                 midab = vertex(distinct_edge([a,b]),newids),
                 midza = vertex(distinct_edge([z,a]),newids))             
             [[midza,a,midab], [midza,midab,centroid]]         
             ])
          ] ))
              
     poly(name=str("y",p_name(obj)),
          vertices= concat(pv, vertex_values(newv)),
          faces=newf
     )
;   // end pyra 
                                 
function ortho(obj,height=0.2) =  
// very like meta but divided into quadrilaterals
    let (pe=p_edges(obj),
         pf=p_faces(obj),
         pv=p_vertices(obj))

     let(newv=concat(
          [for (face = pf)               // new centroid vertices
            let(fp=as_points(face,pv))
            [face,centroid(fp) + normal(fp)*height]                                  
          ],
         [for (edge=pe)               // new midpoints
          let (ep = as_points(edge,pv))
            [edge,(ep[0]+ep[1])/2]
         ]))
     let(newids=vertex_ids(newv,len(pv)))
     let(newf=
         flatten(
         [ for (face=pf)   
           let(centroid=vertex(face,newids))  
            [for (j=[0:len(face)-1])    
             let(a=face[j],
                 b=face[(j+1)%len(face)],
                 z=face[(j-1+len(face))%len(face)],
                 midab= vertex(distinct_edge([a,b]),newids),
                 midza= vertex(distinct_edge([z,a]),newids))                 
             [centroid,midza,a,midab]                    
                
             ]
          ] ))
      
     poly(name=str("o",p_name(obj)),
          vertices= concat(pv, vertex_values(newv)),
          faces=newf
     )
; // end ortho
       
function trunc(obj,ratio=0.25,fn=[]) =
    let (pv=p_vertices(obj),
         pf=p_faces(obj))
               
    let (newv = 
        flatten(
         [for (i=[0:len(pv)-1]) 
          let(v = pv[i])
          let(vf = vertex_faces(i,pf))
          selected_face(vf,fn)        // should drop the _face 
            ? let(oe = ordered_vertex_edges(i,vf))     
              [for (edge=oe)
               let(opv=pv[edge[1]])
                [edge,  v + (opv - v)*ratio]
              ]
            : [[[i],v]]
         ]))
     let (newids = vertex_ids(newv))   
     let (newf = 
          concat(    // truncated faces
             [for (face=pf)
              flatten(
              [for (j=[0:len(face)-1])
               let (a=face[j])
               let (nv=vertex([a],newids)) 
               nv != undef
               ?  nv   // not truncated, just renumbered
               :  let(b=face[(j+1)%len(face)],
                      z=face[(j-1+len(face))%len(face)],
                      eab=[a,b],
                      eaz=[a,z],
                      vab=vertex(eab,newids),
                      vaz=vertex(eaz,newids))
                 [vaz,vab]
 
              ])
             ],
          [for (i=[0:len(pv)-1])   //  truncated  vertexes
           let(vf = vertex_faces(i,pf))
           if (selected_face(vf,fn))
              let(oe = ordered_vertex_edges(i,vf))     
              [for (edge=oe)
               vertex(edge,newids)
             ]
          ] ) )    

     poly(name=str("t",p_name(obj)),
          vertices= vertex_values(newv),
          faces=newf
         )
; // end trunc



function propellor(obj,ratio=0.333) =
    let (pf=p_faces(obj),
         pv=p_vertices(obj),
         pe=p_edges(obj))
    let(newv=
         flatten(      //  2 points per edge
              [for (edge = pe)                 
               let (ep = as_points(edge,pv))
                   [ [ edge,  ep[0]+ ratio*(ep[1]-ep[0])],
                     [ reverse(edge),  ep[1]+ ratio*(ep[0]-ep[1])]
                   ]
               ]         
           ) 
         )
     let(newids=vertex_ids(newv,len(pv)))
     let(newf=
         concat(    
            [for (face=pf)   // rotated face
               [ for (j=[0:len(face)-1])
                 let( a=face[j],
                      b=face[(j+1)%len(face)],
                      eab=[a,b],
                      vab=vertex(eab,newids))
                 vab
               ]  
            ]
            ,
            flatten(
             [for (face=pf)   
               [for (j=[0:len(face)-1])
                 let (a=face[j],
                      b=face[(j+1)%len(face)],
                      z=face[(j-1+len(face))%len(face)],          
                      eab=vertex([a,b],newids),
                      eba=vertex([b,a],newids),
                      eza=vertex([z,a],newids))   
                 [a,eba,eab,eza]
               ]
             ])            
           )
       )        
     poly(name=str("p",p_name(obj)),
          vertices= concat(pv, vertex_values(newv)),
          faces=newf
     )         
; // end propellor
     
function chamfer(obj,ratio=0.333) =
    let (pf=p_faces(obj),
         pv=p_vertices(obj))  
    let(newv=              
          flatten(         //  face inset
          [for(face=pf)
           let(fp=as_points(face,pv),
               c=centroid(fp))
            [for (j=[0:len(face)-1])
               [[face,face[j]], fp[j] + ratio*(c - fp[j])]
            ]
          ])
        )
            
   let(newids=vertex_ids(newv,len(pv)))
   let(newf =   
         concat(    
            [for (face=pf)      // rotated faces
              [ for (v=face)
                  vertex([face,v],newids)  
              ]  
            ] ,
            flatten(         // chamfered pentagons
             [for (face=pf)   
               [
                 for (j=[0:len(face)-1])
                 let (
                      a=face[j],
                      b=face[(j+1)%len(face)])
                 if(a<b)     // dont duplicate
                 let (edge= [a,b],
                      oppface=face_with_edge([b,a],pf), 
                      oppa=vertex([oppface,a],newids),
                      oppb=vertex([oppface,b],newids),
                      thisa=vertex([face,a],newids),
                      thisb=vertex([face,b],newids))
                      [a,oppa,oppb, b,thisb,thisa]
               ]
             ])            
           ))  
    poly(name=str("c",p_name(obj)),
      vertices=
        concat( 
          [for (v = pv)  (1.0-ratio)*v],             // original        
           vertex_values(newv)
         ),
      faces=newf
    ); 
// end chamfer                   
              
              
function ambo(obj) =
  let (pf=p_faces(obj),
       pv=p_vertices(obj),
       pe=p_edges(obj))
  
          
  let(newv=
       [for (edge = pe)                 
        let (ep = as_points(edge,pv))
            [edge, (ep[0]+ep[1])/2 ] 
        ])
       
  let(newids=vertex_ids(newv))

  let(newf = 
       concat(
         [for (face = pf)
            [for (edge = distinct_face_edges(face))   // old faces become the same with the new vertices
              vertex(edge,newids)
            ]
         ]     
         ,        
        [for (vi = [0:len(pv)-1])        // each old vertex creates a new face, with 
           let (vf= vertex_faces(vi,pf)) // the old edges in left-hand order as vertices
           [for (ve = ordered_vertex_edges(vi,vf))
              vertex(distinct_edge(ve), newids)             
           ]
         ] 
          )) 
           
           
  poly(name=str("a",p_name(obj)),
       vertices = vertex_values(newv),  
       faces =  newf
       )
;// end ambo    
       
function snub(obj,height=0.5) = 
   let(pf=p_faces(obj),   
       pv=p_vertices(obj)  )       
       
   let(newv =
          flatten(
             [for (face = pf)   
              let (r = -90 / len(face),
                  fp = as_points(face,pv),
                  c = centroid(fp),
                  n = normal(fp),
                  m =  m_from(c,n) 
                      * m_rotate([0,0,r]) 
                      * m_translate([0,0,height]) 
                      * m_to(c,n))
               [for (i=[0:len(face)-1]) 
                  [[face,face[i]], m_transform(fp[i],m)]
              ]
            ]))
   
   let(newids=vertex_ids(newv))
   let(newf =
         concat(
             [for (face = pf)   
               [for (v = face) 
                  vertex([face,v],newids)
               ]
              ],
               // vertex faces 
             [for (i=[0:len(pv)-1])   
              let (vf=vertex_faces(i,pf))     // vertex faces in left-hand order 
                 [for (of = ordered_vertex_faces(i,vf))
                   vertex([of,i],newids)
                  ] 
             ]
             ,   //  two edge triangles 
             flatten( 
               [for (face=pf)
                flatten( 
                 [for (edge=ordered_face_edges(face))
                  let (oppface=face_with_edge(reverse(edge),pf),
                        e00=vertex([face,edge[0]],newids),
                        e01=vertex([face,edge[1]],newids),                
                        e10=vertex([oppface,edge[0]],newids),                 
                        e11=vertex([oppface,edge[1]],newids) )
                   if (edge[0]<edge[1])
                      [
                         [e00,e10,e11],
                         [e01,e00,e11]
                      ] 
                   ])
                ])     
          ))      
            
   poly(name=str("s",p_name(obj)),
       vertices= vertex_values(newv),
       faces=newf
       )
; // end snub
   
function expand(obj,height=0.5) =                    
   let(pf=p_faces(obj),           
       pv=p_vertices(obj))        
   let(newv=
           flatten(
            [for (face = pf)     //move the whole face outwards
             let (fp = as_points(face,pv),
                  c = centroid(fp),
                  n = normal(fp),
                  m =  m_from(c,n)
                      *  m_translate([0,0,height]) 
                      * m_to(c,n))
             [for (i=[0:len(face)-1]) 
                  [[face,face[i]], m_transform(fp[i],m)]
             ]
             ]))
   let(newids=vertex_ids(newv))
   let(newf =
          concat(
             [for (face = pf)     // expanded faces
               [for (v = face) 
                  vertex([face,v],newids)
               ]
              ],
                 // vertex faces 
              [for (i=[0:len(pv)-1])   
               let (vf=vertex_faces(i,pf))   
                  [for(of=ordered_vertex_faces(i,vf))
                     vertex([of,i],newids)
                  ]
                 ]
               ,       //edge faces                 
               flatten([for (face=pf)
                  [for (edge=ordered_face_edges(face))
                   let (oppface=face_with_edge(reverse(edge),pf),
                        e00=vertex([face,edge[0]],newids),
                        e01=vertex([face,edge[1]],newids),                 
                        e10=vertex([oppface,edge[0]],newids),                
                        e11=vertex([oppface,edge[1]],newids)) 
                   if (edge[0]<edge[1])   // no duplicates
                      [e00,e10,e11,e01] 
                   ]
                ] )           
              ))
                   
   poly(name=str("e",p_name(obj)),
       vertices= vertex_values(newv),
       faces=newf
      )
         
; // end expand

function rexpand(s,height,n=0) =
// used to round edges 
    n == 0
         ? s
         : rexpand(expand(s,height),height*2,n-1)
;
                   
function whirl(obj, ratio=0.3333, height=0.2) = 
// retain original vertices, add directed edge points  and rotated inset points
//  each edge  becomes 2 hexagons
    let(pf=p_faces(obj),
        pv=p_vertices(obj),
        pe=p_edges(obj))
    let(newv= 
          concat(          
           flatten([for (face=pf)  // centroids
            let (fp=as_points(face,pv))
            let (c = centroid(fp))
            [for (i=[0:len(face)-1])
             let (f = face[i])
             let (ep = [fp[i],fp[(i+1) % len(face)]])
             let (mid =  ep[0]+ ratio*(ep[1]-ep[0])) 
              [[face,f], mid + ratio * (c - mid)]
           ]]) ,
           flatten(      //  2 points per edge
              [for (edge = pe)                 
               let (ep = as_points(edge,pv))
                   [ [ edge,  ep[0]+ ratio*(ep[1]-ep[0])],
                     [ reverse(edge),  ep[1]+ ratio*(ep[0]-ep[1])]
                   ]
               ]         
           ) 
          ))
    let(newids=vertex_ids(newv,len(pv)))
    let(newf=concat(
         flatten(                        // new faces are pentagons 
         [for (face=pf)   
             [for (j=[0:len(face)-1])
                let (a=face[j],
                     b=face[(j+1)%len(face)],
                     c=face[(j+2)%len(face)],
                     eab=vertex([a,b],newids),
                     eba=vertex([b,a],newids),
                     ebc=vertex([b,c],newids),
                     mida=vertex([face,a],newids),                   
                     midb=vertex([face,b],newids))                   
                [eab,eba,b,ebc,midb,mida]  
            ]
         ]
       )
     ,
        [for (face=pf)   
             [for (j=[0:len(face)-1])
                let (a=face[j])
                vertex([face,a],newids)                  
             ]
         ]            
        )) 
               
    poly(name=str("w",p_name(obj)),
      vertices=  concat(pv, vertex_values(newv)),
      faces= newf,
      debug=newv
      )
; // end whirl
             
            
function reflect(obj) =
    poly(name=str("r",p_name(obj)),
        vertices =
          [for (p = p_vertices(obj))
              [p.x,-p.y,p.z]
          ],
        faces=  // reverse the winding order 
          [ for (face =p_faces(obj))
              reverse(face)
          ]
    )
;  // end reflect

function ident(obj) =
          // identity operation 
    obj
;  // end nop 
          
function join(obj) =
    let(name=p_name(obj))
    let(p = dual(ambo(obj)))
    poly(name=str("j",name),
         vertices =p_vertices(p),         
         faces= p_faces(p)
    )
;  // end join 
          
function bevel(obj) =
    let(name=p_name(obj))
    let(p = trunc(ambo(obj)))
    poly(name=str("b",name),
         vertices =p_vertices(p),         
         faces= p_faces(p)
    )
;  // end bevel

function random(obj,offset=0.1) =
    poly(name=str("x",p_name(obj)),
         vertices =
          [for (v = p_vertices(obj))
             v + rands(0,offset,3)
          ],
        faces= p_faces(obj)
     )
; 

function qt(obj) =
// triangulate quadrilateral faces
// use shortest diagonal so triangles are most nearly equilateral
  let (pf=p_faces(obj),
       pv=p_vertices(obj))
           
  poly(name=str("u",p_name(obj)),
       vertices=pv,          
       faces= flatten(
           [for (f = pf)
            len(f) == 4
              ?  norm(f[0]-f[2]) < norm(f[1]-f[3])
                   ? [ [f[0],f[1],f[2]], [f[0],f[2],f[3]] ]  
                   : [ [f[1],f[2],f[3]], [f[1],f[3],f[0]] ]         
              :  [f]
           ])
       )
;// end qt
        
function pt(obj) =
// triangulate pentagonal faces
  let (pf=p_faces(obj),
       pv=p_vertices(obj))
           
  poly(name=str("u",p_name(obj)),
       vertices=pv,          
       faces= flatten(
           [for (f = pf)
            len(f) == 5
              ?  [[f[0],f[1],f[4]], [f[1],f[2],f[4]], [f[4],f[2],f[3]]]
              :  [f]
           ])
       )
;// end pt
                 
function tt(obj) =
// replace triangular faces with 4 triangles  
// requires  all faces to be triangular
  let (pf=p_faces(obj),
       pv=p_vertices(obj),
       pe=p_edges(obj))
  
  let (newv=  // edge mid points 
       [for (edge=pe)
          let (ep = as_points(edge,pv))
             [edge, (ep[0]+ep[1])/2]
        ])
  let(newids=vertex_ids(newv,len(pv)))
  let(newf =
          flatten(
          [for (i =[0:len(pf)-1])
            let(face = pf[i])
            let(innerface = 
                    [vertex(distinct_edge([face[0],face[1]]),newids),
                     vertex(distinct_edge([face[1],face[2]]),newids),
                     vertex(distinct_edge([face[2],face[0]]),newids)
                    ])
           
            concat(
                  [innerface],
                  [for (j=[0:2]) 
                     [face[j],
                      innerface[j],
                      innerface[(j-1 +len(face))%len(face)]
                     ]  
                  ])         
           ]))

  poly(name=str("u",p_name(obj)),
       vertices=
           concat(pv, vertex_values(newv)),  
       faces= newf
       )
;// end tt

function inset_kis(obj,ratio=0.5,height=-0.1, fn=[]) = 
 // as kis but pyramids inset in the face 
    let (pe=p_edges(obj),
         pf=p_faces(obj),
         pv=p_vertices(obj))
     
    let(newv =
         flatten(  
          [for (face = pf)               // new centroid vertices
            let(fp=as_points(face,pv))
            if (selected_face(face,fn))
               let(c=centroid(fp))
               let(ec = c+ normal(fp)*height)     // centroid + a bit of normal  
               concat(  
                      [[face,ec]],      // face centroid
                      [ for (j=[0:len(face)-1])
                         [[face,face[j]], fp[j] + ratio*(c-fp[j])]
                      ]
                     )
           ]))
   let(newids=vertex_ids(newv,len(pv)))
   let(newf =
          flatten([for (i = [0:len(pf)-1])   
            let(face = pf[i])
            selected_face(face,fn)
              ? flatten(
                 [for (j=[0:len(face)-1])   //  replace face with n quads and n triangles 
                  let (a=face[j],
                       centroid=vertex(face,newids),
                       mida=vertex([face,a],newids),
                       b=face[(j+1)%len(face)],
                       midb=vertex([face,b],newids)) 
                   [ [a,b,midb,mida]  ,   [centroid,mida,midb] ]         
                 ] )
              : [ face ]
         ] ))       
   
    poly(name=str("x",p_name(obj)),
      vertices=  concat(pv, vertex_values(newv)) ,
      faces= newf
    )
;   // end inset_kis
               
function transform(obj,matrix) =
   poly(
       name=str("T",p_name(obj)),
       vertices=transform_points(p_vertices(obj),matrix),
       faces=p_faces(obj));

function place(obj,face_i) =
// on largest face for printing
   let (face= face_i == undef ? max_area(face_areas_index(obj)) : p_faces(obj)[face_i])
   let (points =as_points(face,p_vertices(obj)))
   let (n = normal(points), c=centroid(points))
   let (m=m_from(c,-n))
   transform(obj,m)
;

function orient(obj) =
// ensure faces have lhs order
    poly(name=str("O",p_name(obj)),
         vertices= p_vertices(obj),
         faces = lhs_faces(p_faces(obj),p_vertices(obj))
    );
 
function invert(obj,p) =
// invert vertices 
    poly(name=str("I",p_name(obj)),
         vertices= 
            [ for (v =p_vertices(obj))
              let (n=norm(v))
              v /  pow(n,p)  
            ],
         faces = p_faces(obj)
    );

function shell(obj,outer_inset_ratio=0.2, outer_inset, inner_inset_ratio, inner_inset,thickness=0.2,fn=[],min_edge_length=0.01,nocut=0) = 
// upper and lower inset can be specified by ratio or absolute distance
   let(inner_inset_ratio= inner_inset_ratio == undef ? outer_inset_ratio : inner_inset_ratio,
       pf=p_faces(obj),           
       pv=p_vertices(obj))
   let(inv=   // corresponding points on inner surface
       [for (i =[0:len(pv)-1])
        let(v = pv[i])
        let(norms =
            [for (f=vertex_faces(i,pf))
             let (fp=as_points(f,pv))
                normal(fp)
            ])
        let(av_norm = -vsum(norms)/len(norms))
            v + thickness*unitv(av_norm)
        ])
                 
   let (newv =   
 // the inset points on outer and inner surfaces
 // outer inset points keyed by face, v, inner points by face,-v-1
         flatten(
           [ for (face = pf)
             if(selected_face(face,fn)
                && min_edge_length(face,pv) > min_edge_length)
                 let(fp=as_points(face,pv),
                     ofp=as_points(face,inv),
                     c=centroid(fp),
                     oc=centroid(ofp))
                 flatten(
                    [for (i=[0:len(face)-1])
                     let(v=face[i],
                         p = fp[i],
                         p1= fp[(i+1)%len(face)],
                         p0=fp[(i-1 + len(face))%len(face)],
                         sa = angle_between(p0-p,p1-p),
                         bv = (unitv(p1-p)+unitv(p0-p))/2,
                         op= ofp[i],
                         ip = outer_inset ==  undef 
                             ? p + (c-p)*outer_inset_ratio 
                             : p + outer_inset/sin(sa) * bv ,
                         oip = inner_inset == undef 
                             ? op + (oc-op)*inner_inset_ratio 
                             : op + inner_inset/sin(sa) * bv)
                     [ [[face,v],ip],[[face,-v-1],oip]]
                    ])
             ])          
           )
   let(newids=vertex_ids(newv,2*len(pv)))
   let(newf =
         flatten(
          [ for (i = [0:len(pf)-1])   
            let(face = pf[i])
            flatten(
              selected_face(face,fn)
                && min_edge_length(face,pv) > min_edge_length
                && i  >= nocut    
              
                ? [for (j=[0:len(face)-1])   //  replace N-face with 3*N quads 
                  let (a=face[j],
                       inseta = vertex([face,a],newids),
                       oinseta= vertex([face,-a-1],newids),
                       b=face[(j+1)%len(face)],
                       insetb= vertex([face,b],newids),
                       oinsetb=vertex([face,-b-1],newids),
                       oa=len(pv) + a,
                       ob=len(pv) + b) 
                  
                     [
                       [a,b,insetb,inseta]  // outer face
                      ,[inseta,insetb,oinsetb,oinseta]  //wall
                      ,[oa,oinseta,oinsetb,ob]  // inner face
                     ] 
                   ] 
                :  [[face],  //outer face
                    [reverse([  //inner face
                           for (j=[0:len(face)-1])
                           len(pv) +face[j]
                         ])
                    ]
                   ]    
               )
         ] ))    
                           
   poly(name=str("S",p_name(obj)),
       vertices=  concat(pv, inv, vertex_values(newv)) ,    
       faces= newf,
       debug=newv       
       )
; // end shell  

module p_render_text(obj,texts,font,depth,offset,size) {
    
/*
    obj is a polyhedron object created as a conway seed or chain of operation
    texts is an array of strings to be placed on the faces of s
    fint is the definition of the fint used by text()
    depth is the depth of the incised text
    offset is the offset of the strings to control the horizontal alignment
    size is the size of the text - because the defualt solid is about 1 mm in 
        size, and the default font size is 10, this needs to be quite small.
    
   e.g. 
    scale(20) p_render_text(place(O()),["1","2","3","4","5","6","7","8"],"Georgia",0.8,4,0.06);
    
    creates an octahedron with the numbers 1 to 8 on the faces
*/
    
 difference() {
       p_render(obj,faces=true);
       for (i =[0:len(texts)-1])  {
           face=p_faces(obj)[i];
           facep = as_points(face,p_vertices(obj));
           center=centroid(facep);
           normal=normal(facep);
           echo(i,face,facep,center,normal,texts[i]);
           orient_to(center,normal)
               scale(size) rotate([0,0,90])
                   translate([-offset,0,-depth])
                     linear_extrude(height=depth+0.1)
                        text(texts[i],valign="center", font=font);
       }
     }
 }  // end of p_render_text
   

// modulation  
                           
function modulate_points(points) =
   [for(p=points)
       let(s=xyz_to_spherical(p),
           fs=fmod(s[0],s[1],s[2]))
       spherical_to_xyz(fs[0],fs[1],fs[2])
   ];

function xyz_to_spherical(p) =
    [ norm(p), acos(p.z/ norm(p)), atan2(p.x,p.y)] ;

function spherical_to_xyz(r,theta,phi) =
    [ r * sin(theta) * cos(phi),
      r * sin(theta) * sin(phi),
      r * cos(theta)];

function fstar(r,theta,phi)=
      [r*(1.0 + 0.5*pow((cos(3*phi)),2)), theta ,phi];  
   
function fegg(r,theta,phi) = 
     [r*(1.0+ 0.5*pow(1.1*(cos(1*theta)),3)), theta,phi];

function fberry(r,theta,phi) =
     [r*(1.0 - 0.5*pow(0.8*(cos(theta+60)),2)),theta,phi];       

function fcushion(r,theta,phi) =
     [r*(1.0 - 0.5*pow(0.9*cos(theta),2)), theta, phi];
          
function fbauble(r,theta,phi) = 
     [r*(1- 0.5*sin(theta*2) + 0.1* sin(theta)*sqrt(abs(cos(theta*2))))
          / (sin(theta)), theta,phi] ;

function fellipsoid(r,theta,phi,e) = [r*(1.0+pow(e*cos(theta),2)),theta,phi] ;
  
function fsuperegg(r,theta,phi,n,e=1) =
       [ r* (pow(
               pow(abs(cos(theta)),n) 
           + e*pow(abs(sin(theta)),n)
            ,-1/n))
         ,theta,phi];
         
function fsupersuperegg(r,theta,phi,nt,et=1,np=2,ep=1) =
       [ r* (pow(
               pow(abs(cos(theta)),nt) 
           + et*pow(abs(sin(theta)),nt)
            ,-1/nt))
            
         * (pow(
               pow(abs(cos(phi)),np) 
           + ep*pow(abs(sin(phi)),np)
            ,-1/np))
         ,theta,phi];
 
function modulate(obj) =
    poly(name=str("S",p_name(obj)),
         vertices=modulate_points(p_vertices(obj)),         
         faces= 
          [ for (face =p_faces(obj))
              reverse(face)
          ]
    )
;  // end modulate

// object trimming

module ground(z=200) {
   translate([0,0,-z]) cube(z*2,center=true);
} 

module sky(z=200) {
   rotate([0,180,0]) ground(z);
}

/*
//  superegg_tktI  - Goldberg (3,3)  
function fmod(r,theta,phi) = fsuperegg(r,theta,phi,2.5,1.3333);
s= modulate(plane(trunc(plane(kis(trunc(I()))))));
echo(p_description(s));                    
t=shell(s,thickness=0.15,outer_inset_ratio=0.35,inner_inset_ratio=0.2,fn=[6]);              
scale(20)  p_render(t,false,false,true);

*/

/*
s=shell(plane(trunc(plane(kis(plane(trunc(D())), fn=[10])), fn=[10])));
// s=trunc(plane(kis(T)),fn=[3]);
p_describe(s);
scale(10) p_render(s,false,false,true);
*/

/*
s=place(canon(plane(propellor(D()),10),10));
p_describe(s);
scale(20) p_render(shell(s,outer_inset=0.15,fn=[],thickness=0.2));

*/

/*
s=plane(whirl(plane(trunc(I()))));
p_print(s);
scale(10) p_render(shell(s,fn=[6]),false,false,true);


*/
/*
s=transform(plane(chamfer(plane(chamfer(D())))),m_translate([0,0,0.3])*m_scale([1,1.5,2]));
t=shell(s,fn=[0]);
p_print(t);
scale(20) difference() {
    translate([0,0,-0.5]) p_render(t,false,false,true,re=0.08,rv=0.08);
    ground();
}
*/
/*
rd = plane(join(C())); // rhombic dodecahedron
di = plane(ortho(C())); // deltoid icositetrahedron
c=C();
p_print(rd);
p_print(di);
intersection() {
color("green") scale(30) rotate([0,45,0]) p_render(rd);
color("red") scale(31) p_render(di);
color("yellow") scale(60) p_render(c);
}

*/
/*
r=0.8;
scale(20)
intersection() {
  p_render(C());
  scale(r) p_render(plane(meta(C())));  

}
*/
/*
intersection(){
   color("red") scale([0.8,0.8,3]) p_render(C());
   color("green") rotate([0,0,45]) scale([2,2,1.2])  p_render(O());
   color("blue") rotate([0,0,45]) scale([1.1,1.1,1.8])  p_render(O());
}
*/

/*
// http://www.smorf.nl/index.php?crystal=Moschellandsbergite_D1

r1=0.65;
r2=0.6;
r3=0.55;
scale(20)
intersection() {
 color("red")   scale(r1) p_render(C());
 color("green") scale(r2) p_render(plane(join(C())));  
 color("blue")  scale(r3) p_render(plane(ortho(C())));  
}
*/
      
k=0.4;
$fn=20;
// scale(20) p_render_text(place(O()),["1","2","3","4","5","6","7","8"],"Georgia",0.8,4,0.06);
// s=plane(cc(kis(C(),height=0.5)));
//s=plane(ortho(C()));
//s=plane(cc(C()));
// s=cc(cc(cc(shell(C()))));
s=(cc(C()));
//p_print(s);
 scale(20) p_render(s,show_edges=true,show_faces=true,re=0.02);
