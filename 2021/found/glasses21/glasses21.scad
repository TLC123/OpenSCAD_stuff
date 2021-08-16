w=148;
hw=w/2;
bridge=20;
edge=rnd(1,5);
rounding=rnd(10,14);
bridgeedge=rnd(edge,10);

halfbridge=bridge/2;
v0=rnd(-0.5,1);
v1=rnd(-0.5,1);
v2=rnd(-0.5,1);
v3=rnd(-0.5,1);
vm=[v0,v1,v2,v3];
v=vm/norm(vm);
n0=  [[-halfbridge, 0, 0], [-halfbridge, 2.5, 0], [3, 2, 25], [18, 10, 150], [48, 11, 150], [58, 4, 5], [67, 4, 1], [67, -4, 1], [62, -3, 5], [58, -18, 25], [51, -40, 25], [33, -40, 25], [8, -40, 25], [-4, -7, 1], [0, -3, 1.6], [-halfbridge, -3, 0]];
n1=  [[-halfbridge, 0, 0], [-halfbridge, 11, 0], [0, 11, 5], [8, 12, 10], [53, 11, 10], [58, 4, 5], [67, 4, 1], [67, -4, 0], [61, -4, 1], [60, -10, 5], [56, -40, 10], [33, -40, 0], [8, -40, 10], [-4, -7, 1], [0, -3, 1.6], [-halfbridge, -3, 0]];
n2=  [[-halfbridge, 0, 0], [-halfbridge, 2.5, 0], [0, 2, 5], [10, 20, 50], [48, 20, 50], [58, 4, 5], [67, 4, 1], [67, -4, 1], [61, -3, 3], [60, -10, 5], [53, -35, 50], [33, -35, 50], [8, -35, 50], [-4, -7, 1], [0, -3, 1.6], [-halfbridge, -3, 0]];
n3= [[-halfbridge, 0, 0], [-halfbridge, 0, 0], [8, 2.5, 5], [18, 10, 26], [38, 10, 26], [48, 2.5, 1], [67, 2.5, 1], [67, -4, 1], [48, -4, 5], [46, -15, 26], [35, -24, 26], [18, -25, 26], [8, -15, 26], [6, -4, 1], [-4, -6, 25], [-halfbridge, -6, 0]];

n=n0*v[0]+n1*v[1]+n2*v[2]+n3*v[3];
 

temp=[
[-5,0,0],[0,0,0],[8,0,2],[6,-80,160],[0,-130,60],[-16,-155,3],
[-30,-150,10],[0,-120,35],[-11,-92,26],[-3,-60,150],[0,-5,0],[-5,-5,0],];
 
// Library: round-anything
// Version: 1.0
// Author: IrevDev
// Contributors: TLC123
// Copyright: 2017
// License: GPL 3
//
//translate ([-75,-40,-10])import("D:/Downloads/glasses_front (1).STL");
// translate ([40-80,-160-10,-10])rotate([0,0,90])
//import("D:/Downloads/glasses_side.STL");
//mirror()translate ([39-80,-160-8,0])rotate([0,0,90])
//import( "D:/Downloads/glasses_side.STL");
//difference(){
//         union(){
//linear_extrude(5) frame(n);
//mirror()linear_extrude(5) frame(n);
//
//    translate ([ n[7].x,n[7].y])linear_extrude(4) polygon(polyRound(temp));
// mirror() translate ([n[7].x,n[7].y])linear_extrude(4) polygon(polyRound(temp));
//}
//    * translate ([0,0,-0.01])     union(){ translate ([n[7].x,n[7].y]+[0,2.4,0])linear_extrude(2,scale=[0,1]) square([4,15],center=true);
// translate ([n[7].x,n[7].y]+[2.4,0,0])linear_extrude(2,scale=[1,0]) square([15,4],center=true);
//}}

echo( n0 );
echo(n1  );
echo(n2 );
echo(n3  );

  linear_extrude(5)
union(){
 difference(){
 frame();
 offset(r=0) offset(r=-bridgeedge)frame();
}
corners();
}
  linear_extrude(4)
 {translate ([halfbridge,0])  translate ([ n[7].x,n[7].y])  polygon(polyRound(temp));
 mirror()  translate ([halfbridge,0])translate ([n[7].x,n[7].y])  polygon(polyRound(temp));}

module frame(){

   union(){
 translate ([halfbridge,0])  framehalf(n);
mirror() translate ([halfbridge,0])  framehalf(n);


}
}  
module corners(){

   union(){
 translate ([halfbridge,0])  corner(n);
mirror() translate ([halfbridge,0])  corner(n);


}
}  
module framehalf(n)   {

p=polyRound(n);
difference()
{polygon(p);
r=rounding;
b=edge;
offset(r=r)union(){
offset(-(r+b))polygon(p);
translate([37,-10])circle(0.01);
}
}
 

}
module corner(n)   {

p=polyRound([[n[5].x,n[5].y,0],n[6],n[7],[n[8].x,n[8].y,0]]);
 polygon(p); 
 

}
 *color("red")translate([0,0,5])polyline(n);
function polyRound(radiipoints,fn=5,debug=0)=
		let(p=getpoints(radiipoints)) //make list of coordinates without radii
		let(Lp=len(p))
		//remove the middle point of any three colinear points
		let(newrp=[for(i=[0:len(p)-1]) if(isColinear(p[wrap(i-1,Lp)],p[wrap(i+0,Lp)],p[wrap(i+1,Lp)])==0)radiipoints[wrap(i+0,Lp)] ])
		let(temp=[for(i=[0:len(newrp)-1]) //for each point in the radii array
				let(the5points=[for(j=[-2:2])newrp[wrap(i+j,len(newrp))]])//collect 5 radii points
                let(temp2=round5points(the5points,fn,debug))
								debug>0?temp2:newrp[i][2]==0?[[newrp[i][0],newrp[i][1]]]: //return the original point if the radius is 0
                CentreN2PointsArc(temp2[0],temp2[1],temp2[2],0,fn) //return the arc if everything is normal
		])
		[for (a = temp) for (b = a) b];//flattern and return the array

function round5points(rp,fn,debug=0)=
		rp[2][2]==0&&debug==0?[[rp[2][0],rp[2][1]]]://return the middle point if the radius is 0
		rp[2][2]==0&&debug==1?0://if debug is enabled and the radius is 0 return 0
		let(p=getpoints(rp)) //get list of points
		let(r=[for(i=[1:3]) rp[i][2]])//get the centre 3 radii
    //start by determining what the radius should be at point 3
    //find angles at points 2 , 3 and 4
    let(a2=cosineRuleAngle(p[0],p[1],p[2]))
    let(a3=cosineRuleAngle(p[1],p[2],p[3]))
    let(a4=cosineRuleAngle(p[2],p[3],p[4]))
    //find the distance between points 2&3 and between points 3&4
    let(d23=pointDist(p[1],p[2]))
    let(d34=pointDist(p[2],p[3]))
    //find the radius factors
    let(F23=(d23*tan(a2/2)*tan(a3/2))/(r[0]*tan(a3/2)+r[1]*tan(a2/2)))
    let(F34=(d34*tan(a3/2)*tan(a4/2))/(r[1]*tan(a4/2)+r[2]*tan(a3/2)))
    let(newR=min(r[1],F23*r[1],F34*r[1]))//use the smallest radius
		//now that the radius has been determined, find tangent points and circle centre
		let(tangD=newR/tan(a3/2))//distance to the tangent point from p3
    let(circD=newR/sin(a3/2))//distance to the circle centre from p3
		//find the angle from the p3
		let(an23=getAngle(p[1],p[2]))//angle from point 3 to 2
		let(an34=getAngle(p[3],p[2]))//angle from point 3 to 4
		//find tangent points
		let(t23=[p[2][0]-cos(an23)*tangD,p[2][1]-sin(an23)*tangD])//tangent point between points 2&3
		let(t34=[p[2][0]-cos(an34)*tangD,p[2][1]-sin(an34)*tangD])//tangent point between points 3&4
		//find circle centre
		let(tmid=getMidpoint(t23,t34))//midpoint between the two tangent points
		let(anCen=getAngle(tmid,p[2]))//angle from point 3 to circle centre
		let(cen=[p[2][0]-cos(anCen)*circD,p[2][1]-sin(anCen)*circD])//circle center by offseting from point 3
    //determine the direction of rotation
		debug==0?//if debug in disabled return arc (default)
        [t23,t34,cen]
		:(newR-r[1]);

function polycarious(radiipoints,fn=5)=
		let(p=getpoints(radiipoints)) 
		let(newrp=[for(i=[0:len(p)-1]) 
		 		let(the3points=[for(j=[-1:1]) p[wrap(i+j,len(p))]])
				if(isColinear(the3points[0],the3points[1],the3points[2])==0) radiipoints[wrap(i+0,len(p))] 
	  ])
		let(temp=[for(i=[0:len(newrp)-1]) 
				let(the3points=[for(j=[-1:1]) newrp[wrap(i+j,len(newrp))]])//collect 3 points
				let(temp2=round3points(the3points,fn))
            newrp[i][2]==0?[[newrp[i][0],newrp[i][1]]]: //return the original point if the radius is 0
            CentreN2PointsArc(temp2[0],temp2[1],temp2[2],0,fn) //return the arc if everything is normal
				])
		[for (a = temp) for (b = a) b]; //flattern and return the array

function round3points(rp,fn)=
    rp[1][2]==0?[[rp[1][0],rp[1][1]]]://return the middle point if the radius is 0
		let(p=getpoints(rp)) //get list of points
		let(r=max(0,rp[1][2]))//get the centre 3 radii
    let(ang=cosineRuleAngle(p[0],p[1],p[2]))//angle between the lines
    //now that the radius has been determined, find tangent points and circle centre
		let(tangD=r/tan(ang/2))//distance to the tangent point from p2
    let(circD=r/sin(ang/2))//distance to the circle centre from p2
		//find the angles from the p2 with respect to the postitive x axis
		let(a12=getAngle(p[0],p[1]))//angle from point 2 to 1
		let(a23=getAngle(p[2],p[1]))//angle from point 2 to 3
		//find tangent points
		let(t12=[p[1][0]-cos(a12)*tangD,p[1][1]-sin(a12)*tangD])//tangent point between points 1&2
		let(t23=[p[1][0]-cos(a23)*tangD,p[1][1]-sin(a23)*tangD])//tangent point between points 2&3
    //find circle centre
		let(tmid=getMidpoint(t12,t23))//midpoint between the two tangent points
		let(angCen=getAngle(tmid,p[1]))//angle from point 2 to circle centre
		let(cen=[p[1][0]-cos(angCen)*circD,p[1][1]-sin(angCen)*circD])//circle center by offseting from point 2 
		[t12,t23,cen];
        //CentreN2PointsArc(t12,t23,cen,0,fn);
        
function CentreN2PointsArc(p1,p2,cen,mode=0,fn)=
    /* This function plots an arc from p1 to p2 with fn increments using the cen as the centre of the arc.
    the mode determines how the arc is plotted
    mode==0, shortest arc possible 
    mode==1, longest arc possible
    mode==2, plotted clockwise
    mode==3, plotted counter clockwise
    */
    //determine the direction of rotation
    let(e1=(cen[0]-p1[0])*(cen[1]+p1[1]))//edge 1
    let(e2=(p2[0]-cen[0])*(p2[1]+cen[1]))//edge 2
    let(e3=(p1[0]-p2[0])*(p1[1]+p2[1]))//edge 3
    let(CWorCCW=(e1+e2+e3)/abs(e1+e2+e3))//rotation of the three points cw or ccw?
    //determine the arc angle depending on the mode
    let(p1p2Angle=cosineRuleAngle(p2,cen,p1))
    let(arcAngle=
        mode==0?p1p2Angle:
        mode==1?p1p2Angle-360:
        mode==2&&CWorCCW==-1?p1p2Angle:
        mode==2&&CWorCCW== 1?p1p2Angle-360:
        mode==3&&CWorCCW== 1?p1p2Angle:
        mode==3&&CWorCCW==-1?p1p2Angle-360:
        cosineRuleAngle(p2,cen,p1))
    let(r=pointDist(p1,cen))//determine the radius
	let(p1Angle=getAngle(cen,p1))//angle of line 1
    [for(i=[0:fn]) [cos(p1Angle+(arcAngle/fn)*i*CWorCCW)*r+cen[0],sin(p1Angle+(arcAngle/fn)*i*CWorCCW)*r+cen[1]]];
 
function invtan(run,rise)=
    let(a=abs(atan(rise/run)))
    rise==0&&run>0?0:rise>0&&run>0?a:rise>0&&run==0?90:rise>0&&run<0?180-a:rise==0&&run<0?180:rise<0&&run<0?a+180:rise<0&&run==0?270:rise<0&&run>0?360-a:"error";

function cosineRuleAngle(p1,p2,p3)=
    let(p12=abs(pointDist(p1,p2)))
    let(p13=abs(pointDist(p1,p3)))
    let(p23=abs(pointDist(p2,p3)))
    acos((sq(p23)+sq(p12)-sq(p13))/(2*p23*p12));

function sq(x)=x*x;
function getGradient(p1,p2)=(p2[1]-p1[1])/(p2[0]-p1[0]);
function getAngle(p1,p2)=invtan(p2[0]-p1[0],p2[1]-p1[1]);
function getMidpoint(p1,p2)=[(p1[0]+p2[0])/2,(p1[1]+p2[1])/2]; //returns the midpoint of two points
function pointDist(p1,p2)=sqrt(abs(sq(p1[0]-p2[0])+sq(p1[1]-p2[1]))); //returns the distance between two points
function isColinear(p1,p2,p3)=getGradient(p1,p2)==getGradient(p2,p3)?1:0;//return 1 if 3 points are colinear

 module polyline(p) {for(i=[0:max(0,len(p)-1)])line(p[i],p[wrap(i+1,len(p) )]);
} // polyline plotter

module line(p1, p2 ,width=0.3) 
{ // single line plotter
    hull() {
        translate([p1.x,p1.y]) sphere(width);
        translate([p2.x,p2.y]) sphere(width);
    }
}

function getpoints(p)=[for(i=[0:len(p)-1])[p[i].x,p[i].y]];// gets [x,y]list of[x,y,r]list
function wrap(x,x_max=1,x_min=0) = (((x - x_min) % (x_max - x_min)) + (x_max - x_min)) % (x_max - x_min) + x_min; // wraps numbers inside boundaries
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; // nice rands wrapper 