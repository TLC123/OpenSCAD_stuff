sphere(1);
    ahead=30;
    r=4;
    a=[cos($t*360   )*r,sin($t*360)   *r,0];
    b=[cos($t*360+ahead)*r,sin($t*360+ahead)*r,0];
    c=[2,a.y-30,0];
    d=[-2,b.y-30,0];
    e=lerp(c,d,.5) +un(d-c)*2;
    f=lerp(c,d,.5) -un(d-c)*2;
    
    
  color("red")    translate(e){sphere(1);}
   color("red")   translate(f){sphere(1);}
    
  color("red")     translate(a){sphere(1);}
  color("red")    translate(b){sphere(1);}
    color("red")    sphere(1);
  
  color("gray")    translate([0,0,-1]) circle(r);

    
  color("yellow")    hull() {
    translate(lerp(f,e,-1.5))sphere(.5);
   translate(lerp(f,e,1.5)) sphere(.5);

    }
   color("blue")   hull() {
    translate(b){sphere(.5);}
   translate(e) sphere(.5);

    }
     color("blue") hull() {
    translate(a){sphere(.5);}
    translate(f)sphere(.5);

    }
    
      color("gray")  hull() {
    translate(lerp(f,e,1.5))sphere(.25);
   translate([-50,-30,0]) sphere(.25);

    }
    function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function un(v) = assert(is_list(v)) v / max(norm(v), 1e-64);
