function octobaCh( scene, cell,subdivision = 6) =
        /*O= cell origin S=cell max corner C=cell center D= cell size*/
        let (
        O = cell[0], S = cell[1], C = (O + S) / 2, 
        D = S - O, maxD = max( D.x, D.y, D.z), 
        eC = eval(C, scene) )
        // if 
subdivision > 0 ?
         // if DF at cell center i larger than aproximate cell bundary sphere then do nothing
     abs(eC) > maxD *2 ? mapcell(scene, cell) :   // else split cell in 8 new cells constructed by corners and center point
    let(
        p1 = O,   
        p2 = ([S.x, O.y, O.z]),             p3 = ([O.x, S.y, O.z]), 
        p4 = ([O.x, O.y, S.z ]),            p5 = ([S.x, S.y, O.z]), 
        p6 = ([S.x, O.y, S.z ]),            p7 = ([O.x, S.y, S.z]),
        p8 = ([S.x, S.y, S.z ])            )
    [       
    octobaCh(scene,bflip(p1, C), subdivision - 1), 
    octobaCh(scene,bflip(p2, C), subdivision - 1), 
    octobaCh(scene,bflip(p3, C), subdivision - 1), 
    octobaCh(scene,bflip(p4, C), subdivision - 1),
    octobaCh(scene,bflip(p5, C), subdivision - 1), 
    octobaCh(scene,bflip(p6, C), subdivision - 1), 
    octobaCh(scene,bflip(p7, C), subdivision - 1), 
    octobaCh(scene,bflip(p8, C), subdivision - 1)
    ] :
  // if out of subdidvisions
mapcell(scene, cell) ; 
        
 function     mapcell(scene, cell)=
        let (
        O = cell[0], S = cell[1], D = S - O, 
        
        p1 =   O,                       p2 = ([S.x, O.y, O.z ]),         
        p3 = ([O.x, S.y, O.z]),         p4 = ([O.x, O.y, S.z ]),       
        p5 = ([S.x, S.y, O.z]),         p6 = ([S.x, O.y, S.z ]),     
        p7 = ([O.x, S.y, S.z]),         p8 = ([S.x, S.y, S.z ]), 
 
        e1=eval(  p1, scene),         e2=eval(  p2, scene), 
        e3=eval(  p3, scene),         e4=eval(  p4, scene), 
        e5=eval(  p5, scene),         e6=eval(  p6, scene), 
        e7=eval(  p7, scene),         e8=eval(  p8, scene))
[e1,e2,e3,e4,e5,e6,e7,e8] ;

 
function octsearch(p,cell,evalcache) =
        let (
        O = cell[0], S = cell[1],  C = (O + S) / 2, D = S - O)
        isleaf(evalcache)?fetchmap(p,cell,evalcache):
        let(
            p1 =   O,                       p2 = ([S.x, O.y, O.z]),         
            p3 = ([O.x, S.y, O.z]),         p4 = ([O.x, O.y, S.z ]),       
            p5 = ([S.x, S.y, O.z]),         p6 = ([S.x, O.y, S.z ]),     
            p7 = ([O.x, S.y, S.z]),         p8 = ([S.x, S.y, S.z ])
           )
         p.x< C.x && p.y< C.y &&p.z< C.z ?octsearch(p,bflip(p1, C),evalcache[0]) 
        :p.x>=C.x && p.y< C.y &&p.z< C.z ?octsearch(p,bflip(p2, C),evalcache[1])
        :p.x< C.x && p.y>=C.y &&p.z< C.z ?octsearch(p,bflip(p3, C),evalcache[2])
        :p.x>=C.x && p.y< C.y &&p.z>=C.z ?octsearch(p,bflip(p4, C),evalcache[3])
        :p.x>=C.x && p.y>=C.y &&p.z< C.z ?octsearch(p,bflip(p5, C),evalcache[4])
        :p.x>=C.x && p.y< C.y &&p.z>=C.z ?octsearch(p,bflip(p6, C),evalcache[5])
        :p.x< C.x && p.y>=C.y &&p.z>=C.z ?octsearch(p,bflip(p7, C),evalcache[6])
        ://p.x>=C.x && p.y>=C.y &&p.z>=C.z 
                                         octsearch(p,bflip(p8, C),evalcache[7])
        ;
   
function fetchmap(p,cell,cachelet)= 
    let(
        O = cell[0], S = cell[1],   D = S - O,
        p1=cachelet[0],p2=cachelet[1],p3=cachelet[2],p4=cachelet[3],
        p5=cachelet[4],p6=cachelet[5],p7=cachelet[6],p8=cachelet[7],
        xo= ((p.x-O.x)/D.x), yo= ((p.y-O.y)/D.y), zo= ((p.z-O.z)/D.z)
        //,e=!verbose?0:echo(str("found ",p," in cell ",cell))
    )
lerp(
    lerp(
        lerp(p1,p2,xo) ,
        lerp(p3,p5,xo),
    yo), 
    lerp(
        lerp(p4,p6,xo) ,
        lerp(p7,p8,xo)
    ,yo)
,zo)
;
function clamp01(i)=max(0,min(1,i));
        
function isleaf(evalcache)=len(evalcache[0] )==undef;
        