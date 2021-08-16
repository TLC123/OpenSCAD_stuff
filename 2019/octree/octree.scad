use<subdivision.scad>
use<FunctionalOpenSCAD/functional.scad>

//Additions to functional?

function list_rotate(list,count) =
   (count>0)?
      concat([for (i=[count:len(list)-1]) list[i]],[for (i=[0:count-1]) list[i]])
   :(count<0)?
      concat([for (i=[len(list)-1+count:len(list)-1]) list[i]],[for (i=[0:len(list)-1+count-1]) list[i]])
   :
      list;

function list_head(list,count) =
   [for (i=[0:min(count,len(list)-1)]) list[i]]
;

function list_tail(list,count) =
   [for (i=[max(len(list)-1-count,0):len(list)-1]) list[i]]
;

//maybe function splice?

function listgt (a,b,list,i=0) =
   (i<len(list)-1 && list[i]<len(a)-1 && list[i]<len(b)-1 && a[list[i]]==b[list[i]])?
      listgt(a,b,list,i+1)
   :(i<len(list)-1 && list[i]<len(a)-1 && list[i]<len(b)-1 && a[list[i]]>b[list[i]])?
      true
   :(i<len(list)-1 && list[i]<len(a)-1 && list[i]<len(b)-1 && a[list[i]]<b[list[i]])?
      false
   :
      false
;

function listeq (a,b,list,i=0) =
   (i<len(list)-1 && list[i]<len(a)-1 && list[i]<len(b)-1 && a[list[i]]==b[list[i]])?
      listeq(a,b,list,i+1)
   :(i<len(list)-1 && list[i]<len(a)-1 && list[i]<len(b)-1 && a[list[i]]>b[list[i]])?
      false
   :(i<len(list)-1 && list[i]<len(a)-1 && list[i]<len(b)-1 && a[list[i]]<b[list[i]])?
      false
   :(i==len(list)-1)?
      true
   :
      false
;

function listquicksort(arr,list) =
   !(len(arr)>0)?
      []
   :
      let(
         pivot   = arr[floor(len(arr)/2)],
         lesser  = [ for (y = arr) if(listgt(pivot,y,list)) y ],
         equal   = [ for (y = arr) if(listeq(pivot,y,list)) y ],
         greater = [ for (y = arr) if(listgt(y,pivot,list)) y ]
      )
      concat(
    listquicksort(lesser,list), equal, listquicksort(greater,list)
);

//Cribbed from list comprehensions
function iquicksort(arr,i) =
   !(len(arr)>0)?
      []
   :
      let(
         pivot   = arr[floor(len(arr)/2)],
         lesser  = [ for (y = arr) if (y[i]  < pivot[i]) y ],
         equal   = [ for (y = arr) if (y[i] == pivot[i]) y ],
         greater = [ for (y = arr) if (y[i]  > pivot[i]) y ]
      )
      concat(
    iquicksort(lesser,i), equal, iquicksort(greater,i)
);

function triangle_sort(points) =
   listgt(points[0],points[1],[0,1,2])?
      listgt(points[0],points[2],[0,1,2])?
         points
      :
         list_rotate(points,2)
   :
      listgt(points[1],points[2],[0,1,2])?
         list_rotate(points,1)
      :
         list_rotate(points,2)
;


function triangle_plane(p) =
   let(
      normal=cross(p[1]-p[0],p[2]-p[1]),
      unormal=normal/norm(normal)
   )
   [unormal,p[0]*unormal]
;

function tp_normal (triangle_plane)=
   triangle_plane[0];


function tp_distance (triangle_plane)=
   triangle_plane[1];

module line (a=[1,1,1],b=[21,2,2],r=0.1) {
   v=b-a;
   translate(a)
       rotate(a=atan2(v[1],v[0]))
           rotate(v=[0,1,0],a=atan2(sqrt(v[0]*v[0]+v[1]*v[1]),v[2]))
               cylinder(h=sqrt(v*v),r=r);
}


//[points,plane,sphere,bound]
//bound is set up assuming all octrees are centered at the origin.

function triangle_struct(points) =
   let(
      plane=triangle_plane(points),
      unormal=tp_normal(plane),
      nepv=[for (i=[0:2]) let(normal=cross(unormal,points[(i+1)%3]-points[i])) normal/norm(normal)]
   )
   [
      points,
      plane,
      [for(i=[0:2])
         [nepv[i],nepv[i]*points[i]]
      ],
      max([for (p=points) sqrt(p*p)]),
      
   ]
;

//Functions to fake named data structure elements.

function points(trianglestruct) =
  trianglestruct[0]
;

function ts_plane(trianglestruct) =
  trianglestruct[1]
;

function ts_edgetests(trianglestruct) =
   trianglestruct[2]
;

function ts_bound(trianglestruct) =
  trianglestruct[3]
;

function triangle_prep (points) =
   triangle_struct(triangle_sort(points));

//Picking clarity over efficiency...
//Octree structures always centered at the origin (at least for now.)
//Information for each node:
//Position of center, ir, or
//maximum granularity
//child nodes
//triangles if a leaf node.

//Insertion procedure:
//Start with new triangle & the octree to add to
//grow the octree until it's ir is bigger than the triangle's bound.
//then recursively add the triangle to all child nodes that it interacts with.

function new_octree(fineness=0.5) =
   new_octreenode(center=[0,0,0],fineness=fineness,ir=fineness,or=fineness*sqrt(3))
;

function new_octreenode(center=[0,0,0],fineness=0.5,ir=0.5,or=sqrt(3/4),children=[],triangles=[],solid=undef) =
   [
      center,    //Center of node
      ir,        //"minor radius",
      or,        //"major radius"
      fineness,  //"granulaity
      children,  //List of child nodes
      triangles, //List of triangles
      solid     //boolean - indicates
   ]
;

function octree_center(octree)=
   octree[0];

function octree_ir(octree)=
   octree[1];

function octree_or(octree)=
   octree[2];

function octree_fineness(octree) =
   octree[3];

function octree_children(octree) =
   octree[4];

function octree_triangles(octree) =
   octree[5];

function octree_issolid(octree) =
   octree[6];

function octree_grow(octree,bound) =
   let(
      old_center=octree_center(octree),
      old_ir=octree_ir(octree),
      old_or=octree_or(octree),
      fineness=octree_fineness(octree),
      displacement=
         [
           [ 2, 2, 2],[ 2, 2, 0],[ 2, 2, -2],
           [ 2, 0, 2],[ 2, 0, 0],[ 2, 0, -2],
           [ 2,-2, 2],[ 2,-2, 0],[ 2,-2, -2],

           [ 0, 2, 2],[ 0, 2, 0],[ 0, 2, -2],
           [ 0, 0, 2],[ 0, 0, 0],[ 0, 0, -2],
           [ 0,-2, 2],[ 0,-2, 0],[ 0,-2, -2],

           [-2, 2, 2],[-2, 2, 0],[-2, 2, -2],
           [-2, 0, 2],[-2, 0, 0],[-2, 0, -2],
           [-2,-2, 2],[-2,-2, 0],[-2,-2, -2]
         ]
   )
   (old_ir>=bound)?
      octree
   :
   octree_grow(
       new_octreenode(
          center=[0,0,0],
          ir=3*old_ir,
          or=3*old_or,
          fineness=fineness,
          children=[
                for(i=[0:26])
                    (i==13)?
                        octree
                    :
                        new_octreenode(
                           center=old_center+old_ir*displacement[i],
                           fineness=fineness,
                           ir=old_ir,
                           or=old_or
                       )
          ],
          triangles=[],
          solid=undef
        ),
        bound)
;

//This should probably be modified to be agnostic about the center of the octree
function octree_insert(octree,trianglestruct) =
   octree_node_insert(octree_grow(octree,ts_bound(trianglestruct)),trianglestruct)
;

function octree_node_insert(octree,trianglestruct) =
   let(
     displacement=
         [
           [ 2, 2, 2],[ 2, 2, 0],[ 2, 2, -2],
           [ 2, 0, 2],[ 2, 0, 0],[ 2, 0, -2],
           [ 2,-2, 2],[ 2,-2, 0],[ 2,-2, -2],

           [ 0, 2, 2],[ 0, 2, 0],[ 0, 2, -2],
           [ 0, 0, 2],[ 0, 0, 0],[ 0, 0, -2],
           [ 0,-2, 2],[ 0,-2, 0],[ 0,-2, -2],

           [-2, 2, 2],[-2, 2, 0],[-2, 2, -2],
           [-2, 0, 2],[-2, 0, 0],[-2, 0, -2],
           [-2,-2, 2],[-2,-2, 0],[-2,-2, -2]
         ],
     children=octree_children(octree),
     center=octree_center(octree),
     fineness=octree_fineness(octree),
     ir=octree_ir(octree),
     or=octree_or(octree)
   )
   (octree_fineness(octree)>=octree_ir(octree))?
//Resolution limit reached.  Add the triangle to the list.
      new_octreenode(
         center=center,
         fineness=fineness,
         ir=ir,
         or=or,
         children=children,
         triangles=concat(octree_triangles(octree),[trianglestruct])
      )
   :(len(children) > 0) ? //The child array is already populated.
      new_octreenode(
         center=center,
         fineness=fineness,
         ir=ir,
         or=or,
         children=[
            for(i=[0:26])
            (octree_touches_triangle(children[i],trianglestruct))?
               octree_node_insert(children[i],trianglestruct)
            :
               children[i]
         ],
         triangles=octree_triangles(octree),
         solid=octree_issolid(octree)
      )
   ://Child array is *not* populated so populate it & then it's the case above.
      octree_node_insert(
          new_octreenode(
             center=center,
             fineness=fineness,
             ir=ir,
             or=or,
             children=[
                for(i=[0:26])
                    let(
                       nir=ir/3,
                       nor=or/3
                    )
                    new_octreenode(
                     center=center+displacement[i]*nir,
                     fineness=fineness,
                     ir=nir,
                     or=nor,
                     children=[],
                     triangles=[]
                   )  
             ],
             triangles=octree_triangles(octree)
          ),
          trianglestruct
      )
;


//The triangle 'touches' the octree if:
//the triangle's plane intersects the sphere containing the octree node
//AND
//the outer sphere of the node is at least partially on the correct
//side of all the 'edge planes' of the triangle

function octree_touches_triangle(octree,ts)=
   let(
      tplane=ts_plane(ts), //[a,b,c],d with ax+by+cz-d=0 as the plane equation
      unormal=tp_normal(tplane),
      d=tp_distance(tplane),
      tests=ts_edgetests(ts), //edge tests are [a,b,c],d with ax+by+cz>d inside the triangle
      or=octree_or(octree),
      center=octree_center(octree)
  )
  abs(unormal*center-d) > or?  //triangle plane octree sphere test
     false
  :(tp_normal(tests[0])*center-tp_distance(tests[0])) + or < 0?
     false
  :(tp_normal(tests[1])*center-tp_distance(tests[1])) + or < 0?
     false
  :(tp_normal(tests[2])*center-tp_distance(tests[2])) + or < 0?
     false
  :
     true
;

function octree_insert_triangles (octree,triangles,i=0) =
   (len(triangles)==0)?
      octree
   :(i<len(triangles)-1)?
      octree_insert(
         octree_insert_triangles(octree,triangles,i+1),
         triangle_prep(triangles[i])
      )
   :
      octree_insert(
         octree,
         triangle_prep(triangles[i])
      )
;

function x_ray_trace_ts(origin,trianglestruct)=
   let(
      plane=ts_plane(trianglestruct),
      normal=tp_normal(plane),
      distance=tp_distance(plane),
      tests=ts_edgetests(trianglestruct),
      t=(0==normal[0])?
         undef
      :
         (distance-origin*normal)/normal[0]
      ,
      p=origin+t*[1,0,0]
   )
   (
       t != undef &&
       tp_normal(tests[0])*p-tp_distance(tests[0]) >= 0 &&
       tp_normal(tests[1])*p-tp_distance(tests[1]) >= 0 &&
       tp_normal(tests[2])*p-tp_distance(tests[2]) >= 0
   )?
      [t,normal[0]/abs(normal[0])]
   :
      undef
;

function x_ray_trace_tslist(origin,tslist)=
   let(
      distances=[for (ts=tslist) x_ray_trace_ts(origin,ts)]
   )
   iquicksort([for (d=distances) if(d!=undef && d[0]>0) d],0)
;

function x_ray_trace_leafnode(origin,leafnode)=
   (len(octree_triangles(leafnode))>0)?
       x_ray_trace_tslist(origin,octree_triangles(leafnode))
   ://FIXME: This should take advantage of solid status.
       []
;

function octree_getleaf(octree,destination)=
   (0==len(octree_children(octree)))?
      octree
   :
      let(
         r=octree_ir(octree)/3,
         delta=destination-octree_center(octree),
//Magic values for displacement table.
         dx=(delta[0]>r)?-9:(delta[0]<-r)?9:0,
         dy=(delta[1]>r)?-3:(delta[1]<-r)?3:0,
         dz=(delta[2]>r)?-1:(delta[2]<-r)?1:0
      )
      octree_getleaf(octree_children(octree)[13+dx+dy+dz],destination)
;

function x_ray_trace_step(octree,origin,waypoint)=
   let(
      leaf=octree_getleaf(octree,waypoint),
      next=[
         octree_center(leaf)[0]+octree_ir(leaf)+octree_fineness(leaf),
         origin[1],
         origin[2]
      ]
   )
   [x_ray_trace_leafnode(origin,leaf),next]
;

function x_ray_trace_origin(octree,origin,waypoint)=
   let(
      ir=octree_ir(octree)
   )
   ( //Most likely to run over on x, but might as well check the other limits.
      waypoint[0]>ir || waypoint[1]>ir || waypoint[2]>ir||
      waypoint[0]<-ir || waypoint[1]<-ir || waypoint[2]<-ir 
   )?
      false
   :
      let(
         trace=x_ray_trace_step(octree,origin,waypoint),
         hits=trace[0],
         next=trace[1]
      )
      len(hits)?
        (hits[0][1]<0)
      :
         x_ray_trace_origin(octree,origin,next)
;

function is_point_inside(octree,point)=
   x_ray_trace_origin(octree,point,point)
;

function octree_fill(octree) =
   octree_fill_iterator(octree,octree)
;

function octree_fill_iterator(node,root)=
   let(
      kids=octree_children(node)
   )
   len(kids)>0?
      new_octreenode(
         center=octree_center(node),
         fineness=octree_fineness(node),
         ir=octree_ir(node),
         or=octree_or(node),
         children=[for (childnode=kids) octree_fill_iterator(childnode,root)],
         triangles=octree_triangles(node),
         solid=undef
     )
   :
      new_octreenode(
         center=octree_center(node),
         fineness=octree_fineness(node),
         ir=octree_ir(node),
         or=octree_or(node),
         children=[],
         triangles=octree_triangles(node),
         solid=is_point_inside(root,octree_center(node))
     )
;


module octreeshowedge(octree) {
   kids=octree_children(octree);
   if(len(octree_triangles(octree))>0)
      translate(octree_center(octree)) cube(size=octree_ir(octree)*2,center=true);
   if(len(kids)>0) {
      for(i=[0:len(kids)-1])
         octreeshowedge(kids[i]);
   }
}

module octreeshow(octree,margin=0) {
   kids=octree_children(octree);
   if(octree_issolid(octree))
      translate(octree_center(octree)) cube(size=octree_ir(octree)*2-margin,center=true);
   if(len(kids)>0) {
      for(i=[0:len(kids)-1])
         octreeshow(kids[i],margin=margin);
   }
}


scale=1/16;
testoctree=new_octree(scale);

//Translate mitigates triangle edge issues.
poly=translate([0.00001,0.00001,0.00001],sphere(size=2,$fn=16));

//Triangulate faces
tpoly=triangulate_poly3d(poly);

//Map list reference triangles to point triangles
triangles=[for (i=tpoly[1]) [for (j=i) tpoly[0][j]]];

//Insert triangles into octree
inserted=octree_insert_triangles(testoctree,triangles);

//Identify interior nodes
filled=octree_fill(inserted);

//#octreeshowedge(inserted);
//#poly3d(tpoly);
octreeshow(filled,margin=scale/2);

//TODO:
//Improve "x-ray trace" to deal with triangle edge situations.
//Implement tree trimmer.
//Implement boolean operations.
//Switch to spheres/cylinders/prism triangle/node collision model
