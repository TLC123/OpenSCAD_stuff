$t2=$t+1/3;
$t3=$t+2/3;
rotate([sin($t3*360)*5,cos($t3*360)*5,0])hull(){
cylinder(3,0.01,0.02,center= true);
cylinder(1,0.05,0.09,center= true);
}
rotate([sin($t*360+30)*65,sin($t*360)*10,cos(45+$t*360)*5])linear_extrude(.05)offset(.1)polygon([[0,0.2],[1.5,2.5],[0,2],[-1.3,2.2]]);
rotate(120)rotate([sin($t2*360+30)*65,sin($t2*360)*10,cos(45+$t2*360)*5])linear_extrude(.05)offset(.1)polygon([[0,0.2],[1.5,2.5],[0,2],[-1.3,2.2]]);
rotate(240)rotate([sin($t3*360+30)*65,sin($t3*360)*10,cos(45+$t3*360)*5])linear_extrude(.05)offset(.1)polygon([[0,0.2],[1.5,2.5],[0,2],[-1.3,2.2]]);
