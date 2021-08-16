
function octree(cell, scene, subdivision = 6) =
/*O= cell origin S=cell max corner C=cell center D= cell size*/
let (
O = cell[0], S = cell[1], C = (O + S) / 2, 
D = S - O, maxD = max( D.x, D.y, D.z), 
eO = eval(O, scene),  eC = eval(C, scene), 
p1 = O,   
p2 = ([S.x, O.y, O.z]),             p3 = ([O.x, S.y, O.z]), 
p4 = ([O.x, O.y, S.z ]),            p5 = ([S.x, S.y, O.z]), 
p6 = ([S.x, O.y, S.z ]),            p7 = ([O.x, S.y, S.z]),
p8 = ([S.x, S.y, S.z ]),            p9 = C)
// if 
subdivision > 0 ?
 // if DF at cell center i larger than aproximate cell bundary sphere then do nothing
 abs(eC) > maxD * 1.71 * 0.5 ? [] : concat(
 // else split cell in 8 new cells constructed by corners and center point
octree(bflip(p1, C), scene, subdivision - 1), octree(bflip(p2, C), scene, subdivision - 1), 
octree(bflip(p3, C), scene, subdivision - 1), octree(bflip(p4, C), scene, subdivision - 1), 
octree(bflip(p5, C), scene, subdivision - 1), octree(bflip(p6, C), scene, subdivision - 1), 
octree(bflip(p7, C), scene, subdivision - 1), octree(bflip(p8, C), scene, subdivision - 1)) :

 let (
e1 = eval(p1, scene), e2 = eval(p2, scene), 
e3 = eval(p3, scene), e4 = eval(p4, scene), 
e5 = eval(p5, scene), e6 = eval( p6, scene),
e7 = eval(p7, scene), e8 = eval(p8, scene), 
face1 = [encode(C), encode(C + [0, -D.y, 0]), encode(C + [0, -D.y, -D.z]), encode(C + [ 0, 0, -D.z ]) ], 
face2 = [encode(C), encode(C + [-D.x, 0, 0]), encode(C + [-D.x, 0, -D.z ]), encode(C + [0, 0, -D.z]) ], 
face3 = [encode(C), encode(C + [ 0, -D.y, 0 ]), encode(C + [-D.x, -D.y, 0]), encode(C + [-D.x, 0, 0]) ], 
planelista = makepl(scene, e1, e2, e3, e4, e5, e6, e7, e8, p1, p2, p3, p4, p5, p6, p7, p8), // list of planes intersecting edges of current cell
 planelistb = [
 for (i = [0: len(planelista) - 1])
 if (planelista[i][1] != [undef]) planelista[i]
 ], //filter planelist
 planelistc = len(planelistb) <= 0 ? concat(planelistb, [
 [p9, un(v3(evalnorm(p9, scene)))]
 ]) : planelistb, // if plane list is short add p9
 pointa = push(C, scene, C - D * 1, C + D * 1), // Snap vertecies to nearst zero boundary inside cell
 planeC = len(planelistb) > 0 ? avrg(
 [
 for (i = [0: len(planelistb) - 1]) planelistb[i][0]
 ]) : pointa, pointb = normeq(planelistc) <= 0.1 ? pointa :
 findp2p(planeC, planelistc, C - D * 1, C + D * 1,len3(D) ), // feature detector
 pointc = pointb // lerp(pointb, push(planeC,scene,C-D*0.49 ,C+D* 0.49),0.5)
 )
abs(eC) < maxD * 1.75 * 0.5 ? [
 [encode(C), C, [
 sign(e1) == sign(e2) ? [] : sign(e1) > 0 ? face1 : rev(face1),
 sign(e1) == sign(e3) ? [] : sign(e1) > 0 ? rev(face2) : (
 face2),
 sign(e1) == sign(e4) ? [] : sign(e1) > 0 ? rev(face3) : (
 face3)
 ], planelistb]
] : [];

// build list of planes at intersected edges [p,N]
function makepl(scene, e1, e2, e3, e4, e5, e6, e7, e8, p1, p2, p3, p4,
 p5, p6, p7, p8) =
let (
s12 = inter(e1, e2), s13 = inter(e1, e3), s14 = inter(e1, e4), s52 = inter(e5, e2), 
s53 = inter(e5, e3), s58 = inter(e5, e8), s64 = inter(e6, e4), s62 = inter(e6, e2), 
s68 = inter(e6, e8), s74 = inter(e7, e4), s73 = inter(e7, e3), s78 = inter(e7, e8),
 
p12 = (s12 == undef) ? [lerp(p1, p2, 0.5), [undef]] : let (mp1 = lerp(p1, p2, s12))[mp1, un(v3(evalnorm(mp1, scene)))], 
p13 = (s13 == undef) ? [ lerp(p1, p3, 0.5), [undef] ] : let (mp2 = lerp(p1, p3, s13))[mp2, un(v3(evalnorm(mp2, scene)))],
 
 p14 = (s14 == undef) ? [lerp(p1, p4, 0.5), [ undef ]] : let (mp3 = lerp(p1, p4, s14))[mp3, un(v3(evalnorm(mp3, scene)))],
 p52 = (s52 == undef) ? [lerp(p5, p2, 0.5), [undef]] : let (mp4 = lerp(p5, p2, s52))[mp4, un(v3(evalnorm(mp4, scene)))], 
p53 = (s53 == undef) ? [ lerp(p5, p3, 0.5), [undef] ] : let (mp5 = lerp(p5, p3, s53))[mp5, un(v3(evalnorm(mp5, scene)))],
 p58 = (s58 == undef) ? [lerp(p5, p8, 0.5), [ undef ]] : let (mp6 = lerp(p5, p8, s58))[mp6, un(v3(evalnorm(mp6, scene)))],
 p64 = (s64 == undef) ? [lerp(p6, p4, 0.5), [undef]] : let (mp7 = lerp(p6, p4, s64))[mp7, un(v3(evalnorm(mp7, scene)))],
 p62 = (s62 == undef) ? [ lerp(p6, p2, 0.5), [undef] ] : let (mp8 = lerp(p6, p2, s62))[mp8, un(v3(evalnorm(mp8, scene)))],
p68 = (s68 == undef) ? [lerp(p6, p8, 0.5), [ undef ]] : let (mp9 = lerp(p6, p8, s68))[mp9, un(v3(evalnorm(mp9, scene)))],
p74 = (s74 == undef) ? [lerp(p7, p4, 0.5), [undef]] : let (mp10 = lerp(p7, p4, s74))[mp10, un(v3(evalnorm(mp10, scene)))], 
p73 = ( s73 == undef) ? [lerp(p7, p3, 0.5), [undef]] : let (mp11 = lerp( p7, p3, s73))[mp11, un(v3(evalnorm(mp11, scene)))], 
p78 = (s78 == undef) ? [lerp(p7, p8, 0.5), [ undef ]] : let (mp12 = lerp(p7, p8, s78))[mp12, un(v3(evalnorm(mp12, scene)))])

[p12, p13, p14, p52, p53, p58, p64, p62, p68, p74, p73,
 p78];
//////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////
//function encode(p)=str("X", (p.x),"Y", (p.y),"Z", (p.z));// build search key from xyz
//find and connect surrounding points to faces
// new encode: hash a vertex by seeded pseudo random 
function encode(v) =
let (xseed = round(rnd(1e8, -1e8,    round(v.x * 1e6))), 
yseed = round(rnd(1e8, - 1e8, xseed +  round(v.y * 1e6))), 
zseed = round(rnd( 1e8, -1e8, yseed + round(v.z * 1e6))), 
hash =
 round (rnd(1e8, -1e8, zseed)))
hash;

function faceworker(v) =
let (index = [
 for (i = [0: len(v) - 1]) v[i][0]
], a = [
 for (i = [0: len(v) - 1])
 if (v[i][2][0] != [])[find(v[i][2]
 [0][0], index), find(v[i][2]
 [0][1], index), find(v[i][2]
 [0][2], index), find(v[i][2]
 [0][3], index)]
], b = [
 for (i = [0: len(v) - 1])
 if (v[i][2][1] != [])[find(v[i][2]
 [1][0], index), find(v[i][2]
 [1][1], index), find(v[i][2]
 [1][2], index), find(v[i][2]
 [1][3], index)]
], c = [
 for (i = [0: len(v) - 1])
 if (v[i][2][2] != [])[find(v[i][2]
 [2][0], index), find(v[i][2]
 [2][1], index), find(v[i][2]
 [2][2], index), find(v[i][2]
 [2][3], index)]
])
concat(a, b, c);
//reverse list(face)
function rev(v) = [
 for (i = [len(v) - 1: -1: 0]) v[i]
];
//like search() but works with string key used to build polyhedron 
//function find(key,list)=[for(i=[0:len(list)-1])if(key==list[i][0])i][0];
// new find(): dont relies on strings anymore so it can use faster search. 
function find(key, list) = search(key, list, num_returns_per_match =
 1)[0];
// return vec4 of normal and distance at point q
//////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////