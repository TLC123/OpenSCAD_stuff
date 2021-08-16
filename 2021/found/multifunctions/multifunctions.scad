function ywilde(i) = [wildstore[i], 0, wildstore[i * 3]];

function y(v) = [v[0], 0, v[2]];

function y(p) = lookup(p, ylist);

function xyz_to_spherical(p) = [norm(p), acos(p.z / norm(p)), atan2(p.x, p.y)];

 

function wilde(i) = [wildstore[i], wildstore[i * 2], wildstore[i * 3]];

function whirl(obj, ratio = 0.3333, height = 0.2) = /*//retain original vertices,add directed edge points and rotated inset points*/ /*//each edge becomes 2 hexagons*/
    let (pf = p_faces(obj), pv = p_vertices(obj), pe = p_edges(obj)) let (newv = concat(flatten([
        for (face = pf) /*//centroids*/ let (fp = as_points(face, pv)) let (c = centroid(fp))[
            for (i = [0: len(face) - 1]) let (f = face[i]) let (ep = [fp[i], fp[(i + 1) % len(face)]]) let (mid = ep[0] + ratio * (ep[1] - ep[0]))[[face, f], mid + ratio * (c - mid)]]
    ]), flatten( /*//2 points per edge*/ [
        for (edge = pe) let (ep = as_points(edge, pv))[[edge, ep[0] + ratio * (ep[1] - ep[0])], [reverse(edge), ep[1] + ratio * (ep[0] - ep[1])]]
    ]))) let (newids = vertex_ids(newv, len(pv))) let (newf = concat(flatten( /*//new faces are pentagons */ [
        for (face = pf)[
            for (j = [0: len(face) - 1]) let (a = face[j], b = face[(j + 1) % len(face)], c = face[(j + 2) % len(face)], eab = vertex([a, b], newids), eba = vertex([b, a], newids), ebc = vertex([b, c], newids), mida = vertex([face, a], newids), midb = vertex([face, b], newids))[eab, eba, b, ebc, midb, mida]]
    ]), [
        for (face = pf)[
            for (j = [0: len(face) - 1]) let (a = face[j]) vertex([face, a], newids)]
    ])) poly(name = str("w", p_name(obj)), vertices = concat(pv, vertex_values(newv)), faces = newf, debug = newv);

function weld(v) =
    let (data = v[0])[v[0], [
        for (i = [0: len(v[1]) - 1]) let (index1 = v[1][i][0], index2 = v[1][i][1], index3 = v[1][i][2]) concat(search(data[index1][0], data), search(data[index2][0], data), search(data[index3][0], data, 1))
    ]];

function wavestar_profile(size = 1, frequency = 4, amplitude = 1) = [ /*//The first point is the anchor point,put it on the point corresponding to [cos(0),sin(0)]*/
    for (i = [0: 180 - 1])(size + amplitude * (1 + sin(frequency * 2 * i))) * [cos(2 * i), sin(2 * i)]
];

function wave(w, a = 1, b = 1) = [
    [
        for (i = [0: len(w[0]) - 1]) let (x = w[0][i][0], y = w[0][i][1], z = w[0][i][2]) w[0][i] + [sin((y + z) * b) * a, sin((z + x) * b) * a, sin((x + y) * b) * a]
    ], w[1]
];

function wave(w, a = 1, b = 1) = [
    [
        for (i = [0: len(w[0]) - 1]) let (x = w[0][i][0], y = w[0][i][1], z = w[0][i][2]) w[0][i] + [sin((y + z) * b) * a, sin((z + x) * b) * a, sin((x + y) * b) * a]
    ], w[1]
];

function w3rnd(c) = [rands(-1, 1, 1)[0] * c, rands(-1, 1, 1)[0] * c * 0.1, rands(-1, 1, 1)[0]] * c;

function vsum(points, i = 0) = i < len(points) ? (points[i] + vsum(points, i + 1)) : [0, 0, 0];

function vsmooth(v) = [
    for (i = [0: 1 / len(v): 1]) bez2(i, v)
];

function vsmooth(v) = [
    for (i = [0: 1 / len(v) * 0.5: 1]) bez2(i, v)
];

function vsharp(v) = [
    for (i = [0: 0.5: len(v) - 1]) v[floor(i)]
];

function vsharp(v) = [
    for (i = [0: 0.5: len(v) - 1]) v[floor(i)]
];

function vsharp(v) = [
    for (i = [0: 0.5: len(v) - 1]) v[floor(i)]
];

function vnorm(points) = [
    for (p = points) norm(p)
];

function vertex_values(entries) = [
    for (e = entries) e[1]
];

function vertex_ids(entries, offset = 0, i = 0) = /*//to get position of new vertices */ len(entries) > 0 ? [
    for (i = [0: len(entries) - 1])[entries[i][0], i + offset]
] : [];

function vertex_faces(v, faces) = /*//return the faces containing v*/ [
    for (f = faces)
        if (v != [] && search(v, f)) f
];

function vertex_face_list(vertices, faces) = [
    for (i = [0: len(vertices) - 1]) let (vf = vertex_faces(i, faces)) len(vf)
];

function vertex_edges(v, edges) = /*//return the ordered edges containing v*/ [
    for (e = edges)
        if (e[0] == v || e[1] == v) e
];

function vertex_analysis(vertices, faces) =
    let (face_counts = vertex_face_list(vertices, faces))[
        for (vo = distinct(face_counts))[vo, count(vo, face_counts)]];

function vertex(key, entries) = /*//key is an array */ entries[search([key], entries)[0]][1];

function vecmul(v, mul) = (len(v) == 3) ? [v[0] * mul[0], v[1] * mul[1], v[2] * mul[2]] : [
    for (i = [0: len(v) - 1]) vecmul(v[i], mul)
];

function vecmul(v, mul) = (len(v) == 3 && len(v[0]) == 1 && len(v[1]) == 1 && len(v[2]) == 1) ? [v[0] * mul[0], v[1] * mul[1], v[2] * mul[2]] : [
    for (i = [0: len(v) - 1]) vecmul(v[i], mul)
];

function vec_is_undef(x, index_ = 0) = index_ >= len(x) ? true : is_undef(x[index_]) && vec_is_undef(x, index_ + 1);

function vec4_mults(v, s) = [v[0] * s, v[1] * s, v[2] * s, v[3] * s];

function vec4_mult_mat4(vec, mat) = [vec4_dot(vec, mat4_col(mat, 0)), vec4_dot(vec, mat4_col(mat, 1)), vec4_dot(vec, mat4_col(mat, 2)), vec4_dot(vec, mat4_col(mat, 3)), ];

function vec4_mult_mat34(vec, mat) = [vec4_dot(vec, mat4_col(mat, 0)), vec4_dot(vec, mat4_col(mat, 1)), vec4_dot(vec, mat4_col(mat, 2))];

function vec4_lengthsqr(v) = v[0] * v[0] + v[1] * v[1] + v[2] * v[2] + v[3] * v[3];

function vec4_from_vec3(v) = [v[0], v[1], v[2], 1];

function vec4_dot(v1, v2) = v1[0] * v2[0] + v1[1] * v2[1] + v1[2] * v2[2] + v1[3] * v2[3];

function vec4_add(v1, v2) = [v1[0] + v2[0], v1[1] + v2[1], v1[2] + v2[2], v1[3] + v2[3]];

function vec4(p) =
    let (v3 = vec3(p)) len(v3) < 4 ? concat(v3, 1) : v3;

function vec3_mults(v, s) = [v[0] * s, v[1] * s, v[2] * s];

function vec3_from_vec4(v) = [v[0], v[1], v[2]];

function vec3_from_point3(pt) = [pt[0], pt[1], pt[2]];

function vec3_dot(v1, v2) = v1[0] * v2[0] + v1[1] * v2[1] + v1[2] * v2[2];

function vec3_add(v1, v2) = [v1[0] + v2[0], v1[1] + v2[1], v1[2] + v2[2]];

function vec3(v) = [v.x, v.y, v.z];

function vec3(p) = len(p) < 3 ? concat(p, 0) : p;

function vec2_mults(v, s) = [v[0] * s, v[1] * s];

function vec2_from_vec3(pt) = [pt[0], pt[1]];

function vec2_from_point3(pt) = [pt[0], pt[1]];

function vec2_add(v1, v2) = [v1[0] + v2[0], v1[1] + v2[1]];

function vcontains(val, list) = search([val], list)[0] != [];

function value_of(key, list) = list[search([key], list)[0]][1];

function val(a = undef,
        default = undef) = a == undef ?
    default : a;

function vadd(points, v, i = 0) = i < len(points) ? concat([points[i] + v], vadd(points, v, i + 1)) : [];

function v3rnd(c = 1) = [rands(-1, 1, 1)[0] * c, rands(-1, 1, 1)[0] * c, rands(-1, 1, 1)[0]] * c;

function v3rnd(c) = [rands(-1, 1, 1)[0] * c, rands(-1, 1, 1)[0] * c, rands(-1, 1, 1)[0]] * c;

function v3(p) = [p.x, p.y, p.z];

function v2xy(v) = lim3(1, [v[0], v[1], 0]);

function v2t(v, stop, p = 0) = p + 1 > len(v) - 1 || stop < len3(v[p] - v[p + 1]) ? v[p] + un(v[p + 1] - v[p]) * stop : v2t(v, stop - len3(v[p] - v[p + 1]), p + 1);

function v2t(v, stop, p = 0) = p + 1 > len(v) - 1 || stop < len3(v[p] - v[p + 1]) ? v[p] + un(v[p + 1] - v[p]) * stop : v2t(v, stop - len3(v[p] - v[p + 1]), p + 1);

function v2spl(v, t = 0.3) =
    let (L = len(v) - 1)[
        for (i = [0: L - 1]) let (prev = max(0, i - 1), next = min(L, i + 1), nnext = min(L, i + 2)) let (M = len3(v[next] - v[i]), N0 = un(v[i] - v[prev]), N1 = un(v[next] - v[i]), N2 = un(v[nnext] - v[next]), N01 = un(N0 + N1) * M * t, N12 = un(N1 + N2) * M * t, P1 = v[i] + N01, P2 = v[next] - N12, L1 = lerp(v[i], v[next], t), L2 = lerp(v[i], v[next], 1 - t), O1 = concat([P1[0], P1[1], P1[2]], [
            for (ii = [3: len(L1) - 1]) L1[ii]
        ]), O2 = concat([P2[0], P2[1], P2[2]], [
            for (ii = [3: len(L2) - 1]) L2[ii]
        ]))[v[i], O1, O2, v[next]]];

function v2spl(v, t = 0.3) =
    let (L = len(v) - 1)[
        for (i = [0: L - 1]) let (prev = max(0, i - 1), next = min(L, i + 1), nnext = min(L, i + 2)) let (M = len3(v[next] - v[i]), N0 = un(v[i] - v[prev]), N1 = un(v[next] - v[i]), N2 = un(v[nnext] - v[next]), N01 = un(N0 + N1) * M * t, N12 = un(N1 + N2) * M * t)[v[i], v[i] + N01, v[next] - N12, v[next]]];

function v2round(v, t = 0.01) =
    let (L = len(v) - 1)[
        for (i = [0: L - 1]) let (prev = max(0, i - 1), next = min(L, i + 1), nnext = min(L, i + 2))[lerp(v[i], v[next], t), lerp(v[i], v[next], 1 - t)]];

function v2rad(v, r = 0.3) =
    let (L = len(v) - 1)[
        for (i = [0: 0.5: L - 0.5]) let (next = min(L, floor(i) + 1), prev = max(0, floor(i) - 1)) floor(i) != i ? [v[i], v[next]] : [1]];

function v(i, v) = v[i + 1] - v[i];

function uv2euler(v) = [0, -asin(v[2]), atan2(bez2xy(v[1]), bez2xy(v[0]))];

function unitv(v) = v / mod(v);

function unit(v) = v / norm(v);

function unit(v) = v / len3(v);

function unfold(fdna) = concat(repete(fdna[0]), repete(fdna[1]), repete(fdna[2]), repete(fdna[3]), repete(fdna[4]), repete(fdna[5]), repete(fdna[6]), repete(fdna[7]), repete(fdna[8]), repete(fdna[9]), repete(fdna[10]), repete(fdna[11]), repete(fdna[12]), repete(fdna[13]), repete(fdna[14]), repete(fdna[15]));

function unfold(fdna) = concat(repete(fdna, 0), repete(fdna, 1), repete(fdna, 2), repete(fdna, 3), repete(fdna, 4), repete(fdna, 5), repete(fdna, 6), repete(fdna, 7), repete(fdna, 8), repete(fdna, 9), repete(fdna, 10), repete(fdna, 11), repete(fdna, 12), repete(fdna, 13), repete(fdna, 14), repete(fdna, 15));

function un(v) = v / max(len3(v), 0.000001) * 1;

function un(v) = v / len3(v);

function un(v) = v / len3(v) * 1;

function tt(obj) = /*//replace triangular faces with 4 triangles */ /*//requires all faces to be triangular*/
    let (pf = p_faces(obj), pv = p_vertices(obj), pe = p_edges(obj)) let (newv = /*//edge mid points */ [
        for (edge = pe) let (ep = as_points(edge, pv))[edge, (ep[0] + ep[1]) / 2]
    ]) let (newids = vertex_ids(newv, len(pv))) let (newf = flatten([
        for (i = [0: len(pf) - 1]) let (face = pf[i]) let (innerface = [vertex(distinct_edge([face[0], face[1]]), newids), vertex(distinct_edge([face[1], face[2]]), newids), vertex(distinct_edge([face[2], face[0]]), newids)]) concat([innerface], [
            for (j = [0: 2])[face[j], innerface[j], innerface[(j - 1 + len(face)) % len(face)]]
        ])
    ])) poly(name = str("u", p_name(obj)), vertices = concat(pv, vertex_values(newv)), faces = newf);

function trunk2core(T, i = 0) = i == len(T) - 1 ?
    let (grove = T[i][1][3]) let (tr1 = T[i][1][2]) let (points = concat([tr1], [tr1])) points : let (grove = T[i][1][3]) let (tr1 = T[i][1][2]) let (tr2 = lerp(T[i][1][2], T[min(len(T) - 1, i + 1)][1][2], 0.2)) let (tr3 = lerp(T[i][1][2], T[min(len(T) - 1, i + 1)][1][2], grove[2]), points = grove[1] < 0.7 ? concat([tr1], [tr2], [tr3], trunk2core(T, i + 1)) : concat([tr1], trunk2core(T, i + 1))) points;

function trunc(obj, ratio = 0.25, fn = []) =
    let (pv = p_vertices(obj), pf = p_faces(obj)) let (newv = flatten([
        for (i = [0: len(pv) - 1]) let (v = pv[i]) let (vf = vertex_faces(i, pf)) selected_face(vf, fn) /*//should drop the _face */ ?
            let (oe = ordered_vertex_edges(i, vf))[
                for (edge = oe) let (opv = pv[edge[1]])[edge, v + (opv - v) * ratio]] : [
                [
                    [i], v
                ]
            ]
    ])) let (newids = vertex_ids(newv)) let (newf = concat( /*//truncated faces*/ [
        for (face = pf) flatten([
            for (j = [0: len(face) - 1]) let (a = face[j]) let (nv = vertex([a], newids)) nv != undef ? nv /*//not truncated,just renumbered*/ : let (b = face[(j + 1) % len(face)], z = face[(j - 1 + len(face)) % len(face)], eab = [a, b], eaz = [a, z], vab = vertex(eab, newids), vaz = vertex(eaz, newids))[vaz, vab]
        ])
    ], [
        for (i = [0: len(pv) - 1]) /*//truncated vertexes*/ let (vf = vertex_faces(i, pf)) if (selected_face(vf, fn)) let (oe = ordered_vertex_edges(i, vf))[
            for (edge = oe) vertex(edge, newids)]
    ])) poly(name = str("t", p_name(obj)), vertices = vertex_values(newv), faces = newf);

function tril(x, y, z, V000, V100, V010, V001, V101, V011, V110, V111) = V111 * (1 - x) * (1 - y) * (1 - z) + V011 * x * (1 - y) * (1 - z) + V101 * (1 - x) * y * (1 - z) + V110 * (1 - x) * (1 - y) * z + V010 * x * (1 - y) * z + V100 * (1 - x) * y * z + V001 * x * y * (1 - z) + V000 * x * y * z;

function tril(x, y, z, V000, V100, V010, V001, V101, V011, V110, V111) = /*V111*(1-x)*(1-y)*(1-z)+V011*x*(1-y)*(1-z)+V101*(1-x)*y*(1-z)+V110*(1-x)*(1-y)*z+V010*x*(1-y)*z+V100*(1-x)*y*z+V001*x*y*(1-z)+V000*x*y*z */ V000 * (1 - x) * (1 - y) * (1 - z) + V100 * x * (1 - y) * (1 - z) + V010 * (1 - x) * y * (1 - z) + V001 * (1 - x) * (1 - y) * z + V101 * x * (1 - y) * z + V011 * (1 - x) * y * z + V110 * x * y * (1 - z) + V111 * x * y * z;

function tril(x, y, z, V000, V100, V010, V001, V101, V011, V110, V111) = /*V111*(1-x)*(1-y)*(1-z)+V011* x *(1-y)*(1-z)+V101*(1-x)*y *(1-z)+V110*(1-x)*(1-y)* z+V010* x *(1-y)* z+V100*(1-x)* y *z+V001* x *y*(1-z)+V000* x *y *z */ V000 * (1 - x) * (1 - y) * (1 - z) + V100 * x * (1 - y) * (1 - z) + V010 * (1 - x) * y * (1 - z) + V001 * (1 - x) * (1 - y) * z + V101 * x * (1 - y) * z + V011 * (1 - x) * y * z + V110 * x * y * (1 - z) + V111 * x * y * z;

function tril(x, y, z, V000, V100, V010, V001, V101, V011, V110, V111) = /*V111*(1-x)*(1-y)*(1-z)+V011* x *(1-y)*(1-z)+V101*(1-x)*y *(1-z)+V110*(1-x)*(1-y)* z+V010* x *(1-y)* z+V100*(1-x)* y *z+V001* x *y*(1-z)+V000* x *y *z */ V000 * SC3((1 - x) * (1 - y) * (1 - z)) + V100 * SC3(x * (1 - y) * (1 - z)) + V010 * SC3((1 - x) * y * (1 - z)) + V001 * SC3((1 - x) * (1 - y) * z) + V101 * SC3(x * (1 - y) * z) + V011 * SC3((1 - x) * y * z) + V110 * SC3(x * y * (1 - z)) + V111 * SC3(x * y * z);

function tril(x, y, z, V00, V100, V010, V001, V101, V011, V110, V111) = V000 * (1 - x) * (1 - y) * (1 - z) + V100 * x * (1 - y) * (1 - z) + V010 * (1 - x) * y * (1 - z) + V001 * (1 - x) * (1 - y) * z + V101 * x * (1 - y) * z + V011 * (1 - x) * y * z + V110 * x * y * (1 - z) + V111 * x * y * z;

function triarea(v0, v1) = cross(v0, v1) / 2;

function triangle(a, b) = norm(cross(a, b)) / 2;

function transpose_4(m) = [
    [m[0][0], m[1][0], m[2][0], m[3][0]],
    [m[0][1], m[1][1], m[2][1], m[3][1]],
    [m[0][2], m[1][2], m[2][2], m[3][2]],
    [m[0][3], m[1][3], m[2][3], m[3][3]]
];

function transpose_3(m) = [
    [m[0][0], m[1][0], m[2][0]],
    [m[0][1], m[1][1], m[2][1]],
    [m[0][2], m[1][2], m[2][2]]
];

function translationv_2(x, y, z, translation) = x == undef && y == undef && z == undef ? translation : is_undef(translation) ? [val(x, 0), val(y, 0), val(z, 0)] : undef;

function translationv(left = undef, right = undef, up = undef, down = undef, forward = undef, backward = undef, translation = undef) = translationv_2(x = either(up, -down), y = either(right, -left), z = either(forward, -backward), translation = translation);

function translation_part(m) = [m[0][3], m[1][3], m[2][3]];

function translation(v) = [
    [1, 0, 0, v[0]],
    [0, 1, 0, v[1]],
    [0, 0, 1, v[2]],
    [0, 0, 0, 1],
];

function translate(v, poly) = is_poly_vector(poly) ? [
    for (p = poly) _translate(v = v, poly = p)
] : _translate(v = v, poly = poly);

function transform_translate(xyz) = [
    [1, 0, 0, xyz[0]],
    [0, 1, 0, xyz[1]],
    [0, 0, 1, xyz[2]],
    [0, 0, 0, 1]
];

function transform_scale(xyz) = [
    [xyz[0], 0, 0, 0],
    [0, xyz[1], 0, 0],
    [0, 0, xyz[2], 0],
    [0, 0, 0, 1]
];

function transform_rotz(deg) = [
    [cos(deg), -sin(deg), 0, 0],
    [sin(deg), cos(deg), 0, 0],
    [0, 0, 1, 0],
    [0, 0, 0, 1]
];

function transform_roty(deg) = [
    [cos(deg), 0, sin(deg), 0],
    [0, 1, 0, 0],
    [-sin(deg), 0, cos(deg), 0],
    [0, 0, 0, 1]
];

function transform_rotx(angle) = [
    [1, 0, 0, 0],
    [0, cos(angle), -sin(angle), 0],
    [0, sin(angle), cos(angle), 0],
    [0, 0, 0, 1]
];

function transform_points(points, matrix) = [
    for (p = points) m_transform(p, matrix)
];

function transform(obj, matrix) = poly(name = str("T", p_name(obj)), vertices = transform_points(p_vertices(obj), matrix), faces = p_faces(obj));

function transform(m, list) = [
    for (p = list) project(m * vec4(p))
];

function trajectory(left = undef, right = undef, up = undef, down = undef, forward = undef, backward = undef, translation = undef, pitch = undef, yaw = undef, roll = undef, rotation = undef) = concat(translationv(left = left, right = right, up = up, down = down, forward = forward, backward = backward, translation = translation), rotationv(pitch = pitch, yaw = yaw, roll = roll, rotation = rotation));

function trajectories_length(trajectories, i_ = 0) = i_ >= len(trajectories) ? 0 : len3(take3(trajectories[i_])) + trajectories_length(trajectories, i_ + 1);

function trajectories_end_position(rt, i_ = 0, last_ = identity4()) = i_ >= len(rt) ? last_ : trajectories_end_position(rt, i_ + 1, last_ * se3_exp(rt[i_]));

function torus(p, tx = 2.9, ty = 0.61) =
    let (q = [len3([p.x, p.z]) - tx, p.y]) len3(q) - ty;

function to_3d(list) = [
    for (v = list) vec3(v)
];

function toVector(v, size) = len(v) == undef ? toVector([v], size) : len(v) >= size ? v : toVector(concat(v, v[0]), size);

function to3d(p) =
    let (l = len(p))(l > 2 ? [p.x, p.y, p.z] : (l > 1 ? [p.x, p.y, 0] : (l > 0 ? [p.x, 0, 0] : [0, 0, 0])));

function to2d(p) =
    let (l = len(p))(l > 1 ? [p.x, p.y] : (l > 0 ? [p.x, 0] : [0, 0]));

function mod(v) = (sqrt(v[0] * v[0] + v[1] * v[1] + v[2] * v[2]));

function v(a) =
    let (d = 360 / num, v = floor((a + d / 2) / d) * d)(r - rounding) * [cos(v), sin(v)];

function tiny() = [
    [
        [1, 1, -1],
        [1.30656, 0.541196, -1],
        [1.41421, -0, -1],
        [1.30656, -0.541196, -1],
        [1, -1, -1],
        [0.541196, -1.30656, -1],
        [0, -1.41421, -1],
        [-0.541196, -1.30656, -1],
        [-1, -1, -1],
        [-1.30656, -0.541196, -1],
        [-1.41421, 0, -1],
        [-1.30656, 0.541196, -1],
        [-1, 1, -1],
        [-0.541195, 1.30656, -1],
        [0.006, 1.41421, -1],
        [0.541197, 1.30656, -1],
        [1, 0.999999, 1],
        [1.30656, 0.541195, 1],
        [1.41421, -0.006, 1],
        [1.30656, -0.541198, 1],
        [0.999998, -1, 1],
        [0.541194, -1.30656, 1],
        [-0.006, -1.41421, 1],
        [-0.541199, -1.30656, 1],
        [-1, -0.999998, 1],
        [-1.30656, -0.541193, 1],
        [-1.41421, 0.006, 1],
        [-1.30656, 0.5412, 1],
        [-0.999997, 1, 1],
        [-0.541192, 1.30657, 1],
        [0.006, 1.41421, 1],
        [0.541201, 1.30656, 1],
        [0, 0, -1],
        [0, 0, 1]
    ],
    [
        [32, 0, 1],
        [33, 17, 16],
        [32, 1, 2],
        [33, 18, 17],
        [32, 2, 3],
        [33, 19, 18],
        [32, 3, 4],
        [33, 20, 19],
        [32, 4, 5],
        [33, 21, 20],
        [32, 5, 6],
        [33, 22, 21],
        [32, 6, 7],
        [33, 23, 22],
        [32, 7, 8],
        [33, 24, 23],
        [32, 8, 9],
        [33, 25, 24],
        [32, 9, 10],
        [33, 26, 25],
        [32, 10, 11],
        [33, 27, 26],
        [32, 11, 12],
        [33, 28, 27],
        [32, 12, 13],
        [33, 29, 28],
        [32, 13, 14],
        [33, 30, 29],
        [32, 14, 15],
        [33, 31, 30],
        [15, 0, 32],
        [33, 16, 31],
        [0, 16, 17],
        [0, 17, 1],
        [1, 17, 18],
        [1, 18, 2],
        [2, 18, 19],
        [2, 19, 3],
        [3, 19, 20],
        [3, 20, 4],
        [4, 20, 21],
        [4, 21, 5],
        [5, 21, 22],
        [5, 22, 6],
        [6, 22, 23],
        [6, 23, 7],
        [7, 23, 24],
        [7, 24, 8],
        [8, 24, 25],
        [8, 25, 9],
        [9, 25, 26],
        [9, 26, 10],
        [10, 26, 27],
        [10, 27, 11],
        [11, 27, 28],
        [11, 28, 12],
        [12, 28, 29],
        [12, 29, 13],
        [13, 29, 30],
        [13, 30, 14],
        [14, 30, 31],
        [14, 31, 15],
        [16, 0, 15],
        [16, 15, 31]
    ]
];

function tet() = [
    [
        [10, 10, 10],
        [10, -10, -10],
        [-10, 10, -10],
        [-10, -10, 10]
    ],
    [
        [2, 1, 0],
        [3, 2, 0],
        [1, 3, 0],
        [2, 3, 1]
    ]
];

function tangent_path(path, i) = i == 0 ? unit(path[1] - path[0]) : (i == len(path) - 1 ? unit(path[i] - path[i - 1]) : unit(path[i + 1] - path[i - 1]));

function tangent(v1, v2) =
    let (d = v2 - v1) v1 - d * (d * v1) / (d * d);

function take3(v) = [v[0], v[1], v[2]];

function tail3(v) = [v[3], v[4], v[5]];

function t(v) = [v[0], v[1], v[2]];

function gauss(i, n = 0) = n > 0 ?
    let (x = gauss(i, n - 1)) x + (x - SC3(x)) : let (x = i) x + (x - SC3(x));

function t(v) = [v[0], v[1], v[2]];

function t(v) = [v.x, v.y, v.z];

function t(pitch, z) = z / b(pitch);

function sweep_points() = flatten([
    for (i = [0: pathlen]) transform(path_transforms[i], shape3d)
]);

function supersphere(p, r = 15, d = 2, c = 0) =
    let (n = un(p)) len3(p) - r + (sin(atan2(n.y, n.x) * 8) * d + sin(atan2(atan2(n.y, n.x) / 90, n.z) * 8) * d);

function supersphere(p, r = 15, d = 2, c = 0) =
    let (n = un(p)) len3(p) - r + (sin(atan2(n.y, n.x) * 8) * d + sin(atan2(atan2(n.y, n.x) / 90, n.z) * 8) * d);

function sumv(v, i, s = 0) = (i == s ? v[i] : v[i] + sumv(v, i - 1, s));

function sumv(v, i, s = 0) = (i == s || i == undef ? v[i] : v[i] + sumv(v, i - 1, s));

function sumv(v, i, s = 0) = (i == s || i == undef ? v[i] : v[i] + sumv(v, i - 1, s));

function sumv(v, i) = i == 0 ? v[0] : v[i] + sumv(v, i - 1);

function sum(v, i = 0) = len(v) > i ? v[i] + sum(v, i + 1) : 0;

function subv(u, v) = [u[0] - v[0], u[1] - v[1], u[2] - v[2]];

function subdv(v) = [let (last = (len(v) - 1) * 3) for (i = [0: last]) let (j = floor((i + 1) / 3)) i % 3 == 0 ? v[j] : i % 3 == 2 ? v[j] - un(un(pre(v, j)) + un(post(v, j))) * (len3(pre(v, j)) + len3(post(v, j))) * 0.1 : v[j] + un(un(pre(v, j)) + un(post(v, j))) * (len3(pre(v, j)) + len3(post(v, j))) * 0.1];

function subdv(v) = [let (last = (len(v) - 1) * 3) for (i = [0: last]) let (j = floor((i + 1) / 3)) i % 3 == 0 ? v[j] : i % 3 == 2 ? v[j] - un(un(pre(v, j)) + un(post(v, j))) * (len3(pre(v, j)) + len3(post(v, j))) * 0.1 : v[j] + un(un(pre(v, j)) + un(post(v, j))) * (len3(pre(v, j)) + len3(post(v, j))) * 0.1];

function subdv(v) = [let (last = (len(v) - 1) * 3) for (i = [0: last]) let (j = floor((i + 1) / 3)) i % 3 == 0 ? v[j] : i % 3 == 2 ? v[j] - un(un(pre(v, j)) + un(post(v, j))) * (len3(pre(v, j)) + len3(post(v, j))) * 0.13 : v[j] + un(un(pre(v, j)) + un(post(v, j))) * (len3(pre(v, j)) + len3(post(v, j))) * 0.13];

function subdivide(profile, subdivisions) =
    let (N = len(profile))[
        for (i = [0: N - 1]) let (n = len(subdivisions) > 0 ? subdivisions[i] : subdivisions) for (p = interpolate(profile[i], profile[(i + 1) % N], n + 1)) p];

function subarray(list, begin = 0, end = -1) = [let (end = end < 0 ? len(list) : end) for (i = [begin: 1: end - 1]) list[i]];

function stemShape() = circle(1, $fn = res);

function stemRotate(t) = 180 * pow((1 - t), 1);

function stemPath(t) = [0, 0, t];

 
function star_profile(size = 1, points = 4, stellate = 2) = [ /*//The first point is the anchor point,put it on the point corresponding to [cos(0),sin(0)]*/
    for (i = [0: 2 * points - 1]) size * ((pow(-1, i + 1) + 1) * (stellate - 1) + 1) * [cos(i * 180 / points), sin(i * 180 / points)]
];

function ssum(list, i = 0) = i < len(list) ? (list[i] + ssum(list, i + 1)) : 0;

function srnd(a, b) = rands(a, b, 1)[0];

 

function square(size) = [
    [-size, -size],
    [-size, size],
    [size, size],
    [size, -size]
] / 2;

function spl2xy(v) = lim31(1, [v[0], v[1], 0]);

function spl2v(i, v) = lim31(1, spl2(i - 0.0001, v) - spl2(i, v));

function spl2euler(i, v) = [0, -asin(spl2v(i, v)[2]), atan2(spl2xy(spl2v(i, v))[1], spl2xy(spl2v(i, v))[0])];

function spl2(stop, v, p = 0) =
    let (L = len3bz(v[p])) p + 1 > len(v) - 1 || stop < L ? bez2(stop / L, v[p]) : spl2(stop - L, v, p + 1);

function spherical_to_xyz(r, theta, phi) = [r * sin(theta) * cos(phi), r * sin(theta) * sin(phi), r * cos(theta)];

 
 

function sphere(p, b = 1) = len3(p) - b;

function spade_profile(size = 1) = transform(scaling([size / 6, size / 6, 0]) * rotation([0, 0, 90]), concat(spadeRight, spadeLeftRev));

function so3_ln_rad(m) = so3_ln_0(m, cos_angle = rot_cos_angle(m), preliminary_result = rot_axis_part(m));

function so3_ln_1(m, cos_angle, preliminary_result, sin_angle_abs) = cos_angle > sqrt(1 / 2) ? sin_angle_abs > 0 ? preliminary_result * asin(sin_angle_abs) * PI / 180 / sin_angle_abs : preliminary_result : cos_angle > -sqrt(1 / 2) ? preliminary_result * acos(cos_angle) * PI / 180 / sin_angle_abs : so3_get_symmetric_part_rotation(preliminary_result, m, angle = PI - asin(sin_angle_abs) * PI / 180, d0 = m[0][0] - cos_angle, d1 = m[1][1] - cos_angle, d2 = m[2][2] - cos_angle);

function so3_ln_0(m, cos_angle, preliminary_result) = so3_ln_1(m, cos_angle, preliminary_result, sin_angle_abs = sqrt(preliminary_result * preliminary_result));

function so3_ln(m) = 180 / PI * so3_ln_rad(m);

function so3_largest_column(m, d0, d1, d2) = d0 * d0 > d1 * d1 && d0 * d0 > d2 * d2 ? [d0, (m[1][0] + m[0][1]) / 2, (m[0][2] + m[2][0]) / 2] : d1 * d1 > d2 * d2 ? [(m[1][0] + m[0][1]) / 2, d1, (m[2][1] + m[1][2]) / 2] : [(m[0][2] + m[2][0]) / 2, (m[2][1] + m[1][2]) / 2, d2];

function so3_get_symmetric_part_rotation_0(preliminary_result, angle, c_max) = angle * unit(c_max * preliminary_result < 0 ? -c_max : c_max);

function so3_get_symmetric_part_rotation(preliminary_result, m, angle, d0, d1, d2) = so3_get_symmetric_part_rotation_0(preliminary_result, angle, so3_largest_column(m, d0, d1, d2));

function so3_exp_rad(w) = combine_so3_exp(w, w * w < 1e-8 ? so3_exp_1(w * w) : w * w < 1e-6 ? so3_exp_2(w * w) : so3_exp_3(w * w));

function so3_exp_3_0(theta_deg, inv_theta) = [sin(theta_deg) * inv_theta, (1 - cos(theta_deg)) * (inv_theta * inv_theta)];

function so3_exp_3(theta_sq) = so3_exp_3_0(sqrt(theta_sq) * 180 / PI, 1 / sqrt(theta_sq));

function so3_exp_2(theta_sq) = [1.0 - theta_sq * (1.0 - theta_sq / 20) / 6, 0.5 - 0.25 / 6 * theta_sq];

function so3_exp_1(theta_sq) = [1 - 1 / 6 * theta_sq, 0.5];

function so3_exp(w) = so3_exp_rad(w / 180 * PI);

function snub(obj, height = 0.5) =
    let (pf = p_faces(obj), pv = p_vertices(obj)) let (newv = flatten([
        for (face = pf) let (r = -90 / len(face), fp = as_points(face, pv), c = centroid(fp), n = normal(fp), m = m_from(c, n) * m_rotate([0, 0, r]) * m_translate([0, 0, height]) * m_to(c, n))[
            for (i = [0: len(face) - 1])[[face, face[i]], m_transform(fp[i], m)]]
    ])) let (newids = vertex_ids(newv)) let (newf = concat([
        for (face = pf)[
            for (v = face) vertex([face, v], newids)]
    ], /*//vertex faces */ [
        for (i = [0: len(pv) - 1]) let (vf = vertex_faces(i, pf)) /*//vertex faces in left-hand order */ [
            for (of = ordered_vertex_faces(i, vf)) vertex([of, i], newids)]
    ], /*//two edge triangles */ flatten([
        for (face = pf) flatten([
            for (edge = ordered_face_edges(face)) let (oppface = face_with_edge(reverse(edge), pf), e00 = vertex([face, edge[0]], newids), e01 = vertex([face, edge[1]], newids), e10 = vertex([oppface, edge[0]], newids), e11 = vertex([oppface, edge[1]], newids)) if (edge[0] < edge[1])[[e00, e10, e11], [e01, e00, e11]]
        ])
    ]))) poly(name = str("s", p_name(obj)), vertices = vertex_values(newv), faces = newf);

function smin(a, b, k = 128) =
    let (a = pow(a, k), b = pow(b, k)) pow((a * b) / (a + b), 1.0 / k);

function smin(a, b, k = 0.2) =
    let (h = clamp(0.5 + 0.5 * (b - a) / k, 0.0, 1.0)) mix(b, a, h) - k * h * (1.0 - h);

function smin(a, b, k = -1) =
    let (h = clamp(0.5 + 0.5 * (b - a) / k, 0.0, 1.0)) mix(b, a, h) - k * h * (1.0 - h);

function sixring() = [
    for (i = [0: 360 / 6: 359])[sin(i), cos(i), 0]
];

function sin_n(a) = a % 90 ? sin(a) : round(sin(a));

function signx(x) = x == 0 ? 1 : sign(x);

function signed_area(points) =
    let (l = len(points)) sum([
        for (i = [0: l - 1]) let (p_i = points[i], i1 = i + 1, p_i1 = points[i1 >= l ? i1 - l : i1]) p_i.x * p_i1.y - p_i1.x * p_i.y
    ]) / 2;

function sign_y(i, n) = i > 0 && i < n / 2 ? 1 : i > n / 2 ? -1 : 0;

function sign_x(i, n) = i < n / 4 || i > n - n / 4 ? 1 : i > n / 4 && i < n - n / 4 ? -1 : 0;

function shrimp(v, r = 10) = [
    for (i = [0: len(v) - 1]) let (first = (i == 0 ? 0 : 1), last = (i == len(v) - 1 ? 0 : 1), L = len3(v[i][1] - v[i][0]) / 4.5) let (n = un(v[i][1] - v[i][0]))[v[i][0] + (first * n * min(r, L)), v[i][1] - (last * n * min(r, L))]
];

function shift(l, shift = 0) = [
    for (i = [0: len(l) - 1]) l[(i + len(l) - shift) % len(l)]
];

function set_points(poly, points) = depth(poly) <= 2 ? points : [points, poly[1]];

function set(list, i, x) = [
    for (i_ = [0: len(list) - 1]) i == i_ ? x : list[i_]
];

function se3_ln_to_deg(v) = concat(take3(v), tail3(v) * 180 / PI);

function se3_ln_rad(m) = se3_ln_0(m, rot = so3_ln_rad(rotation_part(m)));

function se3_ln_2(m, rot, theta, shtot, halfrotator) = concat((halfrotator * translation_part(m) - (theta > 0.001 ? rot * ((translation_part(m) * rot) * (1 - 2 * shtot) / (rot * rot)) : rot * ((translation_part(m) * rot) / 24))) / (2 * shtot), rot);

function se3_ln_1(m, rot, theta) = se3_ln_2(m, rot, theta, shtot = theta > 0.00001 ? sin(theta / 2 * 180 / PI) / theta : 0.5, halfrotator = so3_exp_rad(rot * -.5));

function se3_ln_0(m, rot) = se3_ln_1(m, rot, theta = sqrt(rot * rot));

function se3_ln(m) = se3_ln_to_deg(se3_ln_rad(m));

function se3_exp_3_0(t, w, theta_deg, inv_theta) = se3_exp_23(so3_exp_3_0(theta_deg = theta_deg, inv_theta = inv_theta), C = (1 - sin(theta_deg) * inv_theta) * (inv_theta * inv_theta), t = t, w = w);

function se3_exp_3(t, w) = se3_exp_3_0(t, w, sqrt(w * w) * 180 / PI, 1 / sqrt(w * w));

function se3_exp_2_0(t, w, theta_sq) = se3_exp_23(so3_exp_2(theta_sq), C = (1.0 - theta_sq / 20) / 6, t = t, w = w);

function se3_exp_23(AB, C, t, w) = [AB[0], AB[1], t + AB[1] * cross(w, t) + C * cross(w, cross(w, t))];

function se3_exp_2(t, w) = se3_exp_2_0(t, w, w * w);

function se3_exp_1(t, w) = concat(so3_exp_1(w * w), [t + 0.5 * cross(w, t)]);

function se3_exp_0(t, w) = combine_se3_exp(w, /*//Evaluate by Taylor expansion when near 0*/ w * w < 1e-8 ? se3_exp_1(t, w) : w * w < 1e-6 ? se3_exp_2(t, w) : se3_exp_3(t, w));

function se3_exp(mu) = se3_exp_0(t = take3(mu), w = tail3(mu) / 180 * PI);

function scaling(v) = [
    [v[0], 0, 0, 0],
    [0, v[1], 0, 0],
    [0, 0, v[2], 0],
    [0, 0, 0, 1],
];

function scale(v = 1, poly) = is_poly_vector(poly) ? [
    for (p = poly) _scale(v = v, poly = p)
] : _scale(v = v, poly = poly);

function scalar_sub_quat(s, q1) = [-q1[0], -q1[1], -q1[2], s - q1[3]];

function sanitycheck(v) = [v[0],
    [v[1][0],
        [let (l = len(v[1][1]) - 1) for (i = [0: l])[i == 0 || i == l ? v[1][0][i][0] : v[1][1][i][0], i == 0 || i == l ? v[1][0][i][1] : v[1][1][i][1], i == 0 || i == l ? v[1][0][i][2] : min(v[1][1][i][2], v[1][0][i][2]) * 0.8]]
    ], v[2]
];

function sanitycheck(v) = [v[0],
    [v[1][0],
        [let (l = len(v[1][1]) - 1) for (i = [0: l])[i == 0 || i == l ? v[1][0][i][0] : v[1][1][i][0], i == 0 || i == l ? v[1][0][i][1] : v[1][1][i][1], i == 0 || i == l ? v[1][0][i][2] : min(v[1][1][i][2], v[1][0][i][2]) * 0.8]]
    ], v[2]
];

 function un(v) = v / max(len3(v), 0.000001) * 1;

function rounline(v, r = 1, i = 0) = i == 0 ? fillgap(shrimp(makesegmentline(v), r)) : fillgap(shrimp(rounline(v, r, i - 1), r));

function roundp(a, p = 0.01) = a - (a % p);

function roundlist(v, r = 1) = len(v) == undef ? v - (v % r) : len(v) == 0 ? [] : [
    for (i = [0: len(v) - 1]) roundlist(v[i], r)
];

function roundlist(v, r = 1) = len(v) == undef ? v - (v % r) : len(v) == 0 ? [] : [
    for (i = [0: len(v) - 1]) roundlist(v[i], r)
];

function rounded_rectangle_profile(size = [1, 1], r = 1, fn = 32) = [
    for (index = [0: fn - 1]) let (a = index / fn * 360) r * [cos(a), sin(a)] + sign_x(index, fn) * [size[0] / 2 - r, 0] + sign_y(index, fn) * [0, size[1] / 2 - r]
];

function rotlist(p) = [p[2], p[0], p[1]];

function rotationv(pitch = undef, yaw = undef, roll = undef, rotation = undef) = rotation == undef ? [val(yaw, 0), val(pitch, 0), val(roll, 0)] : pitch == undef && yaw == undef && roll == undef ? rotation : undef;

function rotations(v) = [VANG([0, 1, 0], [0, v[1], v[2]]), VANG([0, 0, -1], [v[0], 0, v[2]]), VANG([1, 0, 0], [v[0], v[1], 0])];

function rotationm(rotation = undef, pitch = undef, yaw = undef, roll = undef) = so3_exp(rotationv(rotation = rotation, pitch = pitch, yaw = yaw, roll = roll));

function rotation_part(m) = [take3(m[0]), take3(m[1]), take3(m[2])];

function rotation_from_axis(x, y, z) = [
    [x[0], y[0], z[0]],
    [x[1], y[1], z[1]],
    [x[2], y[2], z[2]]
];

function rotation(xyz = undef, axis = undef) = xyz != undef && axis != undef ? undef : xyz == undef ? se3_exp([0, 0, 0, axis[0], axis[1], axis[2]]) : len(xyz) == undef ? rotation(axis = [0, 0, xyz]) : (len(xyz) >= 3 ? rotation(axis = [0, 0, xyz[2]]) : identity4()) * (len(xyz) >= 2 ? rotation(axis = [0, xyz[1], 0]) : identity4()) * (len(xyz) >= 1 ? rotation(axis = [xyz[0], 0, 0]) : identity4());

function rotated_involute(rotate, base_radius, involute_angle) = [cos(rotate) * involute(base_radius, involute_angle)[0] + sin(rotate) * involute(base_radius, involute_angle)[1], cos(rotate) * involute(base_radius, involute_angle)[1] - sin(rotate) * involute(base_radius, involute_angle)[0]];

function rotate_point(rotate, coord) = [cos(rotate) * coord[0] + sin(rotate) * coord[1], cos(rotate) * coord[1] - sin(rotate) * coord[0]];

function rotate_from_to(a, b, _axis = []) = len(_axis) == 0 ? rotate_from_to(a, b, unit(cross(a, b))) : _axis * _axis >= 0.99 ? rotation_from_axis(unit(b), _axis, cross(_axis, unit(b))) * transpose_3(rotation_from_axis(unit(a), _axis, cross(_axis, unit(a)))) : identity3();

function rotate_extrude(angle = 360, offsetAngle = 0, center = false, v_offset = 0, i_offset = 0, poly) =
    let (points = get_points(poly), a = ((angle != angle /*nan check*/ || angle == undef || angle > 360) ? 360 : (angle <= -360 ? 360 : angle)), full_rev = a == 360 ? 1 : 0, l = len(points), xs = [
        for (p = points) p.x
    ], min_x = min(xs), max_x = max(xs), fragments = ceil((abs(a) / 360) * fragments(max_x, $fn)), steps = fragments - full_rev, step = a / fragments, a1 = offsetAngle - (center ? a / 2 : 0), ps = rotate(a = [90, 0, 0], poly = signed_area(points) < 0 ? reverse(points) : points), out_points = flatten([
        for (i = [0: steps]) let (a2 = i * step + a1, h = v_offset * i / (fragments)) translate([0, 0, h], poly = rotate(a2, poly = ps))
    ]), lp = len(out_points), out_paths = flatten([
        for (i = [0: fragments - 1], j = [0: l - 1]) let (il = i * l, il1 = (i == steps) ? 0 : (i + 1) * l, j1 = (j == l - 1) ? 0 : j + 1, a = il + j, b = il + j1, c = il1 + j, d = il1 + j1, ax = ps[j].x, bx = ps[j1].x) ax == 0 ? /*//ax==cx==0 */ (bx == 0 ? [] : /*//zero area tri*/ [
            [c, b, d]
        ] /*//triangle fan*/ ) : (bx == 0 ? /*//bx==dx==0*/ [
            [a, b, c]
        ] : /*//triangle fan*/ [
            [a, b, c],
            [c, b, d]
        ] /*//full quad*/ )
    ])) /*//assert(min_x>=0)*/ [out_points, out_paths];

function rotate(xyz, u) =
    let (xx = cos(u[0]) * cos(u[1]), xy = -sin(u[0]) * cos(u[1]), xz = -sin(u[1]), yx = sin(u[0]) * cos(u[2]) - cos(u[0]) * sin(u[1]) * sin(u[2]), yy = cos(u[0]) * cos(u[2]) + sin(u[0]) * sin(u[1]) * sin(u[2]), yz = -cos(u[1]) * sin(u[2]), zx = sin(u[0]) * sin(u[2]) + cos(u[0]) * sin(u[1]) * cos(u[2]), zy = cos(u[0]) * sin(u[2]) - sin(u[0]) * sin(u[1]) * cos(u[2]), zz = cos(u[1]) * cos(u[2]))[xyz[0] * xx + xyz[1] * xy + xyz[1] * xz, xyz[0] * yx + xyz[1] * yy + xyz[1] * yz, xyz[0] * zx + xyz[1] * zy + xyz[1] * zz];

function rotate(a = 0, v, poly) = is_poly_vector(poly) ? [
    for (p = poly) _rotate(a = a, v = v, poly = p)
] : _rotate(a = a, v = v, poly = poly);

function rot_trace(m) = m[0][0] + m[1][1] + m[2][2];

function rot_cos_angle(m) = (rot_trace(m) - 1) / 2;

function rot_axis_part(m) = [m[2][1] - m[1][2], m[0][2] - m[2][0], m[1][0] - m[0][1]] * 0.5;

function rodrigues_so3_exp(w, A, B) = [
    [1.0 - B * (w[1] * w[1] + w[2] * w[2]), B * (w[0] * w[1]) - A * w[2], B * (w[0] * w[2]) + A * w[1]],
    [B * (w[0] * w[1]) + A * w[2], 1.0 - B * (w[0] * w[0] + w[2] * w[2]), B * (w[1] * w[2]) - A * w[0]],
    [B * (w[0] * w[2]) - A * w[1], B * (w[1] * w[2]) + A * w[0], 1.0 - B * (w[0] * w[0] + w[1] * w[1])]
];

function rndc(seed) = seed == undef ? [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]] : [rands(0, 1, 1, seed)[0], rands(0, 1, 1, seed + 101)[0], rands(0, 1, 1, seed + 201)[0]];

function rndc(seed) = [rands(0, 1, 1, seed)[0], rands(0, 1, 1, seed + 100)[0], rands(0, 1, 1, seed + 200)[0]];

function rndc(a = 1, b = 0, seed) = [rnd(a, b, seed), rnd(a, b, seed + 1), rnd(a, b, seed + 2)];

function rndc(a = 1, b = 0) = [rnd(a, b), rnd(a, b), rnd(a, b)];

function rndc() = [round(rands(0, 2, 1)[0]) / 2, round(rands(0, 2, 1)[0]) / 2, round(rands(0, 2, 1)[0]) / 2];

function rndc() = [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]];

function rndV3(t = 2) = [rands(3, 6, 1)[0], rands(0, 0, 1)[0], rands(-t, t, 1)[0]];

function rndV2(t = 3) = [rands(0, 0, 1)[0], rands(-t, t, 1)[0], rands(-t, t, 1)[0]];

function rndV2(t = 20) = [rands(0, 0, 1)[0], rands(-t, t, 1)[0], rands(-t, t, 1)[0]];

function rndV2(t = 130) = [rands(0, 0, 1)[0], rands(-t, t, 1)[0], rands(-t, t, 1)[0]];

function rndV2(t = 1) = [rands(-t, t, 1)[0], rands(-t, t, 1)[0], rands(-t, t, 1)[0]];

function rndV2() = [rands(0, 0, 1)[0], rands(-1, 1, 1)[0], rands(-1, 1, 1)[0]];

function rndV() = [rands(-1, 1, 1)[0], rands(-1, 1, 1)[0], rands(-1, 1, 1)[0]];

function rndR() = [rands(0, 360, 1)[0], rands(0, 360, 1)[1], rands(0, 360, 1)[0]];

function rnd1(s = 1) = rands(1, s, 1)[0];

function rnd(s = 1, t = 0) = rands(min(s, t), max(s, t), 1)[0];

function rnd(s = 1) = rands(0.0001, s, 1)[0];

function rnd(s = 0, a = 1, b = 0) = (rands(min(a, b), max(a, b), 1, s)[0]);

function rnd(s = 0, a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);

function rnd(s, e, r) = random[r % rcnt] * (e - s) + s;

function rnd(r) = rands(-r, r, 10)[part];

function rnd(r) = rands(-r, r, 1)[0];

function rnd(n, m) = rands(n, m, 9)[part];

function rnd(n, m) = rands(n, m, 1)[0];

function rnd(i = 1) = rands(-i, i, 1)[0];

function rnd(a = 1, b = 0, s = []) = s == [] ? (rands(min(a, b), max(a, b), 1)[0]) : (rands(min(a, b), max(a, b), 1, s)[0]);

function rnd(a = 1, b = 0) = rands(min(a, b), max(a, b), 1)[0];

function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1, s)[0]);

function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);

function rnd(a = 0, b = 1, S = 1) = Unseeded == 0 ? (rands(min(a, b), max(a, b), 1, RSeed + S)[0]) : (rands(min(a, b), max(a, b), 1, Seed + S)[0]);

function rnd(a = 0, b = 1, S) = (rands(min(a, b), max(a, b), 1, S)[0]);

function rnd(a = 0, b = 1, S) = (rands(min(a, b), max(a, b), 1)[0]);

function rnd(a = 0, b = 1) = round(rands(min(a, b), max(a, b), 1)[0]);

function rnd(a = 0, b = 1) = a + (rands(a, b, 1)[0]) * (b - a);

function rnd(a = 0, b = 1) = (rands(min(a, b), max(a, b), 1)[0]);

function rnd(a, b) = rands(a, b, 1)[0];

function rnd(a, b) = a + gauss(rands(0, 1, 1)[0]) * (b - a);

function rnd(a, b) = a + (rands(0, 1, 1)[0]) * (b - a);

function rnd(S, a = 0, b = 1) = Seeded == 1 ? (rands(min(a, b), max(a, b), 1, S)[0]) : (rands(min(a, b), max(a, b), 1)[0]);

function ringtrans(v, t) = [
    for (i = [0: len(v) - 1])[v[i][0] + t[0], v[i][1] + t[1], v[i][2] + t[2]]
];

function ringtrans(v, t) = [
    for (i = [0: len(v) - 1])[v[i][0] + t[0], v[i][1] + t[1], v[i][2] + t[2]]
];

function ringtrans(v, t) = [
    for (i = [0: len(v) - 1])[v[i][0] + t[0], v[i][1] + t[1], v[i][2] + t[2]]
];

function ringscale(v, scale) = [
    for (i = [0: len(v) - 1])[v[i][0] * scale, v[i][1] * scale, v[i][2] * scale]
];

function ringscale(v, scale) = [
    for (i = [0: len(v) - 1])[v[i][0] * scale, v[i][1] * scale, v[i][2] * scale]
];

function ringscale(v, s) = [
    for (i = [0: len(v) - 1])[v[i][0] * s[0], v[i][1] * s[1], v[i][2] * s[2]]
];

function ringscale(v, s) = [
    for (i = [0: len(v) - 1])[v[i][0] * s[0], v[i][1] * s[1], v[i][2] * s[2]]
];

function ringrot(r = [
    [0, 0, 0]
], v) = [
    for (i = [0: len(r) - 1]) let (inx = r[i][0], iny = r[i][1], inz = r[i][2])[inx * sin(v) - inz * cos(v), iny, inx * cos(v) + inz * sin(v)]
];

function ringrot(r = [
    [0, 0, 0]
], v) = [
    for (i = [0: len(r) - 1]) let (inx = r[i][0], iny = r[i][1], inz = r[i][2])[inx * sin(v) + inz * cos(v), iny, inx * cos(v) - inz * sin(v)]
];

function ringrot(r = [
    [0, 0, 0]
], v = 0) = [
    for (i = [0: len(r) - 1]) let (inx = r[i][0], iny = r[i][1], inz = r[i][2])[inx * sin(v) - inz * cos(v), iny, inx * cos(v) + inz * sin(v)]
];

function ringrot(r = [
    [0, 0, 0]
], v) = [
    for (i = [0: len(r) - 1]) let (inx = r[i][0], iny = r[i][1], inz = r[i][2])[inx * sin(v) - inz * cos(v), iny, inx * cos(v) + inz * sin(v)]
];

function ringrot(r = [
    [0, 0, 0]
], v) = [
    for (i = [0: len(r) - 1]) let (inx = r[i][0], iny = r[i][1], inz = r[i][2])[inx * sin(v) - inz * cos(v), iny, inx * cos(v) + inz * sin(v)]
];

function right_multiply(as, b, i_ = 0) = i_ >= len(as) ? [] : concat([as[i_] * b], right_multiply(as, b, i_ + 1));

function rexpand(s, height, n = 0) = /*//used to round edges */ n == 0 ? s : rexpand(expand(s, height), height * 2, n - 1);

function reverse(v) = [
    for (i = [0: len(v) - 1]) v[len(v) - 1 - i]
];

function reverse(list) = [
    for (i = [len(list) - 1: -1: 0]) list[i]
];

function reverse(l) = [
    for (i = [1: len(l)]) l[len(l) - i]
];

function revXring(x = 8, r = 1, ) = [
    for (i = [359: -360 / x: (360 / x) * 0.5])[0, sin(i) * r, cos(i) * r]
];

function rev(v) = [
    for (i = [len(v) - 1: -1: 0]) v[i]
];

function rev(v) = [
    for (i = [len(v) - 1: -1: 0]) v[i]
];

function resize(newsize, poly) =
    let (b = bounds(poly), minB = b[0], maxB = b[1], sX = newsize.x ? newsize.x / (maxB.x - minB.x) : 1, sY = newsize.y ? newsize.y / (maxB.y - minB.y) : 1, v1 = len(minB) == 3 ? [sX, sY, newsize.z ? newsize.z / (maxB.z - minB.z) : 1] : [sX, sY]) scale(v1, poly);

function replace(v1, v2, vs) = [
    for (i = [0: len(vs) - 1]) vs[i] == v1 ? v2 : vs[i]
];

function init_maze(rows, columns) = [
    for (c = [1: columns])
        for (r = [1: rows])[c, r, 0, UP_RIGHT_WALL()]
];

function replace(v1, v2, vs) = [
    for (i = [0: len(vs) - 1]) vs[i] == v1 ? v2 : vs[i]
];

function repete(v, i) =
    let (c = round(v[i][0])) c > 0 ?
    let (l = max(0, len(v) - 1)) let (j = min(i + 1, l))[
        for (n = [1: c])[v[i][0], [let (temp = lerp(v[i][1][0], v[j][1][0], n / c))[v[i][1][0][0], temp[1], temp[2]], v[i][1][1] / c, v[i][1][2], lerp(v[i][1][3], v[j][1][3], n / c), lerp(v[i][1][4], v[j][1][4], n / c), /*//ring lerp(v[i][1][5],v[j][1][5],n/c),*/ ], unfold(v[i][2]), /*//legs*/ v[i][3], v[i][4] /*//wings*/ ]] : [];

function repete(v, i) =
    let (c = round(v[i][0])) c > 0 ?
    let (l = max(0, len(v) - 1)) let (j = min(i + 1, l))[
        for (n = [1: c])[v[i][0], [let (temp = lerp(v[i][1][0], v[j][1][0], n / c))[v[i][1][0][0], temp[1], temp[2]], v[i][1][1] / c, v[i][1][2], lerp(v[i][1][3], v[j][1][3], n / c), lerp(v[i][1][4], v[j][1][4], n / c), /*//ring lerp(v[i][1][5],v[j][1][5],n/c),*/ ], unfold(v[i][2]), /*//legs*/ v[i][3], v[i][4] /*//wings*/ ]] : [];

function repete(v, i) =
    let (c = round(v[i][0])) c > 0 ? (let (l = max(0, len(v) - 1)) let (j = min(i + 1, l))[
        for (n = [1: c])[v[i][0], [let (temp = lerp(v[i][1][0], v[j][1][0], n / c))[v[i][1][0][0], temp[1], temp[2]], /*//lerp only y/z X will be same*/ v[i][1][1] / c, /*//??possibly angle can be divided by no reps*/ v[i][1][2], /*//accumulator no need to lerp,will be reasssigned in poppulate*/ lerp(v[i][1][3], v[j][1][3], n / c), /*//grove*/ lerp(v[i][1][4], v[j][1][4], n / c), /*//ring */ lerp(v[i][1][5], v[j][1][5], n / c), /*//texture*/ ], unfold(v[i][2]), v[i][3]]]) : [];

function repete(v, i) =
    let (c = round(v[i][0])) c > 0 ? (let (l = max(0, len(v) - 1)) let (j = min(i + 1, l))[
        for (n = [1: c])[v[i][0], [let (temp = lerp(v[i][1][0], v[j][1][0], n / c))[v[i][1][0][0], temp[1], temp[2]], v[i][1][1] / c, v[i][1][2], lerp(v[i][1][3], v[j][1][3], n / c), lerp(v[i][1][4], v[j][1][4], n / c), /*//ring lerp(v[i][1][5],v[j][1][5],n/c),*/ ], unfold(v[i][2]), v[i][3]]]) : [];

function repete(v) = v[0] > 0 ? ([
    for (i = [1: v[0]])[v[0], v[1], unfold(v[2])]
]) : [];

function regular(r, n) = circle(r, $fn = n);

function reflect(obj) = poly(name = str("r", p_name(obj)), vertices = [
    for (p = p_vertices(obj))[p.x, -p.y, p.z]
], faces = /*//reverse the winding order */ [
    for (face = p_faces(obj)) reverse(face)
]);

function redround(a, b) = a - (a % b);

function rectangle_profile(size = [1, 1]) = [ /*//The first point is the anchor point,put it on the point corresponding to [cos(0),sin(0)]*/
    [size[0] / 2, 0],
    [size[0] / 2, size[1] / 2],
    [-size[0] / 2, size[1] / 2],
    [-size[0] / 2, -size[1] / 2],
    [size[0] / 2, -size[1] / 2],
];

function reciprocal(v) = v / norm2(v);

function rdual(obj) =
    let (np = p_vertices(obj)) poly(name = p_name(obj), vertices = [
        for (f = p_faces(obj)) let (c = centroid(as_points(f, np))) reciprocal(c)
    ], faces = p_vertices_to_faces(obj));

function rcc(s, n = 0) = /*//multilevel Catmull-Clark*/ n == 0 ? s : rcc(cc(s), n - 1);
 
    function rate(profiles) = [
        for (index = [0: len(profiles) - 2])[profile_length(profiles[index + 1]) - profile_length(profiles[index]), profile_distance(profiles[index], profiles[index + 1])]
    ];

function range(r) = [
    for (x = r) x
];

function random(obj, offset = 0.1) = poly(name = str("x", p_name(obj)), vertices = [
    for (v = p_vertices(obj)) v + rands(0, offset, 3)
], faces = p_faces(obj));

function randn(n, idx = 0) = floor(rands(0, n, max_random_values, $seed)[idx]);

function randf(n, idx = 0) = rands(0, n * 1000, max_random_values, $seed)[idx] / 1000.0;

function rand_dirs() = PERMUTATION_OF_FOUR()[round(rands(0, 24, 1)[0])];

function r_from_dia(d) = d / 2;

function r(a) = (floor(a / 10) % 2) ? 10 : 8;

function quicksort(arr, o) = !(len(arr) > 0) ? [] : let (pivot = arr[floor(len(arr) / 2)], lesser = [
    for (y = arr)
        if (y[o] < pivot[o]) y
], equal = [
    for (y = arr)
        if (y[o] == pivot[o]) y
], greater = [
    for (y = arr)
        if (y[o] > pivot[o]) y
]) concat(quicksort(lesser, o), equal, quicksort(greater, o));

function quat_to_mat4_xyzs(q, s) = [q[0] * s, q[1] * s, q[2] * s];

function quat_to_mat4_s(q) = (vec4_lengthsqr(q) != 0) ? 2 / vec4_lengthsqr(q) : 0;

function quat_to_mat4_X(xyzs, x) = xyzs * x;

function quat_to_mat4(q) = _quat_to_mat4(_quat_xyzsw(quat_to_mat4_xyzs(q, quat_to_mat4_s(q)), q[3]), _quat_XYZ(quat_to_mat4_xyzs(q, quat_to_mat4_s(q)), q));

function quat_subs(q1, s) = [q1[0], q1[1], q1[2], q1[3] - s];

function quat_sub(q1, q2) = [q1[0] - q2[0], q1[1] - q2[1], q1[2] - q2[2], q1[3] - q2[3]];

function quat_normalize(q) = q / quat_norm(q);

function quat_norm(q) = sqrt(q[0] * q[0] + q[1] * q[1] + q[2] * q[2] + q[3] * q[3]);

function quat_new(x, y, z, w) = [x, y, z, w];

function quat_neg(q1) = [-q1[0], -q1[1], -q1[2], -q1[3]];

function quat_mults(q1, s) = [q1[0] * s, q1[1] * s, q1[2] * s, q1[3] * s];

function quat_mult(a, r) = [a[1] * r[2] - a[2] * r[1] + r[3] * a[0] + a[3] * r[0], a[2] * r[0] - a[0] * r[2] + r[3] * a[1] + a[3] * r[1], a[0] * r[1] - a[1] * r[0] + r[3] * a[2] + a[3] * r[2], a[3] * r[3] - a[0] * r[0] - a[1] * r[1] - a[2] * r[2]];

function quat_identity() = [0, 0, 0, 1];

function quat_dot(q1, q2) = q1[0] * q2[0] + q1[1] * q2[1] + q1[2] * q2[2] + q1[3] * q2[3];

function quat_divs(q1, s) = [q1[0] / s, q1[1] / s, q1[2] / s, q1[3] / s];

function quat_distance(q1, q2) = quat_norm(quat_sub(q1 - q2));

function quat_conj(q) = [-q[0], -q[1], -q[2], q[3]];

function quat_adds(q1, s) = [q1[0], q1[1], q1[2], q1[3] + s];

function quat(axis, angle) = _quat(VNORM(axis), s = sin(angle / 2), c = cos(angle / 2));

function quantize_trajectory(trajectory, step = undef, start_position = 0, steps = undef, i_ = 0, length_ = undef) = length_ == undef ? quantize_trajectory(trajectory = trajectory, start_position = (step == undef ? len3(take3(trajectory)) / steps * start_position : start_position), length_ = len3(take3(trajectory)), step = step, steps = steps, i_ = i_) : (steps == undef ? start_position > length_ : i_ >= steps) ? [] : concat([ /*//if steps is defined,ignore start_position*/ se3_exp(trajectory * (steps == undef ? start_position / length_ : i_ / (steps > 1 ? steps - 1 : 1)))], quantize_trajectory(trajectory = trajectory, step = step, start_position = (steps == undef ? start_position + step : start_position), steps = steps, i_ = i_ + 1, length_ = length_));

function quantize_trajectories(trajectories, step = undef, start_position = 0, steps = undef, loop = false, last_ = identity4(), i_ = 0, current_length_ = undef, j_ = 0) = /*//due to quantization differences,the last step may be missed. In that case,add it:*/ loop == true ? quantize_trajectories(trajectories = close_trajectory_loop(trajectories), step = step, start_position = start_position, steps = steps, loop = false, last_ = last_, i_ = i_, current_length_ = current_length_, j_ = j_) : i_ >= len(trajectories) ? (j_ < steps ? [last_] : []) : current_length_ == undef ? quantize_trajectories(trajectories = trajectories, step = (step == undef ? trajectories_length(trajectories) / steps : step), start_position = (step == undef ? start_position * trajectories_length(trajectories) / steps : start_position), steps = steps, loop = loop, last_ = last_, i_ = i_, current_length_ = len3(take3(trajectories[i_])), j_ = j_) : concat(left_multiply(last_, quantize_trajectory(trajectory = trajectories[i_], start_position = start_position, step = step)), quantize_trajectories(trajectories = trajectories, step = step, start_position = start_position > current_length_ ? start_position - current_length_ : step - ((current_length_ - start_position) % step), steps = steps, loop = loop, last_ = last_ * se3_exp(trajectories[i_]), i_ = i_ + 1, current_length_ = undef, j_ = j_ + len(quantize_trajectory(trajectory = trajectories[i_], start_position = start_position, step = step))));

function quadratic_U(u) = [3 * (u * u), 2 * u, 1, 0];

function quad(i, P, o) = [
    [o + i, o + i + P, o + i % P + P + 1],
    [o + i, o + i % P + P + 1, o + i % P + 1]
];

function qt(obj) = /*//triangulate quadrilateral faces*/ /*//use shortest diagonal so triangles are most nearly equilateral*/
    let (pf = p_faces(obj), pv = p_vertices(obj)) poly(name = str("u", p_name(obj)), vertices = pv, faces = flatten([
        for (f = pf) len(f) == 4 ? norm(f[0] - f[2]) < norm(f[1] - f[3]) ? [
            [f[0], f[1], f[2]],
            [f[0], f[2], f[3]]
        ] : [
            [f[1], f[2], f[3]],
            [f[1], f[3], f[0]]
        ] : [f]
    ]));

function q(v, i) = [v[0], v[1], v[2], i];

function pyra(obj, height = 0.1) = /*//very like meta but different triangles*/
    let (pe = p_edges(obj), pf = p_faces(obj), pv = p_vertices(obj)) let (newv = concat([
        for (face = pf) /*//new centroid vertices*/ let (fp = as_points(face, pv))[face, centroid(fp) + normal(fp) * height]
    ], [
        for (edge = pe) /*//new midpoints*/ let (ep = as_points(edge, pv))[edge, (ep[0] + ep[1]) / 2]
    ])) let (newids = vertex_ids(newv, len(pv))) let (newf = flatten([
        for (face = pf) let (centroid = vertex(face, newids)) flatten([
            for (j = [0: len(face) - 1]) let (a = face[j], b = face[(j + 1) % len(face)], z = face[(j - 1 + len(face)) % len(face)], midab = vertex(distinct_edge([a, b]), newids), midza = vertex(distinct_edge([z, a]), newids))[[midza, a, midab], [midza, midab, centroid]]
        ])
    ])) poly(name = str("y", p_name(obj)), vertices = concat(pv, vertex_values(newv)), faces = newf);

function push(p, model, c = 5) =
    let (q = evalnorm(p, model)) p + un([q.x, q.y, q.z]) * (-q[3]);

function push(p, c = 5) =
    let (q = evalnorm(p)) p + un([q.x, q.y, q.z]) * (-q[3]);

function push(p, c = 4) =
    let (q = evalnorm(p), np = p + un([q.x, q.y, q.z]) * (-q[3]) * 0.5) c > 0 ? push(np, c - 1) : abs(q[3] < 0.1) ? p : np;

function push(inp, scene, mi, ma, c = 4) =
    let (p = mima3(inp, mi, ma)) let (q = evalnorm(p, scene), np = p + un([q.x, q.y, q.z]) * (-q[3] * 0.95)) c > 0 ? push(np, scene, mi, ma, c - 1) : np;

function push(inp, mi, ma, c = 4) =
    let (p = mima3(inp, mi, ma)) let (q = evalnorm(p), np = p + un([q.x, q.y, q.z]) * (-q[3] * 0.95)) c > 0 ? push(np, mi, ma, c - 1) : np;

function pt(obj) = /*//triangulate pentagonal faces*/
    let (pf = p_faces(obj), pv = p_vertices(obj)) poly(name = str("u", p_name(obj)), vertices = pv, faces = flatten([
        for (f = pf) len(f) == 5 ? [
            [f[0], f[1], f[4]],
            [f[1], f[2], f[4]],
            [f[4], f[2], f[3]]
        ] : [f]
    ]));

function propellor(obj, ratio = 0.333) =
    let (pf = p_faces(obj), pv = p_vertices(obj), pe = p_edges(obj)) let (newv = flatten( /*//2 points per edge*/ [
        for (edge = pe) let (ep = as_points(edge, pv))[[edge, ep[0] + ratio * (ep[1] - ep[0])], [reverse(edge), ep[1] + ratio * (ep[0] - ep[1])]]
    ])) let (newids = vertex_ids(newv, len(pv))) let (newf = concat([
        for (face = pf) /*//rotated face*/ [
            for (j = [0: len(face) - 1]) let (a = face[j], b = face[(j + 1) % len(face)], eab = [a, b], vab = vertex(eab, newids)) vab]
    ], flatten([
        for (face = pf)[
            for (j = [0: len(face) - 1]) let (a = face[j], b = face[(j + 1) % len(face)], z = face[(j - 1 + len(face)) % len(face)], eab = vertex([a, b], newids), eba = vertex([b, a], newids), eza = vertex([z, a], newids))[a, eba, eab, eza]]
    ]))) poly(name = str("p", p_name(obj)), vertices = concat(pv, vertex_values(newv)), faces = newf);

function project(x) = subarray(x, end = len(x) - 1) / x[len(x) - 1];

function profiles_lengths(profiles) = [
    for (p = profiles) profile_length(p)
];

function profile_triangles(tindex) = [
    for (index = [0: P - 1]) let (qs = quad(index + 1, P, P * (tindex - 1) - 1)) for (q = qs) q
];

function profile_segment_length(profile, i) = len3(profile[(i + 1) % len(profile)] - profile[i]);

function profile_lengths(profile) = [
    for (i = [0: len(profile) - 1]) profile_segment_length(profile, i)
];

function profile_length(profile, i = 0) = i >= len(profile) ? 0 : profile_segment_length(profile, i) + profile_length(profile, i + 1);

function prndc() = palette[rands(0, len(palette) - 1, 1)[0]];

function pre(v, i) = i > 0 ? (v[i] - v[i - 1]) : [0, 0, 0, 0];

function powerstar_profile(size = 1, frequency = 4, amplitude = 1) = [ /*//The first point is the anchor point,put it on the point corresponding to [cos(0),sin(0)]*/
    for (i = [0: 180 - 1])(size + amplitude * (1 + sin(frequency * 2 * i) * (cos(2 * frequency * 2 * i)))) * [cos(2 * i), sin(2 * i)]
];

function post(v, i) = i < len(v) - 1 ? (v[i + 1] - v[i]) : [0, 0, 0, 0];

function polyarea(p1, p2, p3) = heron(len3(p1 - p2), len3(p2 - p3), len3(p2 - p1));

function poly(name, vertices, faces, debug = [], partial = false) = [name, vertices, faces, debug, partial];

function polar_to_cartesian(polar) = [polar[1] * cos(polar[0]), polar[1] * sin(polar[0])];

function pol2(i, v) = t(v2t(v, len3v(v) * (1 - i)));

function pointFfaces(mesh, point) = [mesh[0],
    [
        for (i = [0: len(mesh[1]) - 1])
            if (search(point, mesh[1][i]) == []) mesh[1][i]
    ]
];

function point3_from_vec3(vec) = [vec[0], vec[1], vec[2], 1];

function point2ring(mesh, point) =
    let (faces = point2faces(mesh, point), ed = edgesort(faces))[
        for (i = [0: len(ed) - 1]) ed[(len(ed) - 1) - i][0]];

function point2plane(p, o, n) =
    let (v = o - p) p + (n * (v.x * n.x + v.y * n.y + v.z * n.z));

function point2faces(mesh, point) = [
    for (i = [0: len(mesh[1]) - 1])
        if (search(point, mesh[1][i])) mesh[1][i][0] == point ? rotlist(rotlist(mesh[1][i])) : mesh[1][i][1] == point ? rotlist(mesh[1][i]) : mesh[1][i]
];

function plane(p, plane) =
    let (q = p - plane[1]) dot(q, plane[0]);

function plane(obj, n = 5) = n > 0 ? plane(rdual(rdual(obj)), n - 1) : p_resize(poly(name = str("P", p_name(obj)), vertices = p_vertices(obj), faces = p_faces(obj)));

function place(obj, face_i) = /*//on largest face for printing*/
    let (face = face_i == undef ? max_area(face_areas_index(obj)) : p_faces(obj)[face_i]) let (points = as_points(face, p_vertices(obj))) let (n = normal(points), c = centroid(points)) let (m = m_from(c, -n)) transform(obj, m);

 
 function pele(start, end, lookat = [0, 0, 4]) = midpoint(t(start), t(end)) + un(flipxy(t(end) - t(start))) * lookat[1] + un(flipxz(t(end) - t(start))) * lookat[2] + un(t(end) - t(start)) * lookat[0];

function pele(start, end, lookat = [0, 0, 4]) = midpoint(start, end) + un(flipxy(end - start)) * lookat[1] + un(flipxz(end - start)) * lookat[2] + un(end - start) * lookat[0];

function p_vertices_to_faces(obj) = [
    for (vi = [0: len(p_vertices(obj)) - 1]) /*//each old vertex creates a new face,with */ let (vf = vertex_faces(vi, p_faces(obj))) /*//vertex faces in left-hand order */ [
        for (of = ordered_vertex_faces(vi, vf)) index_of(of, p_faces(obj))]
];

function p_vertices(obj) = obj[1];

function p_resize(obj, radius = 1) = p_circumscribed_resize(obj, radius);

function p_partial(obj) = obj[4];

function p_non_planar_faces(obj, tolerance = 0.001) = [
    for (face = p_faces(obj))
        if (len(face) > 3) let (points = as_points(face, p_vertices(obj))) let (error = face_coplanarity(points)) if (error > tolerance)[tolerance, face]
];

function p_name(obj) = obj[0];

function p_midscribed_resize(obj, radius = 1) =
    let (pv = centroid_points(p_vertices(obj))) let (centroids = [
        for (e = p_edges(obj)) let (ep = as_points(e, pv)) norm((ep[0] + ep[1]) / 2)
    ]) let (average = ssum(centroids) / len(centroids)) poly(name = p_name(obj), vertices = pv * radius / average, faces = p_faces(obj), debug = centroids);

function p_irregular_faces(obj, tolerance = 0.01) = [
    for (face = p_faces(obj)) let (ir = face_irregularity(face, p_vertices(obj))) if (abs(ir - 1) > tolerance)[ir, face]
];

function p_inscribed_resize(obj, radius = 1) =
    let (pv = centroid_points(p_vertices(obj))) let (centroids = [
        for (f = p_faces(obj)) norm(centroid(as_points(f, pv)))
    ]) let (average = ssum(centroids) / len(centroids)) poly(name = p_name(obj), vertices = pv * radius / average, faces = p_faces(obj), debug = centroids);

function p_faces_as_points(obj) = [
    for (f = p_faces(obj)) as_points(f, p_vertices(obj))
];

function p_faces(obj) = obj[2];

function p_edges(obj) = p_partial(obj) ? all_edges(p_faces(obj)) : distinct_edges(p_faces(obj));

function p_dihedral_angles(obj) = [
    for (edge = p_edges(obj)) dihedral_angle(edge, p_faces(obj), p_vertices(obj))
];

function p_description(obj) = str(p_name(obj), ",", str(len(p_vertices(obj)), " Vertices "), vertex_analysis(p_vertices(obj), p_faces(obj)), ",", str(len(p_faces(obj)), " Faces "), face_analysis(p_faces(obj)), " ", str(len(p_non_planar_faces(obj)), " not planar"), ",", str(len(p_edges(obj)), " Edges "));

function p_debug(obj) = obj[3];

function p_circumscribed_resize(obj, radius = 1) =
    let (pv = centroid_points(p_vertices(obj))) let (average = average_norm(pv)) poly(name = p_name(obj), vertices = pv * radius / average, faces = p_faces(obj), debug = average);

function p2p(p, b = un([1, 1, 1]), a = [0, 0, 0]) =
    let (ap = p - a, ab = b - a) a + dot(ap, ab) / dot(ab, ab) * ab;

function p2n(pa, pb, pc) =
    let (u = pa - pb, v = pa - pc) un([u[1] * v[2] - u[2] * v[1], u[2] * v[0] - u[0] * v[2], u[0] * v[1] - u[1] * v[0]]);

function orthogonal(v0, v1, v2) = cross(v1 - v0, v2 - v1);

function ortho(obj, height = 0.2) = /*//very like meta but divided into quadrilaterals*/
    let (pe = p_edges(obj), pf = p_faces(obj), pv = p_vertices(obj)) let (newv = concat([
        for (face = pf) /*//new centroid vertices*/ let (fp = as_points(face, pv))[face, centroid(fp) + normal(fp) * height]
    ], [
        for (edge = pe) /*//new midpoints*/ let (ep = as_points(edge, pv))[edge, (ep[0] + ep[1]) / 2]
    ])) let (newids = vertex_ids(newv, len(pv))) let (newf = flatten([
        for (face = pf) let (centroid = vertex(face, newids))[
            for (j = [0: len(face) - 1]) let (a = face[j], b = face[(j + 1) % len(face)], z = face[(j - 1 + len(face)) % len(face)], midab = vertex(distinct_edge([a, b]), newids), midza = vertex(distinct_edge([z, a]), newids))[centroid, midza, a, midab]]
    ])) poly(name = str("o", p_name(obj)), vertices = concat(pv, vertex_values(newv)), faces = newf);

function orient(obj) = /*//ensure faces have lhs order*/ poly(name = str("O", p_name(obj)), vertices = p_vertices(obj), faces = lhs_faces(p_faces(obj), p_vertices(obj)));
 
    
function ordered_vertex_faces(v, vfaces, cface = [], k = 0) = k == 0 ?
    let (nface = vfaces[0]) concat([nface], ordered_vertex_faces(v, vfaces, nface, k + 1)) : k < len(vfaces) ?
    let (i = index_of(v, cface)) let (j = (i - 1 + len(cface)) % len(cface)) let (edge = [v, cface[j]]) let (nface = face_with_edge(edge, vfaces)) concat([nface], ordered_vertex_faces(v, vfaces, nface, k + 1)) : [];

 

function ordered_vertex_edges(v, vfaces, face, k = 0) =
    let (cface = (k == 0) ? vfaces[0] : face) k < len(vfaces) ?
    let (i = index_of(v, cface)) let (j = (i - 1 + len(cface)) % len(cface)) let (edge = [v, cface[j]]) let (nface = face_with_edge(edge, vfaces)) concat([edge], ordered_vertex_edges(v, vfaces, nface, k + 1)) : [];

function ordered_face_edges(f) = /*//edges are ordered anticlockwise*/ [
    for (j = [0: len(f) - 1])[f[j], f[(j + 1) % len(f)]]
];

function octavebalance() = lim31(1, [40, 150, 280]);

function nv(v) = concat(v[0], [
    for (i = [0: len(v[1]) - 1])(v[0][v[1][i][0]] + v[0][v[1][i][1]] + v[0][v[1][i][2]]) / 3
]);

function normeq(pl) =
    let (sums = avrg([
        for (i = [0: len(pl - 1)])
            for (j = [0: len(pl - 1)])(-1 + dot(pl[i][1], pl[j][1]))
    ])) abs(sums);

function normalized_axis(a) = a == "x" ? [1, 0, 0] : a == "y" ? [0, 1, 0] : a == "z" ? [0, 0, 1] : normalized(a);

function normalized(a) = a / (max(distance([0, 0, 0], a), 0.00001));

function normal(face) =
    let (n = orthogonal(face[0], face[1], face[2])) - n / norm(n);

 function triangle(a, b) = norm(cross(a, b)) / 2;

function norm2(v) = v.x * v.x + v.y * v.y + v.z * v.z;

function ngon(num, r) = [
    for (i = [0: num - 1], a = i * 360 / num)[r * cos(a), r * sin(a)]
];

function nf(hf) = [
    for (i = [0: 1: len(hf) - 1])(i % 2) == 0 ? [hf[i][4], hf[(i + 1) % len(hf)][2], hf[i][2]] : [hf[i][4], hf[(i - 1) % len(hf)][2], hf[i][2]]
];

function ndual(obj) =
    let (np = p_vertices(obj)) poly(name = p_name(obj), vertices = [
        for (f = p_faces(obj)) let (fp = as_points(f, np), c = centroid(fp), n = average_normal(fp), cdotn = c * n, ed = average_edge_distance(fp)) reciprocal(n * cdotn) * (1 + ed) / 2
    ], faces = p_vertices_to_faces(obj));

function nberpm(mesh, uv) = VUNIT(VPROD([Bern3du(mesh, uv), Bern3dv(mesh, uv)]));

function myfunction(b) = 27 + b;

function multmatrix(M, poly) = is_poly_vector(poly) ? [
    for (p = poly) _multmatrix(M = M, poly = p)
] : _multmatrix(M = M, poly = poly);

function mt(x, y) = [
    [1, 0, 0, x],
    [0, 1, 0, y],
    [0, 0, 1, 0],
    [0, 0, 0, 1]
];

function mr(a) = [
    [cos(a), -sin(a), 0, 0],
    [sin(a), cos(a), 0, 0],
    [0, 0, 1, 0],
    [0, 0, 0, 1]
];

function mmul(v1, v2) = [v1[0] * v2[0], v1[1] * v2[1], v1[2] * v2[2]];

function mix(a, b, h) = a * h + b * (1 - h);

function mirror_point(coord) = [coord[0], -coord[1]];

function mirror(normal, poly) = is_poly_vector(poly) ? [
    for (p = poly) _mirror(normal = normal, poly = p)
] : _mirror(normal = normal, poly = poly);

function minls(l, select = 0, c = 0) = c < len(l) - 1 ? min(l[c][select], minls(l, select, c + 1)) : l[c][select];

function minl(l, r, c = 0) = c < len(l) - 1 ? minR(l[c], minl(l, r, c + 1), r) : l[c];

function minl(l, c = 0) = c < len(l) - 1 ? min(l[c], minl(l, c + 1)) : l[c];

function min_edge_length(face, points) = min(face_edges(face, points));

function minR(d1, d2, r = 5) = r > 0 ?
    let (m = min(d1, d2))(abs(d1) < abs(r) && abs(d2) < abs(r)) || (d1 < r && d2 < r) ? min(m, r - len3([r - d1, r - d2])) : m : let (m = min(d1, d2), rr = -r)(d1 < rr && d2 < rr) ? min(m, len3([d1, d2]) - rr) : m;

function minR(d1, d2, r = 5) = r > 0 ?
    let (m = min(d1, d2))(abs(d1) < abs(r) && abs(d2) < abs(r)) || (d1 < r && d2 < r) ? min(m, r - len3([r - d1, r - d2])) : m : let (m = min(d1, d2), rr = -r)(d1 < rr && d2 < rr) ? min(m, len3([d1, d2]) - rr) : m;

function minR(d1, d2, r) = r > 0 ?
    let (m = min(d1, d2))(abs(d1) < abs(r) && abs(d2) < abs(r)) || (d1 < r && d2 < r) ? min(m, r - len3([r - d1, r - d2])) : m : let (m = min(d1, d2), rr = -r)(d1 < rr && d2 < rr) ? min(m, len3([d1, d2]) - rr) : m;

function minCH(d1, d2, r) =
    let (m = min(d1, d2))(d1 < r && d2 < r) ? min(m, d1 + d2 - r) : m;

function min3(v, l) = [
    for (i = [0: len(v) - 1]) min(l, v[i])
];

function min3(a, b) = [min(a[0], b), min(a[1], b), min(a[2], b)];

function mima3(a, b, c) = [min(max(a[0], b[0]), c[0]), min(max(a[1], b[1]), c[1]), min(max(a[2], b[2]), c[2])];

function midpointjust(start, end) = start + (end - start) / 2;

function midpoint(start, end, bias = 0.5) = start + (end - start) * bias;

function midpoint(start, end, bias = 0.5) = start + (end * bias - start * (1 - bias));

function midpoint(start, end) = start + (end - start) / 2;

function meta(obj, height = 0.1) = /*//each face is replaced with 2n triangles based on edge midpoint and centroid*/
    let (pe = p_edges(obj), pf = p_faces(obj), pv = p_vertices(obj)) let (newv = concat([
        for (face = pf) /*//new centroid vertices*/ let (fp = as_points(face, pv))[face, centroid(fp) + normal(fp) * height]
    ], [
        for (edge = pe) let (ep = as_points(edge, pv))[edge, (ep[0] + ep[1]) / 2]
    ])) let (newids = vertex_ids(newv, len(pv))) let (newf = flatten([
        for (face = pf) let (centroid = vertex(face, newids)) flatten([
            for (j = [0: len(face) - 1]) /*//replace face with 2n triangle */ let (a = face[j], b = face[(j + 1) % len(face)], mid = vertex(distinct_edge([a, b]), newids))[[mid, centroid, a], [b, centroid, mid]]
        ])
    ])) poly(name = str("m", p_name(obj)), vertices = concat(pv, vertex_values(newv)), faces = newf);

function maxls(l, select = 0, c = 0) = c < len(l) - 1 ? max(l[c][select], maxls(l, select, c + 1)) : l[c][select];

function maxl(l, r = 3, c = 0) = c < len(l) - 1 ? maxR(l[c], maxl(l, r, c + 1), r) : l[c];

function maxl(l, r, c = 0) = c < len(l) - 1 ? maxR(l[c], maxl(l, r, c + 1), r) : l[c];

function maxl(l, c = 0) = c < len(l) - 1 ? min(l[c], maxl(l, c + 1)) : l[c];

function maxl(l, c = 0) = c < len(l) - 1 ? max(l[c], maxl(l, c + 1)) : l[c];

function max_len(arr) = max([
    for (i = arr) len(i)
]);

function max_element(arr, ma_, ma_i_ = -1, i_ = 0) = i_ >= len(arr) ? ma_i_ : i_ == 0 || arr[i_] > ma_ ? max_element(arr, arr[i_], i_, i_ + 1) : max_element(arr, ma_, ma_i_, i_ + 1);

function max_area(areas, max = [undef, 0], i = 0) = i < len(areas) ? areas[i][1] > max[1] ? max_area(areas, areas[i], i + 1) : max_area(areas, max, i + 1) : max[0];

function maxR(d1, d2, r) =
    let (m = max(d1, d2))(d1 > -r && d2 > -r) ? max(m, -r + len3([-r - d1, -r - d2])) : m;

function maxR(d1, d2, r) =
    let (m = max(d1, d2))(d1 > -r && d2 > -r) ? max(m, -r + len3([-r - d1, -r - d2])) : m;

function maxCH(d1, d2, r) =
    let (m = min(-d1, -d2))(-d1 < r && -d2 < r) ? -min(m, -d1 + -d2 - r) : -m;

function maxCH(d1, d2, r) =
    let (m = min(-d1, -d2))(-d1 < r && -d2 < r) ? -min(m, -d1 + -d2 - r) : -m;

function maxCH(d1, d2, r) = -minCH(-d1, -d2, r);

function max3(v, l) = [
    for (i = [0: len(v) - 1]) max(l, v[i])
];

function max3(a, b) = [max(a[0], b), max(a[1], b), max(a[2], b)];

function matrot(v, r) =
    let (x = v[0], y = v[1], z = v[2])[x * sin(r[1]) + y * 0 + z * 0, y * 1 + x * 0 + z * 0, z * 0 + y * 0 + x * cos(r[1])];

function mat4_transpose(m) = [mat4_col(m, 0), mat4_col(m, 1), mat4_col(m, 2), mat4_col(m, 3)];

function mat4_row(m, row) = m[row];

function mat4_mult_mat4(m1, m2) = [
    [vec4_dot(m1[0], mat4_col(m2, 0)), vec4_dot(m1[0], mat4_col(m2, 1)), vec4_dot(m1[0], mat4_col(m2, 2)), vec4_dot(m1[0], mat4_col(m2, 3))],
    [vec4_dot(m1[1], mat4_col(m2, 0)), vec4_dot(m1[1], mat4_col(m2, 1)), vec4_dot(m1[1], mat4_col(m2, 2)), vec4_dot(m1[1], mat4_col(m2, 3))],
    [vec4_dot(m1[2], mat4_col(m2, 0)), vec4_dot(m1[2], mat4_col(m2, 1)), vec4_dot(m1[2], mat4_col(m2, 2)), vec4_dot(m1[2], mat4_col(m2, 3))],
    [vec4_dot(m1[3], mat4_col(m2, 0)), vec4_dot(m1[3], mat4_col(m2, 1)), vec4_dot(m1[3], mat4_col(m2, 2)), vec4_dot(m1[3], mat4_col(m2, 3))],
];

function mat4_identity() = [
    [1, 0, 0, 0],
    [0, 1, 0, 0],
    [0, 0, 1, 0],
    [0, 0, 0, 1]
];

function mat4_col(m, col) = [m[0][col], m[1][col], m[2][col], m[3][col]];

function mat4_add(m1, m2) = m1 + m2;

function mat3_to_mat4(m) = [
    [m[0][0], m[0][1], m[0][2], 0],
    [m[1][0], m[1][1], m[1][2], 0],
    [m[2][0], m[2][1], m[2][2], 0],
    [m[3][0], m[3][1], m[3][2], 1],
];

function makemapstraight() = [
    [1, [
        [50, 0, 0],
        [0, rnd(-1, 1), 0],
        [0, rnd(-20, 25), rnd(-20, 25)]
    ], xring(12, 0.5), legs(0.5)],
    [1, [
        [30, 0, 0],
        [0, rnd(-4, 4), 0],
        [0, rnd(-150, 55), rnd(-150, 155)]
    ], xring(12, 0.5), legs(0.05)],
    [1, [
        [30, 0, 0],
        [0, rnd(-4, 4), 0],
        [0, rnd(-150, 55), rnd(-150, 155)]
    ], xring(12, 0.5), legs(0.05)],
    [1, [
        [30, 0, 0],
        [0, rnd(-2, 20), 0],
        [0, rnd(-110, 150), rnd(-115, 175)]
    ], xring(12, 0.5), legs(0.05)],
    [1, [
        [100, 0, 0],
        [0, rnd(-2, 2), 0],
        [0, rnd(140, 250), rnd(-45, 175)]
    ], xring(12, 0.5), legs(rnd(1, 1.2))],
    [2, [
        [100, 0, 0],
        [0, rnd(-2, 2), 0],
        [0, rnd(-20, 15), rnd(-20, 5)]
    ], xring(12, 0.5), legs(rnd(1, 1.2))],
    [1, [
        [100, 0, 0],
        [0, rnd(-2, 2), 0],
        [0, rnd(-20, 25), rnd(-20, 25)]
    ], xring(12, 0.5), legs(rnd(1, 1.2))],
    [1, [
        [100, 0, 0],
        [0, 1, 0],
        [0, 2, 2]
    ], xring(12, 0.5), legs(0.25)],
    [1, [
        [100, 0, 0],
        [0, 1, 0],
        [0, 2, 2]
    ], xring(12, 0.5), legs(0.25)],
    [1, [
        [100, 0, 0],
        [0, 1, 0],
        [0, 2, 2]
    ], xring(12, 0.5), legs(0.25)],
    [1, [
        [100, 0, 0],
        [0, 1, 0],
        [0, 2, 2]
    ], xring(12, 0.5), legs(0.25)],
    [1, [
        [100, 0, 0],
        [0, 1, 0],
        [0, 2, 2]
    ], xring(12, 0.5), legs(0.25)],
    [1, [
        [rnd(250, 30), 0, 0],
        [0, rnd(-5, 5), 0],
        [0, rnd(-120, 125), rnd(-20, 25)]
    ], xring(12, 0.5), legs(0.25)],
    [1, [
        [rnd(50, 30), 0, 0],
        [0, rnd(-5, 5), 0],
        [0, rnd(-20, 25), rnd(-20, 25)]
    ], xring(12, 0.5), legs(0.25)],
    [1, [
        [rnd(150, 30), 0, 0],
        [0, rnd(-5, 5), 0],
        [0, 0, rnd(-10, 15)]
    ], xring(12, 0.5), legs(0)]
];

function make_orthogonal(u, v) = unit(u - unit(v) * (unit(v) * u));

function m_translate(v) = [
    [1, 0, 0, 0],
    [0, 1, 0, 0],
    [0, 0, 1, 0],
    [v.x, v.y, v.z, 1]
];

function m_translate(v) = [
    [1, 0, 0, 0],
    [0, 1, 0, 0],
    [0, 0, 1, 0],
    [v.x, v.y, v.z, 1]
];

function m_transform(v, m) = vec3([v.x, v.y, v.z, 1] * m);

function m_to(origin, normal) = m_rotate([0, atan2(sqrt(pow(normal.x, 2) + pow(normal.y, 2)), normal.z), 0]) * m_rotate([0, 0, atan2(normal.y, normal.x)]) * m_translate(normal);

function m_scale(v) = [
    [v.x, 0, 0, 0],
    [0, v.y, 0, 0],
    [0, 0, v.z, 0],
    [0, 0, 0, 1]
];

function m_scale(v) = [
    [v.x, 0, 0, 0],
    [0, v.y, 0, 0],
    [0, 0, v.z, 0],
    [0, 0, 0, 1]
];

function m_rotate_to(normal) = m_rotate([0, atan2(sqrt(pow(normal.x, 2) + pow(normal.y, 2)), normal.z), 0]) * m_rotate([0, 0, atan2(normal.y, normal.x)]);

function m_rotate_from(normal) = m_rotate([0, 0, -atan2(normal.y, normal.x)]) * m_rotate([0, -atan2(sqrt(pow(normal.x, 2) + pow(normal.y, 2)), normal.z), 0]);

function m_rotate_about_line(a, v1, v2) = m_from(v1, v2 - v1) * m_rotate([0, 0, a]) * m_to(v1, v2 - v1);

function m_rotate(v) = [
    [1, 0, 0, 0],
    [0, cos(v.x), sin(v.x), 0],
    [0, -sin(v.x), cos(v.x), 0],
    [0, 0, 0, 1]
] * [
    [cos(v.y), 0, -sin(v.y), 0],
    [0, 1, 0, 0],
    [sin(v.y), 0, cos(v.y), 0],
    [0, 0, 0, 1]
] * [
    [cos(v.z), sin(v.z), 0, 0],
    [-sin(v.z), cos(v.z), 0, 0],
    [0, 0, 1, 0],
    [0, 0, 0, 1]
];

function m_rotate(v) = [
    [1, 0, 0, 0],
    [0, cos(v.x), sin(v.x), 0],
    [0, -sin(v.x), cos(v.x), 0],
    [0, 0, 0, 1]
] * [
    [cos(v.y), 0, -sin(v.y), 0],
    [0, 1, 0, 0],
    [sin(v.y), 0, cos(v.y), 0],
    [0, 0, 0, 1]
] * [
    [cos(v.z), sin(v.z), 0, 0],
    [-sin(v.z), cos(v.z), 0, 0],
    [0, 0, 1, 0],
    [0, 0, 0, 1]
];

function m_from(origin, normal) = m_translate(-origin) * m_rotate([0, 0, -atan2(normal.y, normal.x)]) * m_rotate([0, -atan2(sqrt(pow(normal.x, 2) + pow(normal.y, 2)), normal.z), 0]);

function loop_faces() = [let (facets = len(shape3d)) for (s = [0: segments - 1], i = [0: facets - 1])[(s % pathlen) * facets + i, (s % pathlen) * facets + (i + 1) % facets, ((s + 1) % pathlen) * facets + (i + 1) % facets, ((s + 1) % pathlen) * facets + i]];

function linear_fragments(l = 1) = ($fn > 0) ? ($fn >= 3 ? $fn : 3) : ceil(max(l / $fs), 5);

function linear_extrude(height = 100, center = false, convexity = 1, twist = 0, slices, scale = 1.0, poly) = is_poly_vector(poly) ? [
    for (p = poly) _linear_extrude(height = height, center = center, convexity = convexity, twist = twist, slices = slices, scale = scale, poly = poly)
] : _linear_extrude(height = height, center = center, convexity = convexity, twist = twist, slices = slices, scale = scale, poly = poly);

function limlist(v, r = 1) = [
    for (i = [0: len(v) - 1])[v[i][0], v[i][1], v[i][2]]
];

function limlist(v, r = 1) = [
    for (i = [0: len(v) - 1])[v[i][0], v[i][1], v[i][2]]
];

function limin3(l, v) = v / len3(v) * smin(l, len3(v));

function lim33(l1, l2, v) = v / len3(v) * min(max(len3(v), l1), l2);

function lim32(l, v) = v / len3(v) * max(l, 1);

function lim31(l, v) = v / len3(v) * l;

function lim3(l, v) = v / len3(v) * min(len3(v), l);

function lim3(l, v) = v / len3(v) * max(min(len3(v), l), 5);

function lim3(l, v) = v / len3(v) * l;

function lhs_faces(faces, vertices) = [
    for (face = faces) let (points = as_points(face, vertices)) cosine_between(normal(points), centroid(points)) < 0 ? reverse(face) : face
];

function lerplist(v1, v2, bias) = [
    for (i = [0: len(v) - 1])(v2[i] * bias + v2[i] * (1 - bias))
];

function lerp1(p0, p1, u) = (1 - u) * p0 + u * p1;

function lerp(v1, v2, u) = [lerp1(v1[0], v2[0], u), lerp1(v1[1], v2[1], u), lerp1(v1[2], v2[2], u)];

function lerp(start, end, bias = 0.5) = (end * bias + start * (1 - bias));

function lerp(start, end, bias) = (end * bias + start * (1 - bias));

function length2(a) = sqrt(a[0] * a[0] + a[1] * a[1]);

function len3v(v, acc = 0, p = 0) = p + 1 > len(v) - 1 ? acc : len3v(v, acc + len3(v[p] - v[p + 1]), p + 1);

function len3spl(v, precision = 1 / 5, acc = 0, p = 0) = p + 1 > len(v) ? acc : len3spl(v, precision, acc + len3bz(v[p], precision), p + 1);

function len3spl(v, precision = 1 / 20, acc = 0, p = 0) = p + 1 > len(v) ? acc : len3spl(v, precision, acc + len3bz(v[p], precision), p + 1);

function len3spl(v, precision = 0.211, acc = 0, p = 0) = p + 1 > len(v) ? acc : len3spl(v, precision, acc + len3bz(v[p], precision), p + 1);

function len3spl(v, acc = 0, p = 0) = p + 1 > len(v) ? acc : len3spl(v, acc + len3bz(v[p]), p + 1);

function len3q(v, q = 3) = len(v) > 1 ? pow(addl([
    for (i = [0: len(v) - 1]) pow(v[i], q)
]), 1 / q) : len(v) == 1 ? v[0] : v;

function len3bz(v, precision = 1 / 5, t = 0, acc = 0) = t > 1 ? acc : len3bz(v, precision, t + precision, acc + len3(bez2(t, v) - bez2(t + precision, v)));

function len3bz(v, precision = 1 / 20, t = 0, acc = 0) = t > 1 ? acc : len3bz(v, precision, t + precision, acc + len3(bez2(t, v) - bez2(t + precision, v)));

function len3bz(v, precision = 0.211, t = 0, acc = 0) = t > 1 ? acc : len3bz(v, precision, t + precision, acc + len3(bez2(t, v) - bez2(t + precision, v)));

function len3bz(v, precision = 0.01, t = 0, acc = 0) = t > 1 ? acc : len3bz(v, precision, t + precision, acc + len3(bez2(t, v) - bez2(t + precision, v)));

function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));

function len3(v) = len(v) > 1 ? sqrt(addl([
    for (i = [0: len(v) - 1]) pow(v[i], 2)
])) : len(v) == 1 ? v[0] : v;

function len3(v) = len(v) > 1 ? sqrt(addl([
    for (i = [0: len(v) - 1]) pow(v[i], 2)
])) : len(v) == 1 ? v[0] : v;

function len3(v) = len(v) == 2 ? sqrt(pow(v[0], 2) + pow(v[1], 2)) : sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));

function legs(l) = [
    [1, [
        [rnd(40 * l, 150 * l), 0, 0],
        [0, rnd(70, 80), 0],
        [0, rnd(10 * l, 10 * l), rnd(10 * l, 40 * l)]
    ], xring(12, 0.5), 1],
    [1, [
        [rnd(40 * l, 150 * l), 0, 0],
        [0, rnd(-90, -45), 0],
        [0, rnd(30, 40), rnd(30, 40)]
    ], xring(12, 0.5), 1],
    [1, [
        [rnd(100 * l, 480 * l), 0, 0],
        [0, rnd(20, -55), 0],
        [0, rnd(-20, 25), rnd(-20, 5)]
    ], xring(12, 0.5), 1],
    [rnd(2), [
        [rnd(50 * l, 40 * l), 0, 0],
        [0, rnd(25, 55), 0],
        [0, rnd(-20, 25), rnd(-20, 25 * l)]
    ], xring(12, 0.5), 1],
    [1, [
        [rnd(250 * l, 380 * l), 0, 0],
        [0, rnd(20, 120), 0],
        [0, rnd(-20, 25), rnd(-20, 25 * l)]
    ], xring(12, 0.5), 1],
    [1, [
        [rnd(50 * l, 10), 0, 0],
        [0, rnd(-30, -20), 0],
        [0, rnd(-20, 25), rnd(-20, 25 * l)]
    ], xring(12, 0.5), 1],
    [1, [
        [rnd(50 * l, 10), 0, 0],
        [0, rnd(-30, -20), 0],
        [0, rnd(-20, -25), rnd(-20, 25 * l)]
    ], xring(12, 0.5), 1],
    [1, [
        [rnd(50 * l, 10), 0, 0],
        [0, rnd(-0, 20), 0],
        [0, rnd(-20, -25), rnd(-20, -25 * l)]
    ], xring(12, 0.5), 1],
    [rnd(2), [
        [rnd(50 * l, 10), 0, 0],
        [0, rnd(-20, 2), 0],
        [0, rnd(-20, -25), rnd(-20, -25 * l)]
    ], xring(12, 0.5), 1],
    [rnd(2), [
        [rnd(50 * l, 10), 0, 0],
        [0, rnd(-2, 20), 0],
        [0, rnd(-20, -25), rnd(-20, -25)]
    ], xring(12, 0.5), 1],
    [rnd(2), [
        [rnd(5 * l, 10), 0, 0],
        [0, rnd(-2, 20), 0],
        [0, rnd(-20, -25), rnd(-20, -25)]
    ], xring(12, 0.5), 1],
    [rnd(2), [
        [rnd(5 * l, 10), 0, 0],
        [0, rnd(-2, 20), 0],
        [0, rnd(-10, -15), rnd(-10, -15)]
    ], xring(12, 0.5), 1]
];

function leg(extention) = Leg;

function left_multiply(a, bs, i_ = 0) = i_ >= len(bs) ? [] : concat([a * bs[i_]], left_multiply(a, bs, i_ + 1));

function kis(obj, height = 0.1, fn = []) = /*//kis each n-face is divided into n triangles which extend to the face centroid*/ /*//existimg vertices retained*/
    let (pf = p_faces(obj), pv = p_vertices(obj)) let (newv = /*//new centroid vertices */ [
        for (f = pf)
            if (selected_face(f, fn)) let (fp = as_points(f, pv))[f, centroid(fp) + normal(fp) * height] /*//centroid+a bit of normal*/
    ]) let (newids = vertex_ids(newv, len(pv))) let (newf = flatten([
        for (face = pf) selected_face(face, fn) /*//replace face with triangles*/ ?
            let (centroid = vertex(face, newids))[
                for (j = [0: len(face) - 1]) let (a = face[j], b = face[(j + 1) % len(face)])[a, b, centroid]] : [face] /*//original face*/
    ])) poly(name = str("k", p_name(obj)), vertices = concat(pv, vertex_values(newv)), faces = newf);

function join(obj) =
    let (name = p_name(obj)) let (p = dual(ambo(obj))) poly(name = str("j", name), vertices = p_vertices(p), faces = p_faces(p));

function it(size = 1) =
    let (baser = 1, phase = 90, mag1 = rnd(3) * baser, rep1 = round(rnd(0, 8)), ophase1 = rnd(360), mag2 = rnd(6) * baser, rep2 = round(rnd(3, 10)), ophase2 = rnd(360), phase0 = rnd(360), r0 = rnd(0, 1), phase1 = rnd(360), r1 = rnd(0, 1) / 2, phase2 = rnd(360), r2 = rnd(0, 1) / 3, phase3 = rnd(360), r3 = rnd(0, 1) / 4, phase8 = rnd(360), r8 = rnd(0, 0) / 8, rsum = baser + r0 + r1 + r2 + r3 + r8, step = 360 / 60)[
        for (i = [0: step: 360]) let (theta = i + sin((i + ophase1) * rep1) * mag1 + sin((i + ophase2) * rep2) * mag2)[size * sin(theta + phase) * (baser + sin((i + phase0)) * r0 + sin((i + phase1) * 2) * r1 + sin((i + phase2) * 3) * r2 + sin((i + phase3) * 4) * r3 + sin((i + phase8) * 8) * r8) / rsum, -size * cos(theta + phase) * (baser + sin((i + phase0)) * r0 + sin((i + phase1) * 2) * r1 + sin((i + phase2) * 3) * r2 + sin((i + phase3) * 4) * r3 + sin((i + phase8) * 8) * r8) / rsum]];

function it() =
    let (baser = rnd(0.5, 2), phase = rnd(360), mag1 = rnd(3) * baser, rep1 = round(rnd(0, 8)), ophase1 = rnd(360), mag2 = rnd(6) * baser, rep2 = round(rnd(3, 10)), ophase2 = rnd(360), phase0 = rnd(360), r0 = rnd(0, 1), phase1 = rnd(360), r1 = rnd(0, 1) / 2, phase2 = rnd(360), r2 = rnd(0, 1) / 3, phase3 = rnd(360), r3 = rnd(0, 1) / 4, phase8 = rnd(360), r8 = rnd(0, 1) / 8, rsum = baser + r0 + r1 + r2 + r3 + r8, step = 5)[
        for (i = [0: step: 360]) let (theta = i + sin((i + ophase1) * rep1) * mag1 + sin((i + ophase2) * rep2) * mag2)[sin(theta + phase) * (baser + sin((i + phase0)) * r0 + sin((i + phase1) * 2) * r1 + sin((i + phase2) * 3) * r2 + sin((i + phase3) * 4) * r3 + sin((i + phase8) * 8) * r8) / rsum, cos(theta + phase) * (baser + sin((i + phase0)) * r0 + sin((i + phase1) * 2) * r1 + sin((i + phase2) * 3) * r2 + sin((i + phase3) * 4) * r3 + sin((i + phase8) * 8) * r8) / rsum]];

function is_undef(x) = len(x) > 0 ? vec_is_undef(x) : x == undef;

function is_poly_vector(poly) = depth(poly) > 3;

function is_3d_poly(poly) = is_poly_vector(poly) ? len(get_points(poly[0])[0]) == 3 : len(get_points(poly)[0]) == 3;

function irange(a, b) =
    let (step = a > b ? -1 : 1)[
        for (i = [a: step: b]) i];

function invtransform(q, T = [0, 0, 0], R = [30, 30, 30], S = [1, 1, 1]) =
    let (p = q) Vdiv(t([p.x, p.y, p.z, 1] * m_translate(T * -1) * m_rotate(R * -1)), S);

function invtransform(q, T = [0, 0, 0], R = [30, 30, 30], S = [1, 1, 1]) =
    let (p = q) Vdiv(t([p.x, p.y, p.z, 1] * m_translate(T * -1) * m_rotate(R * -1)), S);

function invtransform(q, T, R, S) =
    let (p = q) Vdiv(t([p.x, p.y, p.z, 1] * m_translate(T * -1) * m_rotate(R * -1)), S);

function involute_intersect_angle(base_radius, radius) = sqrt(pow(radius / base_radius, 2) - 1);

function involute_intersect_angle(base_radius, radius) = sqrt(pow(radius / base_radius, 2) - 1) * 180 / pi;

function involute_intersect_angle(base_radius, radius) = sqrt(pow(radius / base_radius, 2) - 1) * 180 / PI;

function involute(base_radius, involute_angle) = [base_radius * (cos(involute_angle) + involute_angle * pi / 180 * sin(involute_angle)), base_radius * (sin(involute_angle) - involute_angle * pi / 180 * cos(involute_angle))];

function involute(base_radius, involute_angle) = [base_radius * (cos(involute_angle) + involute_angle * PI / 180 * sin(involute_angle)), base_radius * (sin(involute_angle) - involute_angle * PI / 180 * cos(involute_angle))];

function invert_rt(m) = construct_Rt(transpose_3(rotation_part(m)), -(transpose_3(rotation_part(m)) * translation_part(m)));

function invert(obj, p) = /*//invert vertices */ poly(name = str("I", p_name(obj)), vertices = [
    for (v = p_vertices(obj)) let (n = norm(v)) v / pow(n, p)
], faces = p_faces(obj));

 
    function intrnd(a = 0, b = 1) = round((rands(min(a, b), max(a, b), 1)[0]));

function interpolate_profile(profile1, profile2, t) =
    let (e = 1)[
        for (i = [0: len(profile1) - 1])[lerp(profile1[i][0], profile2[i][0], SC3(t)) * e, lerp(profile1[i][1], profile2[i][1], SC3(t)) * e, lerp(profile1[i][2], profile2[i][2], t)]];

function interpolate(a, b, subdivisions) = [
    for (index = [0: subdivisions - 1]) let (t = index / subdivisions) a * (1 - t) + b * t
];

function inter(t, r, Threshold = 0) = (t == r) ? 1 : (t > Threshold) ? (r < Threshold) ? abs(Threshold - t) / abs(t - r) : 0 : (r > Threshold) ? abs(Threshold - t) / abs(t - r) : 1;

function inter(t, r, Threshold) = (t == r) ? 1 : (t > Threshold) ? (r < Threshold) ? abs(Threshold - t) / abs(t - r) : 0 : (r > Threshold) ? abs(Threshold - t) / abs(t - r) : 1;

function inter(t, r) = (t > r) ? (t > Threshold) && (r <= Threshold) ? (t - Threshold) / (t - r) : 1 : (t <= Threshold) && (r > Threshold) ? (r - Threshold) / (r - t) : 0;

function inter(t, r) = (t == r) ? 1 : (t > Threshold) ? (r < Threshold) ? abs(Threshold - t) / abs(t - r) : 0 : (r > Threshold) ? abs(Threshold - t) / abs(t - r) : 1;

function inter(t, r) = (t == r) ? 1 : (t > Threshold) ? (r < Threshold) ? abs(Threshold - t) / abs(t - r) : 0 : (r >= Threshold) ? abs(Threshold - t) / abs(t - r) : 0;

function inter(t, r) = (sign(t) == sign(r)) ? undef : abs(0 - t) / max(abs(t - r), 0.000001);

function inter(t, r) = (sign(t) == sign(r)) ? undef : abs(0 - t) / max(abs(t - r), 0.0000001);

function inset_kis(obj, ratio = 0.5, height = -0.1, fn = []) = /*//as kis but pyramids inset in the face */
    let (pe = p_edges(obj), pf = p_faces(obj), pv = p_vertices(obj)) let (newv = flatten([
        for (face = pf) /*//new centroid vertices*/ let (fp = as_points(face, pv)) if (selected_face(face, fn)) let (c = centroid(fp)) let (ec = c + normal(fp) * height) /*//centroid+a bit of normal */ concat([
            [face, ec]
        ], /*//face centroid*/ [
            for (j = [0: len(face) - 1])[[face, face[j]], fp[j] + ratio * (c - fp[j])]
        ])
    ])) let (newids = vertex_ids(newv, len(pv))) let (newf = flatten([
        for (i = [0: len(pf) - 1]) let (face = pf[i]) selected_face(face, fn) ? flatten([
            for (j = [0: len(face) - 1]) /*//replace face with n quads and n triangles */ let (a = face[j], centroid = vertex(face, newids), mida = vertex([face, a], newids), b = face[(j + 1) % len(face)], midb = vertex([face, b], newids))[[a, b, midb, mida], [centroid, mida, midb]]
        ]) : [face]
    ])) poly(name = str("x", p_name(obj)), vertices = concat(pv, vertex_values(newv)), faces = newf);

function insert_extra_vertices_0(lengths_count, n_extra) = n_extra <= 0 ? lengths_count : insert_extra_vertices_0(distribute_extra_vertex(lengths_count), n_extra - 1);

function inradius(R, sides) = R * cos(180 / sides);

function index_of(key, list) = search([key], list)[0];

function increment(arr, i, x = 1) = set(arr, i, arr[i] + x);

function identity4() = [
    [1, 0, 0, 0],
    [0, 1, 0, 0],
    [0, 0, 1, 0],
    [0, 0, 0, 1]
];

function identity3() = [
    [1, 0, 0],
    [0, 1, 0],
    [0, 0, 1]
];

function ident(obj) = /*//identity operation */ obj;

function hrndTA() = [
    [rnd(1), [
        [rnd(1, 1), 6, 6],
        [0, -90, 0],
        [7, 8, 9], logrove, Xring(RING, 1, 0.5), tex
    ], lerp(bna3(), lerp(bna2(), bna(), rnd()), rnd()), fork],
    [rnd(3), [
        [rnd(3, 30), rnd(3, 60), rnd(3, 60)],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], logrove, Xring(RING, 1, 0.5), tex
    ], lerp(mandible(), bna2(), rnd()), fork],
    [rnd(2), [
        [rnd(3, 30), rnd(3, 60), rnd(3, 60)],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], logrove, Xring(RING, 1, 0.5), tex
    ], lerp(bna3(), lerp(bna2(), bna(), rnd()), rnd()), fork],
    [rnd(4), [
        [rnd(3, 30), rnd(3, 60), rnd(3, 60)],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], logrove, Xring(RING, 1, 0.5), tex
    ], lerp(ant1(), lerp(ant2(), bna(), rnd()), rnd()), fork],
    [rnd(3), [
        [rnd(3, 30), rnd(3, 60), rnd(3, 60)],
        [0, rnd(-200, 60), 0],
        [7, 8, 9], logrove, Xring(RING, 1, 0.5), tex
    ], lerp(ant1(), lerp(eye1(), eye2(), 0), 1), fork],
    [rnd(2), [
        [rnd(8, 10), rnd(5, 7), rnd(5, 7)],
        [0, rnd(-60, 60), 0],
        [7, 8, 9], logrove, Xring(RING, 1, 0.5), tex
    ], lerp(eye2(), eye1(), rnd()), fork]
];

function hrndTA() = [
    [rnd(1), [
        [rnd(1, 1), 4, 1],
        [0, -90, 0],
        [7, 8, 9], grove, ring, tex
    ], lerp(bna3(), lerp(bna2(), bna(), rnd()), rnd()), fork],
    [rnd(4), [
        [rnd(3, 30), 5, 8],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], grove, ring, tex
    ], lerp(bna3(), lerp(bna2(), bna(), rnd()), rnd()), fork],
    [rnd(4), [
        [rnd(3, 30), 8, 18],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], grove, ring, tex
    ], lerp(bna3(), lerp(bna2(), bna(), rnd()), rnd()), fork],
    [rnd(4), [
        [rnd(3, 30), 18, 8],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], grove, ring, tex
    ], lerp(bna3(), lerp(bna2(), bna(), rnd()), rnd()), fork],
    [rnd(4), [
        [rnd(3, 30), 5, 8],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], grove, ring, tex
    ], lerp(bna3(), lerp(bna2(), bna(), rnd()), rnd()), fork],
    [rnd(2), [
        [rnd(3, 30), 5, 2],
        [0, rnd(-200, 60), 0],
        [7, 8, 9], grove, ring, tex
    ], lerp(bna3(), lerp(bna2(), bna(), rnd()), rnd()), fork],
    [rnd(1), [
        [rnd(3, 30), 4, 5],
        [0, rnd(-60, 60), 0],
        [7, 8, 9], grove, ring, tex
    ], lerp(eye2(), eye1(), rnd()), fork]
];

function hrndTA() = [
    [rnd(1), [
        [rnd(1, 1), 4, 1],
        [0, -90, 0],
        [7, 8, 9], grove, ring, tex
    ], lerp(bna3(), lerp(bna2(), bna(), rnd()), rnd()), fork],
    [rnd(4), [
        [rnd(3, 30), 5, 8],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], grove, ring, tex
    ], lerp(bna3(), lerp(bna2(), bna(), rnd()), rnd()), fork],
    [rnd(4), [
        [rnd(3, 30), 8, 18],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], grove, ring, tex
    ], lerp(bna3(), lerp(bna2(), bna(), rnd()), rnd()), fork],
    [rnd(4), [
        [rnd(3, 30), 18, 8],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], grove, ring, tex
    ], lerp(bna3(), lerp(bna2(), bna(), rnd()), rnd()), fork],
    [rnd(4), [
        [rnd(3, 30), 5, 8],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], grove, ring, tex
    ], lerp(bna3(), lerp(bna2(), bna(), rnd()), rnd()), fork],
    [rnd(2), [
        [rnd(3, 30), 5, 2],
        [0, rnd(-200, 60), 0],
        [7, 8, 9], grove, ring, tex
    ], lerp(bna3(), lerp(bna2(), bna(), rnd()), rnd()), fork],
    [rnd(1), [
        [rnd(3, 30), 4, 5],
        [0, rnd(-60, 60), 0],
        [7, 8, 9], grove, ring, tex
    ], lerp(bna3(), lerp(eye(), eye(), rnd()), rnd()), fork]
];

function hrndTA() = [
    [rnd(1), [
        [rnd(1, 1), 4, 1],
        [0, -90, 0],
        [7, 8, 9], grove, ring, tex
    ], lerp(bna3(), lerp(bna2(), bna(), rnd()), rnd()), fork],
    [rnd(3), [
        [rnd(3, 30), rnd(3, 60), rnd(3, 60)],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], grove, ring, tex
    ], lerp(mandible(), bna2(), rnd()), fork],
    [rnd(2), [
        [rnd(3, 30), rnd(3, 60), rnd(3, 60)],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], grove, ring, tex
    ], lerp(bna3(), lerp(bna2(), bna(), rnd()), rnd()), fork],
    [rnd(4), [
        [rnd(3, 30), rnd(3, 60), rnd(3, 60)],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], grove, ring, tex
    ], lerp(bna3(), lerp(bna2(), bna(), rnd()), rnd()), fork],
    [rnd(3), [
        [rnd(3, 30), rnd(3, 60), rnd(3, 60)],
        [0, rnd(-200, 60), 0],
        [7, 8, 9], grove, ring, tex
    ], lerp(bna3(), lerp(bna2(), bna(), rnd()), rnd()), fork],
    [rnd(2), [
        [rnd(3, 30), rnd(3, 60), rnd(3, 60)],
        [0, rnd(-60, 60), 0],
        [7, 8, 9], grove, ring, tex
    ], lerp(eye2(), eye1(), rnd()), fork]
];

function hrndTA() = [
    [rnd(1), [
        [rnd(1, 1), 6, 6],
        [0, -90, 0],
        [7, 8, 9], logrove, Xring(RING, 1, 0.3), tex
    ], lerp(bna3(), lerp(bna2(), bna(), rnd()), rnd()), fork],
    [rnd(3), [
        [rnd(3, 30), rnd(3, 60), rnd(3, 60)],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], logrove, Xring(RING, 1, 0.3), tex
    ], lerp(mandible(), bna2(), rnd()), fork],
    [rnd(3), [
        [rnd(3, 30), rnd(3, 60), rnd(3, 60)],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], logrove, Xring(RING, 1, 0.3), tex
    ], lerp(mandible(), bna2(), rnd()), fork],
    [rnd(2), [
        [rnd(3, 30), rnd(3, 60), rnd(3, 60)],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], logrove, Xring(RING, 1, 0.3), tex
    ], lerp(bna3(), lerp(bna2(), bna(), rnd()), rnd()), fork],
    [rnd(4), [
        [rnd(3, 30), rnd(3, 60), rnd(3, 60)],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], logrove, Xring(RING, 1, 0.3), tex
    ], lerp(ant1(), lerp(ant2(), bna(), rnd()), rnd()), fork],
    [rnd(3), [
        [rnd(3, 30), rnd(3, 60), rnd(3, 60)],
        [0, rnd(-200, 60), 0],
        [7, 8, 9], logrove, Xring(RING, 1, 0.3), tex
    ], lerp(ant1(), lerp(eye1(), eye2(), 0), 1), fork],
    [rnd(2), [
        [rnd(8, 10), rnd(5, 7), rnd(5, 7)],
        [0, rnd(-60, 60), 0],
        [7, 8, 9], logrove, Xring(RING, 1, 0.3), tex
    ], lerp(eye2(), eye1(), rnd()), fork]
];

function herpm(mesh, uv) = herp([herp(mesh[0], uv[0]), herp(mesh[1], uv[0]), herp(mesh[2], uv[0]), herp(mesh[3], uv[0])], uv[1]);

function herp1(cps, u) = HERMp0(u) * cps[0] + HERMm0(u) * cps[1] + HERMp1(u) * cps[2] + HERMm1(u) * cps[3];

function herp(cps, u) = [herp1([cps[0][0][0], cps[0][1][0], cps[1][0][0], cps[1][1][0]]), herp1([cps[0][0][1], cps[0][1][1], cps[1][0][1], cps[1][1][1]]), herp1([cps[0][0][2], cps[0][1][2], cps[1][0][2], cps[1][1][2]])];

function heron(a, b, c) =
    let (s = (a + b + c) / 2) sqrt(abs(s * (s - a) * (s - b) * (s - c)));

function helix_curve(pitch, radius, z) = [radius * cos(deg(t(pitch, z))), radius * sin(deg(t(pitch, z))), z];

function hearty(t) = 0.0625 * (13 * cos(t) - 5 * cos(2 * t) - 2 * cos(3 * t) - .6 * cos(4 * t)) + 0.08;

function heartx(t) = pow(sin(t), 3);

function heart_profile(size = 1) = transform(scaling([size / 6, size / 6, 0]) * rotation([0, 0, 90]), concat(heartRight, heartLeftRev));

function half(b, select = 1, l1 = 0.68, l2 = 0.5) =
    let (np1 = lerp(b[0], b[3], l1), np2 = lerp(b[1], b[2], l2)) select == 1 ? [b[0], b[1], np2, np1] : [np1, np2, b[2], b[3]];

function half(b, select = 1, l1 = 0.5, l2 = 0.5) =
    let (np1 = lerp(b[0], b[3], l1), np2 = lerp(b[1], b[2], l2)) select == 1 ? [b[0], b[1], np2, np1] : [np1, np2, b[2], b[3]];

function hadamard(a, b) = !(len(a) > 0) ? a * b : [
    for (i = [0: len(a) - 1]) hadamard(a[i], b[i])
];

function gyro(obj, ratio = 0.3333, height = 0.2) = /*//retain original vertices,add face centroids and directed edge points */ /*//each N-face becomes N pentagons*/
    let (pf = p_faces(obj), pv = p_vertices(obj), pe = p_edges(obj)) let (newv = concat([
        for (face = pf) /*//centroids*/ let (fp = as_points(face, pv))[face, centroid(fp) + normal(fp) * height] /*//centroid+a bit of normal*/
    ], flatten( /*//2 points per edge*/ [
        for (edge = pe) let (ep = as_points(edge, pv))[[edge, ep[0] + ratio * (ep[1] - ep[0])], [reverse(edge), ep[1] + ratio * (ep[0] - ep[1])]]
    ]))) let (newids = vertex_ids(newv, len(pv))) let (newf = flatten( /*//new faces are pentagons */ [
        for (face = pf)[
            for (j = [0: len(face) - 1]) let (a = face[j], b = face[(j + 1) % len(face)], z = face[(j - 1 + len(face)) % len(face)], eab = vertex([a, b], newids), eza = vertex([z, a], newids), eaz = vertex([a, z], newids), centroid = vertex(face, newids))[a, eab, centroid, eza, eaz]]
    ])) poly(name = str("g", p_name(obj)), vertices = concat(pv, vertex_values(newv)), faces = newf);

function ground(v, h = 2) = [v[0], v[1], max(h, v[2])];

function geteulerxz(v) = [0, atan2(v[0], v[2]), 0];

function geteuler(v) = [0, -asin(v[2]), atan2(v2xy(v)[1], v2xy(v)[0])];

function getanglexz(v) = geteulerxz(lim3(1, t(v)));

function getanglexz(v) = (len(v) == 3 || len(v) == 4) ? [0, 0, 0] + geteulerxz(lim3(1, v)) : [90, 0, 0] + [0, 0, -atan2(v[0], v[1])];

function getangle(vector) = [0, 0, -atan2(vector[0], vector[1])];

function getangle(v) = (len(v) == 3 || len(v) == 4) ? [0, 90, 0] + geteuler(lim3(1, v)) : [90, 0, 0] + [0, 0, -atan2(v[0], v[1])];

function getangle(v) = (len(v) == 3) ? [0, 90, 0] + geteuler(lim3(1, v)) : [90, 0, 0] + [0, 0, -atan2(v[0], v[1])];

function get_points(poly) = depth(poly) <= 2 ? poly : poly[0];

function get_cylinder_h(p) = lookup(p, [
    [-200, 5],
    [-50, 20],
    [-20, 18],
    [+80, 25],
    [+150, 2]
]);

function getRange(start, finish, v = []) = len(v) > finish ? v : getRange(start + 1, finish, concat(v, start));

function getPhi(i, f) = (i * 360) / f;

function getFragments(r, fn, fs, fa) = (r < GRID_FINE) ? 3 : (fn > 0.0) ? (fn >= 3 ? fn : 3) : ceil(max(min(360.0 / fa, r * 2 * M_PI / fs), 5));

function getCircle_y(r, i, f) = r * cos(getPhi(i, f));

function getCircle_x(r, i, f) = r * sin(getPhi(i, f));

function getCircle(r, f, i = 0, points = []) = (i >= f ? points : getCircle(r, f, i + 1, concat(points, [
    [getCircle_x(r, i, f), getCircle_y(r, i, f)]
])));

function gauss(x) = x + (x - SC3(x));

function gauss(x) = x + (x - SC3(x)) * 2;

function gauss(i, n = 0) = n > 0 ?
    let (x = gauss(i, n - 1)) x + (x - SC3(x)) : let (x = i) x + (x - SC3(x));

function rnd(a = 1, b = 0, s = []) = s == [] ? (rands(min(a, b), max(a, b), 1)[0]) : (rands(min(a, b), max(a, b), 1, s)[0]);

function fsupersuperegg(r, theta, phi, nt, et = 1, np = 2, ep = 1) = [r * (pow(pow(abs(cos(theta)), nt) + et * pow(abs(sin(theta)), nt), -1 / nt)) * (pow(pow(abs(cos(phi)), np) + ep * pow(abs(sin(phi)), np), -1 / np)), theta, phi];

function fsuperegg(r, theta, phi, n, e = 1) = [r * (pow(pow(abs(cos(theta)), n) + e * pow(abs(sin(theta)), n), -1 / n)), theta, phi];

 
 
 

function fstar(r, theta, phi) = [r * (1.0 + 0.5 * pow((cos(3 * phi)), 2)), theta, phi];

function fmod(r, theta, phi) = fsuperegg(r, theta, phi, 2.5, 1.3333);

function floor3(v) = [floor(v[0]), floor(v[1]), floor(v[2]), floor(v[3])];

function flipxz(v) = un(crosst(t(v), flipxy(v, sky))) * len3(v);

function flipxz(v) = un(cross(v, flipxy(v, sky))) * len3(v);

function flipxy(v) = un(crosst(sky, t(v))) * len3(v);

function flipxy(v) = un(cross(sky, v)) * len3(v);

function flip3(v) = [-v[2], -v[1], v[0]];

function flip(b) = [b[1], b[2], b[3], b[0]];

function flatten(list) = [
    for (i = list, v = i) v
];

function flatten(l) = [
    for (a = l)
        for (b = a) b
];

function findp2p(p, pl, mi, ma, f = 6) = f > 0 && len(pl) > 0 ?
    let (q = avrg([
        for (i = [0: len(pl) - 1]) point2plane(p, pl[i][0], pl[i][1])
    ]), df = q - p) findp2p((p + (df * 1)), pl, mi, ma, f - 1) : p;

function findp2p(p, pl, f = 4) = f > 0 && len(pl) > 0 ?
    let (qi = clamp3([0, 0, 0], [20, 20, 20], avrg([
        for (i = [0: len(pl) - 1])
            if (len3(pl[i][1]) > 0) point2plane(p, pl[i][0], pl[i][1])
    ])), q = qi[0] == undef ? p : qi, df = q - p) findp2p(clamp3([0, 0, 0], [20, 20, 20], p + df * 1.9), pl, f - 1) : clamp3([0, 0, 0], [20, 20, 20], p);

function findp2p(inp, pl, mi, ma, f = 500) =
    let (p = mima3(inp, mi, ma)) f > 0 && len(pl) > 0 ?
    let (q = avrg([
        for (i = [0: len(pl) - 1]) point2plane(p, pl[i][0], pl[i][1])
    ]), df = q - p) len3(df) > 0.01 ? findp2p((p + (df * 0.9)), pl, mi, ma, f - 1) : p : p;

function findp2p(inp, pl, mi, ma, f = 5) =
    let (p = mima3(inp, mi, ma)) f + len(pl) * 2 > 0 && len(pl) > 0 ?
    let (q = avrg([
        for (i = [0: len(pl) - 1]) point2plane(p, pl[i][0], pl[i][1])
    ]), df = q - p) findp2p((p + (df * 1)), pl, mi, ma, f - 1) : p;

function findp2p(inp, pl, mi, ma, f = 16) =
    let (p = [rnd(0.001), rnd(0.001), rnd(0.001)] + mima3(inp, mi, ma)) f > 0 && len(pl) > 0 ?
    let (q = avrg([
        for (i = [0: len(pl) - 1]) point2plane(p, pl[i][0], pl[i][1])
    ]), df = q - p) findp2p((p + (df * 1.05)), pl, mi, ma, f - 1) : p;

function findp2p(inp, pl, mi, ma, f = 15) =
    let (p = mima3(inp, mi, ma)) f > 0 && len(pl) > 0 ?
    let (q = avrg([
        for (i = [0: len(pl) - 1]) point2plane(p, pl[i][0], pl[i][1])
    ]), df = q - p) findp2p((p + (df * 1)), pl, mi, ma, f - 1) : p;

function findp2p(inp, pl, mi, ma, f = 15) =
    let (p = mima3(inp, mi, ma)) f > 0 && len(pl) > 0 ?
    let (q = avrg([
        for (i = [0: len(pl) - 1]) point2plane(p, pl[i][0], pl[i][1])
    ]), df = q - p) findp2p((p + (df * 1)), pl, mi, ma, f - 1) : p;

function findbound(vec, scene) =
    let (VeryFar = 9999999999999, p1 = vec * VeryFar, p2 = p1 + vec, e1 = abs(eval(p1, scene)), e2 = abs(eval(p2, scene)), scale = abs(e2 - e1), corrected = (e1 / scale), distance = VeryFar - e1 /*//distance=VeryFar-corrected*/ ) /*//[p1,p2,e1,e2,scale,corrected,distance ]*/ distance;

function findbound(vec, scene) =
    let (VeryFar = 1e6, p1 = vec * VeryFar, p2 = p1 + un(vec), e1 = abs(eval(p1, scene)), e2 = abs(eval(p2, scene)), scale = abs(e2 - e1), corrected = (e1 / scale), distance = VeryFar - e1 / scale /*//distance=VeryFar-corrected*/ ) /*//[p1,p2,e1,e2,scale,corrected,distance ]*/ distance;

function findbound(vec, model) =
    let (VeryFar = 9999999999999, p1 = vec * VeryFar, p2 = p1 + vec, e1 = abs(eval(p1, model)), e2 = abs(eval(p2, model)), scale = abs(e2 - e1), corrected = (e1 / scale), distance = VeryFar - e1 /*//distance=VeryFar-corrected*/ ) /*//[p1,p2,e1,e2,scale,corrected,distance ]*/ distance;

function findbound(vec, model) =
    let (VeryFar = 9999999999999, p1 = vec * VeryFar, p2 = p1 + vec, e1 = abs(eval(p1, model)), e2 = abs(eval(p2, model)), scale = abs(e2 - e1), corrected = (e1 / scale), distance = VeryFar - e1) /*//[p1,p2,e1,e2,scale,corrected,distance ]*/ distance;

function findbound(vec, model) = /*//same as before*/
    let (VeryFar = 9999999999999, p1 = vec * VeryFar, p2 = p1 + vec, e1 = abs(eval(p1, model)), e2 = abs(eval(p2, model)), scale = abs(e2 - e1), corrected = (e1 / scale), distance = VeryFar - e1 /*//distance=VeryFar-corrected*/ ) distance;

function findbound(v, scene = scenegraph) =
    let (VeryFar = 9999999, p1 = un(v) * VeryFar, p2 = p1 + un(v) * 100, e1 = eval(p1, scene), e2 = eval(p2, scene), scale = abs(e2 - e1) / 100, corrected = (e1 / scale), distance = (VeryFar) - corrected) /*//[p1,p2,e1,e2,scale,corrected,distance ]*/ distance;

function findMin(v, select, i = 0) = ((i + 1) < len(v)) ? min(v[i][select] - v[i][3] - Resolution, findMin(v, select, i + 1)) : v[i][select] - v[i][3] - Resolution;

function findMin(v, select, i = 0) = ((i + 1) < len(v)) ? min(v[i][select] - v[i][3] * 2 - Resolution, findMin(v, select, i + 1)) : v[i][select] - v[i][3] * 2 - Resolution;

function findMin(v, select, i = 0) = ((i + 1) < len(v)) ? min(v[i][select] - abs(v[i][3]) - Resolution, findMin(v, select, i + 1)) : v[i][select] - abs(v[i][3]) - Resolution;

function findMin(v, select, i = 0) = ((i + 1) < len(v)) ? min(v[i][select] - (v[i][3]), findMin(v, select, i + 1)) : v[i][select] - (v[i][3]);

function findMax(v, select, i = 0) = ((i + 1) < len(v)) ? max(v[i][select] + v[i][3] + Resolution, findMax(v, select, i + 1)) : v[i][select] + v[i][3] + Resolution;

function findMax(v, select, i = 0) = ((i + 1) < len(v)) ? max(v[i][select] + v[i][3] * 2 + Resolution, findMax(v, select, i + 1)) : v[i][select] + v[i][3] * 2 + Resolution;

function findMax(v, select, i = 0) = ((i + 1) < len(v)) ? max(v[i][select] + abs(v[i][3]) + Resolution, findMax(v, select, i + 1)) : v[i][select] + abs(v[i][3]) + Resolution;

function findMax(v, select, i = 0) = ((i + 1) < len(v)) ? max(v[i][select] + (v[i][3]), findMax(v, select, i + 1)) : v[i][select] + (v[i][3]);

function find(key, list, c = 0) = c > len(list) - 1 ? undef : key == list[c][0] ? c : find(key, list, c + 1);

function find(key, list) = search(key, list, num_returns_per_match = 1)[0];

function find(key, list) = [
    for (i = [0: len(list) - 1])
        if (key == list[i][0]) i
][0];

function find(key, array) = array[search([key], array)[0]];

function find(i, j, maze_vector, index = 0) = index == len(maze_vector) ? [] : (cord_equals([i, j], [maze_vector[index][0], maze_vector[index][1]]) ? maze_vector[index] : find(i, j, maze_vector, index + 1));

function fillgap(v) = [
    for (i = [0: 0.5: len(v) - 1]) i == i - i % 1 ? v[i] : [v[i - 0.5][1], v[i + 0.5][0]]
];

function fellipsoid(r, theta, phi, e) = [r * (1.0 + pow(e * cos(theta), 2)), theta, phi];

function fegg(r, theta, phi) = [r * (1.0 + 0.5 * pow(1.1 * (cos(1 * theta)), 3)), theta, phi];

     function fcushion(r, theta, phi) = [r * (1.0 - 0.5 * pow(0.9 * cos(theta), 2)), theta, phi];

     function fberry(r, theta, phi) = [r * (1.0 - 0.5 * pow(0.8 * (cos(theta + 60)), 2)), theta, phi];

     function fbauble(r, theta, phi) = [r * (1 - 0.5 * sin(theta * 2) + 0.1 * sin(theta) * sqrt(abs(cos(theta * 2)))) / (sin(theta)), theta, phi];

 
    function faceworker(v) =
    let (index = [
        for (i = [0: len(v) - 1]) v[i][0]
    ], a = [
        for (i = [0: len(v) - 1])
            if (v[i][2][0] != [])[find(v[i][2][0][0], index), find(v[i][2][0][1], index), find(v[i][2][0][2], index), find(v[i][2][0][3], index)]
    ], b = [
        for (i = [0: len(v) - 1])
            if (v[i][2][1] != [])[find(v[i][2][1][0], index), find(v[i][2][1][1], index), find(v[i][2][1][2], index), find(v[i][2][1][3], index)]
    ], c = [
        for (i = [0: len(v) - 1])
            if (v[i][2][2] != [])[find(v[i][2][2][0], index), find(v[i][2][2][1], index), find(v[i][2][2][2], index), find(v[i][2][2][3], index)]
    ]) concat(a, b, c);

function faceworker(v) =
    let (index = [
        for (i = [0: len(v) - 1]) v[i][0]
    ], a = [
        for (i = [0: len(v) - 1])
            if (v[i][2][0] != [])[find(v[i][2][0][0], index), find(v[i][2][0][1], index), find(v[i][2][0][2], index), find(v[i][2][0][3], index)]
    ], b = [
        for (i = [0: len(v) - 1])
            if (v[i][2][1] != [])[find(v[i][2][1][0], index), find(v[i][2][1][1], index), find(v[i][2][1][2], index), find(v[i][2][1][3], index)]
    ], c = [
        for (i = [0: len(v) - 1])
            if (v[i][2][2] != [])[find(v[i][2][2][0], index), find(v[i][2][2][1], index), find(v[i][2][2][2], index), find(v[i][2][2][3], index)]
    ]) concat(a, b, c);

function faceworker(v) =
    let (a = [
        for (i = [0: len(v) - 1])
            if (v[i][2][0] != [])[find(v[i][2][0][0], v), find(v[i][2][0][1], v), find(v[i][2][0][2], v), find(v[i][2][0][3], v)]
    ], b = [
        for (i = [0: len(v) - 1])
            if (v[i][2][1] != [])[find(v[i][2][1][0], v), find(v[i][2][1][1], v), find(v[i][2][1][2], v), find(v[i][2][1][3], v)]
    ], c = [
        for (i = [0: len(v) - 1])
            if (v[i][2][2] != [])[find(v[i][2][2][0], v), find(v[i][2][2][1], v), find(v[i][2][2][2], v), find(v[i][2][2][3], v)]
    ]) concat(a, b, c);

function faceworker(v) = concat([
    for (i = [0: len(v) - 1])
        if (v[i][2][0] != [])[find(v[i][2][0][0], v), find(v[i][2][0][1], v), find(v[i][2][0][2], v), find(v[i][2][0][3], v)]
], [
    for (i = [0: len(v) - 1])
        if (v[i][2][1] != [])[find(v[i][2][1][0], v), find(v[i][2][1][1], v), find(v[i][2][1][2], v), find(v[i][2][1][3], v)]
], [
    for (i = [0: len(v) - 1])
        if (v[i][2][2] != [])[find(v[i][2][2][0], v), find(v[i][2][2][1], v), find(v[i][2][2][2], v), find(v[i][2][2][3], v)]
]);

function face_with_edge(edge, faces) = flatten([
    for (f = faces)
        if (vcontains(edge, ordered_face_edges(f))) f
]);

function face_sides(faces) = [
    for (f = faces) len(f)
];

function face_irregularity(face, points) =
    let (lengths = face_edges(face, points)) max(lengths) / min(lengths);

function face_edges(face, points) = [
    for (edge = ordered_face_edges(face)) edge_length(edge, points)
];

function face_coplanarity(face) = norm(cross(cross(face[1] - face[0], face[2] - face[1]), cross(face[2] - face[1], face[3] - face[2])));

function face_areas_index(obj) = [
    for (face = p_faces(obj)) let (face_points = as_points(face, p_vertices(obj))) let (centroid = centroid(face_points))[face, face_area(vadd(face_points, -centroid))]
];

function face_areas(obj) = [
    for (f = p_faces(obj)) let (face_points = as_points(f, p_vertices(obj))) let (centroid = centroid(face_points)) face_area(vadd(face_points, -centroid))
];

function face_area(face) = ssum([
    for (i = [0: len(face) - 1]) triangle(face[i], face[(i + 1) % len(face)])
]);

//function face_area(face) = /*//ssum([for(i=[0:len(face)-1])*/ /*//triangle(face[i],face[(i+1)%len(face)])]);*/ function face_areas(obj) = /*//[for(f=p_faces(obj))*/ /*//let(face_points=as_points(f,p_vertices(obj)))*/ /*//let(centroid=centroid(face_points))*/ /*//face_area(vadd(face_points,-centroid))*/ /*//];*/ function face_areas_index(obj) = /*//[for(face=p_faces(obj))*/ /*//let(face_points=as_points(face,p_vertices(obj)))*/ /*//let(centroid=centroid(face_points))*/ /*//[face,face_area(vadd(face_points,-centroid))]*/ /*//];*/ function max_area(areas, max = [undef, 0], i = 0) = /*//i<len(areas)*/ /*//?areas[i][1]>max[1]*/ /*//?max_area(areas,areas[i],i+1)*/ /*//:max_area(areas,max,i+1)*/ /*//:max[0];*/ function average_face_normal(fp) = /*//let(fl=len(fp))*/ /*//let(normals=*/ /*//[for(i=[0:fl-1])*/ /*//orthogonal(fp[i],fp[(i+1)%fl],fp[(i+2)%fl])*/ /*//]*/ /*//)*/ /*//vsum(normals)/len(normals);*/ function average_normal(fp) = /*//let(fl=len(fp))*/ /*//let(unitns=*/ /*//[for(i=[0:fl-1])*/ /*//let(n=orthogonal(fp[i],fp[(i+1)%fl],fp[(i+2)%fl]))*/ /*//let(normn=norm(n))*/ /*//normn==0?[]:n/normn*/ /*//]*/ /*//)*/ /*//vsum(unitns)/len(unitns);*/ function average_edge_distance(fp) = /*//let(fl=len(fp))*/ /*//ssum([for(i=[0:fl-1])*/ /*//edge_distance(fp[i],fp[(i+1)%fl])*/ /*//])/fl;*/ function face_sides(faces) = /*//[for(f=faces)len(f)];*/ function face_coplanarity(face) = /*//norm(cross(cross(face[1]-face[0],face[2]-face[1]),*/ /*//cross(face[2]-face[1],face[3]-face[2])*/ /*//));*/ function face_edges(face, points) = /*//[for(edge=ordered_face_edges(face))*/ /*//edge_length(edge,points)*/ /*//];*/ function min_edge_length(face, points) = /*//min(face_edges(face,points));*/ function face_irregularity(face, points) = /*//let(lengths=face_edges(face,points))*/ /*//max(lengths)/min(lengths);*/ function face_analysis(faces) = /*//let(edge_counts=face_sides(faces))*/ /*//[for(sides=distinct(edge_counts))*/ /*//[sides,count(sides,edge_counts)]*/ /*//];*/ function vertex_face_list(vertices, faces) = /*//[for(i=[0:len(vertices)-1])*/ /*//let(vf=vertex_faces(i,faces))*/ /*//len(vf)];*/ function vertex_analysis(vertices, faces) = /*//let(face_counts=vertex_face_list(vertices,faces))*/ /*//[for(vo=distinct(face_counts))*/ /*//[vo,count(vo,face_counts)]*/ /*//];*/ function cosine_between(u, v) = (u * v) / (norm(u) * norm(v));

function face_analysis(faces) =
    let (edge_counts = face_sides(faces))[
        for (sides = distinct(edge_counts))[sides, count(sides, edge_counts)]];

function f2(a) = pow(2, round(log(a / (Resolution)) / log(2))) * Resolution;

function f(t) = /*//rolling knot*/ [a * cos(3 * t) / (1 - b * sin(2 * t)), a * sin(3 * t) / (1 - b * sin(2 * t)), 1.8 * b * cos(2 * t) / (1 - b * sin(2 * t))];

function f(a) = floor(a / Resolution) * Resolution;

function extrude(mesh, ring, length, scali, n = 0) =
    let (rl = len(ring), oldfaces = mesh[1], oldpoints = mesh[0], pl = len(oldpoints), newpoints = [
        for (i = [0: rl - 1]) oldpoints[ring[i]] * scali + length
    ], newfaces = [
        for (ii = [0: 0.5: rl - 0.5]) let (i = floor(ii)) i == ii ? [ring[i], pl + i, pl + ((i + 1) % rl)] : [ring[i], pl + ((i + 1) % rl), ring[((i + 1) % rl)]]
    ], newmesh = [concat(oldpoints, newpoints), concat(oldfaces, newfaces)]) n > 1 ?
    let (newring = [
        for (i = [0: rl - 1])(pl + i)
    ]) extrude(newmesh, newring, length, scali, n - 1) : let (newring = concat([
        for (i = [0: rl - 1])((pl + rl) - 1 - i)
    ], pl + rl))[concat(oldpoints, newpoints, [avrg(newpoints)]), concat(oldfaces, newfaces, ring2faces(newring))];

function extrude(mesh, ring, length, scali, n = 0) =
    let (rl = len(ring), oldfaces = mesh[1], oldpoints = mesh[0], pl = len(oldpoints), newpoints = [
        for (i = [0: rl - 1]) oldpoints[ring[i]] * scali + length
    ], newfaces = [
        for (ii = [0: 0.5: rl - 0.5]) let (i = floor(ii)) i == ii ? [ring[i], pl + i, pl + ((i + 1) % rl)] : [ring[i], pl + ((i + 1) % rl), ring[((i + 1) % rl)]]
    ], newmesh = [concat(oldpoints, newpoints), concat(oldfaces, newfaces)]) n > 1 ?
    let (newring = [
        for (i = [0: rl - 1])(pl + i)
    ]) extrude(newmesh, newring, length * 0.75, scali, n - 1) : let (newring = concat([
        for (i = [0: rl - 1])((pl + rl) - 1 - i)
    ], pl + rl))[concat(oldpoints, newpoints, [avrg(newpoints)]), concat(oldfaces, newfaces, ring2faces(newring))];

function extrude(mesh, ring, length, n = 0) =
    let (rl = len(ring), oldfaces = mesh[1], oldpoints = mesh[0], pl = len(oldpoints), newpoints = [
        for (i = [0: rl - 1]) oldpoints[ring[i]] + [0, 0, length]
    ], newfaces = [
        for (ii = [0: 0.5: rl - 0.5]) let (i = floor(ii)) i == ii ? [ring[i], rl + i, rl + ((i + 1) % rl)] : [ring[i], rl + ((i + 1) % rl), ring[((i + 1) % rl)]]
    ], newmesh = [concat(oldpoints, newpoints), concat(oldfaces, newfaces)]) n > 1 ?
    let (newring = [
        for (i = [0: rl - 1])(pl + i)
    ]) extrude(newmesh, newring, length, n - 1) : let (newring = [
        for (i = [0: rl - 1])(pl + (rl - i - 1))
    ])[concat(oldpoints, newpoints), concat(oldfaces, newfaces, [newring])];

function expand_profile_vertices(profile, n = 32) = len(profile) >= n ? profile : expand_profile_vertices_0(profile, profile_length(profile), n);

function expand(obj, height = 0.5) =
    let (pf = p_faces(obj), pv = p_vertices(obj)) let (newv = flatten([
        for (face = pf) /*//move the whole face outwards*/ let (fp = as_points(face, pv), c = centroid(fp), n = normal(fp), m = m_from(c, n) * m_translate([0, 0, height]) * m_to(c, n))[
            for (i = [0: len(face) - 1])[[face, face[i]], m_transform(fp[i], m)]]
    ])) let (newids = vertex_ids(newv)) let (newf = concat([
        for (face = pf) /*//expanded faces*/ [
            for (v = face) vertex([face, v], newids)]
    ], /*//vertex faces */ [
        for (i = [0: len(pv) - 1]) let (vf = vertex_faces(i, pf))[
            for (of = ordered_vertex_faces(i, vf)) vertex([of, i], newids)]
    ], /*//edge faces */ flatten([
        for (face = pf)[
            for (edge = ordered_face_edges(face)) let (oppface = face_with_edge(reverse(edge), pf), e00 = vertex([face, edge[0]], newids), e01 = vertex([face, edge[1]], newids), e10 = vertex([oppface, edge[0]], newids), e11 = vertex([oppface, edge[1]], newids)) if (edge[0] < edge[1]) /*//no duplicates*/ [e00, e10, e11, e01]]
    ]))) poly(name = str("e", p_name(obj)), vertices = vertex_values(newv), faces = newf);

function evalnorm(q, v) =
    let (e = eval(q, v))[e - eval([q.x - tiny, q.y, q.z], v), e - eval([q.x, q.y - tiny, q.z], v), e - eval([q.x, q.y, q.z - tiny], v), e];

function evalnorm(q, scene) =
    let (tiny = 0.00001, e = eval(q, scene))[e - eval([q.x - tiny, q.y, q.z], scene), e - eval([q.x, q.y - tiny, q.z], scene), e - eval([q.x, q.y, q.z - tiny], scene), e];

function evalnorm(q, model) =
    let (tiny = 0.0001, e = eval(q, model))[e - eval([q.x - tiny, q.y, q.z], model), e - eval([q.x, q.y - tiny, q.z], model), e - eval([q.x, q.y, q.z - tiny], model), e];

function evalnorm(q, model) =
    let (tiny = 0.00001, e = eval(q, model))[e - eval([q.x - tiny, q.y, q.z], model), e - eval([q.x, q.y - tiny, q.z], model), e - eval([q.x, q.y, q.z - tiny], model), e];

function evalnorm(q) =
    let (tiny = 0.00001, e = eval(q))[e - eval([q.x - tiny, q.y, q.z]), e - eval([q.x, q.y - tiny, q.z]), e - eval([q.x, q.y, q.z - tiny]), e];

function eval(q, v) =
    let (opcode = v[opc], p = v[params]) opcode == cR3 ? cR3(q, p) : opcode == opT ? opT(q, p, v[subra]) : opcode == opD ? opT(q, null3, v[subra]) : opcode == opU ? opU(q, p, v[subra]) : opcode == opH ? opU(q, p, v[subra]) : opcode == opI ? opI(q, p, v[subra]) : opcode == opS ? opS(q, p, v[subra]) : opcode == opO ? opO(q, p, v[subra]) : opcode == opE ? opE(q, p, v[subra]) : 1;

function eval(q, v) =
    let (opcode = v[opc], p = v[params]) opcode == cR3 ? cR3(q, p) : opcode == opT ? opT(q, p, v[subra]) : opcode == opD ? opT(q, null3, v[subra]) : /*//deform behaves like null trnasform for now*/ opcode == opU ? opU(q, p, v[subra]) : opcode == opH ? opU(q, p, v[subra]) : /*//hull behaves like union for now:*/ opcode == opI ? opI(q, p, v[subra]) : opcode == opS ? opS(q, p, v[subra]) : opcode == opO ? opO(q, p, v[subra]) : opcode == opE ? opE(q, p, v[subra]) : 1;

 

 
 

function eval(p, model = 1) = model == "default1" ? default1(p) : model == "default2" ? default2(p) : max([
    for (i = [0: len(model) - 1]) plane(p, model[i])
]);

function eval(p, model) = minR(torus(p), box(p), 1);

function eval(p, model) = min(sphere(invtransform(p, [0, -10, 10]), 8), -min(minR(sphere(invtransform(p, [0, 0, 10]), 13), cube(invtransform(p, [-20, 0, 0], [14, 65, 210], [1, 1, 1]), 10), 7), -min(sphere(invtransform(p, [20, 0, 0], [-40, 0, 0], [1, 6, 1]), 4), -cube(invtransform(p, [20, 0, 0], [7, 173, 317], [1, 1, 1]), 10))));

function eval(p) = min(minR(sphere(invtransform(p, [0, 0, 10]), 13), cube(invtransform(p, [-20, 0, 0], [14, 65, 210], [1, 1, 1]), 10), 3), cube(invtransform(p, [20, 0, 0], [7, 173, 317], [1, 1, 1]), 10));

function eval(p) = min(min(sphere(invtransform(p, [0, 0, 10]), 13), cube(invtransform(p, [-20, 0, 0], [14, 65, 210], [1, 1, 1]), 10), 3), cube(invtransform(p, [20, 0, 0], [7, 173, 317], [1, 1, 1]), 10));

function encode(v) =
    let (xseed = round(rnd(1e8, -1e8, round(v.x * 1e8))), yseed = round(rnd(1e8, -1e8, xseed + round(v.y * 1e8))), zseed = round(rnd(1e8, -1e8, yseed + round(v.z * 1e8))), hash = round(rnd(1e8, -1e8, zseed))) hash;

function encode(v) =
    let (xseed = (rnd(9999999999999999, -9999999999999999, 9999999999999999 + v.x * 10000)), yseed = (rnd(9999999999999999, -9999999999999999, xseed + v.y * 10000)), zseed = (rnd(9999999999999999, -9999999999999999, yseed + v.z * 10000)), hash = round(rnd(9999999999999999, 0, zseed))) hash;

function encode(v) =
    let (xseed = (rnd(9999999999999999, -9999999999999999, 9999999999999999 + v.x)), yseed = (rnd(9999999999999999, -9999999999999999, xseed + v.y)), zseed = (rnd(9999999999999999, -9999999999999999, yseed + v.z)), hash = round(rnd(9999999999999999, 0, zseed))) hash;

function encode(p) = str("X", (p.x), "Y", (p.y), "Z", (p.z));

function either(a, b,
    default = undef) = is_undef(a) ? (is_undef(b) ?
    default : b) : is_undef(b) ? a : undef;

function edgesort(faces, i = 0) = i < len(faces) - 1 ?
    let (l = edgesort(faces, i + 1), n = l[0][0]) concat([
        for (i = [0: len(faces) - 1])
            if (faces[i][1] == l[0][0]) faces[i]
    ], l) : [faces[len(faces) - 1]];

function edge_lengths(edges, points) = [
    for (edge = edges) edge_length(edge, points)
];

function edge_length(edge, points) =
    let (points = as_points(edge, points)) norm(points[0] - points[1]);

function edge_distance(v1, v2) = norm(tangent(v1, v2));

function dup(value = 0, n) = [
    for (i = [1: n]) value
];

function duckcolor() = lerp([255, 165, 0] / 255, [255, 215, 0] / 255, rnd());

function dual(obj) = poly(name = str("d", p_name(obj)), vertices = [
    for (f = p_faces(obj)) let (fp = as_points(f, p_vertices(obj))) centroid(fp)
], faces = p_vertices_to_faces(obj));

function dot(v1, v2) = v1[0] * v2[0] + v1[1] * v2[1] + v1[2] * v2[2];

function dot(v1, v2) = addl([
    for (i = [0: len(v1) - 1]) v1[i] * v2[i]
]);

function dot(u, v) = u[0] * v[0] + u[1] * v[1] + u[2] * v[2];

function distribute_extra_vertex(lengths_count, ma_ = -1) = ma_ < 0 ? distribute_extra_vertex(lengths_count, max_element(lengths_count[0])) : concat([set(lengths_count[0], ma_, lengths_count[0][ma_] * (lengths_count[1][ma_] + 1) / (lengths_count[1][ma_] + 2))], [increment(lengths_count[1], max_element(lengths_count[0]), 1)]);

function distinct_face_edges(f) = [
    for (j = [0: len(f) - 1]) let (p = f[j], q = f[(j + 1) % len(f)]) distinct_edge([p, q])
];

function distinct_edges(faces) = [
    for (f = faces)
        for (j = [0: len(f) - 1]) let (p = f[j], q = f[(j + 1) % len(f)]) if (p < q)[p, q] /*//no duplicates*/
];

function distinct(list, dlist = [], i = 0) = /*//return only distinct items of d */ i == len(list) ? dlist : search(list[i], dlist) != [] ? distinct(list, dlist, i + 1) : distinct(list, concat(dlist, list[i]), i + 1);

function dihedral_angle_faces(f0, f1, faces, points) =
    let (angle = angle_between(normal(as_points(faces[f0], points)), normal(as_points(faces[f1], points)))) 180 - angle;

function dihedral_angle(edge, faces, points) =
    let (f0 = face_with_edge(edge, faces), f1 = face_with_edge(reverse(edge), faces)) let (angle = angle_between(normal(as_points(f0, points)), normal(as_points(f1, points)))) 180 - angle;
//
//function dihedral_angle(edge, faces, points) = /*//let(f0=face_with_edge(edge,faces),*/ /*//f1=face_with_edge(reverse(edge),faces)*/ /*//)*/ /*//let(angle=*/ /*//angle_between(*/ /*//normal(as_points(f0,points)),*/ /*//normal(as_points(f1,points))))*/ /*//180-angle;*/ function dihedral_angle_faces(f0, f1, faces, points) = /*//let(angle=*/ /*//angle_between(*/ /*//normal(as_points(faces[f0],points)),*/ /*//normal(as_points(faces[f1],points))))*/ /*//180-angle;*/ /*functions*/ /*//function selected_face(face,fn)=*/ /*//fn==[] || search(len(face),fn)!=[] ;*/ function orthogonal(v0, v1, v2) = cross(v1 - v0, v2 - v1);

function dice() = round(rnd(2.2)) == 1 ? false : true;

function dice() = round(rnd(2 + Open)) == 1 ? false : true;

function dice() = max(0, floor(rnd(-5, 2) * 0.999999)) + 1;

function diamond_profile(size = 1) = transform(scaling([size / 6, size / 6, 0]) * rotation([0, 0, 90]), concat(diamondRight, diamondLeftRev));

function dia(r) = sqrt(pow(r * 2, 2) / 2);

function dflatten(l, d = 2) = /*//hack to flattened mixed list and list of lists*/ flatten([
    for (a = l) depth(a) > d ? dflatten(a, d) : [a]
]);

function depth(a, n = 0) = len(a) == undef ? n : depth(a[0], n + 1);

function depth(a) = len(a) == undef ? 0 : 1 + depth(a[0]);

function delta(v) = [
    for (i = [1: len(v) - 1]) v[i] - v[i - 1]
];

function delete_up_wall_of(vs, is_visited, maze_vector) = replace(vs, [vs[0], vs[1], is_visited, delete_up_wall(vs[3])], maze_vector);

function delete_up_wall(original_block) = (original_block == NO_WALL() || original_block == UP_WALL()) ? NO_WALL() : RIGHT_WALL();

function delete_right_wall_of(vs, is_visited, maze_vector) = replace(vs, [vs[0], vs[1], is_visited, delete_right_wall(vs[3])], maze_vector);

function delete_right_wall(original_block) = original_block == NO_WALL() || original_block == RIGHT_WALL() ? NO_WALL() : UP_WALL();

function deg(angle) = 360 * angle / TAU;

function deepmutate(v, r = 0.3) = len(v) == undef ? v * rnd(1 - r, 1 + r) : len(v) == 0 ? [] : [
    for (i = [0: len(v) - 1]) deepmutate(v[i], r)
];

function deepmutate(v, r = 0.3) = len(v) == undef ? v * rnd(1 - r, 1 + r) : len(v) == 0 ? [] : [
    for (i = [0: len(v) - 1]) deepmutate(v[i], r)
];

function deepmutate(v, r = 0.01) = len(v) == undef ? v * rnd(1 - r, 1 + r) : len(v) == 0 ? [] : [
    for (i = [0: len(v) - 1]) roundlist(v[i], r)
];

function decide_roof_type(t, rseed) = (t == 0) ? floor(rands(0, max_roof_types - 0.01, 1, rseed)[0] + 1) : t;

function decide_number_of_sides(s, rseed) = (s == 0) ? sides_predef[floor(rands(0, len(sides_predef) - 0.01, 1, rseed)[0])] : s;

function decide_dimension(dim, minimum, random_min, random_max, rseed) = (dim == 0) ? round(rands(random_min, random_max, 1, rseed)[0]) : ((dim >= minimum) ? dim : minimum);

function de(faces, points) =
    let (l = len(faces) - 1)[
        for (i = [0: l]) let (f = faces[i]) for (j = [0: len(f) - 1]) let (p = f[j], q = f[(j + 1) % len(f)])[min(p, q), max(p, q), i + points + 1, p, q] /*//no duplicates*/ ];

function ddice() = max(0, floor(rnd(0, 2) * 0.999999)) + 1;

function cylinder(h = 1, r1, r2, center = false, r, d, d1, d2) =
    let (R1 = (d1 == undef ? (d == undef ? (r1 == undef ? (r == undef ? 1 : r) : r1) : d / 2) : d1 / 2), R2 = (d2 == undef ? (d == undef ? (r2 == undef ? (r == undef ? 1 : r) : r2) : d / 2) : d2 / 2), scale = R2 / R1) linear_extrude(height = h, scale = scale, center = center, poly = circle(r = R1));

function cyl() = [concat(xring(8, 10, -10), ringrot(xring(8, 2, 1), 30)), [
    [0, 1, 2],
    [0, 2, 3],
    [0, 3, 4],
    [0, 4, 5],
    [0, 5, 6],
    [0, 6, 7],
    [0, 7, 8],
    [0, 8, 1],
    [2, 1, 10],
    [2, 10, 11],
    [3, 2, 11],
    [3, 11, 12],
    [4, 3, 12],
    [4, 12, 13],
    [5, 4, 13],
    [5, 13, 14],
    [6, 5, 14],
    [6, 14, 15],
    [7, 6, 15],
    [7, 15, 16],
    [8, 7, 16],
    [8, 16, 17],
    [1, 8, 17],
    [1, 17, 10],
    [10, 9, 11],
    [11, 9, 12],
    [12, 9, 13],
    [13, 9, 14],
    [14, 9, 15],
    [15, 9, 16],
    [16, 9, 17],
    [17, 9, 10]
]];

function cyl() = [concat(xring(8, 1, -1), xring(8, 2, 2)), [
    [0, 1, 2],
    [0, 2, 3],
    [0, 3, 4],
    [0, 4, 5],
    [0, 5, 6],
    [0, 6, 7],
    [0, 7, 8],
    [0, 8, 1],
    [2, 1, 10],
    [2, 10, 11],
    [3, 2, 11],
    [3, 11, 12],
    [4, 3, 12],
    [4, 12, 13],
    [5, 4, 13],
    [5, 13, 14],
    [6, 5, 14],
    [6, 14, 15],
    [7, 6, 15],
    [7, 15, 16],
    [8, 7, 16],
    [8, 16, 17],
    [1, 8, 17],
    [1, 17, 10],
    [10, 9, 11],
    [11, 9, 12],
    [12, 9, 13],
    [13, 9, 14],
    [14, 9, 15],
    [15, 9, 16],
    [16, 9, 17],
    [17, 9, 10]
]];

function cutShape() = square(.3);

function cubic_hermite_M() = [
    [2, -2, 1, 1],
    [-3, 3, -2, -1],
    [0, 0, 1, 0],
    [1, 0, 0, 0]
];

function cubic_catmullrom_M() = [
    [-1, 3, -3, 1],
    [2, -5, 4, -1],
    [-1, 0, 1, 0],
    [0, 2, 0, 0]
];

function cubic_bspline_M() = [
    [-1, 2, -3, 1],
    [3, -6, 3, 0],
    [-3, 0, 3, 0],
    [1, 4, 1, 0],
];

function cubic_bezier_M() = [
    [-1, 3, -3, 1],
    [3, -6, 3, 0],
    [-3, 3, 0, 0],
    [1, 0, 0, 0]
];

function cubic_U(u) = [u * u * u, u * u, u, 1];

function cube(size = 1, center = false) =
    let (s = is_array(size) ? size : [size, size, size], points = [
        [0, 0, 0],
        [s.x, 0, 0],
        [0, s.y, 0],
        [s.x, s.y, 0],
        [0, 0, s.z],
        [s.x, 0, s.z],
        [0, s.y, s.z],
        [s.x, s.y, s.z]
    ], faces = [
        [3, 1, 5, 7],
        [0, 1, 3, 2],
        [1, 0, 4, 5],
        [2, 3, 7, 6],
        [0, 2, 6, 4],
        [5, 4, 6, 7]
    ], c = is_array(center) ? [center.x ? s.x : 0, center.y ? s.y : 0, center.z ? s.z : 0] / 2 : s / 2) center ? [translate(-c, points), faces] : [points, faces];

function cube(p, b = 1, r = 0) =
    let (d = abs3(p) - [b - r, b - r, b - r])(min(max(d.x, d.y, d.z), 0.0) + len3(max3(d, 0.0)) - r);

function cube(p, b = 1) = maxl(abs3(p) - [b, b, b]);

function cross(u, v) = [u[1] * v[2] - v[1] * u[2], -(u[0] * v[2] - v[0] * u[2]), u[0] * v[1] - v[0] * u[1]];

function crnd(r) = min(1, max(-1, (rands(-r, r, 1)[0] + rands(-r, r, 1)[0]) * 0.7));

function count(val, list) = /*//number of occurances of val in list*/ ssum([
    for (v = list) v == val ? 1 : 0
]);

function cosine_between(u, v) = (u * v) / (norm(u) * norm(v));

function cos_n(a) = a % 90 ? cos(a) : round(cos(a));

function correction_angle(sides) = (sides == 4) ? 45 : (sides == 5) ? 18 : (sides == 8) ? 22.5 : (sides == 12) ? 15 : 0;

function construct_transform_path(path, closed = false) =
    let (l = len(path), tangents = [
        for (i = [0: l - 1]) tangent_path(path, i)
    ], local_rotations = construct_torsion_minimizing_rotations(concat([
        [0, 0, 1]
    ], tangents)), rotations = accumulate_rotations(local_rotations), twist = closed ? calculate_twist(rotations[0], rotations[l - 1]) : 0)[
        for (i = [0: l - 1]) construct_rt(rotations[i], path[i]) * rotation([0, 0, twist * i / (l - 1)])];

function construct_torsion_minimizing_rotations(tangents) = [
    for (i = [0: len(tangents) - 2]) rotate_from_to(tangents[i], tangents[i + 1])
];

function construct_rt(r, t) = [concat(r[0], t[0]), concat(r[1], t[1]), concat(r[2], t[2]), [0, 0, 0, 1]];

function construct_Rt(R, t) = [concat(R[0], t[0]), concat(R[1], t[1]), concat(R[2], t[2]), [0, 0, 0, 1]];

 
function xring(x = 8, i = 0.5) = mirring([
    for (i = [(360 / x) * 0.5: 360 / x: 359])[0, sin(i) * glx, cos(i) * gly] + rndV2(2 / x + 0.2)
]);

function combine_so3_exp(w, AB) = rodrigues_so3_exp(w, AB[0], AB[1]);

function combine_se3_exp(w, ABt) = construct_Rt(rodrigues_so3_exp(w, ABt[0], ABt[1]), ABt[2]);

function combine_polyhedrons(list, points = [], faces = [], point_count = 0, i = 0) = i < len(list) ? combine_polyhedrons(list, concat(points, list[i][0]), concat(faces, [
    for (face_i = [0: len(list[i][1]) - 1])[
        for (point_i = [0: len(list[i][1][face_i]) - 1]) list[i][1][face_i][point_i] + point_count]
]), point_count + len(list[i][0]), i + 1) : [points, faces];

function coerce(m) = [unit(m[0]), make_orthogonal(m[1], m[0]), make_orthogonal(make_orthogonal(m[2], m[0]), m[1])];

function cmin(c) = c[0] == undef ? [0.5, 0.5, 0.5] : [max(0, min(1, c[0])), max(0, min(1, c[1])), max(0, min(1, c[2]))];

function close_trajectory_loop(trajectories) = concat(trajectories, [se3_ln(invert_rt(trajectories_end_position(trajectories)))]);

function claw(extention) = concat(Claw, extention);

function claw(extention) = Claw;

function clampMin(v, lim) = [
    for (vi = v) max(vi, lim)
];

function clampMin(v, lim) = [
    for (vi = v) max(vi, lim)
];

function clamp3(v1, v2, v3) = [min(v2.x, max(v3.x, v1.x)), min(v2.y, max(v3.y, v1.y)), min(v2.z, max(v3.z, v1.z))];

function clamp(a, b = 0, c = 10) = min(max(a, b), c);

function circle(r = 1, c = [0, 0], internal = false, d) =
    let (r1 = d == undef ? r : d / 2, points = arc(r = r1, c = c, angle = -360, internal = internal))[points, [irange(0, len(points) - 1)]];

function circle(r) = [
    for (i = [0: $fn - 1]) let (a = i * 360 / $fn) r * [cos(a), sin(a)]
];

function check_euler(obj) = /*//E=V+F-2 */ len(p_vertices(obj)) + len(p_faces(obj)) - 2 == len(distinct_edges(obj[2]));
 
 function edge_distance(v1, v2) = norm(tangent(v1, v2));

function chaos_sides(val, rseed = detail_random_seed) = (rands(-5, 10, 1, rseed)[0] >= chaos) ? val : decide_number_of_sides(0, rseed);

function chaos_roof(val, rseed = detail_random_seed) = (rands(-5, 10, 1, rseed)[0] >= chaos) ? val : decide_roof_type(0, rseed);

function chanfered_filleted_block_eval(p, size, ch, r) =
    let (M = [
        [1, 0, 0],
        [0, 1, 0],
        [0, 0, 1], /*//box bounds*/
        [1, 1, 0] / sqrt(2), [0, 1, 1] / sqrt(2), [1, 0, 1] / sqrt(2), /*//edge chamfer bounds*/ [1, 1, 1] / sqrt(3)
    ], /*//vertex chamfer bounds,*/ cr = (ch - sqrt(2) * r / tan(67.5)) / sqrt(2), d = _abs(p) - size / 2 + [r, r, r]) - (r /*//offset*/ - max(M * d + [0, 0, 0, cr, cr, cr, cr * sqrt(3)]) /*//distance inside model*/ - norm(clampMin(M * d + [0, 0, 0, cr, cr, cr, cr * sqrt(3)], 0)));

function chamfered_filleted_block_eval(p, size, ch, r) =
    let (M = [
        [1, 0, 0],
        [0, 1, 0],
        [0, 0, 1], /*//box bounds*/
        [1, 1, 0] / sqrt(2), [0, 1, 1] / sqrt(2), [1, 0, 1] / sqrt(2), /*//edge chamfer bounds*/ [1, 1, 1] / sqrt(3)
    ], /*//vertex chamfer bounds,*/ cr = (ch - sqrt(2) * r / tan(67.5)) / sqrt(2), d = _abs(p) - size / 2 + [r, r, r]) - (r /*//offset*/ - max(M * d + [0, 0, 0, cr, cr, cr, cr * sqrt(3)]) /*//distance inside scene*/ - norm(clampMin(M * d + [0, 0, 0, cr, cr, cr, cr * sqrt(3)], 0)));

function chamfered_filleted_block_eval(p, size, ch, r) =
    let (M = [
        [1, 0, 0],
        [0, 1, 0],
        [0, 0, 1], /*//box bounds*/
        [1, 1, 0] / sqrt(2), [0, 1, 1] / sqrt(2), [1, 0, 1] / sqrt(2), /*//edge chamfer bounds*/ [1, 1, 1] / sqrt(3)
    ], /*//vertex chamfer bounds,*/ cr = (ch - sqrt(2) * r / tan(67.5)) / sqrt(2), d = _abs(p) - size / 2 + [r, r, r])( /*//offset*/ max(M * d + [0, 0, 0, cr, cr, cr, cr * sqrt(3)]) /*//distance inside scene*/ + (norm(clampMin(M * d + [0, 0, 0, cr, cr, cr, cr * sqrt(3)], 0)) * 0.1 - r));

function chamfer(obj, ratio = 0.333) =
    let (pf = p_faces(obj), pv = p_vertices(obj)) let (newv = flatten( /*//face inset*/ [
        for (face = pf) let (fp = as_points(face, pv), c = centroid(fp))[
            for (j = [0: len(face) - 1])[[face, face[j]], fp[j] + ratio * (c - fp[j])]]
    ])) let (newids = vertex_ids(newv, len(pv))) let (newf = concat([
        for (face = pf) /*//rotated faces*/ [
            for (v = face) vertex([face, v], newids)]
    ], flatten( /*//chamfered pentagons*/ [
        for (face = pf)[
            for (j = [0: len(face) - 1]) let (a = face[j], b = face[(j + 1) % len(face)]) if (a < b) /*//dont duplicate*/ let (edge = [a, b], oppface = face_with_edge([b, a], pf), oppa = vertex([oppface, a], newids), oppb = vertex([oppface, b], newids), thisa = vertex([face, a], newids), thisb = vertex([face, b], newids))[a, oppa, oppb, b, thisb, thisa]]
    ]))) poly(name = str("c", p_name(obj)), vertices = concat([
        for (v = pv)(1.0 - ratio) * v
    ], /*//original */ vertex_values(newv)), faces = newf);

function centroid_points(points) = vadd(points, -centroid(points));

function centroid(points) = vsum(points) / len(points);

function ccweld(v) =
    let (data = v[0])[v[0], [
        for (i = [0: len(v[1]) - 1]) let (index1 = v[1][i][0], index2 = v[1][i][1], index3 = v[1][i][2]) concat(search(data[index1][0], data), search(data[index2][0], data), search(data[index3][0], data, 1))
    ]];

function ccweld(v) =
    let (data = v[0])[v[0], [
        for (i = [0: len(v[1]) - 1]) let (index1 = v[1][i][0], index2 = v[1][i][1], index3 = v[1][i][2]) concat(search(data[index1][0], data), search(data[index2][0], data), search(data[index3][0], data, 1))
    ]];

function ccquicksort(arr, o) = !(len(arr) > 0) ? [] : let (pivot = arr[floor(len(arr) / 2)], lesser = [
    for (y = arr)
        if (y[o] < pivot[o]) y
], equal = [
    for (y = arr)
        if (y[o] == pivot[o]) y
], greater = [
    for (y = arr)
        if (y[o] > pivot[o]) y
]) concat(ccquicksort(lesser, o), equal, ccquicksort(greater, o));

function ccnv(v, nf, curve) =
    let (nv = [
        for (i = [0: len(v[1]) - 1])(v[0][v[1][i][0]] + v[0][v[1][i][1]] + v[0][v[1][i][2]]) / 3
    ]) let (sfv = [
        for (i = [0: len(v[0]) - 1]) avrg(ccfind(i, v[1], nv))
    ]) concat(lerp(v[0], sfv, curve), nv);

function ccnv(v, nf, curve) =
    let (nv = [
        for (i = [0: len(v[1]) - 1])(v[0][v[1][i][0]] + v[0][v[1][i][1]] + v[0][v[1][i][2]]) / 3
    ]) let (sfv = [
        for (i = [0: len(v[0]) - 1]) avrg(ccfind(i, v[1], nv))
    ]) concat(lerp(v[0], sfv, curve), nv);

function ccnv(v, nf, curve) =
    let (nv = [
        for (i = [0: len(v[1]) - 1])(v[0][v[1][i][0]] + v[0][v[1][i][1]] + v[0][v[1][i][2]]) / 3
    ]) let (sfv = [
        for (i = [0: len(v[0]) - 1]) avrg(ccfind(i, v[1], nv))
    ]) concat(lerp(v[0], sfv, curve), nv);

function ccnf(hf) = [
    for (i = [0: 1: len(hf) - 1])(i % 2) == 0 ? [hf[i][4], hf[(i + 1) % len(hf)][2], hf[i][2]] : [hf[i][4], hf[(i - 1) % len(hf)][2], hf[i][2]]
];

function ccnf(hf) = [
    for (i = [0: 1: len(hf) - 1])(i % 2) == 0 ? [hf[i][4], hf[(i + 1) % len(hf)][2], hf[i][2]] : [hf[i][4], hf[(i - 1) % len(hf)][2], hf[i][2]]
];

function ccflip(w) = [w[0],
    [
        for (i = [0: len(w[1]) - 1])[w[1][i][0], w[1][i][2], w[1][i][1]]
    ]
];

function ccflip(w) = [w[0],
    [
        for (i = [0: len(w[1]) - 1])[w[1][i][0], w[1][i][2], w[1][i][1]]
    ]
];

function ccflip(w) = [w[0],
    [
        for (i = [0: len(w[1]) - 1])[w[1][i][0], w[1][i][1], w[1][i][2]]
    ]
];

function ccflip(w) = [w[0],
    [
        for (i = [0: len(w[1]) - 1])[w[1][i][0], w[1][i][2], w[1][i][1]]
    ]
];

function ccfind(lookfor, faces, nv) = [
    for (i = [0: len(faces) - 1])
        if (faces[i][0] == lookfor || faces[i][1] == lookfor || faces[i][2] == lookfor) nv[i]
];

function ccfind(lookfor, faces, nv) = [
    for (i = [0: len(faces) - 1])
        if (faces[i][0] == lookfor || faces[i][1] == lookfor || faces[i][2] == lookfor) nv[i]
];

function ccfind(lookfor, faces, nv) = [
    for (i = [0: len(faces) - 1])
        if (faces[i][0] == lookfor || faces[i][1] == lookfor || faces[i][2] == lookfor) nv[i]
];

function ccerp(U, M, G) = vec4_mult_mat34(vec4_mult_mat4(U, M), G);

function ccde(faces, points) =
    let (l = len(faces) - 1)[
        for (i = [0: l]) let (f = faces[i]) for (j = [0: len(f) - 1]) let (p = f[j], q = f[(j + 1) % len(f)])[min(p, q), max(p, q), i + points + 1, p, q] /*//noduplicates */ ];

function ccde(faces, points) =
    let (l = len(faces) - 1)[
        for (i = [0: l]) let (f = faces[i]) for (j = [0: len(f) - 1]) let (p = f[j], q = f[(j + 1) % len(f)])[min(p, q), max(p, q), i + points + 1, p, q] /*//no duplicates*/ ];

function ccde(faces, points) =
    let (l = len(faces) - 1)[
        for (i = [0: l]) let (f = faces[i]) for (j = [0: len(f) - 1]) let (p = f[j], q = f[(j + 1) % len(f)])[min(p, q), max(p, q), i + points + 1, p, q] /*//noduplicates */ ];

function cccheck(ed) = concat([
    for (i = [0: len(ed) - 1])
        if ((ed[i][0] == ed[i - 1][0] && ed[i][1] == ed[i - 1][1]) || (ed[i][0] == ed[i + 1][0] && ed[i][1] == ed[i + 1][1])) ed[i]
], [
    for (i = [0: len(ed) - 1])
        if ((ed[i][0] != ed[i - 1][0] || ed[i][1] != ed[i - 1][1]) && (ed[i][0] != ed[i + 1][0] || ed[i][1] != ed[i + 1][1])) ed[i]
]);

function cccheck(ed) = concat([
    for (i = [0: len(ed) - 1])
        if ((ed[i][0] == ed[i - 1][0] && ed[i][1] == ed[i - 1][1]) || (ed[i][0] == ed[i + 1][0] && ed[i][1] == ed[i + 1][1])) ed[i]
]);

function cccheck(ed) = concat([
    for (i = [0: len(ed) - 1])
        if ((ed[i][0] == ed[i - 1][0] && ed[i][1] == ed[i - 1][1]) || (ed[i][0] == ed[i + 1][0] && ed[i][1] == ed[i + 1][1])) ed[i]
]);

function ccQS(arr, o) = !(len(arr) > 0) ? [] : let (pivot = arr[floor(len(arr) / 2)], lesser = [
    for (y = arr)
        if (y[o] < pivot[o]) y
], equal = [
    for (y = arr)
        if (y[o] == pivot[o]) y
], greater = [
    for (y = arr)
        if (y[o] > pivot[o]) y
]) concat(ccQS(lesser, o), equal, ccQS(greater, o));

function ccQS(arr, o) = !(len(arr) > 0) ? [] : let (pivot = arr[floor(len(arr) / 2)], lesser = [
    for (y = arr)
        if (y[o] < pivot[o]) y
], equal = [
    for (y = arr)
        if (y[o] == pivot[o]) y
], greater = [
    for (y = arr)
        if (y[o] > pivot[o]) y
]) concat(ccQS(lesser, o), equal, ccQS(greater, o));

function cc(polyhedronobj) =
    let (obj = p_resize(poly(name = "T", polyhedronobj[0], polyhedronobj[1] /*vertices=[[1,1,1],[1,-1,-1],[-1,1,-1],[-1,-1,1]],faces=[[2,1,0],[3,2,0],[1,3,0],[2,3,1]]*/ ))) /*//Catmull-Clark smoothing*/ /*//each face is replaced with n quadralaterals based on edge midpoints vertices and centroid*/ /*//edge midpoints are average of edge endpoints and adjacent centroids*/ /*//original vertices replaced by weighted average of original vertex,face centroids and edge midpoints*/ let (pe = p_edges(obj), pf = p_faces(obj), pv = p_vertices(obj)) let (newfv = [
        for (face = pf) /*//new centroid vertices*/ let (fp = as_points(face, pv))[face, centroid(fp)]
    ]) let (newev = /*//new edge 'midpoints'*/ [
        for (edge = pe) let (ep = as_points(edge, pv), af1 = face_with_edge(edge, pf), af2 = face_with_edge(reverse(edge), pf), fc1 = vertex(af1, newfv), fc2 = vertex(af2, newfv))[edge, (ep[0] + ep[1] + fc1 + fc2) / 4]
    ]) let (newfvids = vertex_ids(newfv, len(pv))) let (newevids = vertex_ids(newev, len(pv) + len(newfv))) let (newf = flatten([
        for (face = pf) let (centroid = vertex(face, newfvids)) flatten([
            for (j = [0: len(face) - 1]) /*//*/ let (a = face[j], b = face[(j + 1) % len(face)], c = face[(j + 2) % len(face)], mid1 = vertex(distinct_edge([a, b]), newevids), mid2 = vertex(distinct_edge([b, c]), newevids))[[centroid, mid1, b, mid2]]
        ])
    ])) let (newv = /*//revised original vertices */ [
        for (i = [0: len(pv) - 1]) let (v = pv[i], vf = [
            for (face = vertex_faces(i, pf)) vertex(face, newfv)
        ], F = centroid(vf), R = centroid([
            for (edge = vertex_edges(i, pe)) vertex(edge, newev)
        ]), n = len(vf))(F + 2 * R + (n - 3) * v) / n
    ])[concat(newv, vertex_values(newfv), vertex_values(newev)), newf];

function cc(obj) = /*//Catmull-Clark smoothing*/ /*//each face is replaced with n quadralaterals based on edge midpoints vertices and centroid*/ /*//edge midpoints are average of edge endpoints and adjacent centroids*/ /*//original vertices replaced by weighted average of original vertex,face centroids and edge midpoints*/
    let (pe = p_edges(obj), pf = p_faces(obj), pv = p_vertices(obj)) let (newfv = [
        for (face = pf) /*//new centroid vertices*/ let (fp = as_points(face, pv))[face, centroid(fp)]
    ]) let (newev = /*//new edge 'midpoints'*/ [
        for (edge = pe) let (ep = as_points(edge, pv), af1 = face_with_edge(edge, pf), af2 = face_with_edge(reverse(edge), pf), fc1 = vertex(af1, newfv), fc2 = vertex(af2, newfv))[edge, (ep[0] + ep[1] + fc1 + fc2) / 4]
    ]) let (newfvids = vertex_ids(newfv, len(pv))) let (newevids = vertex_ids(newev, len(pv) + len(newfv))) let (newf = flatten([
        for (face = pf) let (centroid = vertex(face, newfvids)) flatten([
            for (j = [0: len(face) - 1]) /*//*/ let (a = face[j], b = face[(j + 1) % len(face)], c = face[(j + 2) % len(face)], mid1 = vertex(distinct_edge([a, b]), newevids), mid2 = vertex(distinct_edge([b, c]), newevids))[[centroid, mid1, b, mid2]]
        ])
    ])) let (newv = /*//revised original vertices */ [
        for (i = [0: len(pv) - 1]) let (v = pv[i], vf = [
            for (face = vertex_faces(i, pf)) vertex(face, newfv)
        ], F = centroid(vf), R = centroid([
            for (edge = vertex_edges(i, pe)) vertex(edge, newev)
        ]), n = len(vf))(F + 2 * R + (n - 3) * v) / n
    ]) poly(name = str("v", p_name(obj)), vertices = concat(newv, vertex_values(newfv), vertex_values(newev)), faces = newf);

function cc(V, n = 1, curve = 0.7) = n <= 0 ? V : n == 1 ?
    let (w = V) let (ed = (ccquicksort(ccquicksort(ccquicksort(ccquicksort(ccde(w[1], len(w[0]) - 1), 2), 1), 0), 1))) let (nf = ccnf(ed))[ccnv(w, nf, curve), nf] : let (w = cc(V, n - 1, curve)) let (ed = (ccquicksort(ccquicksort(ccquicksort(ccquicksort(ccde(w[1], len(w[0]) - 1), 2), 1), 0), 1))) let (nf = ccnf(ed))[ccnv(w, nf, curve), nf];

function cc(V, n = 1, curve = 0.61803398875) = n <= 0 ? V : n == 1 ?
    let (w = V) let (ed = cccheck(ccquicksort(ccquicksort(ccquicksort(ccquicksort(ccde(w[1], len(w[0]) - 1), 2), 1), 0), 1))) let (nf = ccnf(ed)) ccflip([ccnv(w, nf, curve), nf]) : let (w = cc(V, n - 1, curve)) let (ed = cccheck(ccquicksort(ccquicksort(ccquicksort(ccquicksort(ccde(w[1], len(w[0]) - 1), 2), 1), 0), 1))) let (nf = ccnf(ed)) ccflip([ccnv(w, nf, curve), nf]);

function cc(V, n = 1, curve = 0.61803398875) = n <= 0 ? V : n == 1 ?
    let (w = V) let (ed = cccheck(ccquicksort(ccquicksort(ccquicksort(ccquicksort(ccde(w[1], len(w[0]) - 1), 2), 1), 0), 1))) let (nf = ccnf(ed))[ccnv(w, nf, curve), nf] : let (w = cc(V, n - 1, curve)) let (ed = cccheck(ccquicksort(ccquicksort(ccquicksort(ccquicksort(ccde(w[1], len(w[0]) - 1), 2), 1), 0), 1))) let (nf = ccnf(ed))[ccnv(w, nf, curve), nf];

function cc(V, n = 1, curve = 0.61803398875) = n <= 0 ? V : n == 1 ?
    let (w = V) let (ed = cccheck(ccQS(ccQS(ccQS(ccQS(ccde(w[1], len(w[0]) - 1), 2), 1), 0), 1))) let (nf = ccnf(ed)) ccflip([ccnv(w, nf, curve), nf]) : let (w = cc(V, n - 1, curve)) let (ed = cccheck(ccQS(ccQS(ccQS(ccQS(ccde(w[1], len(w[0]) - 1), 2), 1), 0), 1))) let (nf = ccnf(ed)) ccflip([ccnv(w, nf, curve), nf]);

function cc(V, n = 1) = n <= 0 ? V : n == 1 ?
    let (w = V) let (ed = quicksort(quicksort(quicksort(quicksort(de(w[1], len(w[0]) - 1), 2), 1), 0), 1))[nv(w), nf(ed)] : let (w = cc(V, n - 1)) let (ed = quicksort(quicksort(quicksort(quicksort(de(w[1], len(w[0]) - 1), 2), 1), 0), 1))[nv(w), nf(ed)];

function cant(obj, height = 0.1) = /*//each face is replaced with n quadralaterals based on edge midpoints vertices and centroid moved normally(like ortho)*/
    let (pe = p_edges(obj), pf = p_faces(obj), pv = p_vertices(obj)) let (newv = concat([
        for (face = pf) /*//new centroid vertices*/ let (fp = as_points(face, pv))[face, centroid(fp) + normal(fp) * height]
    ], [
        for (edge = pe) let (ep = as_points(edge, pv))[edge, (ep[0] + ep[1]) / 2]
    ])) let (newids = vertex_ids(newv, len(pv))) let (newf = flatten([
        for (face = pf) let (centroid = vertex(face, newids)) flatten([
            for (j = [0: len(face) - 1]) /*//*/ let (a = face[j], b = face[(j + 1) % len(face)], c = face[(j + 2) % len(face)], mid1 = vertex(distinct_edge([a, b]), newids), mid2 = vertex(distinct_edge([b, c]), newids)) /*//[ [ mid1,centroid,mid2,b] ]*/ [[b, mid2, centroid, mid1]]
        ])
    ])) poly(name = str("o", p_name(obj)), vertices = concat(pv, vertex_values(newv)), faces = newf);

function canon(obj, n = 5) = n > 0 ? canon(ndual(ndual(obj)), n - 1) : p_resize(poly(name = str("K", p_name(obj)), vertices = p_vertices(obj), faces = p_faces(obj)));

function calculate_twist(A, B) =
    let (D = transpose_3(B) * A) atan2(D[1][0], D[0][0]);

function cR3(q, r) = max(maxCH(abs(q.x) - 3, abs(q.y) - 3, 1), maxCH(abs(q.x) - 3, abs(q.z) - 3, 1), maxCH(abs(q.y) - 3, abs(q.z) - 3, 1));

function cR3(q, r) =
    let (d = abs3(q) - (r[0] - [r[1], r[1], r[1]])) min(max(d.x, d.y, d.z), 0.0) + len3(max3(d, 0.0)) - r[1];

function cR3(q, r) = len3(q) - r;

function cR3(p, params) =
    let (r = params[0]) torus(p, r, r / 4);

function bzplot(v, res) = [
    for (i = [1: -1 / res: 0]) bez2(i, v)
];

function bzplot(v, res) = [
    for (i = [0: 1 / res: 1.001]) bez2(i, v)
];

function bzplot(v, res) = [
    for (i = [0: 1 / res: 1.001]) bez2(i, v)
];

function bz2t(v, stop, precision = 0.01, t = 0, acc = 0) = acc >= stop || t > 1 ? t : bz2t(v, stop, precision, t + precision, acc + len3(bez2(t, v) - bez2(t + precision, v)));

function bz2t(v, stop, precision = 0.01, t = 0, acc = 0) = acc >= stop || t > 1 ? t : bz2t(v, stop, precision, t + precision, acc + len3(bez2(t, v) - bez2(t + precision, v)));

function build_wall(i, j, n, rows, columns, maze_vector) = n == 1 && i != columns && not_visited([i + 1, j], maze_vector) ? go_right(i, j, rows, columns, maze_vector) : (n == 2 && j != 1 && not_visited([i, j - 1], maze_vector) ? go_up(i, j, rows, columns, maze_vector) : (n == 3 && i != 1 && not_visited([i - 1, j], maze_vector) ? go_left(i, j, rows, columns, maze_vector) : (n == 4 && j != rows && not_visited([i, j + 1], maze_vector) ? go_down(i, j, rows, columns, maze_vector) : maze_vector)));

function brndc(rgb) = [(rands(255 - 50, 255, 1)[0]) / 256, rands(224 - 40, 224 + 30, 1)[0] / 256, rands(198 - 35, 198 + 35, 1)[0] / 256];

function box(p1, b = 0.71) =
    let (p = p1 + [0.1, 0.6, 1.5]) len3(p) - b;

function bounds(poly) = is_3d_poly(poly) ? (is_poly_vector(poly) ? _bounds_multi_3d(poly) : _bounds_3d(poly)) : (is_poly_vector(poly) ? _bounds_multi_2d(poly) : _bounds_2d(poly));

function bound(v) = [
    [minls(v, 0), minls(v, 1), minls(v, 2)],
    [maxls(v, 0), maxls(v, 1), maxls(v, 2)]
];

function bound(scene, steps = 20) =
    let (up = findbound([0, 0, 1], scene), down = -findbound([0, 0, -1], scene), north = findbound([0, 1, 0], scene), south = -findbound([0, -1, 0], scene), west = findbound([1, 0, 0], scene), east = -findbound([-1, 0, 0], scene))[[east, south, down], [west, north, up], steps];

function bound(field, maxspan = 50, steps = 20) =
    let (top = far - eval([0, 0, far], field), /*//* roundp(far/eval([0,0,far],field)),*/ bottom = -(far - eval([0, 0, -far], field)), /*//*roundp(far/eval([0,0,far],field))),*/ north = far - eval([0, far, 0], field), south = -(far - eval([0, -far, 0], field)), west = far - eval([far, 0, 0], field), east = -(far - eval([-far, 0, 0], field))) /*//[min(maxspan,west),min(maxspan,north),min(maxspan,top)],*/ [[max(-maxspan), max(-maxspan), max(-maxspan)], [min(maxspan), min(maxspan), min(maxspan)], (((west - east) + (north - south) + (top - bottom)) / 3) / steps];

function bound(field, maxspan = 50, steps = 20) =
    let (top = far - eval([0, 0, far], field), /*//* roundp(far/eval([0,0,far],field)),*/ bottom = -(far - eval([0, 0, -far], field)), /*//*roundp(far/eval([0,0,far],field))),*/ north = far - eval([0, far, 0], field), /*//*roundp(far/eval([0,far,0],field)),*/ south = -(far - eval([0, -far, 0], field)), /*//*roundp(far/eval([0,far,0],field))),*/ west = far - eval([far, 0, 0], field), /*//*roundp(far/eval([far,0,0],field)),*/ east = -(far - eval([-far, 0, 0], field)) /*//*roundp(far/eval([far,0,0],field)))*/ ) /*//[[max(-maxspan,east),max(-maxspan,south),max(-maxspan,bottom)],*/ /*//[min(maxspan,west),min(maxspan,north),min(maxspan,top)],*/ [[max(-maxspan), max(-maxspan), max(-maxspan)], [min(maxspan), min(maxspan), min(maxspan)], (((west - east) + (north - south) + (top - bottom)) / 3) / steps];

function bna3(ii = 1) =
    let (i = (ii - 5) * -7)[[rnd(2), [
        [rnd(3, 15), rnd(3, 10), rnd(3, 10)],
        [-40 + rnd(-20, 20), -40 + rnd(-20, 20), -40 + rnd(-20, 20)],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [rnd(2), [
        [rnd(3, 15), rnd(3, 10), rnd(3, 10)],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [rnd(2), [
        [rnd(13, 60), rnd(3, 10), rnd(3, 10)],
        [0, rnd(-60, -30), 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [rnd(2), [
        [rnd(3, 10), rnd(3, 10), rnd(3, 10)],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [rnd(2), [
        [rnd(13, 60), rnd(3, 10), rnd(3, 10)],
        [0, rnd(30, 60), 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [rnd(2), [
        [rnd(3, 15), rnd(3, 10), rnd(3, 10)],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [rnd(8), [
        [rnd(3, 1), rnd(3, 2), rnd(3, 2)],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), Xring(8, 1, 0.5), tex
    ], fork]];

function bna3(ii = 1) =
    let (i = (ii - 5) * -7)[[rnd(2), [
        [rnd(3, 15), rnd(3, 15), rnd(3, 15)],
        [i + rnd(-20, 20), 220 + rnd(-20, 20), 90 + i + rnd(-20, 20)],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [rnd(2), [
        [rnd(3, 15), rnd(3, 15), rnd(3, 15)],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [rnd(2), [
        [rnd(3, 15), rnd(3, 15), rnd(3, 15)],
        [0, rnd(-60, -30), 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [rnd(2), [
        [rnd(3, 15), rnd(3, 15), rnd(3, 15)],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [rnd(2), [
        [rnd(3, 15), rnd(3, 15), rnd(3, 15)],
        [0, rnd(30, 60), 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [rnd(2), [
        [rnd(3, 15), rnd(3, 15), rnd(3, 15)],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [rnd(8), [
        [rnd(3, 0.5), rnd(3, 2), rnd(3, 2)],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), Xring(8, 1, 0.5), tex
    ], fork]];

function bna3() = [
    [rnd(2), [
        [rnd(3, 5), 4, 1],
        [rnd(-90, 90), -135, intrnd(70, 110)],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [rnd(2), [
        [rnd(3, 5), 5, 8],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [rnd(2), [
        [rnd(3, 30), 8, 18],
        [0, rnd(-60, -30), 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [rnd(2), [
        [rnd(3, 5), 4, 8],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [rnd(2), [
        [rnd(3, 30), 5, 8],
        [0, rnd(30, 60), 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [rnd(2), [
        [rnd(3, 10), 5, 2],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [rnd(8), [
        [rnd(3, 4), 4, 5],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], grove, ring, tex
    ], fork]
];

function bna3() = [
    [rnd(2), [
        [rnd(3, 5), 4, 1],
        [rnd(-90, 90), -135, intrnd(70, 110)],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [rnd(2), [
        [rnd(3, 5), 5, 8],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [rnd(2), [
        [rnd(3, 30), 8, 18],
        [0, rnd(-60, -30), 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [rnd(2), [
        [rnd(3, 5), 18, 8],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [rnd(2), [
        [rnd(3, 30), 5, 8],
        [0, rnd(30, 60), 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [rnd(2), [
        [rnd(3, 10), 5, 2],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [rnd(8), [
        [rnd(3, 4), 4, 5],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], grove, ring, tex
    ], fork]
];

function bna3() = [
    [rnd(2), [
        [rnd(3, 15), 4, 1],
        [rnd(-90, 90), -135, intrnd(70, 110)],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [rnd(2), [
        [rnd(3, 15), 5, 8],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [rnd(2), [
        [rnd(3, 60), 8, 18],
        [0, rnd(-60, -30), 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [rnd(2), [
        [rnd(3, 15), 4, 8],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [rnd(2), [
        [rnd(3, 60), 5, 8],
        [0, rnd(30, 60), 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [rnd(2), [
        [rnd(3, 15), 5, 2],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [rnd(8), [
        [rnd(3, 14), 4, 5],
        [0, rnd(-30, 30), 0],
        [7, 8, 9], grove, ring, tex
    ], fork]
];

function bna2(ii = 1) =
    let (i = (ii - 5) * -7)[[0, [
        [0, 1, 1],
        [-60 + rnd(-20, 20), 0 + rnd(-20, 20), 0 + rnd(-20, 20)],
        [100, 0, 0], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [0, [
        [0, 1, 1],
        [0, 0, 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [0, [
        [0, 1, 1],
        [0, 0, 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [0, [
        [0, 1, 1],
        [0, 0, 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [0, [
        [0, 1, 1],
        [0, 0, 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [0, [
        [0, 1, 1],
        [0, 0, 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [0, [
        [0, rnd(3, 0.5), rnd(3, 0.5)],
        [0, 0, 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork]];

function bna2(ii = 1) =
    let (i = (ii - 5) * -7)[[0, [
        [0, 1, 1],
        [0 + rnd(-20, 20), 220 + i + rnd(-20, 20), 90 + i + rnd(-20, 20)],
        [100, 0, 0], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [0, [
        [0, 1, 1],
        [0, 0, 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [0, [
        [0, rnd(3, 0.5), rnd(3, 0.5)],
        [0, 0, 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork]];

function bna2(ii = 1) =
    let (i = (ii - 5) * -7)[[0, [
        [0, 1, 1],
        [0 + rnd(-20, 20), 220 + i + rnd(-20, 20), 90 + i + rnd(-20, 20)],
        [100, 0, 0], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [0, [
        [0, 1, 1],
        [0, 0, 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [0, [
        [0, 1, 1],
        [0, 0, 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [0, [
        [0, 1, 1],
        [0, 0, 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [0, [
        [0, 1, 1],
        [0, 0, 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [0, [
        [0, rnd(3, 0.5), rnd(3, 0.5)],
        [0, 0, 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork]];

function bna2() = [
    [1, [
        [0, 1, 1],
        [0, -135, intrnd(70, 110)],
        [100, 0, 0], grove, ring, tex
    ], fork],
    [0, [
        [5, 5, 1],
        [0, 15, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [0, [
        [0, 1, 1],
        [0, 35, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [1, [
        [0, 5, 1],
        [0, -15, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [1, [
        [0, 1, 1],
        [0, -45, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [0, [
        [0, 5, 1],
        [0, -15, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [0, [
        [0, 1, 1],
        [0, -7, 0],
        [7, 8, 9], grove, ring, tex
    ], fork]
];

function bna2() = [
    [1, [
        [0, 1, 1],
        [-45, -135, intrnd(70, 110)],
        [100, 0, 0], grove, ring, tex
    ], fork],
    [0, [
        [5, 5, 1],
        [0, 15, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [0, [
        [0, 1, 1],
        [0, 35, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [1, [
        [0, 5, 1],
        [0, -15, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [1, [
        [0, 1, 1],
        [0, -45, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [0, [
        [0, 5, 1],
        [0, -15, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [0, [
        [0, 1, 1],
        [0, -7, 0],
        [7, 8, 9], grove, ring, tex
    ], fork]
];

function bna2() = [
    [1, [
        [0, 1, 1],
        [0, -135, intrnd(70, 110)],
        [100, 0, 0], grove, ring, tex
    ], fork],
    [0, [
        [5, 5, 1],
        [0, 15, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [0, [
        [0, 1, 1],
        [0, 35, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [0, [
        [0, 5, 1],
        [0, -15, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [0, [
        [0, 1, 1],
        [0, -45, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [0, [
        [0, 5, 1],
        [0, -15, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [0, [
        [0, 1, 1],
        [0, -7, 0],
        [7, 8, 9], grove, ring, tex
    ], fork]
];

function bna2() = [
    [1, [
        [0, 1, 1],
        [-45, -135, intrnd(70, 110)],
        [100, 0, 0], grove, ring, tex
    ], fork],
    [0, [
        [5, 1, 1],
        [0, 15, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [0, [
        [0, 1, 1],
        [0, 35, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [1, [
        [0, 1, 1],
        [0, -15, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [1, [
        [0, 1, 1],
        [0, -45, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [0, [
        [0, 1, 1],
        [0, -15, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [0, [
        [0, 1, 1],
        [0, -7, 0],
        [7, 8, 9], grove, ring, tex
    ], fork]
];

function bna2() = [
    [0, [
        [0, 1, 1],
        [-45, -135, intrnd(70, 110)],
        [100, 0, 0], grove, ring, tex
    ], fork],
    [0, [
        [0, 1, 1],
        [0, 0, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [0, [
        [0, 1, 1],
        [0, 0, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [0, [
        [0, 1, 1],
        [0, 0, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [0, [
        [0, 1, 1],
        [0, 0, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [0, [
        [0, 1, 1],
        [0, 0, 0],
        [7, 8, 9], grove, ring, tex
    ], fork]
];

function bna(ii = 1) =
    let (i = (ii - 5) * -7)[[1, [
        [10, 5, 2],
        [-60 + rnd(-20, 20), 0 + rnd(-20, 20), 0 + rnd(-20, 20)],
        [100, 0, 0], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [1, [
        [15, 2, 2],
        [0, 55, 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [1, [
        [60, 2, 2],
        [0, 35, 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [1, [
        [5, 2, 2],
        [0, -35, 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [1, [
        [60, 2, 2],
        [0, -45, 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [rnd(2, 5), [
        [10, rnd(5, 8), 1],
        [0, rnd(-30, 55), 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [2, [
        [5, rnd(3, 0.5), rnd(3, 0.5)],
        [0, -17, 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork]];

function bna(ii = 1) =
    let (i = (ii - 5) * -7)[[1, [
        [10, 5, 2],
        [0 + rnd(-20, 20), 220 + rnd(-20, 20), 90 + i + rnd(-20, 20)],
        [100, 0, 0], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [1, [
        [15, 2, 2],
        [0, 55, 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [1, [
        [60, 2, 2],
        [0, 35, 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [1, [
        [5, 2, 2],
        [0, -35, 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [1, [
        [60, 2, 2],
        [0, -45, 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [rnd(2, 5), [
        [10, rnd(5, 8), 1],
        [0, rnd(-30, 55), 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork], [2, [
        [5, rnd(3, 0.5), rnd(3, 0.5)],
        [0, -17, 0],
        [7, 8, 9], xgrove, Xring(8, 1, 0.5), tex
    ], fork]];

function bna() = [
    [1, [
        [10, 5, 5],
        [0, -135, intrnd(70, 110)],
        [100, 0, 0], grove, ring, tex
    ], fork],
    [1, [
        [5, 5, 4],
        [0, 45, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [1, [
        [20, 5, 5],
        [0, 35, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [1, [
        [5, 5, 4],
        [0, -15, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [1, [
        [20, 5, 5],
        [0, -45, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [1, [
        [10, 5, 4],
        [0, -15, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [3, [
        [5, 3, 3],
        [0, -7, 0],
        [7, 8, 9], grove, ring, tex
    ], fork]
];

function bna() = [
    [1, [
        [10, 5, 5],
        [-10, -135, intrnd(70, 110)],
        [100, 0, 0], grove, ring, tex
    ], fork],
    [1, [
        [5, 5, 4],
        [0, 45, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [1, [
        [20, 5, 5],
        [0, 35, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [1, [
        [5, 5, 4],
        [0, -15, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [1, [
        [20, 5, 5],
        [0, -45, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [1, [
        [10, 5, 4],
        [0, -15, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [3, [
        [5, 3, 3],
        [0, -7, 0],
        [7, 8, 9], grove, ring, tex
    ], fork]
];

function bna() = [
    [1, [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9], grove, ring, fork
    ]],
    [1, [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9], grove, ring, fork
    ]],
    [1, [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9], grove, ring, fork
    ]]
];

function bna() = [
    [1, [
        [10, 5, 5],
        [0, -135, intrnd(70, 110)],
        [100, 0, 0], grove, ring, tex
    ], fork],
    [1, [
        [5, 5, 4],
        [0, 45, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [1, [
        [20, 5, 5],
        [0, 35, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [1, [
        [5, 5, 4],
        [0, -15, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [1, [
        [20, 5, 5],
        [0, -45, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [1, [
        [10, 5, 4],
        [0, -15, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [3, [
        [5, 3, 3],
        [0, -7, 0],
        [7, 8, 9], grove, ring, tex
    ], fork]
];

function bna() = [
    [1, [
        [10, 5, 5],
        [-10, -135, intrnd(70, 110)],
        [100, 0, 0], grove, ring, tex
    ], fork],
    [1, [
        [5, 5, 4],
        [0, 45, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [1, [
        [20, 5, 5],
        [0, 35, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [1, [
        [5, 5, 4],
        [0, -15, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [1, [
        [20, 5, 5],
        [0, -45, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [1, [
        [10, 5, 4],
        [0, -15, 0],
        [7, 8, 9], grove, ring, tex
    ], fork],
    [3, [
        [5, 3, 3],
        [0, -7, 0],
        [7, 8, 9], grove, ring, tex
    ], fork]
];

function blur(inwing, c = 1) = c <= 0 ? inwing : let (wing = blur(inwing, c - 1))[wing[0], wing[1], [concat([wing[2][0][0]], [wing[2][0][1]], [
    for (i = [2: len(wing[2][0]) - 2])(wing[2][0][max(i - 1, 0)] * 0.5 + wing[2][0][i] + wing[2][0][min(i + 1, len(wing[2][0]) - 1)] * 0.5) / 2
], [wing[2][0][len(wing[2][0]) - 1]]), concat([wing[2][1][0]], [wing[2][1][1]], [
    for (i = [2: len(wing[2][1]) - 2])(wing[2][1][max(i - 1, 0)] * 0.5 + wing[2][1][i] + wing[2][1][min(i + 1, len(wing[2][1]) - 1)] * 0.5) / 2
], [wing[2][1][len(wing[2][1]) - 1]])]];

function blur(inwing, c = 1) = c <= 0 ? inwing : let (wing = blur(inwing, c - 1))[wing[0], wing[1], [concat([wing[2][0][0]], [wing[2][0][1]], [
    for (i = [2: len(wing[2][0]) - 2])(wing[2][0][max(i - 1, 0)] * 0.5 + wing[2][0][i] + wing[2][0][min(i + 1, len(wing[2][0]) - 1)] * 0.5) / 2
], [wing[2][0][len(wing[2][0]) - 1]]), concat([wing[2][1][0]], [wing[2][1][1]], [
    for (i = [2: len(wing[2][1]) - 2])(wing[2][1][max(i - 1, 0)] * 0.5 + wing[2][1][i] + wing[2][1][min(i + 1, len(wing[2][1]) - 1)] * 0.5) / 2
], [wing[2][1][len(wing[2][1]) - 1]])]];

function bflip(a, b) = [
    [min(a.x, b.x), min(a.y, b.y), min(a.z, b.z)],
    [max(a.x, b.x), max(a.y, b.y), max(a.z, b.z)]
];

function bflip(a, b) = [
    [min(a.x, b.x), min(a.y, b.y), min(a.z, b.z)],
    [max(a.x, b.x), max(a.y, b.y), max(a.z, b.z)]
];

function bez4(i, j, v1, v2, v3, v4) = ((bez2(j, v3)) * i + (bez2(j, v4)) * (1 - i)) * 0.5 + ((bez2(i, v1)) * j + (bez2(i, v2)) * (1 - j)) * 0.5;

function bez2xy(v) = lim31(1, [v[0], v[1], 0]);

function bez2v(i, v) = lim31(1, bez2(i - 0.0001, v) - bez2(i, v));

function bez2euler(i, v) = [0, -asin(bez2v(i, v)[2]), atan2(bez2xy(bez2v(i, v))[1], bez2xy(bez2v(i, v))[0])];

function bez2(t, v) = (len(v) > 2) ? bez2(t, [
    for (i = [0: len(v) - 2]) v[i] * t + v[i + 1] * (1 - t)
]) : v[0] * t + v[1] * (1 - t);

function bez2(t, v) = (len(v) > 2) ? bez2(t, [
    for (i = [0: len(v) - 2]) v[i] * t + v[i + 1] * (1 - t)
]) : v[0] * t + v[1] * (1 - t);

function bez2(t, v) = (len(v) > 2) ? bez2(t, [
    for (i = [0: len(v) - 2]) v[i] * (1 - t) + v[i + 1] * (t)
]) : v[0] * (1 - t) + v[1] * (t);

function bevel(obj) =
    let (name = p_name(obj)) let (p = trunc(ambo(obj))) poly(name = str("b", name), vertices = p_vertices(p), faces = p_faces(p));

function berpm(mesh, uv) = berp([berp(mesh[0], uv[0]), berp(mesh[1], uv[0]), berp(mesh[2], uv[0]), berp(mesh[3], uv[0])], uv[1]);

function berp2(cps, u) = Bern02(cps, u) + Bern12(cps, u) + Bern22(cps, u);

function berp(cps, u) = Bern03(cps, u) + Bern13(cps, u) + Bern23(cps, u) + Bern33(cps, u);

function beckham(start, end, length = len3(b - a) * 1.1, lookat = [0, 1, 0]) = midpoint(start, end) + un(flipxy(end - start)) * un(lookat)[1] * IK(length, end - start) + un(flipxz(end - start)) * un(lookat)[2] * IK(length, end - start) + un(end - start) * un(lookat)[0] * IK(length, end - start);

function beckham(start, end, length, lookat = [0, 1, 0], bias = 0.5) = midpoint(start, end, bias) + (un(flipxy(end - start)) * un(lookat)[1] * IK(length, (end - start)) + un(flipxz(end - start)) * un(lookat)[2] * IK(length, (end - start)) + un(end - start) * un(lookat)[0] * IK(length, (end - start)));

function bearingWidth(model) = bearingDimensions(model)[BEARING_WIDTH];

function bearingOuterDiameter(model) = bearingDimensions(model)[BEARING_OUTER_DIAMETER];

function bearingInnerDiameter(model) = bearingDimensions(model)[BEARING_INNER_DIAMETER];

function bearingDimensions(model) = model == 608 ? [8 * mm, 22 * mm, 7 * mm] : model == 623 ? [3 * mm, 10 * mm, 4 * mm] : model == 624 ? [4 * mm, 13 * mm, 5 * mm] : model == 627 ? [7 * mm, 22 * mm, 7 * mm] : model == 688 ? [8 * mm, 16 * mm, 4 * mm] : model == 698 ? [8 * mm, 19 * mm, 6 * mm] : [8 * mm, 22 * mm, 7 * mm];

function basevec(i, j) = [sin(i * 360), cos(i * 360), 0];

function basering(x = 8) = mirring([
    for (i = [(360 / x): 360 / x: 359])[0, sin(i), cos(i)] + rndV2(3)
]);

function basering(x = 8) = mirring([
    for (i = [(360 / x): 360 / x: 359])[0, sin(i), cos(i)] + rndV2(1)
]);

function basering(x = 8) = mirring([
    for (i = [(360 / x): 360 / x: 359])[0, sin(i), cos(i)] + rndV2(3)
]);

function basemag(theta, rho) =
    let (n = basevec(theta, rho)) 7 + (sin(theta * 360 * 6 + rho * 360 * 6) * 3 + sin((rho + 0.075) * 180 * 20) * 3);

function base() = [
    [10, 4, 1],
    [0, -90, 0],
    [7, 8, 9], grove, ring, tex
];

function base() = [
    [10, 10, 10],
    [0, -90, 0],
    [0, 0, 0], grove, revXring(RING, 1, 0.3), tex
];

function base() = [
    [10, 10, 10],
    [0, -90, 0],
    [0, 0, 0], grove, revXring(RING, 1, 0.3), tex
];

function b(pitch) = pitch / (TAU);

function axflip(v) = [v[0], v[1], -v[2]];

function avrg(v) = sumv(v, max(0, len(v) - 1)) / len(v);

function avrg(v) = sumv(v, len(v) - 1) / len(v);

function avrg(l) = len(l) > 1 ? addl(l) / (len(l) - 1) : l;

function avrg(l) = len(l) > 1 ? addl(l) / (len(l)) : l;

function avrg(l) = addl(l) / (len(l) - 1);

function average_normal(fp) =
    let (fl = len(fp)) let (unitns = [
        for (i = [0: fl - 1]) let (n = orthogonal(fp[i], fp[(i + 1) % fl], fp[(i + 2) % fl])) let (normn = norm(n)) normn == 0 ? [] : n / normn
    ]) vsum(unitns) / len(unitns);

function average_norm(points) = ssum(vnorm(points)) / len(points);

function average_face_normal(fp) =
    let (fl = len(fp)) let (normals = [
        for (i = [0: fl - 1]) orthogonal(fp[i], fp[(i + 1) % fl], fp[(i + 2) % fl])
    ]) vsum(normals) / len(normals);

function average_edge_distance(fp) =
    let (fl = len(fp)) ssum([
        for (i = [0: fl - 1]) edge_distance(fp[i], fp[(i + 1) % fl])
    ]) / fl;

function av2(l, c0 = 0, c1 = 2, c2 = 2, av1 = [0, 0, 0], av2 = [0, 0, 0], l1 = [], l2 = []) =
    let (L = len(l) - 1, intiav1 = c0 == 0 ? l[rnd(L)] : [0, 0, 0], intiav2 = c0 == 0 ? l[rnd(L)] : [0, 0, 0], p1 = l[c0], d1 = len3(p1 - (av1 + intiav1)), d2 = len3(p1 - (av2 + intiav2))) c0 < L ? d1 < d2 || (c2 - c1) > 10 ?
    let (av1u = av1 * (1 - (1 / c1)) + p1 * (1 / (c1)), l1u = concat(l1, [p1])) av2(l, c0 + 1, c1 + 1, c2, av1u, av2, l1u, l2) : let (av2u = av2 * (1 - (1 / c2)) + p1 * (1 / c2), l2u = concat(l2, [p1])) av2(l, c0 + 1, c1, c2 + 1, av1, av2u, l1, l2u) : [l1, l2];

function autohullworker(p1, p2, p3, scene, far, c = 4) =
    let (e1 = un(t(evalnorm(p1, scene))), e2 = un(t(evalnorm(p2, scene))), e3 = un(t(evalnorm(p3, scene))), p12 = un((p1 + p2) / 2) * far, p23 = un((p2 + p3) / 2) * far, p31 = un((p3 + p1) / 2) * far, C = un(avrg([e1, e2, e3])), meancurve = (dot(e1, e2) + dot(e3, e2) + dot(e1, e3))) meancurve > 2.1 || c <= 0 ? [C] : concat(autohullworker(p1, p12, p31, scene, far, c - 1), autohullworker(p2, p23, p12, scene, far, c - 1), autohullworker(p3, p23, p31, scene, far, c - 1), autohullworker(p12, p23, p31, scene, far, c - 1));

function autohullworker(p1, p2, p3, model, far, c = 4) =
    let (e1 = un(t(evalnorm(p1, model))), e2 = un(t(evalnorm(p2, model))), e3 = un(t(evalnorm(p3, model))), p12 = un((p1 + p2) / 2) * far, p23 = un((p2 + p3) / 2) * far, p31 = un((p3 + p1) / 2) * far, C = un(avrg([e1, e2, e3])), meancurve = (dot(e1, e2) + dot(e3, e2) + dot(e1, e3))) meancurve > 2.1 || c <= 0 ? [C] : concat(autohullworker(p1, p12, p31, model, far, c - 1), autohullworker(p2, p23, p12, model, far, c - 1), autohullworker(p3, p23, p31, model, far, c - 1), autohullworker(p12, p23, p31, model, far, c - 1));

function autohullworker(p1, p2, p3, model, far, c = 4) = /*//recursive worker of autohull()*/
    let (e1 = un(t(evalnorm(p1, model))), e2 = un(t(evalnorm(p2, model))), e3 = un(t(evalnorm(p3, model))), p12 = un((p1 + p2) / 2) * far, p23 = un((p2 + p3) / 2) * far, p31 = un((p3 + p1) / 2) * far, C = un(avrg([e1, e2, e3])), meancurve = (dot(e1, e2) + dot(e3, e2) + dot(e1, e3)) /*//dot product of 2 unit normals range from-1 to 1 so a summed meancurve=3 indicates all normals are parallel*/ ) meancurve > 2 || c <= 0 ? [C] : concat(autohullworker(p1, p12, p31, model, far, c - 1), autohullworker(p2, p23, p12, model, far, c - 1), autohullworker(p3, p23, p31, model, far, c - 1), autohullworker(p12, p23, p31, model, far, c - 1));

function autohull(scene) =
    let (far = 1000, p1 = un([1, 1, 1]) * far, p2 = un([-1, -1, 1]) * far, p3 = un([1, -1, -1]) * far, p4 = un([-1, 1, -1]) * far, n = concat(autohullworker(p1, p2, p3, scene, far), autohullworker(p1, p2, p4, scene, far), autohullworker(p2, p3, p4, scene, far), autohullworker(p1, p4, p3, scene, far)))[
        for (i = [1: len(n) - 1]) let (v = findbound(n[i], scene))[n[i], v * n[i], v]];

function autohull(model) =
    let (far = 1000, p1 = un([1, 1, 1]) * far, p2 = un([-1, -1, 1]) * far, p3 = un([1, -1, -1]) * far, p4 = un([-1, 1, -1]) * far, n = concat(autohullworker(p1, p2, p3, model, far), autohullworker(p1, p2, p4, model, far), autohullworker(p2, p3, p4, model, far), autohullworker(p1, p4, p3, model, far)))[
        for (i = [1: len(n) - 1]) let (v = findbound(n[i], model))[n[i], v * n[i], v]];

function autohull(model) = /* In this new autohull we dont genrate random planes We start with the corner points of each face of a Tetrahedron continue and subdivide each side to finer spherical Geodesic polyhedron in a worker function until the DISTANCE FIELD NORMAL at each corner converge as a sum of their internal dot products. Note that its not the facenormal of the sub facet but the normal of the field at the resulting guiding lattice. We return the normalized averaged field vector and apply findbound as before This process reduces the number of resulting planes un the right places */
    let (far = 100, /*//too far out field lines anrent too usefull*/ p1 = un([1, 1, 1]) * far, /*//tet cornes*/ p2 = un([-1, -1, 1]) * far, p3 = un([1, -1, -1]) * far, p4 = un([-1, 1, -1]) * far, n = concat( /*//start recursive worker*/ autohullworker(p1, p2, p3, model, far), autohullworker(p1, p2, p4, model, far), autohullworker(p2, p3, p4, model, far), autohullworker(p1, p4, p3, model, far))) /*//process reulting list of unit vectors to alist of bounding planes*/ [
        for (i = [1: len(n) - 1]) let (v = findbound(n[i], model))[n[i], v * n[i], v]];

function autobound(scene, cubic = (false), pad = 1) =
    let (up = findbound([0, 0, 1], scene), down = -findbound([0, 0, -1], scene), north = findbound([0, 1, 0], scene), south = -findbound([0, -1, 0], scene), west = findbound([1, 0, 0], scene), east = -findbound([-1, 0, 0], scene), esd = min(east, south, down), wnu = max(west, north, up)) cubic == true ?
    let (d = [wnu, wnu, wnu] - [esd, esd, esd])[[esd, esd, esd] - (d * pad), [wnu, wnu, wnu] + d * pad] : let (d = [west, north, up] - [east, south, down])[[east, south, down] - d * pad, [west, north, up] + d * pad];

function autobound(model, cubic = false, padding = 0.05) =
    let (up = findbound([0, 0, 1], model), down = -findbound([0, 0, -1], model), north = findbound([0, 1, 0], model), south = -findbound([0, -1, 0], model), west = findbound([1, 0, 0], model), east = -findbound([-1, 0, 0], model), esd = min(east, south, down), wnu = max(west, north, up)) cubic ?
    let (d = [wnu, wnu, wnu] - [esd, esd, esd])[[esd, esd, esd] - d * padding, [wnu, wnu, wnu] + d * padding] : let (d = [west, north, up] - [east, south, down])[[east, south, down] - d * padding, [west, north, up] + d * padding];

function autobound(model, cubic = (false), pad = 1) =
    let (up = findbound([0, 0, 1], model), down = -findbound([0, 0, -1], model), north = findbound([0, 1, 0], model), south = -findbound([0, -1, 0], model), west = findbound([1, 0, 0], model), east = -findbound([-1, 0, 0], model), esd = min(east, south, down), wnu = max(west, north, up)) cubic == true ?
    let (d = [wnu, wnu, wnu] - [esd, esd, esd])[[esd, esd, esd] - (d * pad), [wnu, wnu, wnu] + d * pad] : let (d = [west, north, up] - [east, south, down])[[east, south, down] - d * pad, [west, north, up] + d * pad];

function augment_profile(profile, n) = subdivide(profile, insert_extra_vertices_0([profile_lengths(profile), dup(0, len(profile))], n - len(profile))[1]);

function as_points(indexes, points) = [
    for (i = [0: len(indexes) - 1]) points[indexes[i]]
];

function f(x) = 0.5 * x + 1;

function area(vertices) =
    let (areas = [let (num = len(vertices)) for (i = [0: num - 1]) triarea(vertices[i], vertices[(i + 1) % num])]) sum(areas);
//
//function area(p, index_ = 0) = index_ >= len(p) ? 0 : 
//function pseudo_centroid(p, index_ = 0) = index_ >= len(p) ? [0, 0, 0] : p[index_] / len(p) + pseudo_centroid(p, index_ + 1);

function arc(r = 1, angle = 360, offsetAngle = 0, c = [0, 0], center = false, internal = false) =
    let (fragments = ceil((abs(angle) / 360) * fragments(r, $fn)), step = angle / fragments, a = offsetAngle - (center ? angle / 2 : 0), R = internal ? r / cos(180 / fragments) : r, last = (abs(angle) == 360 ? 1 : 0))[
        for (i = [0: fragments - last]) let (a2 = i * step + a) c + R * [cos(a2), sin(a2)]];

function anglev(u, v) = acos(dot(u, v) / (mod(u) * mod(v)));

function anglev(u, v) = acos(dot(u, v) / (len3(u) * len3(v)));

function angle_between(u, v, normal) = /*//protection against inaccurate computation*/
    let (x = unitv(u) * unitv(v)) let (y = x <= -1 ? -1 : x >= 1 ? 1 : x) let (a = acos(y)) normal == undef ? a : signx(normal * cross(u, v)) * a;

function angleOfNormalizedVector(n) = [0, -atan2(n[2], length2([n[0], n[1]])), atan2(n[1], n[0])];

function angleBetweenTwoPoints(a, b) = angle(normalized(b - a));

function angle(v) = angleOfNormalizedVector(normalized(v));

function angB(x, y, l1, l2) = 180 - acos((l2 * l2 + l1 * l1 - sq(x, y)) / (2 * l1 * l2));

function ang2(x, y, l1, l2) = 90 - acos((l2 * l2 - l1 * l1 + sq(x, y)) / (2 * l2 * sqrt(sq(x, y)))) - atan2(x, y);

function ang1(x, y, l1, l2) = ang2(x, y, l1, l2) + angB(x, y, l1, l2);

function ambo(obj) =
    let (pf = p_faces(obj), pv = p_vertices(obj), pe = p_edges(obj)) let (newv = [
        for (edge = pe) let (ep = as_points(edge, pv))[edge, (ep[0] + ep[1]) / 2]
    ]) let (newids = vertex_ids(newv)) let (newf = concat([
        for (face = pf)[
            for (edge = distinct_face_edges(face)) /*//old faces become the same with the new vertices*/ vertex(edge, newids)]
    ], [
        for (vi = [0: len(pv) - 1]) /*//each old vertex creates a new face,with */ let (vf = vertex_faces(vi, pf)) /*//the old edges in left-hand order as vertices*/ [
            for (ve = ordered_vertex_edges(vi, vf)) vertex(distinct_edge(ve), newids)]
    ])) poly(name = str("a", p_name(obj)), vertices = vertex_values(newv), faces = newf);

function all_edges(faces) = [
    for (f = faces)
        for (j = [0: len(f) - 1]) let (p = f[j], q = f[(j + 1) % len(f)])[p, q]
];

//function all_edges(faces) = /*//[for(f=faces)*/ /*//for(j=[0:len(f)-1])*/ /*//let(p=f[j],q=f[(j+1)%len(f)])*/ /*//[p,q] */ /*//];*/ function distinct_face_edges(f) = [
//    for (j = [0: len(f) - 1]) let (p = f[j], q = f[(j + 1) % len(f)]) distinct_edge([p, q])
//];

function addl(l, c = 0) = c < len(l) - 1 ? l[c] + addl(l, c + 1) : l[c];

function addl(l, c = 0) = c < len(l) - 1 ? l[c] + addl(l, c + 1) : l[c];

function accumulate_rotations(rotations, acc_ = []) =
    let (i = len(acc_)) i == len(rotations) ? acc_ : accumulate_rotations(rotations, i == 0 ? [rotations[0]] : concat(acc_, [rotations[i] * acc_[i - 1]]));

function abs3(v) = len(v) == 1 ? [abs(v[0])] : len(v) == undef ? abs(v) : [
    for (i = [0: len(v) - 1]) abs3(v[i])
];

function abs3(v) = [abs(v[0]), abs(v[1]), abs(v[2])];

function _z(i, n) = 2 * i / (2 * n + 1);

function _xy(z) = sqrt(1 - pow(z, 2));

function _translate(v, poly) =
    let (points = get_points(poly), lp = len(points[0]), /*//2d or 3d point data?*/ lv = len(v), /*//2d or 3d translation vector?*/ V = lp > lv ? [v.x, v.y, 0] : v, /*//allow adding a 2d vector to 3d points*/ newPoints = (lv > lp) ? [
        for (p = points)[p.x, p.y, 0] + V
    ] : /*//allow adding a 3d vector to 2d point data*/ [
        for (p = points) p + V
    ] /*//allow adding 2d or 3d vectors */ ) set_points(poly, newPoints);

function _torus_eval(pt, R, r) =
    let (n = norm([pt[0], pt[1]])) r - norm(pt - [pt[0], pt[1], 0] * R / n);

function _scale(v, poly) =
    let (points = get_points(poly), s = len(v) ? v : [v, v, v], newPoints = len(points[0]) == 3 ? [
        for (p = points)[s.x * p.x, s.y * p.y, s.z * p.z]
    ] : [
        for (p = points)[s.x * p.x, s.y * p.y]
    ]) set_points(poly, newPoints);

function _rotate3d_xyz(a, points) =
    let (cosa = cos(a.z), sina = sin(a.z), cosb = cos(a.y), sinb = sin(a.y), cosc = cos(a.x), sinc = sin(a.x), Axx = cosa * cosb, Axy = cosa * sinb * sinc - sina * cosc, Axz = cosa * sinb * cosc + sina * sinc, Ayx = sina * cosb, Ayy = sina * sinb * sinc + cosa * cosc, Ayz = sina * sinb * cosc - cosa * sinc, Azx = -sinb, Azy = cosb * sinc, Azz = cosb * cosc)[
        for (p = points) let (pz = (p.z == undef) ? 0 : p.z)[Axx * p.x + Axy * p.y + Axz * pz, Ayx * p.x + Ayy * p.y + Ayz * pz, Azx * p.x + Azy * p.y + Azz * pz]];

function _rotate3d_v(a, v, points) =
    let (cosa = cos(a), sina = sin(a))[
        for (p = points) let (P = to3d(p)) P * cosa + (cross(v, P)) * sina + v * (v * P) * (1 - cosa) /*//Rodrigues' rotation formula*/ ];

function _rotate3d(a, v, points) =
    let (A = is_array(a) ? to3d(a) : [0, 0, a])(!is_array(a) && is_array(v)) ? _rotate3d_v(a, unit(to3d(v)), points) : _rotate3d_xyz(A, points);

function _rotate2d(a, points) =
    let (cosa = cos(a), sina = sin(a))[
        for (p = points)[p.x * cosa - p.y * sina, p.x * sina + p.y * cosa]];

function _rotate(a, v, poly) =
    let (points = get_points(poly), newPoints = is_3d_poly(points) || len(a) == 3 ? _rotate3d(a = a, v = v, points = points) : _rotate2d(a = a, points = points)) set_points(poly, newPoints);

function _quat_xyzsw(xyzs, w) = xyzs * w;

function _quat_to_mat4(xyzsw, XYZ) = [
    [(1.0 - (XYZ[1][1] + XYZ[2][2])), (XYZ[0][1] - xyzsw[2]), (XYZ[0][2] + xyzsw[1]), 0],
    [(XYZ[0][1] + xyzsw[2]), (1 - (XYZ[0][0] + XYZ[2][2])), (XYZ[1][2] - xyzsw[0]), 0],
    [(XYZ[0][2] - xyzsw[1]), (XYZ[1][2] + xyzsw[0]), (1.0 - (XYZ[0][0] + XYZ[1][1])), 0],
    [0, 0, 0, 1]
];

function _quat_XYZ(xyzs, q) = [quat_to_mat4_X(xyzs, q[0]), quat_to_mat4_X(xyzs, q[1]), quat_to_mat4_X(xyzs, q[2])];

function _quat(a, s, c) = [a[0] * s, a[1] * s, a[2] * s, c];

function _pos(i, n) = [cos(_lon(i)) * _xy(_z(i, n)), sin(_lon(i)) * _xy(_z(i, n)), _z(i, n)];

function _multmatrix(M, poly) =
    let (points = get_points(poly), newPoints = is_3d_poly(poly) ? [
        for (p = points) to3d(M * [p.x, p.y, p.z, 1])
    ] : [
        for (p = points) to2d(M * [p.x, p.y, 0, 1])
    ]) set_points(poly, newPoints);

function _mirror(normal = [1, 0], poly) =
    let (points = get_points(poly), newPoints = [
        for (p = points) let (n = normal * normal, t = n == 0 ? 0 : (-p * normal) / n) p + 2 * t * normal
    ]) set_points(poly, newPoints);

function _lon(i) = _golden_angle * i;

function _linear_extrude(height, center, convexity, twist, slices, scale, poly) =
    let (points = get_points(poly), sl = slices == undef ? (twist == 0 ? 1 : 7) : slices, hstep = height / sl, astep = -twist / sl, sstep = (scale - 1) / sl, hoffset = center ? -height / 2 : 0, newPoints = flatten([
        for (i = [0: sl]) rotate(a = astep * i, poly = translate([0, 0, hstep * i + hoffset], poly = scale(1 + sstep * i, poly = points)))
    ]), l = len(points), lp = len(newPoints), faces = concat(flatten([
        for (i = [0: sl - 1], j = [0: l - 1]) let (il = i * l, j1 = j + 1 == l ? 0 : j + 1, i0 = il + j, i1 = il + j1, i2 = il + l + j, i3 = il + l + j1)[[i0, i1, i3], [i0, i3, i2]]
    ]), [irange(l - 1, 0), irange(lp - l, lp - 1)]))[newPoints, faces];

function _bounds_multi_3d(polys) =
    let (minX = min([
        for (poly = polys, p = get_points(poly)) p.x
    ]), maxX = max([
        for (poly = polys, p = get_points(poly)) p.x
    ]), minY = min([
        for (poly = polys, p = get_points(poly)) p.y
    ]), maxY = max([
        for (poly = polys, p = get_points(poly)) p.y
    ]), minZ = min([
        for (poly = polys, p = get_points(poly)) p.z
    ]), maxZ = max([
        for (poly = polys, p = get_points(poly)) p.z
    ]))[[minX, minY, minZ], [maxX, maxY, maxZ]];

function _bounds_multi_2d(polys) =
    let (minX = min([
        for (poly = polys, p = get_points(poly)) p.x
    ]), maxX = max([
        for (poly = polys, p = get_points(poly)) p.x
    ]), minY = min([
        for (poly = polys, p = get_points(poly)) p.y
    ]), maxY = max([
        for (poly = polys, p = get_points(poly)) p.y
    ]))[[minX, minY], [maxX, maxY]];

function _bounds_3d(poly) =
    let (points = get_points(poly), minX = min([
        for (p = points) p.x
    ]), maxX = max([
        for (p = points) p.x
    ]), minY = min([
        for (p = points) p.y
    ]), maxY = max([
        for (p = points) p.y
    ]), minZ = min([
        for (p = points) p.z
    ]), maxZ = max([
        for (p = points) p.z
    ]))[[minX, minY, minZ], [maxX, maxY, maxZ]];

function _bounds_2d(poly) =
    let (points = get_points(poly), minX = min([
        for (p = points) p.x
    ]), maxX = max([
        for (p = points) p.x
    ]), minY = min([
        for (p = points) p.y
    ]), maxY = max([
        for (p = points) p.y
    ]))[[minX, minY], [maxX, maxY]];

function _abs(v) = [
    for (vi = v) abs(vi)
];

function _abs(v) = [
    for (vi = v) abs(vi)
];

function Y(n, h = 1) = /*//pyramids*/ p_resize(poly(name = str("Y", n), vertices = concat([
    for (i = [0: n - 1])[cos(i * 360 / n), sin(i * 360 / n), 0]
], [
    [0, 0, h]
]), faces = concat([
    for (i = [0: n - 1])[(i + 1) % n, i, n]
], [
    [
        for (i = [0: n - 1]) i
    ]
])));

function Xring(x = 8, r = 0.7, kaos = 0.05) = mirring([
    for (i = [(360 / x) * 0.5: 360 / x: 359])[0, sin(i) * r, cos(i) * r] + v3rnd(kaos)
]);

function Voronesque(op) =
    let (i = [floor(op.x + dot(op, [1 / 3, 1 / 3, 1 / 3])), floor(op.y + dot(op, [1 / 3, 1 / 3, 1 / 3])), floor(op.z + dot(op, [1 / 3, 1 / 3, 1 / 3]))], doti = dot(i, [0.166666, 0.166666, 0.166666]), p = [op.x - i.x - doti, op.y - i.y - doti, op.z - i.z - doti], m3 = max3(p - [p.y, p.z, p.x], 0), i1 = [sign(m3.x), sign(m3.y), sign(m3.z)], i2 = [max(1 - i1.z, i1.z), max(1 - i1.x, i1.x), max(1 - i1.y, i1.y)], i1n = [min(1 - i1.z, i1.z), min(1 - i1.x, i1.x), min(1 - i1.y, i1.y)], p1 = p - i1n + [0.166666, 0.166666, 0.166666], p2 = p - i2 + [1 / 3, 1 / 3, 1 / 3], p3 = p - [1 / 2, 1 / 2, 1 / 2], rnd = [7, 157, 113], /*//I use this combination to pay homage to Shadertoy.com.:)*/ v = max3([0.5 - dot(p, p), 0.5 - dot(p1, p1), 0.5 - dot(p2, p2), 0.5 - dot(p3, p3)], 0), di = [dot(i, rnd), dot(i + i1, rnd), dot(i + i2, rnd), dot(i + [1, 1, 1], rnd)], di2 = [((sin(di[0]) * 262144.)), ((sin(di[1]) * 262144.)), ((sin(di[2]) * 262144.)), ((sin(di[3]) * 262144.))], d = [di2[0] % 1, di2[1] % 1, di2[2] % 1, di2[3] % 1], vx = max(d[0], d[1]), vy = d[2], vz = max(min(d.x, d.y), min(d.z, d[3])), vw = min(vx, vy)) max(vx, vy);

function Vmul(v1, v2) = [v1[0] * v2[0], v1[1] * v2[1], v1[2] * v2[2]];

function Vdiv(v1, v2) = [v1[0] / v2[0], v1[1] / v2[1], v1[2] / v2[2]];

function VUNIT(v) = v / VMAG(v);

function VSUM(v1, v2) = [v1[0] + v2[0], v1[1] + v2[1], v1[2] + v2[2]];

function VSUBS(v, s) = [v[0] - s, v[1] - s, v[2] - s];

function VSUB(v1, v2) = [v1[0] - v2[0], v1[1] - v2[1], v1[2] - v2[2]];

function VPROD(vs) = [(vs[0][1] * vs[1][2]) - (vs[1][1] * vs[0][2]), (vs[0][2] * vs[1][0]) - (vs[1][2] * vs[0][0]), (vs[0][0] * vs[1][1]) - (vs[1][0] * vs[0][1])];

function VNORM(v) = v / VMAG(v);

function VMULTS(v, s) = [v[0] * s, v[1] * s, v[2] * s];

function VMULT(v1, v2) = [v1[0] * v2[0], v1[1] * v2[1], v1[2] * v2[2]];

function VMIN4(v1, v2, v3, v4) = VMIN(VMIN3(v1, v2, v3), v4);

function VMIN3(v1, v2, v3) = VMIN(VMIN(v1, v2), v3);

function VMIN(v1, v2) = [min(v1[0], v2[0]), min(v1[1], v2[1]), min(v1[2], v2[2])];

function VMAX4(v1, v2, v3, v4) = VMAX(VMAX(v1, v2, v3), v4);

function VMAX3(v1, v2, v3) = VMAX(VMAX(v1, v2), v3);

function VMAX(v1, v2) = [max(v1[0], v2[0]), max(v1[1], v2[1]), max(v1[2], v2[2])];

function VMAG(v) = sqrt(v[0] * v[0] + v[1] * v[1] + v[2] * v[2]);

function VLENSQR(v) = (v[0] * v[0] + v[1] * v[1] + v[2] * v[2]);

function VLEN(v) = sqrt(VLENSQR(v));

function VISITED() = 1;

function cord_equals(cord1, cord2) = cord1 == cord2;

function VISITED() = 1;

function VDOT(v1v2) = SPROD(v1v2[0], v1v2[1]);

function VDIVS(v, s) = [v[0] / s, v[1] / s, v[2] / s];

function VCROSS(v1, v2) = VPROD([v1, v2]);

function VANG(v1, v2) = acos(VDOT([v1, v2]) / (VMAG(v1) * VMAG(v2)));

function VADDS(v, s) = [v[0] + s, v[1] + s, v[2] + s];

function UP_WALL() = 1;

function UP_RIGHT_WALL() = 3;

function Transf(q, M) = q - M;

function Transf(q, M) = invtransform(q, M[0], M[1], M[2]);

function Sweetnoise(x, y, z, seed = 69840) = tril(SC3(x - floor(x)), (SC3(y - floor(y))), (SC3(z - floor(z))), Coldnoise((x), (y), (z), seed), Coldnoise((x + 1), (y), (z), seed), Coldnoise((x), (y + 1), (z), seed), Coldnoise((x), (y), (z + 1), seed), Coldnoise((x + 1), (y), (z + 1), seed), Coldnoise((x), (y + 1), (z + 1), seed), Coldnoise((x + 1), (y + 1), (z), seed), Coldnoise((x + 1), (y + 1), (z + 1), seed));

function Sweetnoise(x, y, z, seed = 69840) = tril(SC3(x - floor(x)), (SC3(y - floor(y))), (SC3(z - floor(z))), Coldnoise((x), (y), (z), seed), Coldnoise((x + 1), (y), (z), seed), Coldnoise((x), (y + 1), (z), seed), Coldnoise((x), (y), (z + 1), seed), Coldnoise((x + 1), (y), (z + 1), seed), Coldnoise((x), (y + 1), (z + 1), seed), Coldnoise((x + 1), (y + 1), (z), seed), Coldnoise((x + 1), (y + 1), (z + 1), seed));

function Sweetnoise(x, y, z, seed = 69840) = tril(((x % 1)), ((y % 1)), ((z % 1)), Coldnoise((x), (y), (z), seed), Coldnoise((x + 1), (y), (z), seed), Coldnoise((x), (y + 1), (z), seed), Coldnoise((x), (y), (z + 1), seed), Coldnoise((x + 1), (y), (z + 1), seed), Coldnoise((x), (y + 1), (z + 1), seed), Coldnoise((x + 1), (y + 1), (z), seed), Coldnoise((x + 1), (y + 1), (z + 1), seed));

function Sweetnoise(x, y, z, seed = 69840) = (z - Zoffset) * Zfalloff + tril(SC3(x - floor(x)), (SC3(y - floor(y))), (SC3(z - floor(z))), Coldnoise((x), (y), (z), seed), Coldnoise((x + 1), (y), (z), seed), Coldnoise((x), (y + 1), (z), seed), Coldnoise((x), (y), (z + 1), seed), Coldnoise((x + 1), (y), (z + 1), seed), Coldnoise((x), (y + 1), (z + 1), seed), Coldnoise((x + 1), (y + 1), (z), seed), Coldnoise((x + 1), (y + 1), (z + 1), seed));

function Sweetnoise(x, y, z, seed = 69840) = (z - 3) / Zfalloff + tril(SC3(x - floor(x)), (SC3(y - floor(y))), (SC3(z - floor(z))), Coldnoise((x), (y), (z), seed), Coldnoise((x + 1), (y), (z), seed), Coldnoise((x), (y + 1), (z), seed), Coldnoise((x), (y), (z + 1), seed), Coldnoise((x + 1), (y), (z + 1), seed), Coldnoise((x), (y + 1), (z + 1), seed), Coldnoise((x + 1), (y + 1), (z), seed), Coldnoise((x + 1), (y + 1), (z + 1), seed));

function Sweetnoise(x, y, z, seed = 211448, scale = 15) = tril(SC3((x % 1)), SC3((y % 1)), SC3((z % 1)), Coldnoise(floor(scale * x), floor(scale * y), floor(scale * z), seed), Coldnoise(floor(scale * x + 1), floor(scale * y), floor(scale * z), seed), Coldnoise(floor(scale * x), floor(scale * y + 1), floor(scale * z), seed), Coldnoise(floor(scale * x), floor(scale * y), floor(scale * z + 1), seed), Coldnoise(floor(scale * x + 1), floor(scale * y), floor(scale * z + 1), seed), Coldnoise(floor(scale * x), floor(scale * y + 1), floor(scale * z + 1), seed), Coldnoise(floor(scale * x + 1), floor(scale * y + 1), floor(scale * z), seed), Coldnoise(floor(scale * x + 1), floor(scale * y + 1), floor(scale * z + 1), seed));

function Sweetnoise(x, y, z, seed = 211448, scale = 1) = tril((SC3(x % 1)), (SC3(y % 1)), (SC3(z % 1)), Coldnoise(floor(scale * x), floor(scale * y), floor(scale * z), seed), Coldnoise(floor(scale * x + 1), floor(scale * y), floor(scale * z), seed), Coldnoise(floor(scale * x), floor(scale * y + 1), floor(scale * z), seed), Coldnoise(floor(scale * x), floor(scale * y), floor(scale * z + 1), seed), Coldnoise(floor(scale * x + 1), floor(scale * y), floor(scale * z + 1), seed), Coldnoise(floor(scale * x), floor(scale * y + 1), floor(scale * z + 1), seed), Coldnoise(floor(scale * x + 1), floor(scale * y + 1), floor(scale * z), seed), Coldnoise(floor(scale * x + 1), floor(scale * y + 1), floor(scale * z + 1), seed));

function SPROD(v1, v2) = v1[0] * v2[0] + v1[1] * v2[1] + v1[2] * v2[2];

function SC3(a) =
    let (b = clamp(a))(b * b * (3 - 2 * b));

function SC3(a) = 1 - (a * a * (3 - 2 * a));

function SC3(a) = (a * a * (3 - 2 * a));

function RIGHT_WALL() = 2;

function Proxyball(x, y, z, Ball) = (abs(x - Ball[0]) + abs(y - Ball[1]) + abs(z - Ball[2]));

function Point3D_Create(u, v, w) = [u, v, w];

function Point2D_Create(u, v) = [u, v];

function PERMUTATION_OF_FOUR() = [
    [1, 2, 3, 4],
    [1, 2, 4, 3],
    [1, 3, 2, 4],
    [1, 3, 4, 2],
    [1, 4, 2, 3],
    [1, 4, 3, 2],
    [2, 1, 3, 4],
    [2, 1, 4, 3],
    [2, 3, 1, 4],
    [2, 3, 4, 1],
    [2, 4, 1, 3],
    [2, 4, 3, 1],
    [3, 1, 2, 4],
    [3, 1, 4, 2],
    [3, 2, 1, 4],
    [3, 2, 4, 1],
    [3, 4, 1, 2],
    [3, 4, 2, 1],
    [4, 1, 2, 3],
    [4, 1, 3, 2],
    [4, 2, 1, 3],
    [4, 2, 3, 1],
    [4, 3, 1, 2],
    [4, 3, 2, 1]
];

function P(n, h = 1) = /*//prisms*/ p_resize(poly(name = str("P", n), vertices = concat([
    for (i = [0: n - 1])[cos(i * 360 / n), sin(i * 360 / n), -h / 2]
], [
    for (i = [0: n - 1])[cos(i * 360 / n), sin(i * 360 / n), h / 2]
]), faces = concat([
    for (i = [0: n - 1])[(i + 1) % n, i, i + n, (i + 1) % n + n]
], [
    [
        for (i = [0: n - 1]) i
    ]
], [
    [
        for (i = [n - 1: -1: 0]) i + n
    ]
])));

function Offs(v, M) = v - M;

function Offs(q, M) = q - M;

function Octavenoice(x, y, z, seed = randseed) =
    let (SML = lim31(1, octavebalance))(Sweetnoise(x * 1, y * 1, z * 2, seed) * SML[0] + Sweetnoise(x * 0.5, y * 0.5, z * 1, seed) * SML[1] + Sweetnoise(x * 0.25, y * 0.25, z * 0.25, seed) * SML[2]);

function Octavenoice(x, y, z, seed = randseed) =
    let (SML = lim31(1, octavebalance))(Sweetnoise(x * 1, y * 1, z * 1, seed) * SML[0] + Sweetnoise(x / 2, y / 2, z / 2, seed) * SML[1] + Sweetnoise(x / 4, y / 4, z / 4, seed) * SML[2]);

function Octavenoice(x, y, z, seed = randseed) =
    let (SML = lim31(1, [20, 60, 380]))(Sweetnoise(x * 4.1, y * 4.1, z * 4.1, seed) * SML[0] + Sweetnoise(x, y, z, seed) * SML[1] + Sweetnoise(x / 2.1, y / 2.1, z / 2.1, seed) * SML[2]);

function O() =
    let (C0 = 0.7071067811865475244008443621048) p_resize(poly(name = "O", vertices = [
        [0.0, 0.0, C0],
        [0.0, 0.0, -C0],
        [C0, 0.0, 0.0],
        [-C0, 0.0, 0.0],
        [0.0, C0, 0.0],
        [0.0, -C0, 0.0]
    ], faces = [
        [4, 2, 0],
        [3, 4, 0],
        [5, 3, 0],
        [2, 5, 0],
        [5, 2, 1],
        [3, 5, 1],
        [4, 3, 1],
        [2, 4, 1]
    ]));

function Noise(x = 1, y = 1, z = 1, seed = 1) =
    let (SML = octavebalance())(Sweetnoise(x * 1, y * 1, z * 1, seed) * SML[0] + Sweetnoise(x / 2, y / 2, z / 2, seed) * SML[1] + Sweetnoise(x / 4, y / 4, z / 4, seed) * SML[2]);

function NO_WALL() = 0;

function NOT_VISITED() = 0;

function MBInfluence(x, y, z, mball) = (mball[3] / sqrt((x - mball[0]) * (x - mball[0]) + (y - mball[1]) * (y - mball[1]) + (z - mball[2]) * (z - mball[2])));

function MADD2X2(m1, m2) = [
    [m1[0][0] + m2[0][0], m1[0][1] + m2[0][1]],
    [m1[1][2] + m2[1][0], m1[1][1] + m2[1][1]]
];

function Lotto(i) = lim31(50, [rands(-75, 75, 1)[0], rands(-75, 75, 1)[0], (SC3(rands(0, 1, 1)[0]) - 0.5) * 150, i]);

function Lotto(i) = lim31(30, [rands(-75, 75, 1)[0], rands(-75, 75, 1)[0], (SC3(rands(0, 1, 1)[0]) - 0.5) * 150, i]);

function Lotto(i) = lim31(30, [rands(-50, 35, 1)[0], rands(-175, 175, 1)[0], (SC3(rands(0, 1, 1)[0]) - 0.5) * 75, i]);

function Lotto(i) = lim31(30, [rands(-100, 35, 1)[0], rands(-175, 175, 1)[0], (SC3(rands(0, 1, 1)[0]) - 0.5) * 75, i]);

function Lotto(i) = [rands(i * 30, i * 30 + 30, 1)[0], rands(0, 65, 1)[0], rands(0, 75, 1)[0], rands(21, 24, 1)[0]];

function Lotto(i) = [rands(i * 30, i * 30 + 30, 1)[0], rands(0, 65, 1)[0], rands(0, 75, 1)[0], rands(11, 159, 1)[0]];

function Lotto(i) = [rands(-60, 60, 1)[0], rands(-60, 65, 1)[0], rands(-60, 75, 1)[0], 8];

function Lotto(i) = [rands(-30, 30, 1)[0], rands(-30, 35, 1)[0], (SC3(rands(0, 1, 1)[0]) - 0.5) * 50, i];

function Lotto(i) = [i * 36, i % 2 * 120, 0, 9];

function Lotto() = [rands(0, 200, 1)[0], rands(0, 100, 1)[0], rands(0, 100, 1)[0], rands(20, 21, 1)[0]];

function LineRotations(v) = [atan2(sqrt(v[0] * v[0] + v[1] * v[1]), v[2]), 0, atan2(v[1], v[0]) + 90];

function IK(l, v) = sqrt(pow(l / 2, 2) - pow(min(len3(v), l) / 2, 2));

function IK(l, v) = sqrt(pow(l / 2, 2) - pow(len3(v) / 2, 2));

function I() =
    let (C0 = 0.809016994374947424102293417183) p_resize(poly(name = "I", vertices = [
        [0.5, 0.0, C0],
        [0.5, 0.0, -C0],
        [-0.5, 0.0, C0],
        [-0.5, 0.0, -C0],
        [C0, 0.5, 0.0],
        [C0, -0.5, 0.0],
        [-C0, 0.5, 0.0],
        [-C0, -0.5, 0.0],
        [0.0, C0, 0.5],
        [0.0, C0, -0.5],
        [0.0, -C0, 0.5],
        [0.0, -C0, -0.5]
    ], faces = [
        [10, 2, 0],
        [5, 10, 0],
        [4, 5, 0],
        [8, 4, 0],
        [2, 8, 0],
        [6, 8, 2],
        [7, 6, 2],
        [10, 7, 2],
        [11, 7, 10],
        [5, 11, 10],
        [1, 11, 5],
        [4, 1, 5],
        [9, 1, 4],
        [8, 9, 4],
        [6, 9, 8],
        [3, 9, 6],
        [7, 3, 6],
        [11, 3, 7],
        [1, 3, 11],
        [9, 3, 1]
    ]));

function Hulltrace(q, qp, vp, c = 8) =
    let (nm = evalnorm(qp, vp), n = [nm[0], nm[1], nm[2]], m = nm[3]) c > 0 ? Hulltrace(q, qp + (n * max(1, abs(m))), vp, c - 1) : /*//eval(q+un(q)*far,vp)-len3(q-(un(qp-q)*far))*/ len3(qp - q) - m;

function Hulltrace(q, qp, vp, c = 8) =
    let (nm = evalnorm(qp, vp), n = [nm[0], nm[1], nm[2]], m = nm[3]) c > 0 ? Hulltrace(q, qp + (n * max(1, abs(m))), vp, c - 1) : /*//eval(q+un(q)*far,vp)-len3(q-(un(qp-q)*far))*/ len3(qp - q) - m;

function HERMp1(u) = Basis33(u) + Basis23(u);

function HERMm1(u) = -1 / 3 * Basis23(u);

function HERMm0(u) = 1 / 3 * Basis13(u);

function GetHermiteQuad(mesh, u1v1, u2v2) = [herpm(mesh, [u1v1[0], u2v2[1]]), herpm(mesh, u1v1), herpm(mesh, [u2v2[0], u1v1[1]]), herpm(mesh, u2v2)];

function GetHermSweepQuad(cpsu, cpsv, uv1, uv2) = [herp(cpsu, uv1[0]) + herp(cpsv, uv1[1]), herp(cpsu, uv2[0]) + herp(cpsv, uv1[1]), herp(cpsu, uv2[0]) + herp(cpsv, uv2[1]), herp(cpsu, uv1[0]) + herp(cpsv, uv2[1])];

function GetCurveQuadNormals(mesh, u1v1, u2v2) = [
    [berpm(mesh, [u1v1[0], u2v2[1]]), berpm(mesh, u1v1), berpm(mesh, [u2v2[0], u1v1[1]]), berpm(mesh, u2v2), ],
    [nberpm(mesh, [u1v1[0], u2v2[1]]), nberpm(mesh, u1v1), nberpm(mesh, [u2v2[0], u1v1[1]]), nberpm(mesh, u2v2), ]
];

function GetCurveQuad(mesh, u1v1, u2v2) = [berpm(mesh, [u1v1[0], u2v2[1]]), berpm(mesh, u1v1), berpm(mesh, [u2v2[0], u1v1[1]]), berpm(mesh, u2v2)];

function GetControlQuad(mesh, rc) = [mesh[rc[0] + 1][rc[1]], mesh[rc[0]][rc[1]], mesh[rc[0]][rc[1] + 1], mesh[rc[0] + 1][rc[1] + 1]];

function Gauss(x) = x + (x - SC3(x)) * 2;

function DETVAL2X2(m) = m[0[0]] * m[1[1]] - m[0[1]] * m[1[0]];

function DETVAL(m) = m[0[0]] * DETVAL2X2([
    [m[1[1]], m[1[2]]],
    [m[2[1]], m[2[2]]]
]) - m[0[1]] * DETVAL2X2([
    [m[1[0]], m[1[2]]],
    [m[2[0]], m[2[2]]]
]) + m[0[2]] * DETVAL2X2([
    [m[1[0]], m[1[1]]],
    [m[2[0]], m[2[1]]]
]);

function D() =
    let (C0 = 0.809016994374947424102293417183) let (C1 = 1.30901699437494742410229341718) p_resize(poly(name = "D", vertices = [
        [0.0, 0.5, C1],
        [0.0, 0.5, -C1],
        [0.0, -0.5, C1],
        [0.0, -0.5, -C1],
        [C1, 0.0, 0.5],
        [C1, 0.0, -0.5],
        [-C1, 0.0, 0.5],
        [-C1, 0.0, -0.5],
        [0.5, C1, 0.0],
        [0.5, -C1, 0.0],
        [-0.5, C1, 0.0],
        [-0.5, -C1, 0.0],
        [C0, C0, C0],
        [C0, C0, -C0],
        [C0, -C0, C0],
        [C0, -C0, -C0],
        [-C0, C0, C0],
        [-C0, C0, -C0],
        [-C0, -C0, C0],
        [-C0, -C0, -C0]
    ], faces = [
        [12, 4, 14, 2, 0],
        [16, 10, 8, 12, 0],
        [2, 18, 6, 16, 0],
        [17, 10, 16, 6, 7],
        [19, 3, 1, 17, 7],
        [6, 18, 11, 19, 7],
        [15, 3, 19, 11, 9],
        [14, 4, 5, 15, 9],
        [11, 18, 2, 14, 9],
        [8, 10, 17, 1, 13],
        [5, 4, 12, 8, 13],
        [1, 3, 15, 5, 13]
    ]));

function ColorField3D(x, y, z, BallSack, i, s = 0) = (i <= 1) ? Powercolor(x, y, z, BallSack[s]) * ColorList[s] : ColorField3D(x, y, z, BallSack, i / 2, s) + ColorField3D(x, y, z, BallSack, i / 2, s + i / 2);

function ColorField3D(x, y, z, BallSack, Colorsack, i) = (i == 0) ? Powercolor(x, y, z, BallSack[0]) * Colorsack[0] : Powercolor(x, y, z, BallSack[i]) * Colorsack[i] + ColorField3D(x, y, z, BallSack, Colorsack, i - 1);

function Coldnoise(x, y, z, seed = 69940) = ((3754853343 / ((abs((floor(x + 40)))) + 1)) % 1 + (3628273133 / ((abs((floor(y + 44)))) + 1)) % 1 + (3500450271 / ((abs((floor(z + 46)))) + 1)) % 1 + (3367900313 / (abs(seed) + 1)) / 1) % 1;

function Coldnoise(x, y, z, seed = 69940) = ((3754853343 / ((abs((floor(x + 40)))) + 1)) % 1 + (3628273133 / ((abs((floor(y + 44)))) + 1)) % 1 + (3500450271 / ((abs((floor(z + 46)))) + 1)) % 1 + (3367900313 / (abs(seed) + 1)) / 1) % 1;

function Coldnoise(x, y, z, seed = 69840) = ((5754853343 / ((abs(round(x) % 100 + 10499)) + 1)) + (3628273133 / ((abs(round(y) % 100 + 84499)) + 1)) + (1500450271 / ((abs(round(z) % 100) + 46633) + 1)) + (3367900313 / (abs(seed) + 1))) % 1;

function Coldnoise(x, y, z, seed = 211448) = ((19990303 / (abs(x % 10) + 1)) + (19990303 / (abs(y % 10) + 1)) + (19990303 / (abs(z % 10) + 1)) + (19990303 / (abs(seed) + 1))) % 1;

function Coldnoise(x, y, z, seed = 211448) = ((19990303 / (abs((x) % 10) + 1)) + (19990303 / (abs((y) % 10) + 1)) + (19990303 / (abs((z) % 10) + 1)) + (19990303 / (abs(seed) + 1))) % 1;

function Clampz(q, p) = [q[x], q[y], q[z] < p[0] && q[z] > 0 ? 0 : q[z] > p[0] ? q[z] - p[0] : q[z]];

function Clampz(q, p) = [q[x], q[y], 0];

function ChamferBox(op, b = [1, 1, 1] /*[l,w,h]*/ , ch = 0 /*Chamfer*/ , r = 0 /*radius*/ ) = /*//radius and chanfer work independently but not as inteded when combined*/
    let (p = max3(abs3(op) - ((b - [ch, ch, ch]) - [r, r, r]), 0.0), plane_normal = un([1, 1, 1]), /*//other directions may be useful*/ ray_origin = [0, 0, 0], ray_direction = un(p), plane_origin = [ch, 0, 0], distance = (dot(plane_normal, (plane_origin - ray_origin))) / dot(plane_normal, ray_direction), location = ray_origin + (ray_direction * distance)) min(0, max(p.x, p.y, p.z)) + /*//tried to get them internal distances correct*/ max(0, len3(max3(p - location, 0)) - r);

function CenterOfGravity4(p0, p1, p2, p3) = [AvgThree(p0[0], p1[0], p2[0], p3[0]), AvgThree(p0[1], p1[1], p2[1], p3[1]), AvgThree(p0[2], p1[2], p2[2], p3[2])];

function CenterOfGravity3(p0, p1, p2) = [AvgThree(p0[0], p1[0], p2[0]), AvgThree(p0[1], p1[1], p2[1]), AvgThree(p0[2], p1[2], p2[2])];

function C() = p_resize(poly(name = "C", vertices = [
    [0.5, 0.5, 0.5],
    [0.5, 0.5, -0.5],
    [0.5, -0.5, 0.5],
    [0.5, -0.5, -0.5],
    [-0.5, 0.5, 0.5],
    [-0.5, 0.5, -0.5],
    [-0.5, -0.5, 0.5],
    [-0.5, -0.5, -0.5]
], faces = [
    [4, 5, 1, 0],
    [2, 6, 4, 0],
    [1, 3, 2, 0],
    [6, 2, 3, 7],
    [5, 4, 6, 7],
    [3, 1, 5, 7]
]));

function Bern3dv(mesh, uv) = Bern03dv(mesh, uv) + Bern13dv(mesh, uv) + Bern23dv(mesh, uv) + Bern33dv(mesh, uv);

function Bern3du(mesh, uv) = Bern03du(mesh, uv) + Bern13du(mesh, uv) + Bern23du(mesh, uv) + Bern33du(mesh, uv);

function Bern33dv(mesh, uv) = (Basis02(uv[1]) * Basis33(uv[0]) * (mesh[1][3] - mesh[0][3])) + (Basis12(uv[1]) * Basis33(uv[0]) * (mesh[2][3] - mesh[1][3])) + (Basis22(uv[1]) * Basis33(uv[0]) * (mesh[3][3] - mesh[2][3]));

function Bern33du(mesh, uv) = (Basis02(uv[0]) * Basis33(uv[1]) * (mesh[3][1] - mesh[3][0])) + (Basis12(uv[0]) * Basis33(uv[1]) * (mesh[3][2] - mesh[3][1])) + (Basis22(uv[0]) * Basis33(uv[1]) * (mesh[3][3] - mesh[3][2]));

function Bern33(cps, u) = [Basis33(u) * cps[3][0], Basis33(u) * cps[3][1], Basis33(u) * cps[3][2]];

function Bern23dv(mesh, uv) = (Basis02(uv[1]) * Basis23(uv[0]) * (mesh[1][2] - mesh[0][2])) + (Basis12(uv[1]) * Basis23(uv[0]) * (mesh[2][2] - mesh[1][2])) + (Basis22(uv[1]) * Basis23(uv[0]) * (mesh[3][2] - mesh[2][2]));

function Bern23du(mesh, uv) = (Basis02(uv[0]) * Basis23(uv[1]) * (mesh[2][1] - mesh[2][0])) + (Basis12(uv[0]) * Basis23(uv[1]) * (mesh[2][2] - mesh[2][1])) + (Basis22(uv[0]) * Basis23(uv[1]) * (mesh[2][3] - mesh[2][2]));

function Bern23(cps, u) = [Basis23(u) * cps[2][0], Basis23(u) * cps[2][1], Basis23(u) * cps[2][2]];

function Bern22(cps, u) = [Basis22(u) * cps[2][0], Basis22(u) * cps[2][1], Basis22(u) * cps[2][2]];

function Bern13dv(mesh, uv) = (Basis02(uv[1]) * Basis13(uv[0]) * (mesh[1][1] - mesh[0][1])) + (Basis12(uv[1]) * Basis13(uv[0]) * (mesh[2][1] - mesh[1][1])) + (Basis22(uv[1]) * Basis13(uv[0]) * (mesh[3][1] - mesh[2][1]));

function Bern13du(mesh, uv) = (Basis02(uv[0]) * Basis13(uv[1]) * (mesh[1][1] - mesh[1][0])) + (Basis12(uv[0]) * Basis13(uv[1]) * (mesh[1][2] - mesh[1][1])) + (Basis22(uv[0]) * Basis13(uv[1]) * (mesh[1][3] - mesh[1][2]));

function Bern13(cps, u) = [Basis13(u) * cps[1][0], Basis13(u) * cps[1][1], Basis13(u) * cps[1][2]];

function Bern12(cps, u) = [Basis12(u) * cps[1][0], Basis12(u) * cps[1][1], Basis12(u) * cps[1][2]];

function Bern03dv(mesh, uv) = (Basis02(uv[1]) * Basis03(uv[0]) * (mesh[1][0] - mesh[0][0])) + (Basis12(uv[1]) * Basis03(uv[0]) * (mesh[2][0] - mesh[1][0])) + (Basis22(uv[1]) * Basis03(uv[0]) * (mesh[3][0] - mesh[2][0]));

function Bern03du(mesh, uv) = (Basis02(uv[0]) * Basis03(uv[1]) * (mesh[0][1] - mesh[0][0])) + (Basis12(uv[0]) * Basis03(uv[1]) * (mesh[0][2] - mesh[0][1])) + (Basis22(uv[0]) * Basis03(uv[1]) * (mesh[0][3] - mesh[0][2]));

function Bern03(cps, u) = [Basis03(u) * cps[0][0], Basis03(u) * cps[0][1], Basis03(u) * cps[0][2]];

function Bern02(cps, u) = [Basis02(u) * cps[0][0], Basis02(u) * cps[0][1], Basis02(u) * cps[0][2]];

function Basis33(u) = pow(u, 3);

function Basis23(u) = 3 * (pow(u, 2)) * (1 - u);

function Basis22(u) = u * u;

function Basis13(u) = 3 * u * (pow((1 - u), 2));

function Basis12(u) = 2 * u * (1 - u);

function Basis02(u) = pow((1 - u), 2);

function AvgThree(v1, v2, v3) = (v1 + v2 + v3) / 3;

function AvgFour(v1, v2, v3, v4) = (v1 + v2 + v3 + v4) / 4;

function A(n, h = 1) = /*//antiprisms*/ p_resize(poly(name = str("A", n), vertices = concat([
    for (i = [0: n - 1])[cos(i * 360 / n), sin(i * 360 / n), -h / 2]
], [
    for (i = [0: n - 1])[cos((i + 1 / 2) * 360 / n), sin((i + 1 / 2) * 360 / n), h / 2]
]), faces = concat([
    for (i = [0: n - 1])[(i + 1) % n, i, i + n]
], [
    for (i = [0: n - 1])[(i + 1) % n, i + n, (i + 1) % n + n]
], [
    [
        for (i = [0: n - 1]) i
    ]
], [
    [
        for (i = [n - 1: -1: 0]) i + n
    ]
])));
 