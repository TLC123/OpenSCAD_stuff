$PathDetail=8;
$fn=6;

for(i=[0:1000:10000],j=[0:1000:10000])
translate([i,j])bodyplan();
module (){
totl=rnd(0,10);
arml1l=rnd(totl);
arml12=rnd(totl-arml1l);
arml13=(totl-arml1l-arml12);



rotate(rnd(90),[1,0,0]){

Points=
[[0,0,0,[rnd(5,30),rnd(5,30),rnd(5,30)], ([rnd(0,0.95),rnd(0,0.95),rnd(0,0.95)] ),[rnd(-1,1),rnd(-1,1),rnd(-1,1),rnd(360)] ]

,for([0:4])[rnd(-50,50),rnd(-150,150),rnd(100),2*[rnd(2,30),rnd(2,30),rnd(2,30)], ([rnd(0,0.99),rnd(0,0.99),rnd(0,0.99)] ),[rnd(-1,1),rnd(-1,1),rnd(-1,1),rnd(360)] ]];

Points2=
[[0,0,0,[rnd(5,30),rnd(5,30),rnd(5,30)], ([rnd(0,0.95),rnd(0,0.95),rnd(0,0.95)] ),[rnd(-1,1),rnd(-1,1),rnd(-1,1),rnd(360)] ]

,for(i=[0:4])[rnd(-50,50),rnd(-150,150),rnd(100),2*[rnd(2,30),rnd(2,30),rnd(2,30)]/max(1,i), ([rnd(0,0.99),rnd(0,0.99),rnd(0,0.99)] ),[rnd(-1,1),rnd(-1,1),rnd(-1,1),rnd(360)] ]];

core=
[[0,0,0,[rnd(15,45),rnd(15,45),rnd(15,45)], ([rnd(0,0.95),rnd(0,0.95),rnd(0,0.95)] ),[rnd(-1,1),rnd(-1,1),rnd(-1,1),rnd(360)] ]

,for(i=[0:3])[rnd(-0,0),rnd(-250,250),i*rnd(-5,-250),[rnd(25,60),rnd(25,60),rnd(15,30)]/max(1,i), ([rnd(0,0.99),rnd(0,0.99),rnd(0,0.99)] ),[1,0,0,rnd(360)] ]];

 arm1=
[[0,0,0,[rnd(5,15),rnd(5,15),rnd(5,15)], ([rnd(0,0.95),rnd(0,0.95),rnd(0,0.95)] ),[rnd(-1,1),rnd(-1,1),rnd(-1,1),rnd(360)] ]

,for([0:arml1l])[rnd(30,350),rnd(-250,250),rnd(-10,200),2*[rnd(2,45),rnd(2,45),rnd(2,30)], ([rnd(0,0.99),rnd(0,0.99),rnd(0,0.99)] ),[rnd(-1,1),rnd(-1,1),rnd(-1,1),rnd(360)] ]];



ins1=PiecewiseQuadraticBezierCurve(0.65, core) ;
ins2=PiecewiseQuadraticBezierCurve(0.85, core) ;
 
 arm2=
[[ins1.x,ins1.y,ins1.z,[rnd(5,30),rnd(5,30),rnd(5,30)], ([rnd(0,0.95),rnd(0,0.95),rnd(0,0.95)] ),[rnd(-1,1),rnd(-1,1),rnd(-1,1),rnd(360)] ]

,for([0:arml12])[rnd(10,250),rnd(-250,50),rnd(-300,-50),2*[rnd(2,45),rnd(25,45),rnd(2,30)], ([rnd(0,0.99),rnd(0,0.99),rnd(0,0.99)] ),[rnd(-1,1),rnd(-1,1),rnd(-1,1),rnd(360)] ]];
 
 arm3=
[[ins2.x,ins2.y,ins2.z,[rnd(5,30),rnd(5,30),rnd(5,30)], ([rnd(0,0.95),rnd(0,0.95),rnd(0,0.95)] ),[rnd(-1,1),rnd(-1,1),rnd(-1,1),rnd(360)] ]

,for([0:arml13])[rnd(10,250),rnd(-50,250),rnd(-300,-50),2*[rnd(2,30),rnd(2,30),rnd(2,30)], ([rnd(0,0.99),rnd(0,0.99),rnd(0,0.99)] ),[rnd(-1,1),rnd(-1,1),rnd(-1,1),rnd(360)] ]];

 
DrawSmoothLine( Points);
mirror()DrawSmoothLine( Points);
DrawSmoothLine( Points2);
mirror()DrawSmoothLine( Points2);
DrawSmoothLine( core);

DrawSmoothLine( arm1);
mirror()DrawSmoothLine( arm1);
DrawSmoothLine( arm2);
mirror()DrawSmoothLine( arm2);
DrawSmoothLine( arm3);
mirror()DrawSmoothLine( arm3);
}
}
module DrawSmoothLine(ListOfPoints)
{
SmoothedLine=SmoothLine (ListOfPoints);
DrawPolyline( SmoothedLine   ) ;
}

function SmoothLine (ListOfPoints)=
let(Steps=(100/$PathDetail))
[for(t=[0:Steps]) (PiecewiseQuadraticBezierCurve(t/Steps, ListOfPoints) )];

function PiecewiseQuadraticBezierCurve(PositionAlongPath,ListOfPoints)=
let( 
    ListLenght=len(ListOfPoints)-1,        
    PaddedListOfPoints=PadList(ListOfPoints)        ,
    IndexCenterPoint=round((ListLenght)*PositionAlongPath)+1, // +One to offset padding
    IndexPreviousPoint=IndexCenterPoint-1,
    IndexfollowingPoint=IndexCenterPoint+1,
     
    PositionAlongSegment=(((ListLenght)*PositionAlongPath)+0.5)%1 ,
    
    FirstHandle = FindMidpoint(PaddedListOfPoints,IndexPreviousPoint,IndexCenterPoint ),
    CenterPoint = PaddedListOfPoints[IndexCenterPoint], 
    LastHandle  = FindMidpoint( PaddedListOfPoints, IndexCenterPoint,IndexfollowingPoint) 
) 

QuadraticBezierSegment (FirstHandle,CenterPoint, LastHandle,PositionAlongSegment ) ;


function PadList(ListOfPoints)=
    concat(ExtendOnePointBefore(ListOfPoints),
            ListOfPoints,
            ExtendOnePointAfter(ListOfPoints) );

function ExtendOnePointBefore(ListOfPoints)=
    [ListOfPoints[0]-(ListOfPoints[1]-ListOfPoints[0])];

function ExtendOnePointAfter(ListOfPoints)=
let( ll=len(ListOfPoints)-1   )
    [ListOfPoints[ll]-(ListOfPoints[ll-1]-ListOfPoints[ll])];

//function FindMidpoint(v,ia,ib)=ia==1?v[ia]:ib==len(v)-2?v[ib]:lerp(v[ia],v[ib],0.5);
function FindMidpoint(v,ia,ib)= lerp(v[ia],v[ib],0.5);




 

function lerp( v1, v2, bias) = (1-bias)*v1 + bias*v2;

function QuadraticBezierSegment
        (FirstHandle,CenterPoint, LastHandle,PositionAlongSegment)=
lerp(
    lerp( FirstHandle,CenterPoint,PositionAlongSegment),
    lerp(CenterPoint,LastHandle,PositionAlongSegment),
PositionAlongSegment)
;

module DrawPolyline(PointList ) 
{
for(i=[0:len(PointList)-2])
     DrawLineSegment(PointList[i],PointList[i+1]);
}

module DrawLineSegment(p1, p2 ) 
{  
 color([min(1,p1[4].x+0.25),min(1,p1[4].y+0.25),min(1,p1[4].z+0.25)] )   
hull() {
        translate(vec3(p1)) rotate(p1[5][3],vec3(p1[5])) scale(p1[3])sphere(1 );
        translate(vec3(p2)) rotate(p2[5][3],vec3(p2[5])) scale(p2[3])sphere(1);
       }
}


function vec3(v) = [ v.x, v.y, v.z ];

 

 
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 
function roundlist(v,r = 0.01) = len(v) == undef ? v - (v % r) : len(v) == 0 ? [] : [
  for (i = [0: len(v) - 1]) roundlist(v[i],r)];

