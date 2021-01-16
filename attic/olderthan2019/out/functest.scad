for(x=[-20:0.2:30]){
    y=   Powerball(x,0,0,[10,0,0,10])+  Powerball(x,0,0,[-4,0,0,20]);
translate([x,0,0])
    scale([1,1,y])cylinder(1,0.1,0.1);
echo(x,y);
}

%translate([10,0,0])sphere(10);
#translate([10,0,0])sphere(5);
#translate([0,0,0.5]) rotate([0,90,0])cylinder(100,0.05,0.05,center=true);



//function Powerball(x, y, z, Ball) =((1/(      len3([x - Ball[0], y - Ball[1] , z - Ball[2]])/Ball[3] +1))) ;

function Powerball(x, y, z, Ball) =max(

SC3((Ball[3]-( len3([x - Ball[0], y - Ball[1] , z - Ball[2]]))) /Ball[3]),
0,
((1/(      len3([x - Ball[0], y - Ball[1] , z - Ball[2]])/0.1 +1)))

)  ;

function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));

function SC3 (a)= let( b=clamp(a))(b * b * (3 - 2 * b));

function clamp (a,b=0,c=10)=min(max(a,b),c);
