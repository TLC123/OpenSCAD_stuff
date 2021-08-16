
linear_extrude(5) difference(){
 offset(r=.25,$fn=24)offset(r=-.5,$fn=24) offset(r=.25,$fn=24)   projection()
translate([0,0,-2.5])import("Visor_frame_SWEDEN_v10_PrusaMiniFit3.stl");
    r=1.9;
offset(r=.25,$fn=24)offset(r=-3.25,$fn=24)

    offset(r=.125*r,$fn=24)    offset(r=-.25*r,$fn=24) offset(r=.125*r,$fn=24) projection()
translate([0,0,-2.5])import("Visor_frame_SWEDEN_v10_PrusaMiniFit3.stl");
}

linear_extrude(2) offset(r=.25,$fn=24)offset(r=-.5,$fn=24) offset(r=.25,$fn=24)   projection()
translate([0,0,-2.5])import("Visor_frame_SWEDEN_v10_PrusaMiniFit3.stl");