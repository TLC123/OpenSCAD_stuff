point=[10,0,0];
for(e=[0:15:360]){for(f=[0:15:180]){
translate(rotate(point,[e,0,f])) sphere();
}}











function rotate(xyz, u) =
let (xx = cos(u[0]) * cos(u[1]), xy = -sin(u[0]) * cos(u[1]), xz = -sin(u[1]), yx = sin(u[0]) * cos(u[2]) - cos(u[0]) * sin(u[1]) * sin(u[2]), yy = cos(u[0]) * cos(u[2]) + sin(u[0]) * sin(u[1]) * sin(u[2]), yz = -cos(u[1]) * sin(u[2]), zx = sin(u[0]) * sin(u[2]) + cos(u[0]) * sin(u[1]) * cos(u[2]), zy = cos(u[0]) * sin(u[2]) - sin(u[0]) * sin(u[1]) * cos(u[2]), zz = cos(u[1]) * cos(u[2]))[xyz[0] * xx + xyz[1] * xy + xyz[1] * xz, xyz[0] * yx + xyz[1] * yy + xyz[1] * yz, xyz[0] * zx + xyz[1] * zy + xyz[1] * zz];