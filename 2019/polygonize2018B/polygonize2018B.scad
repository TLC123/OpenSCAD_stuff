hull()
{translate([0,0,0])sphere(0.01);translate([1,1,1])sphere(0.01);
}
 #cube(1);
//#sphere(1,$fn=25);

//#linear_extrude(1)polygon([[0,0],[1,0],[0,1]]);
//linear_extrude(1)polygon([[0,0],[1,0],[0,1]])
AP=[0.75,0.25,0.5]  ;
BP= [0.5,0.75,0.25] ;
CP= [0.75,0.5,0.25]  ;
DP= [0.5,0.25,0.75] ;
EP= [0.25,0.75,0.5]  ;
FP= [0.25,0.5,0.75]  ;


A000= AP +[0,0,0]; 
B000= BP +[0,0,0];
C000= CP+[0,0,0];
D000= DP+[0,0,0];
E000= EP+[0,0,0];
F000= FP +[0,0,0];

A100= AP +[1,0,0]; 
B100= BP +[1,0,0];
C100= CP+[1,0,0];
D100= DP+[1,0,0];
E100= EP+[1,0,0];
F100= FP +[1,0,0];

A110= AP +[1,1,0]; 
B110= BP +[1,1,0];
C110= CP+[1,1,0];
D110= DP+[1,1,0];
E110= EP+[1,1,0];
F110= FP +[1,1,0];

A010= AP +[0,1,0]; 
B010= BP +[0,1,0];
C010= CP+[0,1,0];
D010= DP+[0,1,0];
E010= EP+[0,1,0];
F010= FP +[0,1,0];


A001= AP +[0,0,1]; 
B001= BP +[0,0,1];
C001= CP+[0,0,1];
D001= DP+[0,0,1];
E001= EP+[0,0,1];
F001= FP +[0,0,1];

A101= AP +[1,0,1]; 
B101= BP +[1,0,1];
C101= CP+[1,0,1];
D101= DP+[1,0,1];
E101= EP+[1,0,1];
F101= FP +[1,0,1];

A111= AP +[1,1,1]; 
B111= BP +[1,1,1];
C111= CP+[1,1,1];
D111= DP+[1,1,1];
E111= EP+[1,1,1];
F111= FP +[1,1,1];

A011= AP +[0,1,1]; 
B011= BP +[0,1,1];
C011= CP+[0,1,1];
D011= DP+[0,1,1];
E011= EP+[0,1,1];
F011= FP +[0,1,1];


* c();
 

 //for(x=[-2:2],y=[-2:2],z=[-2:2])
 x=0;y=0;z=0;
translate([x,y,z-0.1])full(,x,y,z);
 
module full(x,y,z){p=[x,y,z];
e000=eval([x,y,z]+[0,0,0]);
e100=eval([x,y,z]+[1,0,0]);
e010=eval([x,y,z]+[0,1,0]);
e011=eval([x,y,z]+[0,1,1]);
e001=eval([x,y,z]+[0,0,1]);
e110=eval([x,y,z]+[1,1,0]);
e101=eval([x,y,z]+[1,0,1]);
e111=eval([x,y,z]+[1,1,1]);

//tet(e000,e100,e111);
polyhedron ([p+[0,0,0],p+[1,0,0],p+[1,1,1]],[[0,1,2]]);
//if (e101!=e111)polyh6(F100,A000,D000,C001,E101,B101,e101);
//if (e110!=e111)polyh6(E100,D110,F110,A010,B000,C000,e110);
//if (e011!=e111)polyh6(B001,F000,E000,D010,C011,A011,e001);
//
//if (e100!=e111)color("red")polyh(F100,E100,C000,A000,e100);
//if (e010!=e111)color("red") polyh(B000,E000,D010,A010,e010);
//if (e001!=e111)color("red") polyh(B001,C001,D000,F000 ,e001);
//if (e000!=e111)polyh6(A000,C000,B000,E000,F000,D000,e000);

}

function eval(p)=
sign(sphere(p, 1.5));


 function sphere(p, b = 1) = norm(p) - b;


module c(){
translate(AP) linear_extrude(0.1,center=true)text("A",0.1,$fn=29);
 translate(BP) linear_extrude(0.1,center=true)text("B",0.1,$fn=29);
 translate([0.75,0.5,0.25])linear_extrude(0.1,center=true)text("C",0.1,$fn=29);

translate([0.5,0.25,0.75])linear_extrude(0.1,center=true)text("D",0.1,$fn=29);
 translate([0.25,0.75,0.5]) linear_extrude(0.1,center=true)text("E",0.1,$fn=29);
 translate(FP) linear_extrude(0.1,center=true)text("F",0.1,$fn=29);
}

module polyh(p0,p1,p2,p3,flip)
{
if(flip==-1){polyhedron([p0,p1,p2,p3],[[0,1,2],[0,2,3]]);}
else{ polyhedron([p0,p1,p2,p3],[[2,1,0],[3,2,0]]);}
}
//module polyh5(p0,p1,p2,p3,p4,flip)
//{
//if(flip){polyhedron([p0,p1,p2,p3,p4],[[0,1,2],[0,2,3],[0,3,4]]);}
//else  {polyhedron([p0,p1,p2,p3,p4],[[2,1,0],[3,2,0],[4,3,0]]);}
//}
module polyh6(p0,p1,p2,p3,p4,p5,flip)
{
if(flip){
color("blue") polyhedron([p0,p1,p2,p3,p4,p5],[[0,1,2],[0,2,3]]);
color("darkblue") polyhedron([p0,p1,p2,p3,p4,p5],[[0,3,4],[0,4,5]]);
}else{
color("blue") polyhedron([p0,p1,p2,p3,p4,p5],[[2,1,0],[3,2,0]]);
color("darkblue") polyhedron([p0,p1,p2,p3,p4,p5],[[4,3,0],[5,4,0]]);
}
}