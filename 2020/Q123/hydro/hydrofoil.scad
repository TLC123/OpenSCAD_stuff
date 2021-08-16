 $fn=8;
time=$t*10;
    ahead=30;
    r=4;
    a0=[r*1.05,0,-1];
    b0=[-r*1.05,0,-1];
    a=[r*1.1+cos(time*360   )*r,sin(time*360)   *r,0];
    b=[-r*1.1+cos(time*360+ahead)*r,sin(time*360+ahead)*r,0];
    c=[r,a.y-30,0];
    d=[-r,b.y-30,0];
    e=lerp(c,d,.5) +un(d-c)*r;
    f=lerp(c,d,.5) -un(d-c)*r;
    
    
  color("red")    translate(e){sphere(1);}
   color("red")   translate(f){sphere(1);}
    
  color("red")     translate(a){sphere(1);}
  color("red")    translate(b){sphere(1);}
    color("red")   translate(b0) sphere(1);
  
  color("lightgray")    translate(b0) circle(r,$fn=18);
      color("red")   translate(a0) sphere(1);
  
  color("lightgray")    translate(  a0) circle(r,$fn=18);
union(){
    $fn=8;
    
  color("yellow")    hull() {
    translate(lerp(f,e,-1.))circle(.5);
   translate(lerp(f,e,1.5)) circle(.5);

    }
   color("blue")   hull() {
    translate(b){circle(.5);}
   translate(e) circle(.5);

    }
     color("blue") hull() {
    translate(a){circle(.5);}
    translate(f)circle(.5);

    }
    
      color("lightgray")  hull() {
    translate(lerp(f,e,1.5))circle(.25);
   translate([-50,-30,0]) circle(.25);

    }
    
    
}
    function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function un(v) = assert(is_list(v)) v / max(norm(v), 1e-64);
