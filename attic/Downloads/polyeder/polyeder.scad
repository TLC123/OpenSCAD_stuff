/* 
    Purpose:            OpenSCAD Polyeder Library
    Version:            1.0
    Date:               2017-12-014
    Author:             Sohler Guenther
    Information Source: Wikipedia
*/    

$fn=50;

l=20; // Length of one side


facemode=1;
// 0: no face
// 1: plain faces
// 2: cones

r_edge=1;
r_corner=2;

conehight=15;

///////////////////////////
// Utility Functions
///////////////////////////

function rotpt(pt,ang)= // Rotate Point along an angle
    [pt[0]*cos(ang)-pt[1]*sin(ang),
    pt[0]*sin(ang)+pt[1]*cos(ang)];              

function ptfunc(i,lx,ang)= // Calculates all Points of a regular poolygon
    (i > 0)
    ?rotpt(ptfunc(i-1,lx,ang)+[lx,0],ang)
    :[0,0];

function centerfunc(pts,i,n)= //Calculates the center point of a point list
    i==n?centerfunc(pts,i-1,n)/n:
    i==0?pts[i]:
    pts[i]+centerfunc(pts,i-1,n);

// calculate the angle between 3 polyeders
function cosrw(n)=
    cos(180-360/n);

function sinrw(n)=
    sin(180-360/n);

// returns angle bewtween polygon n1,n2 with no in between
function angle_3poly(n1,n2,no)=
    acos((cosrw(no)-cosrw(n1)*cosrw(n2))/(sinrw(n1)*sinrw(n2)));


// One Face of the Polyeder
module face(n)
{
    pts=[for (i =[0:n-1]) ptfunc(i,l,360/n) ];
     
    
    if(facemode == 1)
    {
        translate([0,0,-0.1])
        linear_extrude(height=0.1)
        {
            polygon(pts);
        }
    }
    if(facemode == 2)
    {
        ct=centerfunc(pts,len(pts),len(pts));
        hull()
        {
            translate([0,0,-0.1])
            linear_extrude(height=0.1)
            {
                polygon(pts);
            }
            translate([ct[0],ct[1],conehight])
                sphere(r=0.1);
        }
    }
  
    if(r_edge > 0)
    {
        for(i=[0:len(pts)-1])
        {
            hull()
            {
                translate(pts[i]) sphere(r=r_edge);
                translate(pts[i+1]) sphere(r=r_edge);
            }
        }
    }
    if(r_corner > 0)
    {
        for(i=[0:len(pts)-1])
        {   
            translate(pts[i]) sphere(r=r_corner);
        }
    }

}


module polyeder_rot(info,in,i,ang)
{
    if(i == 0)
    {
        polyeder(info,in); 
    }
    else
    {
        translate([l/2,0,0])
            rotate([0,0,ang])
            translate([l/2,0,0])
            polyeder_rot(info,in,i-1,ang);
    }
     
}

module polyeder(info,inbase) 
{
   rotate([inbase[4],180,0]) 
    {
        n=inbase[3];
        translate([l/2,0,0])
            face(n); 
        cur=inbase[2];

        for(in=info) 
        {
             if(in[0] == cur)
             {
                  polyeder_rot(info,in,in[1],360/n);
             }
        }
    }
}

///////////////////////////
// Solid angles
///////////////////////////


w5_5_5=angle_3poly(5,5,5);
w4_4_4=angle_3poly(4,4,4);
w3_3_3=angle_3poly(3,3,3);
w4_6_10=angle_3poly(4,6,10); 
w10_4_6=angle_3poly(10,4,6); 
w6_10_4=angle_3poly(10,6,4); 
w5_6_6=angle_3poly(5,6,6); 
w6_6_5=angle_3poly(6,6,5); 
w4_6_8=angle_3poly(4,6,8);
w8_4_6=angle_3poly(8,4,6);
w8_6_4=angle_3poly(8,6,4);
w10_10_3=angle_3poly(10,10,3);
w3_10_10=angle_3poly(3,10,10);
w6_6_3=angle_3poly(6,6,3);
w3_6_6=angle_3poly(3,6,6);
w8_8_3=angle_3poly(8,8,3);
w3_8_8=angle_3poly(3,8,8);
w4_6_6=angle_3poly(4,6,6);
w6_6_4=angle_3poly(6,6,4);
aci3=acos(-1/3);
acsq5d3=acos(-sqrt(5)/3);
acsq50x10=acos(-sqrt(50+10*sqrt(5))/10);
ac1psq5x6=acos(-(1+sqrt(5))*sqrt(3)/6);
acs52x15=acos(-sqrt((5+2*sqrt(5))/15));
ac1dsq3=acos(-1/sqrt(3));
asisq3=180-asin(1/sqrt(3));
pid4=135;
wsnubdod33=164.1752;
wsnubdod35=152.93;
wsnubcube33=153.2347;
wsnubcube34=142.98;



///////////////////////////
// Platonic solids
///////////////////////////

function tetrafunc(i)=
    i==0?concat([[-1,0,0,3,0]],tetrafunc(i+1)):
    i<4?concat([[0,i-1,i,3,w3_3_3]],tetrafunc(i+1)):
    [[]];
    
function octafunc(i)=
    i==0?concat([[-1,0,0,3,0]],octafunc(i+1)):
    i<4?concat([[0,i-1,i,3,aci3]],octafunc(i+1)):
    i<8?concat([[i-3,i==7?2:1,i,3,aci3]],octafunc(i+1)):
    [[]];


function icofunc(i)=
    i==0?concat([[-1,0,0,3,0]],icofunc(i+1)):
    i<10?concat([[i-1,(i%2)?2:1,i,3,acsq5d3]],icofunc(i+1)):
    i<15?concat([[(i-10)*2,1,i,3,acsq5d3]],icofunc(i+1)):
    i<20?concat([[(i-15)*2+1,2,i,3,acsq5d3]],icofunc(i+1)):[];

function cubefunc(i)=
    i==0?concat([[-1,    0,  0,  4,  0]],cubefunc(i+1)):
    i<=4?concat([[ 0,    i-1,  i,  4, w4_4_4]],cubefunc(i+1)):
    [[1,2,5,4,w4_4_4]];


function dodecafunc(i)=
    i==0?concat([[-1,    0,  i,  5,  0]],dodecafunc(i+1)):
    i<=5?concat([[ 0,    i-1,  i,  5, w5_5_5]],dodecafunc(i+1)):
    i<=10?concat([[ i-5, 2,  i,  5, w5_5_5]],dodecafunc(i+1)):
    [[10,3,11,5,w5_5_5]];

///////////////////////////
// Archimedic solids
///////////////////////////

function rhombicuboctafunc(i)= //Rhombicuboctahedron
    i==0?concat([[  -1,   0, i,  4,  0]],rhombicuboctafunc(i+1)):
    i<=4?concat([[   0,  i-1,i,  4, pid4]],rhombicuboctafunc(i+1)):
    i<=8?concat([[ i-4,   1, i,  3, asisq3]],rhombicuboctafunc(i+1)):
    i<=12?concat([[ i-8,  2, i,  4, pid4]],rhombicuboctafunc(i+1)):
    i<=16?concat([[ i-8,  2, i,  4, asisq3]],rhombicuboctafunc(i+1)):
    i<=20?concat([[ i-8,  2, i,  3, asisq3]],rhombicuboctafunc(i+1)):
    i<=24?concat([[ i-8,  2, i,  4, pid4]],rhombicuboctafunc(i+1)):
    [[21,2,25,4,pid4]];


function truncicofunc(i)= // Truncated Icosahedron
    i==0?concat([[-1,0,0,5,0]],truncicofunc(i+1)):
    i<6?concat([[0,i-1,i,6,w5_6_6]],truncicofunc(i+1)):
    i<11?concat([[i-5,2,i,5,w5_6_6]],truncicofunc(i+1)):
    i<16?concat([[i-5,2,i,6,w5_6_6]],truncicofunc(i+1)):
    i<21?concat([[i-5,3,i,6,w6_6_5]],truncicofunc(i+1)):
    i<26?concat([[i-5,3,i,5,w5_6_6]],truncicofunc(i+1)):
    i<31?concat([[i-5,3,i,6,w5_6_6]],truncicofunc(i+1)):
    [[27 ,4,31,5,w5_6_6]];

 

function rhombisododekfunc(i)= // Rhombicosidodecahedron
    i==0?concat([[-1,0,0,5,0]],rhombisododekfunc(i+1)):
    i<6?concat([[0,i-1,i,4,acsq50x10]],rhombisododekfunc(i+1)):
    i<11?concat([[i-5,1,i,3,ac1psq5x6]],rhombisododekfunc(i+1)):
    i<16?concat([[i-10,2,i,5,acsq50x10]],rhombisododekfunc(i+1)):
    i<21?concat([[i-5,1,i,4,acsq50x10]],rhombisododekfunc(i+1)):
    i<26?concat([[i-10,2,i,4,acsq50x10]],rhombisododekfunc(i+1)):
    i<31?concat([[i-15,3,i,4,acsq50x10]],rhombisododekfunc(i+1)):
    i<36?concat([[i-5,3,i,3,ac1psq5x6]],rhombisododekfunc(i+1)):
    i<41?concat([[i-10,2,i,5,acsq50x10]],rhombisododekfunc(i+1)):
    i<46?concat([[i-15,1,i,3,ac1psq5x6]],rhombisododekfunc(i+1)):
    i<51?concat([[i-10,1,i,4,acsq50x10]],rhombisododekfunc(i+1)):
    i<56?concat([[i-15,2,i,4,acsq50x10]],rhombisododekfunc(i+1)):
    i<61?concat([[i-5,1,i,3,ac1psq5x6]],rhombisododekfunc(i+1)):
    [[51,2,62,5,acsq50x10]];

function cuboctaederfunc(i)= // Rhombicuboctahedron
    i==0?concat([[-1,0,0,4,0]],cuboctaederfunc(i+1)):
    i<5?concat([[0,i-1,i,3,ac1dsq3]],cuboctaederfunc(i+1)):
    i<9?concat([[i-4,1,i,4,ac1dsq3]],cuboctaederfunc(i+1)):
    i<13?concat([[i-4,2,i,3,ac1dsq3]],cuboctaederfunc(i+1)):
    [[12,2,13,4,ac1dsq3]];


function rhombicosidodecfunc(i)= // truncated icosidodecahedron
    i==0?concat([[-1,0,0,10,0]],rhombicosidodecfunc(i+1)):
    i<6?concat([[0,2*i-2,i,4,w10_4_6]],rhombicosidodecfunc(i+1)):
    i<11?concat([[0,2*i-11,i,6,w6_10_4]],rhombicosidodecfunc(i+1)):
    i<16?concat([[i-10,2,i,10,w10_4_6]],rhombicosidodecfunc(i+1)):
    i<21?concat([[i-10,3,i,4,w4_6_10]],rhombicosidodecfunc(i+1)):
    i<26?concat([[i-5,2,i,6,w4_6_10]],rhombicosidodecfunc(i+1)):
    i<31?concat([[i-5,2,i,4,w4_6_10]],rhombicosidodecfunc(i+1)):
    i<36?concat([[i-10,4,i,4,w4_6_10]],rhombicosidodecfunc(i+1)):
    i<41?concat([[i-25,5,i,6,w6_10_4]],rhombicosidodecfunc(i+1)): 
    i<46?concat([[i-20,3,i,10,w6_10_4]],rhombicosidodecfunc(i+1)): 
    i<51?concat([[i-10,3,i,4,w4_6_10]],rhombicosidodecfunc(i+1)): 
    i<56?concat([[i-5,2,i,6,w4_6_10]],rhombicosidodecfunc(i+1)): 
    i<61?concat([[i-5,2,i,4,w4_6_10]],rhombicosidodecfunc(i+1)): 
    [[56,3,62,10,w10_4_6]];

function truncuboctahedfunc(i)= // 
    i==0?concat([[-1,0,i,8,0]],truncuboctahedfunc(i+1)):
    i<5?concat([[0,2*i-2,i,4,w8_4_6]],truncuboctahedfunc(i+1)):
    i<9?concat([[0,2*i-9,i,6,w8_6_4]],truncuboctahedfunc(i+1)):
    i<13?concat([[i-8,2,i,8,w8_4_6]],truncuboctahedfunc(i+1)):
    i<17?concat([[i-4,2,i,4,w8_4_6]],truncuboctahedfunc(i+1)):
    i<21?concat([[i-4,3,i,6,w4_6_8]],truncuboctahedfunc(i+1)):
    i<25?concat([[i-4,2,i,4,w4_6_8]],truncuboctahedfunc(i+1)):
    [[24,3,25,8,w8_4_6]];


function snubdodecafunc(i)= // snub dodecahedron
    i==0?concat([[-1,0,i,5,0]],snubdodecafunc(i+1)):
    i<6?concat([[0,i-1,i,3,wsnubdod35]],snubdodecafunc(i+1)):
    i<16?concat([[i-5,1,i,3,wsnubdod33]],snubdodecafunc(i+1)):
    i<21?concat([[i-5,2,i,3,wsnubdod33]],snubdodecafunc(i+1)):
    i<26?concat([[i-5,1,i,5,wsnubdod35]],snubdodecafunc(i+1)):
    i<31?concat([[i-5,2,i,3,wsnubdod35]],snubdodecafunc(i+1)):
    i<36?concat([[i-5,2,i,3,wsnubdod33]],snubdodecafunc(i+1)):
    i<41?concat([[i-5,1,i,3,wsnubdod33]],snubdodecafunc(i+1)):
    i<56?concat([[i-10,2,i,3,wsnubdod33]],snubdodecafunc(i+1)):
    i<61?concat([[i-10,1,i,3,wsnubdod33]],snubdodecafunc(i+1)):
    i<66?concat([[i-15,2,i,5,wsnubdod35]],snubdodecafunc(i+1)):
    i<71?concat([[i-5,3,i,3,wsnubdod35]],snubdodecafunc(i+1)):
    i<86?concat([[i-5,1,i,3,wsnubdod33]],snubdodecafunc(i+1)):
    i<91?concat([[i-5,2,i,3,wsnubdod33]],snubdodecafunc(i+1)):
    [[90,2,91,5,wsnubdod35]];
    


function snubcubefunc(i)= // snub cube
    i==0?concat([[-1,0,i,4,0]],snubcubefunc(i+1)):
    i<5?concat([[0,i-1,i,3,wsnubcube34]],snubcubefunc(i+1)):
    i<13?concat([[i-4,1,i,3,wsnubcube33]],snubcubefunc(i+1)):
    i<17?concat([[i-4,2,i,4,wsnubcube34]],snubcubefunc(i+1)):
    i<21?concat([[i-4,1,i,3,wsnubcube34]],snubcubefunc(i+1)):
    i<33?concat([[i-4,2,i,3,wsnubcube33]],snubcubefunc(i+1)):
    i<37?concat([[i-4,1,i,3,wsnubcube33]],snubcubefunc(i+1)):
    [[36,1,i,4,wsnubcube34]];

function truncdodecfunc(i)= // truncated dodecahedron
    i==0?concat([[-1,0,i,10,0]],truncdodecfunc(i+1)):
    i<6?concat([[0,2*i-2,i,3,w3_10_10]],truncdodecfunc(i+1)):
    i<11?concat([[0,2*i-9,i,10,w10_10_3]],truncdodecfunc(i+1)):
    i<16?concat([[i-5,3,i,3,w3_10_10]],truncdodecfunc(i+1)):
    i<21?concat([[i-5,2,i,10,w3_10_10]],truncdodecfunc(i+1)):
    i<26?concat([[i-5,2,i,3,w3_10_10]],truncdodecfunc(i+1)):
    i<31?concat([[i-10,4,i,3,w3_10_10]],truncdodecfunc(i+1)):
    [[30,2,31,10,w3_10_10]];


function ikosidodekafunc(i)= // icosidodecahedron
    i==0?concat([[-1,0,i,5,0]],ikosidodekafunc(i+1)):
    i<6?concat([[0,i-1,i,3,acs52x15]],ikosidodekafunc(i+1)):
    i<11?concat([[i-5,1,i,5,acs52x15]],ikosidodekafunc(i+1)):
    i<16?concat([[i-5,2,i,3,acs52x15]],ikosidodekafunc(i+1)):
    i<21?concat([[i-10,3,i,3,acs52x15]],ikosidodekafunc(i+1)):
    i<26?concat([[i-5,1,i,5,acs52x15]],ikosidodekafunc(i+1)):
    i<31?concat([[i-5,3,i,3,acs52x15]],ikosidodekafunc(i+1)):
    [[30,2,31,5,acs52x15]];

function trunctetrafunc(i)= // truncated tetrahedron
    i==0?concat([[-1,0,0,6,0]],trunctetrafunc(i+1)):
    i<4?concat([[0,2*i-2,i,6,w6_6_3]],trunctetrafunc(i+1)):
    i<7?concat([[0,2*i-7,i,3,w3_6_6]],trunctetrafunc(i+1)):
    [[3,3,7,3,w3_6_6]];

function trunccubefunc(i)= // truncated cube
    i==0?concat([[-1,0,0,8,0]],trunccubefunc(i+1)):
    i<5?concat([[0,2*i-2,i,8,w8_8_3]],trunccubefunc(i+1)):
    i<9?concat([[0,2*i-9,i,3,w3_8_8]],trunccubefunc(i+1)):
    i<13?concat([[i-8,3,i,3,w3_8_8]],trunccubefunc(i+1)):
    [[12,5,13,8,w3_8_8]];

function truncoctfunc(i)= // truncated octahedron
    i==0?concat([[-1,0,0,6,0]],truncoctfunc(i+1)):
    i<4?concat([[0,2*i-2,i,6,w6_6_4]],truncoctfunc(i+1)):
    i<7?concat([[0,2*i-5,i,4,w4_6_6]],truncoctfunc(i+1)):
    i<10?concat([[i-3,2,i,6,w4_6_6]],truncoctfunc(i+1)):
    i<13?concat([[i-3,2,i,4,w4_6_6]],truncoctfunc(i+1)):
    [[12,3,13,6,w4_6_6]];


///////////////////////////
// Prisms
///////////////////////////

function prismafunc(n,i)=
    i==0?concat([[-1,0,0,n,0]],prismafunc(n,i+1)):
    i<n+1?concat([[0,i-1,i,4,90]],prismafunc(n,i+1)):
    [[1,2,i,n,90]];
    
    
a=79;    
b=42;
function antiprismafunc(n,i)=
    i==0?concat([[-1,0,0,n,0]],antiprismafunc(n,i+1)):
    i<n+1?concat([[0,i-1,i,3,a]],antiprismafunc(n,i+1)):
    i<2*n+1?concat([[i-n,1,i,3,b]],antiprismafunc(n,i+1)):
    [[i-n,2,i,n,a]];
    

  
    
///////////////////////////
// Toplevel
///////////////////////////


// Uncomment any of the solids

// Platonic Solids

//info=tetrafunc(0);    // Tetrahedron
//info=octafunc(0);     // Octahedron
info=icofunc(0);      // Icosahedron
//info=cubefunc(0);     // Cube
//info=dodecafunc(0);   // Dodecahedron

// Archimedic Solids

//info=trunctetrafunc(0);   // Truncated Tetrahedron
//info=truncoctfunc(0);     // Truncated Octahedron
//info=truncicofunc(0);     // Truncated Icosahedron
//info=trunccubefunc(0);    // Truncated Cube
//info=truncdodecfunc(0);   // Truncated Dodecahedron
//info=truncuboctahedfunc(0);// Truncated Cuboctahedron

//info=rhombicuboctafunc(0);// Rhombicuboctahedron
info=rhombisododekfunc(0);// Rhombicosidodecahedron
//info=cuboctaederfunc(0);  // Cuboctahedron
//info=rhombicosidodecfunc(0); //truncated icosidodecahedron
//info=ikosidodekafunc(0);  // Icosidodecahedron

//info=snubdodecafunc(0);     // Snub Dodecahedron 
//info=snubcubefunc(0);     // Snub Cube


// Other Solids

//info=prismafunc(5,0);     // Nsided Prisma
//info=antiprismafunc(6,0); // Nsided Anti-Prisma (not finished)


polyeder(info,info[0]);     // Finally assemble the Polyeder
