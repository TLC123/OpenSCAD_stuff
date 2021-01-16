use <../libraries/lists.scad>

////////////////////////////////////////////////////////////////
//
//  lines.scad
//
//          by Ronaldo Persiano
//
//  This library contains graphic utilities for drawing lines, grids and meshes.
//  Except for modules multi_mesh and mesh_volume, all modules are intended for
//  debugging geometric constructions and are recommended to be used just 
//  in preview mode due to the long time they will usually require to render.
//
//  Lines are simulated by thin cylinders. Dots by small cubes. Polylines and grids are drawn 
//  as a set of lines. Meshes and multi meshes are drawn by the polyhedron primitives.
//  A mesh is a bi-dimensional matrix of 3D points, possibly representing a surface.
//  A grid is a array of segments conecting adjacent points of a mesh.
//
//  multi_mesh is the main modeling module. It allows that a solid be built from a list
//  of meshes and a list of faces. If the surfaces defined by the lists close a solid,
//  and have no intersection among them, the polyhedron created will be a manifold. 
//  All faces are triangulated. No self-intersection is checked
//
//////////////////////////////////////////////////////////////////////


// Draw a sequence of small cubes at the points in the list 'pts'

module polydots(pts, t=1)
    if(len(pts)>0 && (0*pts[0]==[0,0,0]) && t>0)
        for(p=pts)
            translate(project_to_3D(p))
                cube(t, center=true);
    else 
        module_msg("<br>Improper list of points or line thickness","module polydots", type=0);

// Draw a sequence of line segments joining the points in the list 'pts'
//    p         - list of the polygonal points
//    t         - the thickness of the line segments
//    closed    - when true, join the last point to the first

module polyline(pts, t=1, closed=false) {
    if(len(pts)>1 && (0*pts[0]==[0,0,0]) && t>0) {
            p  = concat([for(ptsi=pts) project_to_3D(ptsi)], 
                        closed? [project_to_3D(pts[0])] : []);
            for(i=[0:len(p)-2]) {
                h = norm(p[i+1]-p[i])+1e-12; // to avoid division by zero
                translate(p[i+1])
                    mirror([0,0,1]+(p[i+1]-p[i])/h)
                        cylinder(d=t,h=h, $fn=4);
            }
     } else 
        module_msg("<br>Improper list of points or line thickness","module polyline", type=0);
}


// 'grid' allows the visualization of a grid which is represented by a series of
// line segments between adjacent points of a mesh. 
//    mesh  - a mesh, that is a rectangular matrix of 3D points
//    t     - the thickness of the line segments of the grid
// When c=true, for visual reference, the grid is drawn with the colors:
//      red     for the first line of matrix mesh
//      green   for the first column of matrix mesh
//      blue    for the last line of matrix mesh
//      yellow  for the remaining lines

module grid(mesh, t=undef, c=false) {
    
    n = len(mesh)    != 0 ? len(mesh) : 0 ;
    m = len(mesh[0]) != 0 ? len(mesh[0]) : 0 ;
    l = n*m;

    if(l > 0 && 0*mesh[0][0]==[0,0,0] ) {
    // choose a "reasonable" value for the line thickness when not defined
        t0 = t==undef? 
                 0.1*norm( mesh[0][0] - mesh[n-1][m-1] )/(n+m) : 
                 t;
        t1 = (t0<1e-3) && (t==undef) ? 1e-3 : t0;

        for(i=[0:n-1]) polyline(mesh[i], t=t1);
        for(i=[0:n-1], j=[0:m-1]) 
          line(mesh[i][j], mesh[i+1][j], t=t1);
        if(c) {
            color("red")   polyline(mesh[0], t=2*t1);
            color("green") polyline([ for(m=mesh) m[0] ], t=2*t1);
            color("blue")  polyline(mesh[n-1], t=2*t1);
        }
    } else 
        module_msg("<br>Improper mesh", "module grid", type=0);
}

// Draw a surface (not a solid) or a surface with thickness t, when t > 0.1 (possibly a solid)
// representing the 'mesh' which is a bi-dimensional matrix of 3D points. 
// All facets are triangulated. No self-intersection is checked

module mesh(mesh, t=undef, c=false) {

function unit_cross(v1,v2) = 
    norm(cross(v1,v2))<1e-12? [0,0,0] : cross(v1,v2)/norm(cross(v1,v2));

    n = len(mesh) != 0 ? len(mesh) : 0 ;
    m = n==0 ? 0 : len(mesh[0]) != 0 ? len(mesh[0]) : 0 ; 
    l = n*m;
    
    if( l > 0 && 0*mesh[0][0]==[0,0,0] ) {
        topverts = [ for(line=mesh) for(pt=line) pt ];

        bottverts = (t>0.1)?
                      [ let(p = topverts) for(i=[0:l-1])
                        (i<l-m)? // it is not the last row?
                         
                           (i+1)%m!=0? // it is not the last element in the row?
                              p[i] + t*unit_cross(p[i+1]-p[i], p[i+m]-p[i]) : // yes
                              p[i] + t*unit_cross(p[i]-p[i-1], p[i+m]-p[i]) : // no
                         
                           (i+1)%m!=0? // it is not the last element in the last row?
                              p[i] + t*unit_cross(p[i+1]-p[i], p[i]-p[i-m]) :
                              p[i] + t*unit_cross(p[i]-p[i-1], p[i]-p[i-m]) 
                      ] :
                      [];
           
        top    = concat(    [ for(i=[0:n-2], j=[0:m-2]) 
                                [ i*m+j, i*m+j+1, (i+1)*m+j ] ] ,
                            [ for(i=[0:n-2], j=[0:m-2]) 
                                [ i*m+j+1, (i+1)*m+j+1, (i+1)*m+j ] ] 
                        );
                   
        bottom = (t>0.1)? [ for(f=top) [ f[2]+l, f[1]+l, f[0]+l ] ] : [];  
                    
        sides  = (t>0.1)?
                      concat(  
                        [ for(i=[0:m-2])       [   i+1,    i,  i+l ] ]  , 
                        [ for(i=[0:m-2])       [ i+l+1,  i+1,  i+l ] ]  , 
                        [ for(i=[m*(n-1):l-2]) [     i,  i+1,  i+l ] ]  , 
                        [ for(i=[m*(n-1):l-2]) [ i+l+1,  i+l,  i+1 ] ]  ,             
                        [ for(i=[m-1:m:l-2])   [ i+l+m,    i,  i+l ] ]  ,
                        [ for(i=[m-1:m:l-3])   [ i+l+m,  i+m,    i ] ]  ,
                        [ for(i=[l-2*m-1:-m:-0.1]) [ i+l+m+1,  i+l+1,    i+1 ] ] ,
                        [ for(i=[l-2*m-1:-m:-0.1]) [ i+l+m+1,    i+1,  i+m+1 ] ] ,
                        [   [ l+m, l, 0 ] , [ l+m,  0,    m ] ]
                          ) :
                      [] ;
                      
        vertices = concat(topverts, bottverts);
        faces    = concat(top, bottom, sides);

        polyhedron(
        points = vertices,
        faces  = faces,
        convexity = 10
        ); 
        if(c) {
            t0 = t==undef? 
                     0.1*norm( mesh[0][0] - mesh[n-1][m-1] )/(n+m) : 
                     t;
            t1 = (t0<1e-3) && (t==undef) ? 1e-3 : t0;
            color("red")   polyline(mesh[0], t=2*t1);
            color("green") polyline([ for(m=mesh) m[0] ], t=2*t1);
            color("blue")  polyline(mesh[n-1], t=2*t1);
        }

    } else 
        module_msg("<br>Improper mesh", "module mesh", type=0);
}

// Draw the volume bounded by the surface represented by 'mesh' and 
// by the plane XY; the mesh is supposed to have points with positive z,
// otherwise a non-manifold is generated. No self-intersection is checked

module mesh_volume(mesh) {
  
  function projectXY(p) = [ p[0], p[1], 0 ];

  n = len(mesh) > 0 ? len(mesh) : 0 ;
  m = n==0 ? 0 : len(mesh[0]) != 0 ? len(mesh[0]) : 0 ;
  l = n*m; 
  
  if (l > 0 && 0*mesh[0][0]==[0,0,0] ) {
      mesh0 = cross(mesh[0][len(mesh[0])-1]-mesh[0][0],mesh[len(mesh)-1][0]-mesh[0][0])[2]<0 ? 
                    transpose(mesh): mesh;
  
      topverts = [ for(line=mesh0) for(pt=line) pt ];
      // projections of the surface boundary curves on xy plane
      prcurveu0  = [ for(i=[0:m-2]) projectXY(topverts    [i] ) ];
      prcurve1v  = [ for(i=[0:n-2]) projectXY(topverts [(i+1)*m-1]) ];
      prcurveu1  = [ for(i=[0:m-2]) projectXY(topverts [l-i-1]) ];
      prcurve0v  = [ for(i=[0:n-2]) projectXY(topverts [(n-i-1)*m]) ];
      baseverts  = concat(prcurveu0,prcurve1v,prcurveu1,prcurve0v);

      // indices of the surface boundary projected points
      curveu0  = [ for(i=[0:n-2])  i + l ];
      curve1v  = [ for(i=[0:m-2])  i + n-1 + l ];
      curveu1  = [ for(i=[0:n-2])  i + n-1 + m-1 + l ];
      curve0v  = [ for(i=[0:m-2])  i + 2*(n-1) + m-1 + l ]; 

      top    = concat( 
                  [ for(i=[0:n-2], j=[0:m-2]) [   i*m+j, (i+1)*m+j,     i*m+j+1 ] ] ,
                  [ for(i=[0:n-2], j=[0:m-2]) [ i*m+j+1, (i+1)*m+j, (i+1)*m+j+1 ] ]
                   ); 
      bottom =  [concat(curveu0,curve1v,curveu1,curve0v)];

      sides  = concat(  
                  [ for(i=[0:m-2])  [         i,         i+1,     i+l     ] ], 
                  [ for(i=[0:m-2])  [       i+l,         i+1,    i+l+1    ] ], 
               
                  [ for(i=[0:n-2])  [ (i+2)*m-1,     l+m-1+i,   (i+1)*m-1 ] ], 
                  [ for(i=[0:n-2])  [ (i+2)*m-1,       l+m+i,   l+m-1+i   ] ],

                  [ for(i=[0:m-2])  [ l+m+n-1+i,       l-1-i,       l-2-i ] ],
                  [ for(i=[0:m-2])  [ l+m+n-2+i,       l-1-i,   l+m+n-1+i ] ],

                  [ for(i=[0:n-2])  [ l+2*m+n-3+i, (n-i-1)*m,  (n-i-2)*m  ] ],
                  [ for(i=[0:n-3])  [ l+2*m+n-3+i, (n-i-2)*m, l+2*m+n-2+i ] ],
                    
                  [                 [           0,         l, l+2*(m+n)-5 ] ]

                  );
      vertices = concat(topverts  , baseverts);
      faces    = concat(top, bottom, sides);
      
      polyhedron(
        points = vertices,
        faces  = faces,
        convexity = 10
      );
  }  else 
        module_msg("<br>Improper mesh", "module mesh_volume", type=0);        
}

// multi_grid allows the visualization of the grids of a list of meshes
//      meshes    - a list of meshes, that is a list of rectangular matrix of 3D points
//      t         - the thickness of the line segments of the grid
// When c=true, for visual reference, the grids are drawn with the colors:
//      red     for the first line of matrix mesh
//      green   for the first column of matrix mesh
//      blue    for the last line of matrix mesh
//      yellow  for the remaining lines

module multi_grid(meshes, t=undef, c=false) {
    n = len(meshes) != 0 ? len(meshes) : 0 ;
    if( (n>0) && (len(meshes[0]) != 0) && 0*mesh[0][0]==[0,0,0] ) 
        for(m=meshes) grid(m, t, c);
    else 
        module_msg("<br>Improper mesh", "module multi_grid", type=0);        
}

//  multi_mesh is the main modelling module. It allows that a solid be built from a list
//  of meshes and a list of faces. If the surfaces defined by the lists close a solid, 
//  and have no intersection between them, the polyhedron created will be a manifold. 
//  Each mesh is a bi-dimensional matrix of 3D points. Faces are simple lists of 3D points.
//  The meshes are decomposed in a set of quads. The faces should be a simple polygon
//  when projected in the plane that best fit their vertices otherwise they are ignored.
//  Warning messages are issued for each discarded face. No self-intersection is checked.
//
//    meshes    - a list of meshes
//    faces     - a list of faces
//    inv_meshes- a list of numbers with length at least equal to 'meshes' length. If a non-positive
//                value is found in the i-th element of the list, the corresponding mesh will
//                have the orientation of its faces reversed. If the list is omitted, no revertion
//                is done. It is optional and used just when thrown together shows a bad orientation.
//    inv_faces - the same as inv_mesh for the list of faces
//    id        - an optional integer or string to identify the multi_mesh call in the warning 
//                and info messages; if id is undefined, no message is issued

module multi_mesh(meshes=[], faces=[], inv_meshes=undef, inv_faces=undef, id) {

    // helper functions
    function all_mesh_vertices(meshes) = 
                [ for(mesh=meshes, line=mesh, pt=line) pt ];
    // collect the triangular faces of a mesh, index the faces from tot,
    function mesh_faces(mesh, inv, tot) = // inv defines the face orientations
        let( n = len(mesh), m = len(mesh[0]) ) 
        inv > 0?                               
        concat( [ for(i=[0:n-2]) for(j=[0:m-2]) 
                   [ tot+i*m+j  , tot+i*m+j+1, tot+(i+1)*m+j ] ] ,
                [ for(i=[0:n-2]) for(j=[0:m-2]) 
                   [ tot+(i+1)*m+j+1, tot+(i+1)*m+j  , tot+i*m+j+1 ] ]
              ):                            // revert all faces
        concat( [ for(i=[0:n-2]) for(j=[0:m-2]) 
                   [ tot+i*m+j+1, tot+i*m+j  , tot+(i+1)*m+j ] ] ,
                [ for(i=[0:n-2]) for(j=[0:m-2]) 
                   [ tot+(i+1)*m+j  , tot+(i+1)*m+j+1, tot+i*m+j+1 ] ]
              ) ;
    // collect the triangular faces of all meshes starting at ind 
    // indexing the vertices from tot 
    function all_mesh_faces(meshes) = 
        let( n = len(meshes),
             tot = concat([0], accum_sum([for(msh=meshes) len(msh)*len(msh[0]) ])) )
        [ for(ind=[0:n-1], fac=mesh_faces(meshes[ind], inv_m[ind], tot[ind])) fac ];

/* recursive version of all_mesh_faces
    function all_mesh_faces(meshes, ind=0, tot=0) = 
        ind > len(meshes)-1 ? [] : // indexing the vertices from tot 
            // n is total mesh vertices  
            let( n = len(meshes[ind])*len(meshes[ind][0] ) ) 
            concat( mesh_faces(meshes[ind], inv_m[ind], tot),
                    all_mesh_faces(meshes, ind+1, tot+n) ); 
*/

    // list of partial accumulated sum of lists f
    function acc_len( f ) = 
        concat([0], accum_sum([ for(fi=f) len(fi) ]));

    // process meshes
    nmsh  = len(meshes) != 0 ? len(meshes)  : 0 ;
    inv_m = (nmsh == 0)? []: (inv_meshes !=undef) ? inv_meshes  : [ for(f= meshes)  1 ];
    mesh_vertices = nmsh == 0 ? [] : all_mesh_vertices(meshes);
    mesh_facets   = nmsh == 0 ? [] : all_mesh_faces(meshes);
    nvert_mesh    = len(mesh_vertices);

    // process faces
    nfac  = len(faces) != 0 ? len(faces) : 0 ;
    if( nfac > 0 ) {
        inv_f = (inv_faces!=undef) ? inv_faces : [ for(f=faces) 1 ];
        // discard faces with high len to avoid later (quicksort) stack overflow
        small_faces = [ for(face=faces) len(face) <= 3000 ? face : [] ] ; 
        // remove null edges from the small faces
        ma_faces  = [ for( face=small_faces ) len(face) > 0 ? remove_null_segments(face, 1e-6) : [] ] ;
        // remove degenerated faces
        mb_faces  = [ for( face=ma_faces ) len(face) > 2 ? face : [] ] ;
        // 2D projected faces for triangulation
        prj_faces = [ for( face=mb_faces ) len(face) > 0 ? project_poly(face) : [] ];
        // discard 2D faces which are not simple polygons
        smp_faces = [ for( face=prj_faces ) (len(face) > 0) && is_simple_polygon(face) ? face : [] ];
        // collect valid faces
        vld_faces = [ for(face=smp_faces) if( len(face) > 0 ) face ];
        // and valid original 3D faces
        org_faces = [ for(i=[0:nfac-1]) if( len(smp_faces[i]) > 0 ) mb_faces[i] ];
        // collect the inverse flag of valid faces
        vld_inv   = [ for(i=[0:nfac-1]) if( len(smp_faces[i]) > 0 ) inv_f[i] ] ;
        // triangulate valid faces; triangulation is indexed !
        tri_faces = [ for(face=vld_faces) triangulate(face) ];

        // collect the valid face vertices
        face_vertices = [ for(ptlist=org_faces) for(pt=ptlist) pt ]; 
        // offsets of vertex indices for each valid face
        // nvert_faces[i] is the total vertex count of faces previous 
        // to vld_faces[i] 
        nvert_faces = acc_len(vld_faces); 
        
        // collect the triangular faces of valid user faces
        // referring their vertices to the list face_vertices
        face_triangles  = 
           len(vld_faces)==0 ? [] :
           [ for(i=[0:len(vld_faces)-1]) // for each valid face i
                for(tri=tri_faces[i])    // for each triangle of face i
                   let( offset = nvert_mesh + nvert_faces[i] )
                   vld_inv[i] > 0 ?      // apply offset to indexing
                      [ tri[0] + offset, tri[1] + offset, tri[2] + offset ] :
                      [ tri[0] + offset, tri[2] + offset, tri[1] + offset ]
           ];

        poly_points = concat(mesh_vertices, face_vertices) ;
        poly_faces  = concat(mesh_facets,   face_triangles) ;
        polyhedron(
            points = poly_points,
            faces  = poly_faces,
            convexity = 10
        );
        if(id!=undef) {
            module_msg(str("<br>Number of vertices = ", len(poly_points), 
                           "<br>Number of triangular facets = ", len(poly_faces),
                           "<br>Number of meshes = ", len(meshes) ,
                           "<br>Number of faces = ", len(vld_faces)), 
                       str("multi_mesh id=",id), type=1);


        // report errors and warnings
            for(i=[0:nfac-1]) {
                if(len(small_faces[i])==0 && len(faces[i]) > 0)
                    module_msg( "rejected face with more than 3000 vertices", 
                                str("multi_mesh id=",id), data=i);  
                if( len(faces[i]) == 0 )
                    module_msg("void face", str("multi_mesh id=",id), data=i);  
                if( len(ma_faces[i]) > 0 && len(mb_faces[i]) == 0 )
                    module_msg("rejected degenerated face", str("multi_mesh id=",id), data=i);  
                if( len(prj_faces[i]) == 0 && len(mb_faces[i]) > 0 )
                    module_msg("rejected non-planar face", str("multi_mesh id=",id), data=i);  
                if( len(smp_faces[i])==0 && len(prj_faces[i]) > 0 )
                    module_msg("rejected face, not a simple polygon", str("multi_mesh id=",id),  data=i);  
            }
            if(poly_faces==[]) {
                module_msg("nothing to display", str("multi_mesh id=",id));
            }
        }
    }
    else if( nmsh > 0 && 0*meshes[0][0][0]==[0,0,0] ) { 
        polyhedron(
            points = mesh_vertices,
            faces  = mesh_facets,
            convexity = 10
        );
        if(id!=undef) 
            if(mesh_facets==[] || mesh_vertices==[]) 
                module_msg("nothing to display", str("multi_mesh id=",id));
            else {
                module_msg(str("<br>Number of vertices = ", len(mesh_vertices),
                               "<br>Number of triangular facets = ", len(mesh_facets),
                           "<br>Number of meshes = ", len(meshes) ,
                           "<br>Number of faces = ", 0), 
                           str("multi_mesh id=",id), type=1);
        }
    } else
        module_msg("<br>Improper meshes/faces", "module multi_mesh", type=0);        
}

// Helper functions

function project_to_3D(p) = 
    len(p)>=3? [p[0], p[1], p[2]] : len(p)==2 ? [p[0], p[1], 0] : undef;

// A simple messager
module module_msg(msg, caller, data=undef, type=0) {
    if (type==0) // Warning/error
        echo(str("<br><font  style='background-color:rgb(255,130,130);'> WARNING: ", caller, " \> ",   msg, data==undef? "</font><br>": str(": ", data ,"</font><br>") ) ) ;
    else // Info
        echo(str("<br><font  style='background-color:rgb(255, 255, 153);'> INFO: ", caller, " \> ",   msg, data==undef? "</font><br>": str(": ", data ,"</font><br>") ) );  
}

// Deprecated versions. Use polyline instead

// Draw a line between the given points. Lines are emulated by thin cylinders 
// with 4 side faces.
//    p0, p1    - 3D points, the extremes of the segment
//    t         - thickness of the line
//    dots      - when true, draw small cubes just at the point p0 and ignores p1

module line(p0, p1, t=1, thickness, dots=false) {
  
  function project_to_3D(p) = 
        len(p)>=3? [p[0], p[1], p[2]] : len(p)==2? [p[0], p[1], 0] : undef;
  
  function unit(v) = v/norm(v);

  function rotate_Z_to(t) = 
      let( t2 = unit(t),
           v2 = t2 + [0,0,1],
           d  = v2 * v2,
           d2 = d<1e-6? 1: d,
           r2 = unit([1,0,0] - (2/d2) * v2[0] * v2) , 
           c2 = unit(cross(r2, t2)))
     [ [r2[0], c2[0], t2[0], 0],
       [r2[1], c2[1], t2[1], 0],
       [r2[2], c2[2], t2[2], 0],
       [   0,      0,     0, 1] ];  

  th = (thickness==undef ? t: thickness);
  if (dots) { // draw just at p0
    translate(project_to_3D(p0))
      cube(th, center=true);
  } else { 
    p = project_to_3D(p0);
    v = project_to_3D(p1-p0);
    if (norm(v) > 1e-3) {
      translate(p)
        multmatrix(rotate_Z_to(v))
            cylinder(d=th, h=norm(v), $fn=4);
    }
  }
}


