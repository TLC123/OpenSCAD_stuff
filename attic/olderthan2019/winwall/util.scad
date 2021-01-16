///A few lines mor  make your code work in 3D.
///Exception is  gimball-lock artefacts on  straight z moves since no real quaternion rotations

//////////////////////////////////////////////////// Old function getangle(vector)=[0,0,-atan2(vector[0],vector[1])];//////////////////////////////////////////////////// 
//////////////////////////////////// New Sauce //////////////////////////////////////
function getangle(v) = (len(v) == 3) ? [0, 90, 0] + geteuler(lim3(1, v)): [90, 0, 0] + [0, 0, -atan2(v[0], v[1])];
function geteuler(v) = [0, -asin(v[2]), atan2(v2xy(v)[1], v2xy(v)[0])]; //Euler angles from Vec3
function v2xy(v) = lim3(1, [v[0], v[1], 0]); // down  projection xyz2xy
function lim3(l, v) = v / len3(v) * l; // normalize Vec37Vec4 to magnitude l
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2)); // find magnitude of Vec3
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// FollowPath Extrusion
// (c) 2013 Wouter Robers
path3d = [
  [-67.8509, 23.3115, 77.6378],
  [-64.7054, 0.307143, 95.027],
  [-50.7696, -16.9558, 81.0949],
  [-41.9771, -26.9999, 44.4277],
  [-51.9501, -31.5773, -3.16171],
  [-63.3934, -33.86, -47.0519],
  [-60.9717, -35.7994, -74.2041],
  [-31.31, -38.1267, -73.162],
  [9.7399, -38.946, -59.9703],
  [45.7945, -36.5815, -50.7952],
  [59.938, -29.5766, -61.9239],
  [53.9179, -13.5185, -75.4887],
  [32.9007, 13.2599, -73.1502]
];
path2d = [
  [-34.423721, 36.985889],
  [-49.288333, 31.047708],
  [-63.886651, 33.794279],
  [-74.725831, 39.951233],
  [-77.537431, 53.615379],
  [-76.145624, 65.199347],
  [-70.521591, 71.029779],
  [-56.071201, 89.286859],
  [-31.750381, 94.010719],
  [-19.512594, 94.447331],
  [-10.163321, 89.683029],
  [-4.636911, 85.585889],
  [-0.092381, 59.557939],
  [-0.195281, 20.381239],
  [-6.777137, 9.094524],
  [-15.364711, -1.125061]
];

shape = [
  [-6.947730, 5.438190],
  [-4.737390, 3.060760],
  [-4.724490, -1.617340],
  [-2.536640, -2.696480],
  [-1.554030, -4.568120],
  [0.196060, -5.945800],
  [2.046570, -4.596910],
  [3.074680, -2.882730],
  [5.595670, -2.290310],
  [6.947730, -0.764330],
  [5.596470, 1.641280],
  [6.459250, 4.108950],
  [4.910350, 5.210150],
  [0.995560, 5.570330],
  [-2.961680, 5.945800],
  [-5.956510, 5.915000],
  [-6.947670, 5.438140]
];
shaperotate = [0, 0, 0];
shapethickness = 0.11;
FollowPath(shape, path2d, shaperotate);
FollowPath(shape, path3d, shaperotate);

module FollowPath(shape, path, shaperotate){
hull() {
  translate(path[0]) rotate(getangle(path[1] - path[0])) rotate(shaperotate) linear_extrude(height = shapethickness) polygon(shape);
  translate(path[1]) rotate((getangle(path[1] - path[0]) + getangle(path[2] - path[1])) / 2) rotate(shaperotate) linear_extrude(height = shapethickness) polygon(shape);
}
for(i = [1: len(path) - 3]) {
  hull() {
    translate(path[i]) rotate((getangle(path[i] - path[i - 1]) + getangle(path[i + 1] - path[i])) / 2) rotate(shaperotate) linear_extrude(height = shapethickness) polygon(shape);
    translate(path[i + 1]) rotate((getangle(path[i + 1] - path[i]) + getangle(path[i + 2] - path[i + 1])) / 2) rotate(shaperotate) linear_extrude(height = shapethickness) polygon(shape);
  }}
  hull() {
    translate(path[len(path) - 2]) rotate((getangle(path[len(path) - 2] - path[len(path) - 3]) + getangle(path[len(path) - 1] - path[len(path) - 2])) / 2) rotate(shaperotate) linear_extrude(height = shapethickness) polygon(shape);
    translate(path[len(path) - 1]) rotate(getangle(path[len(path) - 1] - path[len(path) - 2])) rotate(shaperotate) linear_extrude(height = shapethickness) polygon(shape);
  }
}


