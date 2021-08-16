    // demo code
    f_h =[for(i=[0:1/2000:1]) [i, invSmooth(i)*25]];
    f_t =[for(j=[0:1/2000:1])let(i=j) [j, i*180+sin(i*360*2)*22.5]];
    f_s =[for(j=[0:1/2000:1])let(i=abs(j-.5)*2)[j,(1-j)*(1-j)+  (.5+ smin(smooth(i),1-smooth(i)))*2 ]];
    echo(lookup(.25,f_s));
    colors=false;
    functional_extrude(f_h,Center=false,f_t,f_s,100) offset(.31)difference(){ rotate(45) square(5,true);square(5,true);}
    //end demo code
    //
    module functional_extrude(height = 100, Center = false, twist = 0, scale = 1, slices  ) {
        {
            slices = !is_undef(slices) ? slices : !is_undef($fn) ? $fn : 10;
            f_twist = is_list(twist) ? twist :    [for(i=[0:1/200:1]) [i, i * twist]];
            f_height = is_list(height) ? height : [for(i=[0:1/200:1]) [i, i * height]];
            f_scale = is_list(scale) ? scale :    [for(i=[0:1/200:1]) [i, lerp( 1, scale, i)]];
            stepsize = 1 / (slices);
            translate([0, 0, (Center == true ? -lookup(1 ,f_height) * .5 : 0)])
                 for (i = [0: stepsize: 1-stepsize]) {
                 {
                    color(colors?rands(0, 1, 3):"yellow") 
                        translate([0, 0, lookup(i ,f_height)]) {
                            linear_extrude(
                            height = lookup(i + stepsize,f_height) - lookup(i ,f_height), 
                            center = false, 
                            twist = lookup(i,f_twist) - lookup(i + stepsize,f_twist), 
                            scale = lookup(i+ stepsize ,f_scale) / lookup(i,f_scale)){
                              rotate( lookup(i,f_twist))
                              {
                                   scale(lookup(i,f_scale))	 {
                                       children();
                                   }
                              }
                            }
                        
                    }
                }
            }
        }
    } 
    function lerp(start,end,bias) = (end * bias + start * (1 - bias));
    function un(v) = v / max(norm(v), 1e-64) * 1;
    function clamp(a,b=0,c=1) =  min(max(a,min(b,c)),max(b,c));
    function smooth(a) = let (b = clamp(a))(b * b * (3 - 2 * b));
    function invSmooth(x) = x + (x - smooth(x));
    function smin(a,b,k=.1)=let(h=clamp(0.5+0.5*(b-a)/k,0.0,1.0))lerp(b,a,h)-k*h*(1.0-h);
    function smax(a,b,k=.1)=let()-smin(-a,-b,k);
