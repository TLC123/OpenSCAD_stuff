$PathDetail=16;
$fn=4;

for(i=[0:2],j=[0:2])
translate([i*1300,j*1300])bodyplan();
module bodyplan(){
TotalApendixLenght=rnd(0,6);
Arm_1Lenght=rnd(0,TotalApendixLenght);
Arm_2Lenght=rnd(0,TotalApendixLenght-Arm_1Lenght);
Arm_3Lenght=max(1,TotalApendixLenght-Arm_1Lenght-Arm_2Lenght);

OrientedScaleType=[[1,1,rnd(1.5,2)],[1,rnd(1.5,2),1],[rnd(1.5,2),1,1]];
OrientedScaleSelected=OrientedScaleType[floor(rnd(0,2.999))];
Orient=round(rnd(4))*90;
OrientedScale=RotateOnXaxis(-Orient,OrientedScaleSelected);

function RotateOnXaxis (q,p)=
[ p.x
, p.y*cos (q) - p.z*sin (q)
, p.y*sin (q) + p.z*cos (q)
];
 rotate(Orient,[1,0,0]){

Brain1=
[[0,0,0,
[rnd(5,30),rnd(5,30),rnd(5,30)], 
([rnd(0,0.95),rnd(0,0.95),rnd(0,0.05)] ),
[rnd(-1,1),rnd(-1,1),rnd(-1,1),rnd(360)] ]

,for([0:4])
[rnd(-50,50),rnd(-150,150),rnd(100),
2*[rnd(2,30),rnd(2,30),rnd(2,30)],
([rnd(0,0.99),rnd(0,0.99),rnd(0,0.99)] ),
[rnd(-1,1),rnd(-1,1),rnd(-1,1),rnd(360)] ]];

Brain2=
[[0,0,0,
[rnd(5,30),rnd(5,30),rnd(5,30)], 
([rnd(0,0.95),rnd(0,0.5),rnd(0,0.65)] ),
[rnd(-1,1),rnd(-1,1),rnd(-1,1),rnd(360)] ]

,for(i=[0:4])
[rnd(-50,50),rnd(-150,150),rnd(100),
2*[rnd(2,30),rnd(2,30),rnd(2,30)]/max(1,i), 
([rnd(0,0.99),rnd(0,0.99),rnd(0,0.99)] ),
[rnd(-1,1),rnd(-1,1),rnd(-1,1),rnd(360)] ]];

BodyTrunk=
[[0,0,0,
[rnd(15,75),rnd(15,45),rnd(15,45)], 
([rnd(0,0.95),rnd(0,0.95),rnd(0,0.95)] ),
[1,0,0,rnd(360)] ]

,for(i=[0:3])
[
rnd(-0,0),
OrientedScale.y*rnd(-250,250),
OrientedScale.z*i*rnd(-5,-250),
[rnd(45,100),rnd(25,90),rnd(15,100)]/max(1,i*0.5), 
([rnd(0,0.99),rnd(0,0.99),rnd(0,0.99)] ),
[1,0,0,rnd(360)] ]];

 Arm_1=
[[0,0,0,
[rnd(5,15),rnd(5,15),rnd(5,15)], 
([rnd(0,0.95),rnd(0,0.95),rnd(0,0.95)] ),
[rnd(-1,1),rnd(-1,1),rnd(-1,1),rnd(360)] ]

,for(i=[0:Arm_1Lenght])
[
OrientedScale.x*rnd(30,350),
OrientedScale.y*rnd(-250,250),
OrientedScale.z*rnd(-10,200),
2*[rnd(2,45),rnd(2,45),rnd(2,30)]/max(1,i*0.5), 
([rnd(0,0.99),rnd(0,0.99),rnd(0,0.99)] ),
[rnd(-1,1),rnd(-1,1),rnd(-1,1),rnd(360)] ]];



AttachArm_2=PiecewiseQuadraticBezierCurve(rnd(0.2,0.9), BodyTrunk) ;
AttachArm_3=PiecewiseQuadraticBezierCurve(rnd(0.2,0.8), BodyTrunk) ;
 
 Arm_2=
[[AttachArm_2.x,AttachArm_2.y,AttachArm_2.z,
[rnd(5,30),rnd(5,30),rnd(5,30)], 
([rnd(0,0.95),rnd(0,0.95),rnd(0,0.95)] ),
[rnd(-1,1),rnd(-1,1),rnd(-1,1),rnd(360)] ]

,for(i=[0:Arm_2Lenght])
[
OrientedScale.x*rnd(10,250),
OrientedScale.y*rnd(-250,50),
OrientedScale.z*rnd(-300,-50),
2*[rnd(2,45),rnd(25,45),rnd(2,30)]/max(1,i*0.5), 
([rnd(0,0.99),rnd(0,0.99),rnd(0,0.99)] ),
[rnd(-1,1),rnd(-1,1),rnd(-1,1),rnd(360)] ]];
 
 Arm_3=
[[AttachArm_3.x,AttachArm_3.y,AttachArm_3.z,
[rnd(5,30),rnd(5,30),rnd(5,30)], 
([rnd(0,0.95),rnd(0,0.95),rnd(0,0.95)] ),
[rnd(-1,1),rnd(-1,1),rnd(-1,1),rnd(360)] ]

,for(i=[0:Arm_3Lenght])
[
OrientedScale.x*rnd(10,250),
OrientedScale.y*rnd(-50,250),
OrientedScale.z*rnd(-300,-50),
2*[rnd(2,30),rnd(2,30),rnd(2,30)]/max(1,i*0.5), 
([rnd(0,0.99),rnd(0,0.99),rnd(0,0.99)] ),
[rnd(-1,1),rnd(-1,1),rnd(-1,1),rnd(360)] ]];

 
DrawSmoothLine( Brain1);
mirror()DrawSmoothLine( Brain1);
DrawSmoothLine( Brain2);
mirror()DrawSmoothLine( Brain2);
DrawSmoothLine( BodyTrunk);

DrawSmoothLine( Arm_1);
mirror()DrawSmoothLine( Arm_1);
DrawSmoothLine( Arm_2);
mirror()DrawSmoothLine( Arm_2);
DrawSmoothLine( Arm_3);
mirror()DrawSmoothLine( Arm_3);
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

QuadraticBezierSegment (FirstHandle,CenterPoint, LastHandle,SmoothStep(PositionAlongSegment) ) ;


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
 color([min(1,p1[4].x+0.75),min(1,p1[4].y+0.5),min(1,p1[4].z+0.25)] )   
hull() {
        translate(vec3(p1)) rotate(p1[5][3],vec3(p1[5])) scale(p1[3])sphere(1 );
        translate(vec3(p2)) rotate(p2[5][3],vec3(p2[5])) scale(p2[3])sphere(1);
       }
}


function vec3(v) = [ v.x, v.y, v.z ];

 
function SmoothStep (a) =let (b = clamp(a))(b * b * (3 - 2 * b));
function clamp(a, b = 0, c = 1) = min(max(a, b), c);
 
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 
function roundlist(v,r = 0.01) = len(v) == undef ? v - (v % r) : len(v) == 0 ? [] : [
  for (i = [0: len(v) - 1]) roundlist(v[i],r)];

