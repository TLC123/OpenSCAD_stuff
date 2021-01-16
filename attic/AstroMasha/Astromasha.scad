vMinLimit = [
    [0, 0, 0],
    [-40, -50, -70],
    [-60, -30, -45],
    [-60, -30, -45],
    [-90, -70, -5],
    [00, 00, -20],
    [-40, -20, -45],
    [-90, -70, -5],
    [00, 00, -20],
    [-40, -20, -45],
    [-90, -20, -120],
    [-150, 0, -160],
    [-70, -45, -30],
    [-90, -20, -120],
    [-150, 0, -160],
    [-70, -45, -30]
];
vMaxLimit = [
    [0, 0, 0],
    [120, 50, 70],
    [30, 30, 45],
    [30, 30, 45],
    [30, 5, 10],
    [160, 0, 30],
    [40, 30, 45],
    [30, 5, 10],
    [160, 0, 30],
    [40, 30, 45],
    [90, 80, 50],
    [80, 0, 0],
    [55, 80, 30],
    [90, 80, 50],
    [80, 0, 0],
    [55, 80, 30]
];




posecount = 199;
$t = rands(0, 1, 2)[1];
vp = [0, 1, sin(($t) * 360 * 50) * 30 + sin(.2 + $t * 360 * 21) * 11];
vp2 = [0, 1, sin(($t - .1) * 360 * 50) * 30 + sin(.2 + $t * 360 * 21) * 11];

//$vpt=vp2+[0,0,100-+sin(.2+$t*360*21)*11 ]+[01,-90,-30];
//$vpr=[70+sin($t*posecount*10)*10,-20,-$t*posecount*10+150];
//$vpd=(700);

//
//sky=[for(i=[0:1000])rands(-360,360,3,i)];
// sky();
vo = (getpose());
//vTest=[
//[0,0,0],[0,0,0],[0,0,0],[0,0,0],
//[0,0,0],[0,0,0],[0,0,0],
//[0,0,0],[0,0,0],[0,0,0],
//[80,90,1000],[90,0,-80],[0,0,0],
//[-80,-90,-10000],[-90,0,-80],[0,0,0]
//];

v = clampAngleVector(vo, vMinLimit, vMaxLimit);
dancer(v);


module dancer(v) {
    ab = v[0];
    tx = v[1];
    nc = v[2];
    hd = v[3];
    ll = v[4];
    lc = v[5];
    lf = v[6];
    rl = v[7];
    rc = v[8];
    rf = v[9];
    la = v[10];
    lu = v[11];
    lh = v[12];
    ra = v[13];
    ru = v[14];
    rh = v[15];

    //translate(vp)
    translate([0, 1, 100]) rotate(ab) {

        hull() import("abdomen.stl");

        translate([0, -3, 25])//tx   
        rotate(tx)   {
            hull() import("torax.stl");


            translate([0, 3, 29]) //nc
            rotate(nc) {
                hull() import("collum.stl");

                translate([0, -1, 8]) //hc
                rotate(hd) {
                    hull() import("head.stl");


                }
            }



            //left arm
            translate([10, 4.5, 22])//la
            rotate(la) {
                import("Uarm.stl");

                translate([33, 1, -0])//lu
                rotate(lu) {
                    import("ulna.stl");

                    translate([22, -.4, -0])//lh
                    rotate(lh) {
                        import("hand.stl");


                    }
                }
            }

            //right arm
            mirror([-1, 0, 0]) 
            translate([10, 4.5, 22])//ra
            rotate(ra) {
                import("Uarm.stl");

                translate([33, 1, -0])//ru
                rotate(ru) {
                    import("ulna.stl");
                    translate([22, -.4, -0])//rh
                    rotate(rh) {
                        import("hand.stl");


                    }
                }
            }

        }

        //left leg

        translate([9.9, 1.7, 2])//ll
        rotate(ll) {
            hull() import("Thigh.stl");
            translate([-0.40, 2.8, -42])//lc
            rotate(lc) {
                import("crus.stl");

                translate([0.65, 2.5, -43.5])//lf
                rotate(lf) {
                    import("foot.stl");
  hull(){
                    translate([.5,-10,-16])cylinder(1, 5, 5,center=true);
                    translate([-1,5,-16])cylinder(1,4,4,center=true);
                    }

                }
            }
        }

        //right leg

        mirror([-1, 0, 0])
        translate([9.9, 1.7, 2])//rl
        rotate(rl) {
            hull() import("Thigh.stl");
            translate([-0.40, 2.8, -42])//rc
            rotate(rc) {
                import("crus.stl");

                translate([0.65, 2.5, -43.5])//rf
                rotate(rf) {
                    import("foot.stl"); 
                    hull(){
                    translate([.5,-10,-16])cylinder(1, 5, 5,center=true);
                    translate([-1,5,-16])cylinder(1,4,4,center=true);
                    }

                }
            }
        }


    }
}

function getpose() =
let (

    vv = [
        for (j = [0: posecount])
            clampAngleVector([
                for (i = [0: 15]) rands(-25, 25, 3, i + 10001 + j)
            ], vMinLimit, vMaxLimit)
    ],
    iv = [
        for (i = [0: posecount]) round(rands(0, 1, 1, 10000 + i)[0])
    ],

    T = $t * posecount,
    m = (smooth(T - floor(T))),
    im = 1 - m,
    //echo (floor(T),ceil(T),m),
    v = lerp(vv[floor(T)], vv[ceil(T)], m) * (.6 + sin($t * 360 * 2) * .1),
    l = smooth(smooth(smooth(lerp(iv[floor(T)], iv[ceil(T)], m)))),
    il = 1 - l,

    ab = v[0] * 1 + [0, 0, 0] - [0, sin($t * 360 * 100 - 30) * 20, 0],
    tx = [v[1].x * 1.2, v[1].y, v[1].z] * 2 + [10, 0, 0] + [0, sin($t * 360 * 100 - 20) * 35, 0],
    nc = v[2] * 2,
    hd = v[3] * 2,

    ll = [v[4].x, -abs(v[4].y), v[4].z * .135] * il * 4 + [-ab.x, -ab.y, 0] * l +
    [-abs(v[5].x) * 5, 0, 0] * l * .5 +
    [sin($t * 360 * 100) * 25 - 15, 0, 0],
    lc = [abs(v[5].x) * 5, 0, 0],
    lf = v[6] * 2,

    rl = [v[7].x, -abs(v[7].y), v[7].z * .135] * l * 4 + [-ab.x, ab.y, 0] * il +
    [-abs(v[8].x) * 5, 0, 0] * il * .5 +
    [sin($t * 360 * 100 + 180) * 25 - 15, 0, 0],
    rc = [abs(v[8].x) * 5, 0, 0],
    rf = v[9] * 2 + [-30, 0, 0],

    la = v[10] * 3 + [30, -10, -20] +
    [sin($t * 360 * 100 + 180 + 30) * 15 - 5, 0, 0],

    lu = [abs(v[11].x) * -5, 0, 0],
    lh = v[12] * 2,

    ra = v[13] * 3 + [30, -10, -20] +
    [sin($t * 360 * 100 + 30) * 15 - 5, 0, 0],

    ru = [abs(v[14].x) * -5, 0, 0],
    rh = v[15] * 2)[ab, tx, nc, hd, ll, lc, lf, rl, rc, rf, la, lu, lh, ra, ru, rh];


module sky() {
    for (i = [0: 1000])
        color("white") rotate(sky[i]) translate([5000, 0, 0]) cube(5.5);

}

function lerp(start, end, bias) = (end * bias + start * (1 - bias));

function smooth(a) =
let (b = clamp(a))(b * b * (3 - 2 * b));

function smooths(v, steps) = smooth(smooth(mods(v, steps))) / steps + mstep(v, steps);



function gauss(x) =
x + (x - smooth(x));

function clamp(a, b = 0, c = 1) = min(max(a, b), c);

function clamp3(a, b, c) = [clamp(a.x, b.x, c.x), clamp(a.y, b.y, c.y), clamp(a.z, b.z, c.z)];

function clampAngleVector(v, vmin, vmax) = [
    for (i = [0: len(v) - 1]) clamp3(v[i], vmin[i], vmax[i])
];