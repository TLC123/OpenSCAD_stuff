function mashatree(pose) =
let (tx = pose[0], ab = pose[1], hd = pose[2], nc = pose[3], ll = pose[4], lc = pose[5], lf = pose[6], rl = pose[7], rc = pose[8], rf = pose[9], la = pose[10], lu = pose[11], lh = pose[12], ra = pose[13], ru = pose[14], rh = pose[15], lt = [0, 0, 0], rt = [0, 0, 0])
let (ttx = [0, 0, 10], tnc = ([0, 3, 29]), thd = ([0, -1, 8]), tla = ([10, 2.5, 24]), tlu = ([33, 1, -0]), tlh = ([22, -.4, -0]), tra = ([-10, 2.5, 24]), tru = ([-33, 1, -0]), trh = ([-22, -.4, -0]), tab = ([0, 0, 2]), tll = ([9.9, 4.7, -23]), tlc = ([-0.40, 2.8, -42]), tlf = ([0.65, 2.5, -43.5]), tlt = ([-0, -6, -17]), trl = ([-9.9, 4.7, -23]), trc = ([0.40, 2.8, -42]), trf = ([-0.65, 2.5, -43.5]), trt = ([0, -6, -17]))
let (tree = 
["tx", [ttx, tx],
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
    ]])
tree;

function rotationSelector(tree, pick = [], v = [0, 0, 0]) =
let (a = (selector(tree, (pick), [1, 0, 0], 0)[1]))
let (b = (selector(tree, (pick), [0, 1, 0], 0)[1]))
let (c = (selector(tree, (pick), [0, 0, 1], 0)[1]))[[a.x, b.x, c.x, 0],
    [a.y, b.y, c.y, 0],
    [a.z, b.z, c.z, 0],
    [0, 0, 0, 1]];

function selector(tree, pick = [], v = [0, 0, 0], notransl = 1) = pick == [] ?
    let (r = tree[1])[tree[0], compose(v, r, notransl)] : let (res = selector(tree[pick[0] + 2], tail(pick), v, notransl))
let (res = [is_undef(res[0]) ? "" : str(" ", res[0]), is_undef(res[1]) ? [
    [0, 0, 0]
] : res[1]])[str(tree[0], res[0]), compose(res[1], tree[1], notransl)];

function compose(p, pq, notransl) =
let (pq = is_undef(pq) ? [
    [0, 0, 0],
    [0, 0, 0]
] : pq)
invrotate(p, pq[1]) + pq[0] * notransl;

function tail(list) = len(list) == 1 ? [] : [
    for (i = [1: max(1, len(list) - 1)]) list[i]
];

function drop(list) = len(list) == 1 ? [] : [
    for (i = [0: max(0, len(list) - 2)]) list[i]
];

function un(v) = assert(is_list(v)) v / max(norm(v), 1e-64);

function invrotate(p, q) =
let (s = sin(q.z), c = cos(-q.z)) let (p = [p.x * c - p.y * s, p.x * s + p.y * c, p.z])
let (s = sin(q.y), c = cos(-q.y)) let (p = [p.x * c + p.z * s, p.y, p.z * c - p.x * s])
let (s = sin(q.x), c = cos(-q.x)) let (p = [p.x, p.y * c - p.z * s, p.y * s + p.z * c])
p;