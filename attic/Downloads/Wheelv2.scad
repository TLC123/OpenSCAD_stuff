flatWidth = 40;
diameter = 92;
sideCurve=0.1;
enableTread=true;
roundBothSides=false;
treadCount = 32;
treadCenterWidth = 5;
treadHeight = (flatWidth/2)-(treadCenterWidth/2);
resolution = 150;
treadResolution = 50;

difference() {
    union() {
        cylinder(h=flatWidth, d=diameter, center = true, $fn=resolution);
        translate([0,0,flatWidth/2]){
            scale([1,1,sideCurve]){
                sphere(d=diameter, $fn=resolution);
            }
        }
        if(roundBothSides){
            translate([0,0,-flatWidth/2]){
                scale([1,1,sideCurve]){
                    sphere(d=diameter, $fn=resolution);
                }
            }
        }
        if(enableTread){
            cylinder(h=treadCenterWidth, d=diameter+2, center=true, $fn=resolution);
            for(trd=[0:treadCount]){
                angle = (trd/treadCount)*360;
                radius = diameter/2;
                
                trdX = cos(angle)*radius;
                trdY = sin(angle)*radius;
                echo(angle=angle,trdX=trdX,trdY=trdY);
                translate([trdX, trdY,(treadHeight/2)+(treadCenterWidth/2)]){
                    rotate(angle, [0,0,1]){
                        scale([1,2.5,1]){
                            cylinder(h= treadHeight, d=2, center = true, $fn=treadResolution);
                        }
                    }
                }
                translate([trdX, trdY,-((treadHeight/2)+(treadCenterWidth/2))]){
                    rotate(angle, [0,0,1]){
                        scale([1,2.5,1]){
                            cylinder(h= treadHeight, d=2, center = true, $fn=treadResolution);
                        }
                    }
                }
            }
        }
    }
    cylinder(h=flatWidth+10, d=10, center = true, $fn=resolution);
    translate([0,0,(flatWidth/2)+(diameter*(sideCurve/2))]){
        scale([1,1,sideCurve*2]){
            sphere(d=diameter/2, $fn=resolution);
        }
    }
    if(roundBothSides){
        translate([0,0,-((flatWidth/2)+(diameter*(sideCurve/2)))]){
            scale([1,1,sideCurve*2]){
                sphere(d=diameter/2, $fn=resolution);
            }
        }
    }
}
