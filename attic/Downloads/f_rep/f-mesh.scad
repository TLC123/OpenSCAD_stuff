use <lists.scad>
use <lines3.scad>
use <voxel_base.scad>
include <F-rep_API_2.1.a.scad>

////////////////////////////////////////////////////////////
// A collection of functions and modules to provide
// the evaluation of the field in a regular rectangle grid
// and to polygonalize the f-rep surface based on the mesh
////////////////////////////////////////////////////////////

//////////////////////////
// f_mesh polygon collect
//////////////////////////

       
// This function generates a regular trivariate mesh discretizing
// the space and evaluating the f_rep tree on each mesh point. 
// This mesh may be used to generate a polyhedron 
// approximating the solid defined by the f_rep tree.
// The arguments of the function are:
//      f_rep - the f_rep tree to evaluate
//      bbox  - bounding box of mesh: [[xmin,ymin,zmin],[xmax,ymax,zmax]]
//      prec  - level of refinement of the mesh, 0<=prec<=1
//      surf  - if true, doesn't include the bounding half-spaces
//                  of the bounding box and it may not be a manifold
//
function f_mesh_evaluation(f_rep, bbox, prec=undef, surf=false) = 
    !is_frep(f_rep) ? 
        undef :
    let( p0 = bbox[0],
         p1 = bbox[1],
         dx = p1[0]-p0[0],
         dy = p1[1]-p0[1],
         dz = p1[2]-p0[2],
         d  = max(dx, dy, dz),
         n  = prec==undef ?
                20 :
                abs(prec)>= 1? 
                    102 : 
                    ceil(10/(1.1-abs(prec))+2),
         sx = dx / ceil(n*dx/d),
         sy = dy / ceil(n*dy/d),
         sz = dz / ceil(n*dz/d)
       )
    [ [ p0, dx, dy, dz, sx, sy, sz ] ,
      [ for( x = [p0[0] :sx: p1[0]+sx/2] )
        [ for( y = [p0[1] :sy: p1[1]+sy/2] )
            [ for( z= [p0[2] :sz: p1[2]+sz/2] ) 
                let( eval = f_evaluate( [x,y,z], f_rep ) )
                ! surf && (
                  x == p0[0] || x > p1[0]-sx/2 || // check bbox bounds
                  y == p0[1] || y > p1[1]-sy/2 ||
                  z == p0[2] || z > p1[2]-sz/2  ) ?
                    min( -1e-3, eval ) :
                    abs(eval) <= 1e-6 ? // avoid zero values at voxel vertices
                        5e-6 * sign(eval) :
                        eval ] ] ] ];
            

        
//************************************************
//  Mesh to surface 
//************************************************            
module mesh_surface(mesh, id) {

    polygs   = mesh_polygons(mesh);
    if (len(polygs) > 0) {

        polygpms = [ for(poly=polygs) 
                        if ( len(poly) !=undef && len(poly) > 0 )
                            len(poly) == 3 ?
                                poly :
                                concat( poly , [ mean_value(poly) ] ) ];
        if( id!=undef)
            module_msg(str("received ",len(polygpms)," polygons to display"), 
                            str("mesh_surface id = ",id),type=1);
        nverts = concat([0], accum_sum([ for(p = polygpms) len(p) ])); 
        tris = flatten([ for(i=[0:len(polygpms)-1]) 
                          let( ptpos  = nverts[i],
                               pmpos  = nverts[i] + len(polygpms[i])-1 )
                          len(polygpms[i]) == 3 ? 
                              [ [ ptpos, ptpos+1, ptpos+2 ] ]:
                              [ for( j=[0:len(polygpms[i])-2] ) 
                                  [ ptpos+j, ptpos+(j+1)%(len(polygpms[i])-1), pmpos ] ]
                   ]);
        verts  = flatten(polygpms);

        if( id!=undef)
            module_msg(str("generated ",len(tris)," triangles with ",len(verts)," vertices on polyhedron"), str("mesh_surface id = ",id),type=1);
        polyhedron( points = verts,  faces = tris );
    } else if( id!=undef)
            module_msg("Nothing to display", str("mesh_surface id = ",id));

}// mesh_surface

module mesh_surface2(mesh, id=0) { // *** not reviwed

    polygs   = mesh_polygons2(mesh);
//    echo(polygs=polygs);
    if (len(polygs) > 0) {

        polygpms = [ for(poly=polygs) 
                        if ( len(poly) !=undef && len(poly) > 0 )
                            len(poly) == 3 ?
                                poly :
                                concat( poly , [ mean_value(poly) ] ) ];
        module_msg(str("received ",len(polygpms)," polygons to display"), str("mesh_surface id = ",id),type=1);
        nverts = concat([0], accum_sum([ for(p = polygpms) len(p) ]));
        tris = flatten([ for(i=[0:len(polygpms)-1]) 
                          let( ptpos  = nverts[i],
                               pmpos  = nverts[i] + len(polygpms[i])-1 )
                          len(polygpms[i]) == 3 ? 
                              [ [ ptpos, ptpos+1, ptpos+2 ] ]:
                              [ for( j=[0:len(polygpms[i])-2] ) 
                                  [ ptpos+j, ptpos+(j+1)%(len(polygpms[i])-1), pmpos ] ]
                   ]);
        verts  = flatten(polygpms);

        module_msg(str("generated ",len(tris)," triangles with ",len(verts)," vertices on polyhedron"), str("mesh_surface id = ",id),type=1);
        polyhedron( points = verts,  faces = tris );
    } else module_msg("Nothing to display", str("mesh_surface id = ",id));
} // mesh_surface2

function mesh_polygons(mesh) =
    [ for( i=[0:f_mesh_size(mesh)[0]-2 ] ) 
        for( j=[0:f_mesh_size(mesh)[1]-2 ] ) 
            for( k=[0:f_mesh_size(mesh)[2]-2 ] )   
                for(poly=voxel_polygons(mesh, i, j, k)) // avoid flatten
                    if(len(poly)>0) poly ] ;

function voxel_polygons(mesh, i, j, k) =
    let( vox_data  = f_mesh_vox_data(mesh, i, j, k),
         vert      = vert_coords (vox_data),
         vals      = vert_values (vox_data),
         diag      = voxel_diagonal(vox_data),
         c_edges   = cut_edges(vals),
         polyedges = len(c_edges)>0 ? edge_polygons(vox_data, c_edges) : [])
    [ for(poly=polyedges) polygon_verts(poly, vert, vals) ] ; 

////////////////////////////////////////////////////////////
// Indexed polygons construction for a voxel with ambiguity
//==========================================================
// edge_polygons is a list of polygons in the voxel. Each polygon,
// computed by polygon_edges, is the list of edges cut by the 
// polygon. The search of edge polygon starts with the edges in 'edges'. 
function edge_polygons(vox_data, edges, polygs=[]) =
    len(edges)==0 ? 
        polygs :
        let( edge     = edges[0], // new fresh edge
             new_poly = polygon_edges(edge, vox_data) ) // its polygon
        edge_polygons( 
                      vox_data, 
                      remaining_edges(edges, new_poly), // filter edges
                      concat(polygs, [ new_poly ] )
                     );
// remove from 'edges' the edges already in the polygon 'poly' cycle
function remaining_edges(edges, poly) =
    [ for(edge=edges) if( len(search(edge, poly, 1))==0 ) edge ];         
// starting from a cut edge, ciclically finds the edges cut by the polygon cut 'edge' 
function polygon_edges(edge, vox_data) =
    _polygon_edges(edge, edge, vert_values(vox_data));

function _polygon_edges(edge, init_edge, v_values, polyg=[]) =
    let( nedg = next_edge( edge, v_values ) )
    nedg == init_edge ?
         concat( polyg, [ edge ] ) : // escape: add the initial edge
         _polygon_edges( nedg, init_edge, v_values, concat( [ edge ], polyg ) );
// cycle the edge left face to find the next edge of the polygon
function next_edge(edge, v_values) = 
    let( vert = fvert(edge) ) // the edge left face vertices
    // the orig vertex of edge is inside >> v_values[ vert[0] ] >= 0
    v_values[ vert[3] ] < 0 ?  // previous vertex is outside?
        v_values[ vert[1] ] < 0  // next vertex is outside
            && v_values[ vert[2] ] >= 0 ? // ambiguity face ?
            face_media(edge, v_values) > 0 ? 
                sym( fnext(edge) ) :
                onext(edge) :
            onext(edge) :
        next_edge( sym( onext(edge) ) , v_values );
// helper functions
// the mean value of vals in the face of 'edge'
function face_media(edge, vals) = // four times the face media
    let( vert = fvert(edge) )
    ( vals[ vert[0] ] + vals[ vert[1] ] + vals[ vert[2] ] + vals[ vert[3] ] );

// voxel polygon vertex evaluation
function polygon_verts(poly, vert, vals) = 
    [ for(edge=poly) 
        let( v1 = vals[ orig(edge) ], v2 = vals[ dest(edge) ],
             p1 = vert[ orig(edge) ], p2 = vert[ dest(edge) ] )
        _root(v1, v2, p1, p2) ];

function _root(v1, v2, p1, p2) = 
    // find a root in the segment p1-p2 by
    // interpolation weighted by the v1 and v2 values
    abs(v1-v2)<1e-12 ? // nearly equal values ?
        (p1+p2)/2 : // takes something
         let( u  = v1 / ( v1 - v2 ) )
         u < 1e-3 ? // too near to p1 ?
            (1-1e-3)*p1 + 1e-3*p2 : 
            1-u < 1e-3 ? // too near to p2 ?
                (1-1e-3)*p2 + 1e-3*p1 : 
                (1-u) * p1  + u * p2;
 
//*************************************
// collect edges cut by solid boundary
//*************************************
function cut_edges(vert_vals) =
    [ for(edg=[0:23]) 
        if( vert_vals[ orig(edg) ] >= 0 && vert_vals[ dest(edg) ] < 0 ) 
            edg ];

function mesh_cut_edges(mesh) =
    let( size = f_mesh_size(mesh),
         nx = size[0],
         ny = size[1],
         nz = size[2] )
    [ for(i=[0:nx-1])
        for(j=[0:ny-1])
            for(k=[0:nz-1])
                let( vox_data  = f_mesh_vox_data(mesh, i, j, k),
                     vert      = vert_coords(vox_data),
                     vals      = vert_values(vox_data) )
                for( edg=ref_edges() )
                    if( vals[ orig(edg) ]*vals[ dest(edg) ] < 0 )
                        vals[ orig(edg) ] > 0 ?
                            (( i*ny + j )*nz + k )*24 + edg :
                            (( i*ny + j )*nz + k )*24 + sym(edg) ] ;


//**********************
// Some utility modules
//**********************

module show_mesh_bounds(mesh) {
    vsize = f_mesh_vox_size(mesh);
    p0    = f_mesh_origin(mesh);
    dx = vsize[0];
    dy = vsize[1];
    dz = vsize[2];
    thick = norm([dx,dy,dz])/50;
    polyline([  p0, p0+[dx,0,0],
                p0+[dx,dy,0], p0+[0,dy,0],
                p0],     t=thick);

    polyline([  p0+[0,0,dz], p0+[dx,0,dz],
                p0+[dx,dy,dz], p0+[0,dy,dz],
                p0+[0,0,dz]],     t=thick);

    polyline([p0,p0+[0,0,dz]], t=thick);
    polyline([p0+[0,dy,0], p0+[0,dy,dz]], t=thick);
    polyline([p0+[dx,0,0], p0+[dx,0,dz]], t=thick);
    polyline([p0+[dx,dy,0], p0+[dx,dy,dz]], t=thick);
} // show_mesh_bounds

// displays the surface in a voxel 
module polygonize_voxel(vox_data, cor) { // *** not reviwed

    // remove from 'edges' the edges already in the polygon 'poly'
    function remaining_edges(edges, poly) =
        [ for(edge=edges) if( len(search(edge, poly, 1))==0 ) edge ];    
     
    // starting from a cut edge, ciclically find the edges cut by the polygon cutting 'edge' 
    function polygon_edges(edge, vox_data) =
        _polygon_edges(edge, edge, vert_values(vox_data));

    function _polygon_edges(edge, init_edge, v_values, polyg=[]) =
        let( nedg = next_edge( edge, v_values ) )
             nedg == init_edge ?
                 concat( polyg, [ edge ] ) :
                 _polygon_edges( nedg, init_edge, v_values, concat( [ edge ], polyg ) );

    // cycle to find the next edge of the polygon
    function next_edge(edge, v_values) =
        v_values[ dest(onext(edge)) ] < 0 ? 
            v_values[ orig(edge) ] >= 0 
                && v_values[ dest(edge) ] < 0 
                    && v_values[ dest(fnext(edge)) ] >= 0 ? // ambiguity face ?
                face_media(edge, v_values) > 0 ? 
                    sym( fnext(edge) ) :
                    onext(edge) :
                onext(edge) :
            next_edge( sym( onext(edge) ) , v_values );

// helper functionns
    // the mean value of vals in the face of 'edge'
    function face_media(edge, vals) =
        let( face = fvert(edge) )
        ( vals[ face[0] ] + vals[ face[1] ] + vals[ face[2] ] + vals[ face[3] ] ) / 4;   
 
    function ambiguity_face(edge, c_edges) =
        is_in(sym(fnext(edge)), c_edges) && is_in(fnext(fnext(edge)), c_edges) ;

    function collect_segments(c_edges, val) =
        [ for(edge=c_edges) 
            ambiguity_face(edge, c_edges) ? 
                face_media(edge, val) > 0 ? 
                    flatten([ [ edge, fnext(edge)], [ fnext(fnext(edge)), fnext(fnext(edge)) ] ] ):
                    flatten([ [ edge, onext(edge)], [ fnext(fnext(edge)), onext(fnext(fnext(edge))) ] ] ) :
                [ edge, next_edge(edge, val) ] ] ;

    pos = vert_coords(vox_data);
    val = vert_values(vox_data);

    thk = voxel_diagonal(vox_data)/50;
    c_edges = cut_edges(vert_values(vox_data));
    if(len(c_edges)>0) {
        color(cor) 
        for( segment = collect_segments(c_edges, val) )
            polyline( [edge_root( segment[0], vox_data ),
                   edge_root( segment[1], vox_data )],
                  t=thk);

        pols  = edge_polygons(vox_data, c_edges);
        polys = [ for(poly=pols) polygon_verts(poly, vox_data) ];
        pms    = [ for(poly=polys) sum_vectors(poly)/len(poly) ];
        verts  = concat( flatten(polys), pms );
        nverts = concat([0], accum_sum([ for(poly=polys) len(poly) ]) ); 
        tris = flatten([ for(i=[0:len(pms)-1]) 
                  let( pmpos = len(verts)+i-len(pms), 
                       ptpos  = nverts[i] )
                  len(polys[i]) == 3 ? 
                      [ [ ptpos, ptpos+1, ptpos+2 ] ]:
                      [ for( j=[0:len(polys[i])-1] ) 
                                    [ ptpos+j, ptpos+(j+1)%len(polys[i]), pmpos ] ]
               ]);
        maxi = max(val);
        mini = min(val);
        for(pm=pms) {
            pmval = evaluate(pm, vox_data); 
            u     = (pmval-mini)/(maxi-mini);
/*
            if( pmval > 0 )
                color("red")
                    polydots( [pm],t= (1-u)+0.2*u );
            else 
                color("blue")
                    polydots( [pm],t= 1.2*(1-u)+0.1*u );
*/
        }
        polyhedron( points = verts,  faces = tris );
    }

} // polygonize_voxel

module polygonize_voxel2(vox_data, cor) { // *** not reviwed

    // Use a different estimation of pm's

function new_pm(poly, vdata) = 
    let( 
            u = root_of(mediax(vdata[1])),
            v = root_of(mediay(vdata[1])),
            w = root_of(mediaz(vdata[1])),
            t = [u,v,w],
           pmu = u != undef ?
                [(1-u), u]*mediax(vdata[0])/4 :
                [0,0,0],
           pmv = v != undef ?
                [(1-v), v]*mediay(vdata[0])/4 :
                [0,0,0],
           pmw = w != undef ?
                [(1-w), w]*mediaz(vdata[0])/4 :
                [0,0,0],
            n  = len([for(i=[0:2]) if(t[i]!=undef) 1]) )
    n > 0 ?
    ( pmu + pmv + pmw ) / n :
        sum_vectors(poly)/len(poly);

function root_of(a) =
    a[0]*a[1] < 0 ?
        a[0]/(a[0]-a[1]) :
        a[0] == 0 ?
            0:
            a[1] == 0 ?
                1 :
                undef;

function mediax(val) =
    [ [1,1,1,0,0,1,0,0]  , [0,0,0,1,1,0,1,1] ]*val; 
function mediay(val) =
    [ [1,1,0,1,0,0,1,0]  , [0,0,1,0,1,1,0,1] ]*val; 
function mediaz(val) =
    [ [1,0,1,1,1,0,0,0]  , [0,1,0,0,0,1,1,1] ]*val; 


    // remove from 'edges' the edges already in the polygon 'poly'
    function remaining_edges(edges, poly) =
        [ for(edge=edges) if( len(search(edge, poly, 1))==0 ) edge ];    
     
    // starting from a cut edge, ciclically find the edges cut by the polygon cutting 'edge' 
    function polygon_edges(edge, vox_data) =
        _polygon_edges(edge, edge, vert_values(vox_data));

    function _polygon_edges(edge, init_edge, v_values, polyg=[]) =
        let( nedg = next_edge( edge, v_values ) )
             nedg == init_edge ?
                 concat( polyg, [ edge ] ) :
                 _polygon_edges( nedg, init_edge, v_values, concat( [ edge ], polyg ) );

    // cycle to find the next edge of the polygon
    function next_edge(edge, v_values) =
        v_values[ dest(onext(edge)) ] < 0 ? 
            v_values[ orig(edge) ] >= 0 
                && v_values[ dest(edge) ] < 0 
                    && v_values[ dest(fnext(edge)) ] >= 0 ? // ambiguity face ?
                face_media(edge, v_values) > 0 ? 
                    sym( fnext(edge) ) :
                    onext(edge) :
                onext(edge) :
            next_edge( sym( onext(edge) ) , v_values );

// helper functions
    // the mean value of vals in the face of 'edge'
    function face_media(edge, vals) =
        let( face = fvert(edge) )
        ( vals[ face[0] ] + vals[ face[1] ] + vals[ face[2] ] + vals[ face[3] ] ) / 4;   
 
    function ambiguity_face(edge, c_edges) =
        is_in(sym(fnext(edge)), c_edges) && is_in(fnext(fnext(edge)), c_edges) ;

    function collect_segments(c_edges, val) =
        [ for(edge=c_edges) 
            ambiguity_face(edge, c_edges) ? 
                face_media(edge, val) > 0 ? 
                    flatten([ [ edge, fnext(edge)], [ fnext(fnext(edge)), fnext(fnext(edge)) ] ] ):
                    flatten([ [ edge, onext(edge)], [ fnext(fnext(edge)), onext(fnext(fnext(edge))) ] ] ) :
                [ edge, next_edge(edge, val) ] ] ;

    pos = vert_coords(vox_data);
    val = vert_values(vox_data);

    thk = voxel_diagonal(vox_data)/50;
    c_edges = cut_edges(vert_values(vox_data));
    if(len(c_edges)>0) {
        color(cor) 
        for( segment = collect_segments(c_edges, val) )
            polyline( [ edge_root( segment[0], vox_data ),
                    edge_root( segment[1], vox_data )] ,
                  t=thk);

        pols  = edge_polygons(vox_data, c_edges);
        polys = [ for(poly=pols) polygon_verts(poly, vox_data) ];
        pms    = [ for(poly=polys) 
                        len(poly) <= 4 ?
                            sum_vectors(poly)/len(poly):
                            new_pm(poly, vox_data) ];
        verts  = concat( flatten(polys), pms );
        nverts = concat([0], accum_sum([ for(poly=polys) len(poly) ] ) ); 
        tris = flatten([ for(i=[0:len(pms)-1]) 
                  let( pmpos = len(verts)+i-len(pms), 
                       ptpos  = nverts[i] )
                  len(polys[i]) == 3 ? 
                      [ [ ptpos, ptpos+1, ptpos+2 ] ]:
                      [ for( j=[0:len(polys[i])-1] ) 
                                    [ ptpos+j, ptpos+(j+1)%len(polys[i]), pmpos ] ]
               ]);
        maxi = max(val);
        mini = min(val);
        for(pm=pms) {
            pmval = evaluate(pm, vox_data); 
            u     = (pmval-mini)/(maxi-mini);
/*
            if( pmval > 0 )
                color("red")
                    polydots( [pm],t= (1-u)+0.2*u );
            else 
                color("blue")
                    polydots( [pm],t= 1.2*(1-u)+0.1*u );
*/
        }
        polyhedron( points = verts,  faces = tris );
    }

} // polygonize_voxel2

// displays the roots in the edges of a voxel as blue dots
// and displays the positive face medias as green dots at their center 
module show_roots(vox_data) { // *** not reviwed
    pos = vert_coords(vox_data);
    val = vert_values(vox_data);
    thick = max([for(p=pos) norm(p-pos[0]) ])/50; 
    edg = 0;
    
        if( face_media(edg,val) >=0 ) color("green") 
            polydots([face_media(edg,pos)],t=thick);
        edg2 = onext(edg);
        if( face_media(edg2,val) >=0 ) color("green") 
            polydots([face_media(edg2,pos)],t=thick);
        edg3 = onext(edg2);
        if( face_media(edg3,val) >=0 ) color("green") 
            polydots([face_media(edg3,pos)],t=thick);
        edg4 = 21;
        if( face_media(edg4,val) >=0 ) color("green") 
            polydots([face_media(edg4,pos)],t=thick);
        edg5 = onext(edg4);
        if( face_media(edg5,val) >=0 ) color("green") 
            polydots([face_media(edg5,pos)],t=thick);
        edg6 = onext(edg5);
        if( face_media(edg6,val) >=0 ) color("green") 
            polydots([face_media(edg6,pos)],t=thick);
    
    for(edg=[0:11]) {
        v1 = orig(edg);
        v2 = dest(edg);
        if(val[v1]*val[v2] < 0)
            color("blue") 
              polydots([edge_root(edg, vox_data),[0,0,0]],t=thick*1.5);
    }
} // show_roots

// displays an edge of a voxel as a blue segment from the edge origin to the
// middle of the edge
module show_edge(edge, vox_data) { // *** not reviwed
    pos = vert_coords(vox_data);
    val = vert_values(vox_data);
    thick = max([for(p=pos) norm(p-pos[0]) ])/50; 
    v1 = orig(edge);
    v2 = dest(edge);
    color("blue") polyline([pos[v1],(pos[v1]+pos[v2])/2],t=thick);
} // show_edge

// displays a voxel edges in yellow and its positive vertices as red dots
module show_voxel(vox_data) { // *** not reviwed
    pos = vert_coords(vox_data);
    val = vert_values(vox_data);
    thick = max([for(p=pos) norm(p-pos[0]) ])/50; 
    for(edg=[0:11]) {
        polyline([pos[ orig(edg) ], pos[ dest(edg) ]], t=thick);
    }
    color("red")
    for(vrt=[0:7])
        if( val[vrt] > 0 )
            polydots([pos[vrt]], t=thick*1.5);
} // show_voxel

// displays the edges of a specific voxel of a mesh
// colorize the vertices according their values and shows the edge roots in blue
module show_specific_voxel(mesh,i,j,k) { // *** not reviwed
    vox_data = f_mesh_vox_data(mesh, i, j, k);
    pos      = vert_coords(vox_data);
    vals     = vert_values(vox_data);
    thick    = max([for(p=pos) norm(p-pos[0]) ])/50;

    function ambiguity_face(edge, c_edges) =
        is_in(sym(fnext(edge)), c_edges) && is_in(fnext(fnext(edge)), c_edges) ;

    function face_media(edge, vals) =
        let( face = fvert(edge) )
        ( vals[ face[0] ] + vals[ face[1] ] + vals[ face[2] ] + vals[ face[3] ] ) / 4;  
 
    echo(SpecificVoxel=[i,j,k]);
    echo("Ambiguity faces");
    for(edg=cut_edges(vals))
        if(ambiguity_face(edg, cut_edges(vals)))
            echo(Edge=edg, FaceMedia=face_media(edg, vals));

        // draw voxel edges
    for(edg=[0:11]) {
        color("red")
        polyline([pos[ orig(edg) ], pos[ dest(edg) ]], t=thick);
    }
    // color voxel vertices according with its mesh value
    for(vrt=[0:7])
        if( vals[vrt] > 0 )
            color("red")
            polydots([pos[vrt]], t=thick*1.5);
        else
            color("green")
            polydots([pos[vrt]], t=thick*1.5);
    show_roots(vox_data);
} // show_specific_voxel

// displays all the voxels of a mesh using show_voxel and show_roots
module show_mesh_voxels(mesh) { // *** not reviwed
    size  = f_mesh_size(mesh);
    vsize = f_mesh_vox_size(mesh);
    p0    = f_mesh_origin(mesh);
    nx = size[0];
    ny = size[1];
    nz = size[2];
    dx = vsize[0];
    dy = vsize[1];
    dz = vsize[2];
    sx = dx /(nx-1);
    sy = dy /(ny-1);
    sz = dz /(nz-1);
    for(i=[0:nx-2]) {
        x = p0[0] + i*sx;
        for(j=[0:ny-2]) {
            y = p0[1] + j*sy;
            for(k=[0:nz-2]) {
                z = p0[2] + k*sz;
                vox_data = f_mesh_vox_data(mesh, i, j, k);
                vox_vals = vert_values(vox_data);
                if( min(vox_vals)<0 && max(vox_vals)>0 ) {
                    show_voxel(vox_data);
                    show_roots(vox_data);
                }
            }
        }
    }
} // show_mesh_voxels

/////////////////////////////////////
// f_mesh and voxel data structures
/////////////////////////////////////

// generate a voxel data structure
function f_mesh_vox_data(mesh, i, j, k) = 
    let( mesh_bounds = mesh[0], // grid subdivision data
         mv          = mesh[1], // grid vertex values
         nx = len(mv),
         ny = len(mv[0]),
         nz = len(mv[0][0]) )
    i >= nx || i < 0 || j >= ny || j < 0 || k >= nz || k < 0 ? [] :
        let( vals = [ mv[ i ][ j ][ k ], mv[ i ][ j ][k+1],   
                      mv[ i ][j+1][ k ], mv[i+1][ j ][ k ], 
                      mv[i+1][j+1][ k ], mv[ i ][j+1][k+1], 
                      mv[i+1][ j ][k+1], mv[i+1][j+1][k+1] ],
             p0 = mesh_bounds[0],
             sx = mesh_bounds[4],
             sy = mesh_bounds[5],
             sz = mesh_bounds[6],
             x  = p0[0] + i*sx,
             y  = p0[1] + j*sy,
             z  = p0[2] + k*sz )
       len(vals[0]) == undef ?
          // no active primitive information
          // vertex coordinates
          [ [ [x,y,z],       [x,y,z+sz],    [x,y+sy,z],    [x+sx,y,z], 
              [x+sx,y+sy,z], [x,y+sy,z+sz], [x+sx,y,z+sz], [x+sx,y+sy,z+sz] ],
          // vertex f-values
            vals ] :
          // there are active primitive information
          // vertex coordinates
          [ [ [x,y,z],       [x,y,z+sz],    [x,y+sy,z],    [x+sx,y,z], 
              [x+sx,y+sy,z], [x,y+sy,z+sz], [x+sx,y,z+sz], [x+sx,y+sy,z+sz] ],
          // vertex f-values
            [ for( v=vals ) v[0] ],
          // active primitive indices 
            [ for( v=vals ) v[1] ],
          // active primitive signs 
            [ for( v=vals ) v[2] ],
          ];

// the list of primitives in the f-rep that produced that mesh
function f_mesh_prims(mesh) =
    mesh[0][4];

// the sizes of a mesh
function f_mesh_size(mesh) = 
    let( mv = mesh[1],
         nx = len(mv),
         ny = len(mv[0]),
         nz = len(mv[0][0]) )
    [ nx, ny, nz ];

// the voxel sizes of a mesh
function f_mesh_vox_size(mesh) =
    let( dx   =  mesh[0][1],
         dy   =  mesh[0][2],
         dz   =  mesh[0][3] )
    [ dx, dy, dz ];

// the origin point of a mesh
function f_mesh_origin(mesh) = mesh[0][0];

// evaluate the f value in a pt of a voxel by trilinear interpolation of the vertex values
function evaluate(pt, vox_data) =
    let( pos  = vert_coords(vox_data),
         val  = vert_values(vox_data),
         ref  = ref_edges(),
         vert = [ for(i=[0:2]) [ pos[orig(ref[i])], pos[dest(ref[i])] ] ],
         u   = (pt[0] - vert[0][0][0])/(vert[0][1][0]-vert[0][0][0]),
         v   = (pt[1] - vert[1][0][1])/(vert[1][1][1]-vert[1][0][1]),
         w   = (pt[2] - vert[2][0][2])/(vert[2][1][2]-vert[2][0][2])
       )
    [ (1-u)*(1-v)*(1-w), (1-u)*(1-v)*w, (1-u)*v*(1-w), u*(1-v)*(1-w),
          u*v*(1-w),     (1-u)*v*w,     u*(1-v)*w,        u*v*w ] * val;

// voxel data retrival
function vert_coords   (vox_data) = vox_data[0];
function vert_values   (vox_data) = vox_data[1];
function prim_indices  (vox_data) = vox_data[2];
function prim_sign     (vox_data) = vox_data[3];
function voxel_diagonal(vox_data) = norm(vox_data[0][7]-vox_data[0][0]);

//////////////////////////////
// Voxel oriented edge graph
//////////////////////////////

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
