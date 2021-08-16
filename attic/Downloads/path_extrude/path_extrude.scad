// rotation matrix implementation
// OpenSCAD seems to do this slightly different from Wikipedia
// c.f. https://en.wikipedia.org/wiki/Rotation_matrix#Basic_rotations
function rot2Mat(rotVec, axis) =
    (len(rotVec) == 2) ?
        rot2Mat([rotVec[0], rotVec[1], 0], axis) :
    (axis == "x") ?
        [[1,              0,               0],
         [0, cos(rotVec[0]),  sin(rotVec[0])],
         [0, sin(rotVec[0]), -cos(rotVec[0])]] :
    (axis == "y") ?
        [[ cos(rotVec[1]), 0, sin(rotVec[1])],
         [              0, 1,              0],
         [-sin(rotVec[1]), 0, cos(rotVec[1])]] :
    (axis == "z") ?
        [[ cos(rotVec[2]), sin(rotVec[2]), 0],
         [-sin(rotVec[2]), cos(rotVec[2]), 0],
         [0,              0,               1]] : undef;

// convert point to 3D by setting Z to zero (if not present)
function c3D(tPoints) = 
    (len(tPoints[0]) < 3) ?
        tPoints * [[1,0,0],[0,1,0]] :
        tPoints;

// rotate [2D] points using a specificed XYZ rotation vector
function myRotate(rotation, points) =
    c3D(points) * rot2Mat(rotation, "x")
           * rot2Mat(rotation, "y")
           * rot2Mat(rotation, "z");    
    
// Determine spherical rotation for cartesian coordinates
function rToS(pt) = 
    [-acos((pt[2]) / norm(pt)), 
	 0, 
	 -atan2(pt[0],pt[1])];

// Generate a line between two points in 3D space
module line3D(p1,p2){
  translate((p1+p2)/2)
    rotate(rToS(p1-p2))
       cylinder(r=1, h=norm(p1-p2), center = true, $fn = 3);
}

// Flattens an array down one level (removing the enclosing array)
function flatten(pointArray, done=0, res=[]) =
    (done == len(pointArray)) ?
        res :
        flatten(pointArray=pointArray, done=done+1, 
            res=concat(res,pointArray[done]));

// Creates a polyhedron face
function phFace(pp, tp, base, add=0) =
    [base + add, (base+1) % pp + add,
     (((base+1) % pp) + pp + add) % tp, (base + pp + add) % tp];

function add(vecArg, scArg, res=[]) = 
    (len(res) >= len(vecArg)) ?
        res :
        add(vecArg, scArg, res=concat(res,[vecArg[len(res)]+scArg]));

// Generate an extruded polyhedron from an array of points
// boolean argument "closed" indicates whether to close up the 
// start and end polygon
module makeExtrudedPoly(ex, merge=false, trimEnds=false){
    ps = flatten(ex);
    pp = len(ex[1]); // points in one polygon
    tp = len(ex[1]) * len(ex); // total number of points
    if(!merge && !trimEnds){
        polyhedron(points=ps, faces=concat(
            [[for (i = [pp-1  : -1 :    0]) i]],
            [[for (i = [tp-pp :  1 : tp-1]) i]],
            [for (pt=[0:(len(ex)-2)])
                for(i = [0:pp-1]) phFace(pp,tp,i,pt*pp)],
            [])
        );
    } else if(trimEnds) {
        polyhedron(points=ps, faces=concat(
            [[for (i = [pp*2-1  : -1 :    pp]) i]],
            [[for (i = [tp-pp*2 :  1 : tp-pp-1]) i]],
            [for (pt=[1:(len(ex)-3)])
                for(i = [0:pp-1]) phFace(pp,tp,i,pt*pp)]));
    } else {
        polyhedron(points=ps, faces=
            [for (pt=[0:(len(ex)-1)])
                for(i = [0:pp-1]) phFace(pp,tp,i,pt*pp)]);
    }
}

// Extrude polygon along a path
module path_extrude(points, path, pos=0, merge=false, trimEnds=false, doRotate=true,
                    doScale=false, extruded=[]){
    if((len(points) > 0) && (len(path) > 0) && (len(points[0]) > 1)){
        if(len(extruded) >= (len(path))){
            // extrusion is finished, so construct the object
            //echo(extruded);
            makeExtrudedPoly(extruded, merge=merge, trimEnds=trimEnds);
        } else {
            sPoints = (doScale ? (points*doScale[pos]) : points );
            // generate points from rotating polygon
            if(merge || (pos < (len(path) - 1))){
                if((pos == 0) && (!merge)) {
                    newPts = (doRotate?(myRotate(rToS(path[1] - path[0]),sPoints)):c3D(sPoints));
                    path_extrude(points=points, path=path, pos=pos+1, 
                        merge=merge, trimEnds=trimEnds, doRotate=doRotate, doScale=doScale,
                        extruded=concat(extruded, [add(newPts,path[pos])]));
                } else {
                    newPts = (doRotate?(myRotate(rToS(path[(pos+1) % len(path)] 
                        - path[(pos+len(path)-1) % len(path)]),
                        sPoints)):c3D(sPoints));
                    path_extrude(points=points, path=path, pos=pos+1,
                        merge=merge, trimEnds=trimEnds, doRotate=doRotate, doScale=doScale,
                        extruded=concat(extruded, [add(newPts,path[pos])]));
                }
            } else {
                newPts = (doRotate?(myRotate(rToS(path[pos] - path[pos-1]),sPoints)):c3D(sPoints));
                path_extrude(points=points, path=path, pos=pos+1,
                    merge=merge, trimEnds=trimEnds, doRotate=doRotate, doScale=doScale,
                    extruded=concat(extruded, [add(newPts,path[pos])]));
            }
        }
    }
}

pi=3.14159;

myPoints = [ for(t = [0:72:359]) [cos(t+45),sin(t+45)] ];
myPath = [ for(t = [0:72:359]) 
    [5*cos(t),5*sin(t), 0] ];

path_extrude(points=myPoints, path=myPath, merge=true);

translate([0,0,4]) path_extrude(points=myPoints, path=myPath,
    merge=false);

translate([0,0,-4]) path_extrude(points=myPoints, path=myPath,
    merge=false, trimEnds=true);
