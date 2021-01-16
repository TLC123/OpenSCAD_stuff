///////////////////////////////////////////////////////////////////
//
// plot
// ====
//
// This module draws a polyhedron mapping a function greater than zero.
// The domain of the function may be either a triangle or a quadrilateral.
// The function is evaluated in a triangular grid of points inside its domain 
// and its graph is ploted. 
//
//    module plot(m,p0,p1,p2,p3=undef,conv=10)
//
// where the parameters are:
//
//    m         - the approximate number of points in the grid for each
//                triangular domain; quadrilaterals will have 2*m points
//    p0,p1,p2  - the three 2D points of the triangular domain
//    p3        - the third point of a second triangular domain (p0,p2,p3);
//                if p3 is undef, just the first triangular domain is used
//    conv      - convexity parameter of the polihedra
//
// The module requires an external function to be plotted:
//
//    function map_to_plot(x,y)
//
// which should return either a real value or undef for each real x and y. 
//
////////////////////////////////////////////////////////////////////

module plot(m, p0, p1, p2, p3=undef, conv=10){
  
  N = ceil( sqrt( 2 * m) - 3/2 );
  
  // the main task
  union(){
    plot_tri(p0, p1, p2);
    if (p3 != undef)
      plot_tri(p0, p2, p3);
  }
  
 // module to plot in a triangular domain
  module plot_tri(p0, p1, p2) {
    
    // the three domain points should be in anti-clockwise order
    A =  p0;
    B = (p1-p0) * (p2-p0) < 0 ? p2 : p1;
    C = (B==p1) ? p2 : p1;
    
    // the indexed points in the grid
    function meshPoint(i,j) = A*i/N + B*j/N + C*(N-i-j)/N;

    // functions to enumerate the points with defined values of the map_to_plot
    function shrinked(a) = 
      [for (i=[0:N], j=[0:N-i]) if(a[i][j][2] != undef) a[i][j] ];
        
    function enum(a) = let(b = shrinked(a))
      [for (i=[0:N]) 
        [ for (j=[0:N-i])
          (a[i][j][2] != undef)? 
            [for ( k = search(a[i][j], b, 0)[0]) if (a[i][j] == b[k]) k ][0]:
            undef
      ]];
  
     // the vertices in the grid
    map = [ for (i=[0:N])
          [ for (j=[0:N-i])
            let(x = meshPoint(i,j)[0], y = meshPoint(i,j)[1])
              [ x, y, map_to_plot(x,y)] 
          ]];

    emap = enum(map);
          
    // the points in the top of the plot
    toppts = [ for(i=[0:N], j=[0:N-i])  if(emap[i][j] != undef) map[i][j] ];

    // the points in the base of the plot
    botpts = [ for (pts = toppts)[ pts[0], pts[1], 0 ] ];
      
    // the faces in the top of the plot
    top_tri_faces = 
      concat( 
        [for(i=[1:N], j=[0:N-i]) 
          if( (emap[i][j]   !=undef) && 
              (emap[i-1][j] !=undef) && 
              (emap[i][j-1] !=undef) ) 
                [ emap[i][j], emap[i][j-1], emap[i-1][j] ]],

        [for(i=[0:N-1], j=[0:N-i]) 
          if( (emap[i][j]     !=undef) && 
              (emap[i][j-1]   !=undef) && 
              (emap[i+1][j-1] !=undef)) 
                [ emap[i][j], emap[i+1][j-1], emap[i][j-1] ]] 
       );
          
    // the faces in the base of the plot
    base_tri_faces = let(k = len(toppts))
        [ for(face = top_tri_faces) [ face[1]+k, face[0]+k, face[2]+k ] ];

    // enumeration of the vertices of vertical quadrilateral faces of the plot
    // faces with constant j :   10 00 1-1 01 
    function side_faces1(a) = let (k = len(toppts))
        [for(i=[0:N-1], j=[0:N-i])
          let (p = (a[ i ][ j ] != undef) && (a[i+1][ j ] != undef),
               q = (a[i+1][j-1] == undef) && (a[ i ][j+1] != undef),
               r = (a[i+1][j-1] != undef) && (a[ i ][j+1] == undef) )
          if ( p  && ( q || r ) ) q ?
            [ a[ i ][j], a[i+1][j], a[i+1][j]+k, a[ i ][j]+k ] :
            [ a[i+1][j], a[ i ][j], a[ i ][j]+k, a[i+1][j]+k ]
        ];

    // faces with constant i :  00 01  10  -11
    function side_faces2(a) = let (k = len(toppts))
        [for(i=[0:N-1], j=[0:N-i])
          let (p = (a[ i ][j] != undef) && (a[ i ][j+1] != undef),
               q = (a[i+1][j] == undef) && (a[i-1][j+1] != undef),
               r = (a[i+1][j] != undef) && (a[i-1][j+1] == undef) )
          if ( p  && ( q || r ) ) q ?
            [ a[i][ j ], a[i][j+1], a[i][j+1]+k, a[i][ j ]+k ]:
            [ a[i][j+1], a[i][ j ], a[i][ j ]+k, a[i][j+1]+k ]
        ];

    // faces with constant N-i-j :   00  1-1  10 0-1 
    function side_faces3(a) = let (k = len(toppts))
        [for(i=[0:N-1], j=[0:N-i])
          let (p = (a[ i ][j] != undef) && (a[i+1][j-1] != undef),
               q = (a[i+1][j] == undef) && (a[ i ][j-1] != undef),
               r = (a[i+1][j] != undef) && (a[ i ][j-1] == undef) )
          if ( p  && ( q || r ) ) q ?
            [ a[i+1][j-1], a[ i ][ j ], a[ i ][ j ]+k, a[i+1][j-1]+k ]:
            [ a[ i ][ j ], a[i+1][j-1], a[i+1][j-1]+k, a[ i ][ j ]+k ]
         ];

    side_faces = 
          concat( side_faces1(emap), side_faces2(emap), side_faces3(emap));
                 
    polyhedron(
        points = concat(toppts, botpts),
        faces  = concat(top_tri_faces, side_faces, base_tri_faces),
        convexity = conv);
  }
}

// examples of usage
// function map_to_plot(x,y) = abs(x*x+y*y+3*x)<170? 0.1*(-x*x + y*y)+20: undef;
// plot(1000,[10,0], [-10,10], [-10,-10], [10,-20]);
//
// function map_to_plot(x,y) = 20+12*exp(-0.006*abs(x*x+y*y))*cos(1.5*(x*x+y*y));
 //plot(750,[20,0], [-20,20], [-20,-20], [20,-40]);
 //plot(750,[20,0], [20,40], [-20,20]);
//
// function map_to_plot(x,y) = 10 + 0.005*(x*x*y - 3*x*y)+ ((rands(0,2,1)[0]<0.7)? rands(0,0.02*y,1)[0]: 0);
// plot(700, [10,-10], [10,10], [-10,10], [-10,-10]);
 
