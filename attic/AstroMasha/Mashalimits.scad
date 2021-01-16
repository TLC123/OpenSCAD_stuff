vMinLimit = vMinLimit();
vMaxLimit = vMaxLimit();
function vMinLimit() =  [
[-360, -360, -360],    [-100, -40, -50],    [-60, -30, -45],    [-60, -30, -45],
[-190, -70, -5],    [00, 0, -20],    [-40, -20, -45],
[-190, -5, -10],    [00, 0, -30],    [-40, -30, -45],
[-90, -80, -120],    [-80, 0, -160],    [-55, -80, -30],
[-90, -20, -50],    [-80, 0, 00],    [-55, -45, -30]
];
function   vMaxLimit() =  [
[360, 360, 360], [40, 40, 50],    [30, 30, 45],    [30, 30, 45],
[30, 5, 10],     [160, 00, 30],    [40, 30, 45],
[30, 70, 5],     [160, 00, 20],    [40, 20, 45],
[30, 20, 50],    [150, 0, 00],    [70, 45, 30],
[30, 80, 120],   [150, 0, 160],    [70, 80, 30],
];
function clamp(a, b = 0, c = 1) = min(max(a, b), c);
function clamp3(a, b, c) = [clamp(a.x, b.x, c.x), clamp(a.y, b.y, c.y), clamp(a.z, b.z, c.z)];
function clampAngleVector(v, vmin=vMinLimit, vmax=vMaxLimit) = [
    for (i = [0: len(v) - 1]) clamp3(v[i], vmin[i], vmax[i])
];