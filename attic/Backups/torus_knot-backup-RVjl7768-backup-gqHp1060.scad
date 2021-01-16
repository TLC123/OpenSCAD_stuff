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




a=concat([rnd(0.5),rnd(0.75)],[for (k = [0:1:30])rnd(1)]);

 pts= close(FlowerF(10,20,round(rnd(0,2))*2+1,a,min(2,round(rnd(1,3))),min(2,round(rnd(1,3))) ,isteps=3));;
path=DS_Apiral_As_Line([0,0],[rnd(60)+40,0],turns=1 ,exponent=rnd(-3,3),steps= 20,bias= (0.5) );
polyline(pts); 
polyline(path); 

   path_extrude(
        pts,path, 
         
        closed = false
    ); 


function close(p)= concat(p,[p[0]]); 

function vsum(l) = len(l) > 0 ? [ for(li=l) 1 ] * l : undef;

 


 



module polyline(p) {for(i=[0:max(0,len(p)-2)])line(p[i],p[i+1]);}

module polyplot(p) {for(i=[0:max(0,len(p)-1)])translate(p[i])sphere(1);}

module line(p1, p2 ,width=0.5) { hull() {        
translate(p1) sphere(width,$fn=5);
translate(p2) sphere(width,$fn=5); } }

function L_Spiral (radius = 50,turns ,exponent=1.685,start_angle=45,
steps=50,p1,p2)
=  [for(a = [1/steps:1/steps: 1  ])[ 
(radius * fx2(1-a, exponent)) * cos(start_angle+ a* abs(turns)*360*sign(turns)),
(radius * fx2(1-a, exponent)) * sin(start_angle+a* abs(turns)*360*sign(turns) ),0]+p1 ];

//function D_Apiral_As_Line(p1,p2,turns=3,exponent=1.685 ,steps=150,bias=0.392)=
//let(p3=lerp(p1,p2,bias) )concat(
//reverse(L_Spiral (radius=norm(p1-p3),turns =2*turns*(bias),exponent=exponent,start_angle=atan2((p3-p1).y,(p3-p1).x),steps=steps,p1=p1,p2=p3)),
//(L_Spiral (radius=norm(p2-p3),turns =2*turns*(1-bias),exponent=exponent,start_angle=atan2((p3-p2).y,(p3-p2).x),steps=steps,p1=p2,p2=p3)    ));
//
function DS_Apiral_As_Line(p1,p2,turns=3,exponenti=1.685 ,steps=10,bias=0.392)=
let(p3=lerp(p1,p2,bias) )concat(
reverse
(L_Spiral (radius=norm(p1-p3)*0.9,turns =- turns ,exponent=exponent,start_angle=atan2((p3-p1).y,(p3-p1).x)-70,steps=steps,p1=p1,p2=p3)),
(L_Spiral (radius=norm(p2-p3)*0.9,turns =( turns ),exponent=exponent,start_angle=atan2((p3-p2).y,(p3-p2).x)+70,steps=steps,p1=p2,p2=p3)    ));
//
////
////function L_Apiral_As_Line(p1,p2,turns=3,exponent=1.685 ,steps=150)=
//L_Spiral (radius=norm(p1-p2),turns =turns,exponent=exponent,start_angle=atan2((p2-p1).y,(p2-p1).x),steps=steps,p1=p1,p2=p2);

function fx2(x,n) = n<0?pow(max(0,x),1/abs(min(-1,n-1) )):pow(max(0,x),max(1,n+1))   ;
function reverse(l) = len(l)>0 ? 
[ for(i=[len(l)-1:-1:0]) l[i] ] : len(l)==0 ? [] : undef; 
function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function rnd(a = 1, b = 0, s = []) = 
s == [] ? 
(rands(min(a, b), max(   a, b), 1)[0]) 
: 
(rands(min(a, b), max(a, b), 1, s)[0])
; 


function FlowerF(r=1,isteps=5,w,a,h=2,h2)=
let(steps=min(isteps*w,300))
reverse([  for(t=[0:1/steps:1])
let( r2= r*1.05+vsum([
for (k = [h2:h:max(9,22-w)])     a[k]*(sin(k*t*w*360)/k)*r] ),
  x =r2* sin(t*360), 
 y =r2* cos(t*360)  )
[x,y] ]);