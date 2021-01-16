sphere([5,5,5]);
GRID_FINE=0.000001;
M_PI=3.14159265358979323846;

function getFragments(r,fn,fs,fa) =
 (r < GRID_FINE)?3:
 (fn > 0.0)?(fn >= 3 ? fn : 3):
 ceil(max(min(360.0 / fa, r*2*M_PI / fs), 5));

function getPhi(i,f) = (i*360)/f;
function getCircle_x(r,i,f) = r*sin(getPhi(i,f));
function getCircle_y(r,i,f) = r*cos(getPhi(i,f));

function getCircle(r,f,i=0,points=[]) = (
i>=f?points : getCircle(r,f,i+1,concat(points,[[getCircle_x(r,i,f),getCircle_y(r,i,f)]]))
);

function getRange(start,finish,v=[]) = len(v)>finish?v:getRange(start+1,finish,concat(v,start));

function toVector(v,size) = len(v)==undef?toVector([v],size):len(v)>=size?v:toVector(concat(v,v[0]),size);

module circle(r,approx="outer") {
 f=getFragments(r,$fn,$fs,$fa);
 if(approx=="inner") {
  assign(apothem=radius*cos(360/f)) {
   polygon(getCircle(apothem,f),[getRange(0,f)]);
  }
 } else {
  polygon(getCircle(r,f),[getRange(0,f)]);
 }
}

module cylinder(r,h,center,approx) {
 linear_extrude(height=h, center = center) circle(r,approx);
}

module sphere(r)
{
 f=getFragments(r,$fn,$fs,$fa);
 points=getCircle(r,f);
 rotate_extrude()polygon(points,[getRange(0,f/2)]);
}

module rotate(v)
{

 function cos_n(a) = a%90?cos(a):round(cos(a));
 function sin_n(a) = a%90?sin(a):round(sin(a));

 cx = cos_n(v[0]);
 cy = cos_n(v[1]);
 cz = cos_n(v[2]);
 sx = sin_n(v[0]);
 sy = sin_n(v[1]);
 sz = sin_n(v[2]);
 multmatrix([
  [cy*cz,cz*sx*sy-cx*sz,cx*cz*sy+sx*sz,0],
  [cy*sz,cx*cz+sx*sy*sz,-cz*sx+cx*sy*sz,0],
  [-sy,cy*sx,cx*cy,0],
  [0,0,0,1]
 ])children();
}

module translate(v)
{
 multmatrix([
  [1,0,0,v[0]],
  [0,1,0,v[1]],
  [0,0,1,v[2]],
  [0,0,0,1]
 ])children();
}

module scale(size,reference=[0,0,0])
{
 x=size[0];
 y=size[1];
 z=size[2];
 a=reference[0];
 b=reference[1];
 c=reference[2];
 multmatrix([
  [x,0,0,a-(a*x)],
  [0,y,0,b-(b*x)],
  [0,0,z,c-(c*x)],
  [0,0,0,1]
 ])children();
}

module mirror(v)
{
 x=v[0];
 y=v[1];
 z=v[2];
 mag = sqrt(x*x + y*y + z*z);
 u = x/mag;
 v = y/mag;
 w = z/mag;
 multmatrix([
  [1-2*u*u,-2*v*u,-2*w*u,0],
  [-2*u*v,1-2*v*v,-2*w*v,0],
  [-2*u*w,-2*v*w,1-2*w*w,0],
  [0,0,0,1]
  ])children();
}

module square(size,center=false) {
  module square_impl(x1,y1,x2,y2) {
    polygon([[x1,y1],[x1,y2],[x2,y2],[x2,y1]],[[0,1,2,3]]);
  }
 s=toVector(size,2);
 if(center)
   assign(
   x1 = -s[0]/2,
   x2 = +s[0]/2,
   y1 = -s[1]/2,
   y2 = +s[1]/2
   )square_impl(x1,y1,x2,y2);
  else
   assign(
    x1=0,
    y1=0,
    x2=s[0],
    y2=s[1]
   )square_impl(x1,y1,x2,y2);
}

module cube(size,center=false)
{
  s=toVector(size,3);
  h=s[2];
  if(center)
   translate([0,0,-h/2])linear_extrude(height=h)square(s,center);
  else
   linear_extrude(height=h)square(s,center);
}
