B=[0,0];
T=[0,100];
W=[25,-25];

mbt=lerp(B,T,rnd(0.25,0.75));
mwt= un(lerp(W,T,rnd())-mbt)*rnd(25,100)+mbt ;


hmbt=lerp(B,T, (0.75));

hmwt= un(lerp(mwt,T,rnd())-hmbt)*rnd(25,75)+hmbt ;

lmbt=lerp(B,T,(0.25));
lmwt= un(lerp(W,mwt,rnd())-lmbt)*rnd(25,100)+lmbt ;


line(mwt,mbt);
line(hmwt,hmbt);
line(lmwt,lmbt);
line(B,T);
line(B,W);


polyline([B,W,lmwt,mwt,hmwt,T]);



 module polyline(p) {for(i=[0:max(0,len(p)-1)])line(p[i],p[wrap(i+1,len(p) )]);
} // polyline plotter

module line(p1, p2 ,width=0.3) 
{ // single line plotter
    hull() {
        translate(p1) sphere(width);
        translate(p2) sphere(width);
    }
}
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; // nice rands wrapper 
function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function un(v) = v / max(norm(v), 0.000001) * 1;
function wrap(x,x_max=1,x_min=0) = (((x - x_min) % (x_max - x_min)) + (x_max - x_min)) % (x_max - x_min) + x_min; // wraps numbers inside boundaries