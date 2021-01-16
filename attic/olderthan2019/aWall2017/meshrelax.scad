function smoothmesh(points, faces, c = 5) =
let (
neighbours = [
for (i = [0: len(points) - 1])[
for (j = [0: len(faces) - 1])
if (faces[j][0] == i || faces[j][1] == i || faces[j][2] == i || faces[j][3] == i) j]],
t = relaxmesh(points, faces, neighbours, 5))
t
;

function relaxmesh(points, faces, neighbours, c = 5) = c >0 ?
let (
midpoints = [
for (i = [0: len(faces) - 1]) avrg(
[points[faces[i][0]], points[faces[i][1]], points[faces[i][2]],
points[faces[i][3]]
])
],
points2 = [
for (i = [0: len(points) - 1]) len(neighbours[i]) > 0 ?
avrg([for (j = [0: len(neighbours[i]) - 1]) midpoints[neighbours[i][j]]])
:points[i]]
)
relax(points2, faces, neighbours, c - 1): [points, faces];
function avrg(l) = len(l) > 1 ? addl(l) / (len(l)) : l;

function addl(v)=v*[for(i=v)1];