echo(it());
p=it();scale([1,1,0.2]){
union(){
translate([0,0,15])linear_extrude(5,scale = 0.50) scale([10,10])polygon(points =p);
translate([0,0,0])linear_extrude(15,scale = 1) scale([10,10])polygon(points =p);
translate([0,0,-5])linear_extrude(5,scale = 2) scale([5,5])polygon(points =p);
}
mirror([1,0,0])union(){
translate([0,0,15])linear_extrude(5,scale = 0.50) scale([10,10])polygon(points =p);
translate([0,0,0])linear_extrude(15,scale = 1) scale([10,10])polygon(points =p);
translate([0,0,-5])linear_extrude(5,scale = 2) scale([5,5])polygon(points =p);
}}
function it()=let(
  baser = rnd(0.5, 2),
  phase = rnd(360),
  mag1 = rnd(3) * baser,
  rep1 = round(rnd(0, 8)),
  ophase1 = rnd(360),
  mag2 = rnd(6) * baser,
  rep2 = round(rnd(3, 10)),
  ophase2 = rnd(360),
  phase0 = rnd(360),
  r0 = rnd(0, 1),
  phase1 = rnd(360),
  r1 = rnd(0, 1) / 2,
  phase2 = rnd(360),
  r2 = rnd(0, 1) / 3,
  phase3 = rnd(360),
  r3 = rnd(0, 1) / 4,
  phase8 = rnd(360),
  r8 = rnd(0, 1) / 8,
  rsum = baser + r0 + r1 + r2 + r3 + r8,
  step = 5)
[  for (i = [0: step: 360]) 
    let(  theta = i + sin((i + ophase1) * rep1) * mag1 + sin((i + ophase2) * rep2) * mag2)
       [
        sin(theta + phase) * (baser + sin((i + phase0)) * r0 + sin((i + phase1) * 2) * r1 + sin((i + phase2) * 3) * r2 + sin((i + phase3) * 4) * r3 + sin((i + phase8) * 8) * r8) / rsum,
        cos(theta + phase) * (baser + sin((i + phase0)) * r0 + sin((i + phase1) * 2) * r1 + sin((i + phase2) * 3) * r2 + sin((i + phase3) * 4) * r3 + sin((i + phase8) * 8) * r8) / rsum
      ]];
  


function rndR() = [rands(0, 360, 1)[0], rands(0, 360, 1)[1], rands(0, 360, 1)[0]];

function un(v) = v / max(len3(v), 0.000001) * 1;

function p2n(pa, pb, pc) =
let (u = pa - pb, v = pa - pc) un([u[1] * v[2] - u[2] * v[1], u[2] * v[0] - u[0] * v[2], u[0] * v[1] - u[1] * v[0]]);

function avrg(v) = sumv(v, max(0, len(v) - 1)) / len(v);

function lerp(start, end, bias) = (end * bias + start * (1 - bias));

function len3(v) = len(v) == 2 ? sqrt(pow(v[0], 2) + pow(v[1], 2)) : sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));

function sumv(v, i, s = 0) = (i == s ? v[i] : v[i] + sumv(v, i - 1, s));

function rnd(a = 0, b = 1) = (rands(min(a, b), max(a, b), 1)[0]);

function rndc() = [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]];