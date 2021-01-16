pose = getRandomPose()*0.5;
scale(10)Ldancer(pose);
baseR=1300;


color([222,184,135]/255){

translate([0,120,300])rotate(90)tobafo(baseR-220+20,0);
    
 translate([0,120,300])rotate([0,90,0])tobafo(200,145);
 translate([0,120,100])rotate([0,0,0])tobafo(145,145);
    
rotate([0,0,90]) translate([0,145,100])rotate([0,0,0])tobafo(145,100);
rotate([0,0,-90]) translate([0,145,100])rotate([0,0,0])tobafo(100,145);
    
    
    
rotate([13.1,0,0]){
    translate([0,baseR-100+77,0])rotate(0)tobafo(baseR-100+77,baseR-100+77);
    translate([baseR,0,00])rotate(90)tobafo(baseR,45);
    translate([-baseR,0,00])rotate(90)tobafo(baseR,45);
}


rotate([-180+rnd(-45,45),0,0]){
    translate([0,baseR,0])rotate(0)tobafo(baseR-100+32-5,baseR-100+32-5);
    translate([baseR-100+55-5,0,00])rotate(90)tobafo(baseR+22,45);
    translate([-(baseR-100+55-5),0,00])rotate(90)tobafo(baseR+22,45);
    
    
    rotate([0,-90+rnd(-45,45),0])
    {    translate([0,baseR-45-5,0])rotate(0)tobafo(baseR-100+22,45);
    translate([baseR-100,0,0])rotate(90)tobafo(baseR-74,45);
        
        rotate([rnd(-45,45),00,0]) translate([baseR-150,0,0])  rotate(90) tobafo(800,800);
        
        }
}

translate([baseR+50,00])rotate(90)tobafo(baseR+72,baseR+72);
translate([-(baseR+50),0,00])rotate(90)tobafo(baseR+72,baseR+72);
rotate([0,0,90]){
    translate([baseR+95,00])rotate(90)tobafo(baseR+72,baseR+72);
    translate([-(baseR+95),0,00])rotate(90)tobafo(baseR+72,baseR+72);
}
}

module tobafo(s0=1,s1=0){
    rotate([0,90,0])translate([0,0,-s1])linear_extrude(s0+s1)
    square([90,45],center=true);
    }
//
module Ldancer(pose, globalselect) {
    mtree = mashatree(pose);
    selectors = [
        [],       
        [0],        [0, 0],
        [1],        [1, 0],        [1, 0, 0],
        [2],        [2, 0],        [2, 0, 0],
        [3],        
        [3, 0],        [3, 0, 0],        [3, 0, 0, 0],
        [3, 1],        [3, 1, 0],        [3, 1, 0, 0],
    ];
    on = true;
    off = false;
    mirrors = [
        off, off, off,
        on, on, on,
        off, off, off,
        off,
        on, on, on,
        off, off, off,
    ];
    file = ["torax.stl", "collum.stl", "head.stl", "Uarm.stl",
        "ulna.stl", "hand2.stl", "Uarm.stl", "ulna.stl",
        "hand2.stl", "abdomen2.stl", "Thigh.stl", "crus.stl",
        "foot2.stl", "Thigh.stl", "crus.stl", "foot2.stl"
    ];
    for (i = [0: len(selectors) - 1]) {
        S = selectors[i];
        T = selector(mtree, S)[1];
        R = rotationSelector(mtree, (S));
        if (is_undef(globalselect) || i == globalselect)
            if (mirrors[i])
                //      mirror([1,0,0])
                translate([T.x, T.y, T.z])
        multmatrix(R)
        mirror([1, 0, 0])
        import(file[i]);
        else translate([T.x, T.y, T.z])
        multmatrix(R)
        import(file[i]);
    }
}
//generate color
function skin() =
let (sho = (rands(0, 1, 3)), mix = sho / (sho.x + sho.y + sho.z))(mix[
        0] * [255, 224, 189] / 255 + mix[1] * [255, 205, 148] / 255 +
    mix[2] * [244, 152, 80] / 255) * 0.9;

function getRandomPose() = clampAngleVector([
    [rnd(-50, 50), rnd(-30, 30), 0],    [rnd(-90, 90), rnd(-40, 40), rnd(-90, 90)],
    [-0, -30, -20],    [rnd(-60, 60), rnd(-60, 60), rnd(-60, 360)],
  
    [rnd(60, -120), rnd(120, -10), rnd(-50, 50)],
    [rnd(-0, 190), 0, 0],
    [rnd(-50, 50), 0, 0],
  
    [rnd(-60, 120), rnd(-120, 10), rnd(-50, 50)],
    [rnd(-0, 190), 0, 0],
    [rnd(-50, 50), 30, 0],
  
    [rnd(-50, 50), rnd(-150, 150), rnd(-50, 50)],
    [rnd(-150, 150), 0, rnd(-150, 150)],
    [rnd(-50, 50), rnd(-50, 50), rnd(-50, 50)],
  
    [rnd(-50, 50), rnd(-150, 150), rnd(-50, 50)],
    [rnd(-150, 150), 0, rnd(-150, 150)],
    [rnd(-50, 50), rnd(-50, 50), rnd(-50, 50)]
] * 0.5);
//masha has limits
//vMinLimit = vMinLimit();
//vMaxLimit = vMaxLimit();
function vMinLimit() = [
    [-360, -360, -360],    [-40, -40, -50],    [-60, -30, -45],    [-60, -30, -45],
    [-190, -70, -5],    [00, 0, -20],    [-40, -20, -45],
    [-190, -5, -10],    [00, 0, -30],    [-40, -30, -45],
    [-90, -20, -120],    [-80, 0, -160],    [-55, -80, -30],
    [-90, -90, -50],    [-80, 0, 00],    [-55, -45, -30]
];

function vMaxLimit() = [
    [360, 360, 360],    [50, 40, 50],    [30, 30, 45],    [30, 30, 45],
    [30, 5, 10],    [160, 00, 30],    [40, 30, 45],
    [30, 70, 5],    [160, 00, 20],    [40, 20, 45],
    [30, 80, 50],    [150, 0, 00],    [70, 45, 30],
    [30, 20, 120],    [150, 0, 160],    [70, 80, 30],
];

function clamp(a, b = 0, c = 1) = min(max(a, b), c);

function clamp3(a, b, c) = [clamp(a.x, b.x, c.x), clamp(a.y, b.y, c
    .y), clamp(a.z, b.z, c.z)
];

function clampAngleVector(v, vmin = vMinLimit(), vmax =
vMaxLimit()) = [
    for (i = [0: len(v) - 1]) clamp3(v[i], vmin[i], vmax[i])
];
// Body plan tree
function mashatree(pose) =
let (tx = pose[0], ab = pose[1], hd = pose[2], nc = pose[3], ll =
    pose[4], lc = pose[5], lf = pose[6], rl = pose[7], rc = pose[8],
    rf = pose[9], la = pose[10], lu = pose[11], lh = pose[12], ra =
    pose[13], ru = pose[14], rh = pose[15], lt = [0, 0, 0], rt = [0,
        0, 0
    ])
let (ttx = [0, 0, 10], tnc = ([0, 3, 29]), thd = ([0, -1, 8]), tla = (
        [10, 2.5, 24]), tlu = ([33, 1, -0]), tlh = ([22, -.4, -0]),
    tra = ([-10, 2.5, 24]), tru = ([-33, 1, -0]), trh = ([-22, -.4, -
        0]), tab = ([0, 0, 2]), tll = ([9.9, 4.7, -23]), tlc = ([-
        0.40, 2.8, -42
    ]), tlf = ([0.65, 2.5, -43.5]), tlt = ([-0, -6, -17]), trl = ([-
        9.9, 4.7, -23
    ]), trc = ([0.40, 2.8, -42]), trf = ([-0.65, 2.5, -43.5]), trt = (
        [0, -6, -17]))
let (tree = ["tx", [ttx, tx],
    ["nc", [tnc, nc],
        ["hd", [thd, hd]]
    ],
    ["ra", [tra, ra],
        ["ru", [tru, ru],
            ["rh", [trh, rh]]
        ]
    ],
    ["la", [tla, la],
        ["lu", [tlu, lu],
            ["lh", [tlh, lh]]
        ]
    ],
    ["ab", [tab, ab],
        ["rl", [trl, rl],
            ["rc", [trc, rc],
                ["rf", [trf, rf],
                    ["rt", [trt, rt]]
                ]
            ]
        ],
        ["ll", [tll, ll],
            ["lc", [tlc, lc],
                ["lf", [tlf, lf],
                    ["lt", [tlt, lt]]
                ]
            ]
        ]
    ]
])
tree;

function rotationSelector(tree, pick = [], v = [0, 0, 0]) =
let (a = (selector(tree, (pick), [1, 0, 0], 0)[1]))
let (b = (selector(tree, (pick), [0, 1, 0], 0)[1]))
let (c = (selector(tree, (pick), [0, 0, 1], 0)[1]))
[   [a.x, b.x, c.x, 0],
    [a.y, b.y, c.y, 0],
    [a.z, b.z, c.z, 0],
    [0  , 0  , 0  , 1]        ];

function selector(tree, pick = [], v = [0, 0, 0], notransl = 1) = 
pick    == [] ?let (r = tree[1])[tree[0], compose(v, r, notransl)] :
let (res = selector(tree[pick[0] + 2], tail(pick), v, notransl))
let (res = [is_undef(res[0]) ? "" : 
            str(" ", res[0]), is_undef(res[ 1]) ? [ [0, 0, 0] ] : res[1]])
[str(tree[0], res[0]), compose(res[1], tree[1], notransl)];

function compose(p, pq, notransl) =
let (pq = is_undef(pq) ? [    [0, 0, 0],    [0, 0, 0]] : pq)
invrotate(p, pq[1]) + pq[0] * notransl;

function tail(list) = len(list) == 1 ? [] : [    for (i = [1: max(1, len(list) - 1)]) list[i]];

function drop(list) = len(list) == 1 ? [] : [    for (i = [0: max(0, len(list) - 2)]) list[i]];

function invrotate(p, q) =
let (s = sin(q.z), c = cos(-q.z)) let (p = [p.x * c - p.y * s, p.x *    s + p.y * c, p.z])
let (s = sin(q.y), c = cos(-q.y)) let (p = [p.x * c + p.z * s, p.y, p    .z * c - p.x * s])
let (s = sin(q.x), c = cos(-q.x)) let (p = [p.x, p.y * c - p.z * s, p    .y * s + p.z * c])
p;
//utility    
function lerp(start, end, bias) = (end * bias + start * (1 - bias));

function smooth(a) =
let (b = clamp(a))(b * b * (3 - 2 * b));

function smooths(v, steps) = smooth(smooth(mods(v, steps))) / steps +
    mstep(v, steps);

function clamp(a, b = 0, c = 1) = min(max(a, b), c);

function gauss(x) = x + (x - smooth(x));

function clamp3(a, b, c) = [clamp(a.x, b.x, c.x), clamp(a.y, b.y, c
    .y), clamp(a.z, b.z, c.z)
];

function angle(a, b) = atan2(sqrt((cross(a, b) * cross(a, b))), (a *
    b));

 
 

function point2plane(p, o, n) =
let (v = o - p) p + (n * (v.x * n.x + v.y * n.y + v.z * n
.z)); //proj ap to a plane
function dist_point2plane(p, o, n) =
let (v = p - o)((v.x * n.x + v.y * n.y + v.z * n
.z)); //proj ap to a plane
 
function v3(p) = [p.x, p.y, p.z]; // vec3 formatter
function rev(v) = [    for (i = [len(v) - 1: -1: 0]) v[i]];

function avrg(l) = len(l) > 1 ? addl(l) / (len(l)) : l;

function avrgp(l) = len(l) > 1 ? addlp(l) / (len(l)) : l;

function addlp(v, i = 0, r = [0, 0, 0]) = i < len(v) ? 
  addlp(v, i + 1,    r + v[i]) : r;

function lerp(start, end, bias) = (end * bias + start * (1 - bias));

function un(v) = assert(is_list(v)) v / max(norm(v), 1e-64);

function rndc(a = 1, b = 0, s = []) = [rnd(a, b, s), rnd(a, b, s),    rnd(a, b, s)];

function rnd(a = 1, b = 0, s = []) = s == [] ? 
  (rands(min(a, b), max(    a, b), 1)[0]) : (rands(min(a, b), max(a, b), 1, s)[0]);