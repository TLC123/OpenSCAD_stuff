module scube(size= [20,20,20],
                        sheer = [0,0],
                        b=2,
                        center=false) 
{
    hull() 
   {
        assign(sheer_offset =
                   [size[2] * sin(sheer[0]), size[2] * sin(sheer[1]), 0 ])
        assign(round_offset = [b,b,b])
        assign(isize = 
                   center ? [- (size +sheer_offset)/2 + round_offset, 
                                    (size )/2 - round_offset]
                               : [ [0,0,0] + round_offset, size - round_offset]
                   ) 
        {
            for (x=[0,1])
            for (y=[0,1]) 
               {
                    translate ([isize[x][0], isize[y][1], isize[0][2]]) sphere(b);
                    translate ([isize[x][0] + sheer_offset[0],
                                     isize[y][1] + sheer_offset[1],
                                     isize[1][2]])  sphere(b);
               }
        }
    }
}

module scylinder(r1=10,r2=10,h=10, b=2,
                             sheer = [0,0], center=false)
{
    assign(sheer_offset = [h * sin(sheer[0]), h * sin(sheer[1]), 0 ])
    assign(z_offset = center ? - h/2 : 0 ) 
    translate([0, 0, z_offset])
    hull()
    {
           rotate_extrude()
                 translate([r1-b, b, 0]) 
                      circle(r = b); 
           translate(sheer_offset)
                rotate_extrude() 
                     translate([r2-b, h-b, 0]) 
                          circle(r = b);
    }
}

$fs=1;
*scube(size=[15,20,25], sheer=[30,45], center=false,b=2);

scylinder( sheer=[-30,-45], center=false);