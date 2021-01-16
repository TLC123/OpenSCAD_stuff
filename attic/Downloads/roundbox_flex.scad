/*
    roundbox-flex.scad - create a flexible round box vector for polyhedron()
    Copyright (C) 2016 Philipp Klostermann (philipp.klostermann@pksl.de)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>
*/

// the following section is for demonstation puposes only
fn=64;

dx=20;
dy=40;
dz=10;
rx=4;
ry=11;
rz=5;
nx=40;
ny=80;
nz=15;

// If you enable animation, comment out the following line:
$t=0.25;

v = roundbox_v(dx,dy,dz*($t+0.5),rx,ry,rz,fn,nx,ny,nz);
polyhedron(v[0],v[1]);

tiefe = dy+2*ry;
breite = dx+2*rx;
vs = [for (p=v[0]) 
               let( w=((p[1]/tiefe)+0.5)*720+$t*360 ) 
               [p[0]*(0.75+sin(w)/5),p[1],p[2]*(0.75+cos(w)/5)]
        ];
translate([-(dx+2*rx+10),0,0]) 
    polyhedron(vs,v[1]);

vg = [for (p=v[0]) 
               let( w=(p[1]/tiefe)*90+90*sin($t*360-90) ) 
               [(p[0]+breite)*cos(w),sin(w)*tiefe+p[0]*sin(w),p[2]]
        ];
translate([dx+rx,0,0]) 
    polyhedron(vg,v[1]);

// end of demonstration code

/* simple module roundbox() without any modifications of points-vector
dx,dy,dz: dimensions of the inner box
rx,ry,rz: radii of the (additional) rounding per dimension
fn: resolution of roundings in steps/360°
nx,ny,nz: resolution of even faces per dimension
*/
module roundbox(dx,dy,dz,rx,ry,rz,fn,nx,ny,nz)
{
    v = roundbox_v(dx,dy,dz,rx,ry,rz,fn,nx,ny,nz);
    polyhedron(v[0],v[1]);
}

/*
function roundbox_v()
retrieves the same parameters as the module roundbox,
returns a vector with 2 elements:
[0] a vector with points, can be optionally modified and used as 
    the parameter "points" for the openSCAD module polyhedron();
[1] a vector with indexes for the points-vector, that, in normal
    cases would not be modified, can be used as the parameter "faces"
    (or, in older openSCAD versions "triangles";
*/
function roundbox_v(dx,dy,dz,rx,ry,rz,fn,nx,ny,nz) =
let
(
    step = 360/fn,
    untenpunkte = (nx+1) * (ny+1),
    wandreihen = nz-1,
    vkp = fn/4,
    eineUmrundung = ((fn+4)+(nx-1)*2+(ny-1)*2),
    rundungpunkte = vkp*eineUmrundung,
    wandpunkte = wandreihen*eineUmrundung,
    dachindex = untenpunkte+rundungpunkte*2+wandpunkte,
    letzteReiheIndex = dachindex-eineUmrundung,
    gesamtreihen = vkp * 2 + wandreihen,
    // Punkte Boden und Dach:
    v_B = [for (n=[0:1:ny]) for (m=[0:1:nx]) [-dx/2 + m*dx/nx, -dy/2 + n*dy/ny, -dz/2-rz]],
    v_D = [for (n=[0:1:ny]) for (m=[0:1:nx]) [-dx/2 + m*dx/nx, -dy/2 + n*dy/ny, dz/2+rz]],
        // Inizes Boden und Dach
    i_B = concat(
        [ for (n=[0:1:ny-1]) for (m=[0:1:nx-1]) [n*(nx+1)+m, n*(nx+1)+m+1, (n+1)*(nx+1)+m] ],
        [ for (n=[0:1:ny-1]) for (m=[0:1:nx-1]) [(n+1)*(nx+1)+m, n*(nx+1)+m+1, (n+1)*(nx+1)+m+1] ]
    ),
    i_D = concat(
        [ for (n=[0:1:ny-1]) for (m=[0:1:nx-1]) [dachindex+n*(nx+1)+m, dachindex+(n+1)*(nx+1)+m, dachindex+n*(nx+1)+m+1] ],
        [ for (n=[0:1:ny-1]) for (m=[0:1:nx-1]) [dachindex+(n+1)*(nx+1)+m, dachindex+(n+1)*(nx+1)+m+1, dachindex+n*(nx+1)+m+1] ]
    ),
    eckpunkte_v=[0, nx, (nx+1)*ny+nx, (nx+1)*ny, dachindex+0, dachindex+nx, dachindex+(nx+1)*ny+nx, dachindex+(nx+1)*ny],
    bd_ndx_inc = [ 1, nx+1, -1, -(nx+1),1,nx+1,-1,-(nx+1)],
        
    endreihen_v=
    [
        untenpunkte,
        untenpunkte+vkp+nx,
        untenpunkte+vkp*2+nx+ny,
        untenpunkte+vkp*3+nx+ny+nx,
        letzteReiheIndex,
        letzteReiheIndex+vkp+nx,
        letzteReiheIndex+vkp*2+nx+ny,
        letzteReiheIndex+vkp*3+nx+ny+nx,
    ],
    // Punkte Rundung unten:
    v_U = [for (w=[step:step:90]) make3D_v(roundsquare_v(dx,dy,rx*sin(w),ry*sin(w),fn,nx,ny),-dz/2-rz*cos(w))],
    // Punkte senkrechte wand:
    v_W = [for (n=[1:1:nz-1]) make3D_v(roundsquare_v(dx,dy,rx,ry,fn,nx,ny),-dz/2+n*dz/nz)],
    // Punkte Rundung oben:
    v_O = [for (w=[90:-step:step]) make3D_v(roundsquare_v(dx,dy,rx*sin(w),ry*sin(w),fn,nx,ny),dz/2+rz*cos(w))],
    // Indizes Reihen
    i_R = concat
    (
        // alle Reihen Dreieck links oben
        [ 
            for (j=[0:1:gesamtreihen-2])
                for (i=[0:1:eineUmrundung-1]) 
                [ 
                    untenpunkte+j*eineUmrundung+i, 
                    untenpunkte+(j+1)*eineUmrundung+i, 
                    untenpunkte+(j+1)*eineUmrundung+i+1-(i==(eineUmrundung-1)?eineUmrundung:0)
                ] 
        ] ,
        // alle Reihen Dreieck rechts unten
        [ 
            for (j=[0:1:gesamtreihen-2])
                for (i=[0:1:eineUmrundung-1]) 
                [ 
                    untenpunkte+j*eineUmrundung+i, 
                    untenpunkte+(j+1)*eineUmrundung+i+1-(i==(eineUmrundung-1)?eineUmrundung:0), 
                    untenpunkte+j*eineUmrundung+i+1-(i==(eineUmrundung-1)?eineUmrundung:0)
                ] 
        ] ,
        // die 8 runden Ecken
        [
            for (j=[0:1:7])
                for (i=[0:1:vkp-1])
                (j <= 3) ?
                [
                    eckpunkte_v[j], 
                    endreihen_v[j]+i,
                    endreihen_v[j]+i+1
                ]
                :
                [
                    eckpunkte_v[j],
                    endreihen_v[j]+i+1, 
                    endreihen_v[j]+i
                ]
        ],
        // die 4 unteren runden Seiten
        [
            for (j=[0:1:7])
                for (i=[0:1:j%2?(ny-1):(nx-1)])
                (j <= 3) ?
                [
                    eckpunkte_v[j]+i*bd_ndx_inc[j], 
                    endreihen_v[j]+vkp+i,
                    (((i==ny-1)&&((j==3)||(j==7)))) ? 
                        (j==3)?endreihen_v[0]:endreihen_v[4]
                        :
                        endreihen_v[j]+vkp+i+1
                ]
                :
                [
                    eckpunkte_v[j]+i*bd_ndx_inc[j], 
                    (((i==ny-1)&&((j==3)||(j==7)))) ? 
                        (j==3)?endreihen_v[0]:endreihen_v[4]
                        :
                        endreihen_v[j]+vkp+i+1,
                    endreihen_v[j]+vkp+i,
                ]
        ],
        [
            for (j=[0:1:7])
                for (i=[0:1:j%2?(ny-1):(nx-1)])
                (j <= 3) ?
                [
                    eckpunkte_v[j]+i*bd_ndx_inc[j], 
                    (((i==ny-1)&&((j==3)||(j==7)))) ? 
                        (j==3)?endreihen_v[0]:endreihen_v[4]
                        :
                        endreihen_v[j]+vkp+i+1,
                    eckpunkte_v[j]+(i+1)*bd_ndx_inc[j]
                ]
                :
                [
                    eckpunkte_v[j]+i*bd_ndx_inc[j], 
                    eckpunkte_v[j]+(i+1)*bd_ndx_inc[j], 
                    (((i==ny-1)&&((j==3)||(j==7)))) ? 
                        (j==3)?endreihen_v[0]:endreihen_v[4]
                        :
                        endreihen_v[j]+vkp+i+1
                ]
        ]
    ),
    v_ges = flatten_v(concat([v_B], v_U, v_W, v_O, [v_D])),
    // v_ges = concat(v_B, v_U, v_W, v_O, v_D),
    i_ges = concat(i_B, i_R, i_D)
)
[v_ges,i_ges];

// Helper fuctions
// use this module to show little cubes, where the points of a "points"-vector are
module debug_points(v)
{
    for (p=v) translate(p) cube([0.5,0.5,0.5], center=true);
}

// returns the points of a rounded square
function roundsquare_v(dx,dy,rx,ry,fn,nx,ny) =
concat(
    viertelkreis_v(-dx/2,-dy/2,rx,ry,180,fn),
    punktedazwischen_v(-dx/2, -dy/2-ry, dx, 0, nx),
    viertelkreis_v(dx/2,-dy/2,rx,ry,270,fn),
    punktedazwischen_v(dx/2+rx, -dy/2, 0, dy, ny),
    viertelkreis_v(dx/2,dy/2,rx,ry,0,fn),
    punktedazwischen_v(dx/2, dy/2+ry, -dx, 0, nx),
    viertelkreis_v(-dx/2,dy/2,rx,ry,90,fn),
    punktedazwischen_v(-dx/2-rx, dy/2, 0, -dy, ny)
    );

// returns the points on a straight line between to points
function punktedazwischen_v(x,y,dx,dy,n) =
[ for (a=[1:1:n-1]) [x + dx/n * a, y + dy/n * a] ];

// returns the points of 1/4 circle
function viertelkreis_v(x,y,rx,ry,sw,fn) =
[ for (w=[sw:360/fn:sw+90]) [x+cos(w)*rx,y+sin(w)*ry] ];

// adds to each 2-D element (x,y) a 3rd value for z
function make3D_v(v,z) = [ for (a = v) [a[0], a[1], z] ];
    
// from the openSCAD documentation:
function flatten_v(l) = [ for (a = l) for (b = a) b ] ;

